package spinalnn.compiler

import java.io.FileInputStream
import java.nio.{ByteBuffer, ByteOrder}
import _root_.onnx.onnx.ModelProto
import _root_.onnx.onnx.GraphProto
import _root_.onnx.onnx.TensorProto
import spinal.lib.misc.plugin._
import spinalnn.types._
import spinalnn.util._

object OnnxCompiler {

  /** Loads an ONNX file from disk and parses it natively into Scala case classes. */
  def loadModel(filePath: String): ModelProto = {
    val input = new FileInputStream(filePath)
    try {
      ModelProto.parseFrom(input)
    } finally {
      input.close()
    }
  }

  /** Unpacks float arrays from an ONNX TensorProto.
    * Can traverse either repeated protobuf float fields or packed little-endian raw bytes.
    */
  def extractFloatData(tensor: TensorProto): Array[Float] = {
    if (tensor.floatData.nonEmpty) {
      tensor.floatData.toArray
    } else if (tensor.rawData.isDefined) {
      val rawBytes = tensor.getRawData.toByteArray
      val buffer = ByteBuffer.wrap(rawBytes).order(ByteOrder.LITTLE_ENDIAN)
      val count = rawBytes.length / 4
      val result = new Array[Float](count)
      for (i <- 0 until count) {
        result(i) = buffer.getFloat()
      }
      result
    } else {
      throw new IllegalArgumentException(s"Tensor '${tensor.getName}' contains no readable float data.")
    }
  }

  /** Unpacks 64-bit integer values from an ONNX TensorProto (commonly used for Shapes/Reshapes). */
  def extractLongData(tensor: TensorProto): Array[Long] = {
    if (tensor.int64Data.nonEmpty) {
      tensor.int64Data.toArray
    } else if (tensor.rawData.isDefined) {
      val rawBytes = tensor.getRawData.toByteArray
      val buffer = ByteBuffer.wrap(rawBytes).order(ByteOrder.LITTLE_ENDIAN)
      val count = rawBytes.length / 8
      val result = new Array[Long](count)
      for (i <- 0 until count) {
        result(i) = buffer.getLong()
      }
      result
    } else {
      throw new IllegalArgumentException(s"Tensor '${tensor.getName}' contains no readable 64-bit integer data.")
    }
  }

  /** Unpacks 32-bit integer values (e.g. standard biases, indices). */
  def extractIntData(tensor: TensorProto): Array[Int] = {
    if (tensor.int32Data.nonEmpty) {
      tensor.int32Data.toArray
    } else if (tensor.rawData.isDefined) {
      val rawBytes = tensor.getRawData.toByteArray
      val buffer = ByteBuffer.wrap(rawBytes).order(ByteOrder.LITTLE_ENDIAN)
      val count = rawBytes.length / 4
      val result = new Array[Int](count)
      for (i <- 0 until count) {
        result(i) = buffer.getInt()
      }
      result
    } else {
      throw new IllegalArgumentException(s"Tensor '${tensor.getName}' contains no readable 32-bit integer data.")
    }
  }

  /** Transposes weight matrices from ONNX [outCh, C_in, kH, kW] format to
    * Spinal [outCh, kH, kW, C_in] format for parallel inner-loop MAC reads.
    */
  def transposeWeights(weights: Array[Byte], outCh: Int, inCh: Int, kH: Int, kW: Int): Array[Byte] = {
    val transposed = new Array[Byte](outCh * inCh * kH * kW)
    for (och <- 0 until outCh) {
      for (kh <- 0 until kH) {
        for (kw <- 0 until kW) {
          for (ic <- 0 until inCh) {
            val onnxIdx = och * (inCh * kH * kW) + ic * (kH * kW) + kh * kW + kw
            val spinalIdx = och * (kH * kW * inCh) + kh * (kW * inCh) + kw * inCh + ic
            transposed(spinalIdx) = weights(onnxIdx)
          }
        }
      }
    }
    transposed
  }

  /** Transposes and reorders fully-connected linear weights from ONNX flat CHW-order $[C \times H \times W, O]$
    * directly into Spinal row-major HWC-order $[O, H \times W \times C]$ to match stream layout.
    */
  def transposeLinearWeights(onnxWeights: Array[Byte], outNeurons: Int, inChannels: Int, H: Int, W: Int): Array[Byte] = {
    val transposed = new Array[Byte](outNeurons * inChannels * H * W)
    val M = inChannels * H * W
    for (o <- 0 until outNeurons) {
      for (h <- 0 until H) {
        for (w <- 0 until W) {
          for (ch <- 0 until inChannels) {
            val idxHwc = h * (W * inChannels) + w * inChannels + ch
            val idxChw = ch * (H * W) + h * W + w
            transposed(o * M + idxHwc) = onnxWeights(idxChw * outNeurons + o)
          }
        }
      }
    }
    transposed
  }

  /** Quantizes a float array symmetrically to fit into an SInt8 range [-128, 127] (standard INT8 symmetric quantization).
    * Calculates the scale factor and zero-point parameters.
    */
  def quantizeSymmetric(floats: Array[Float]): (QuantParams, Array[Byte]) = {
    if (floats.isEmpty) {
      return (QuantParams(1.0f, 0), Array.emptyByteArray)
    }
    val maxAbs = floats.map(Math.abs).max
    // Symmetrical quantization scale: S = max(|x|) / 127.
    val scale = if (maxAbs == 0.0f) 1.0f else (maxAbs / 127.0f)
    val zeroPoint = 0 // Symmetric quantization forces zero-point offset to 0.

    val bytes = floats.map { f =>
      val quantized = Math.round(f / scale)
      val clamped = Math.max(-128, Math.min(127, quantized))
      clamped.toByte
    }
    (QuantParams(scale, zeroPoint), bytes)
  }

  /** Quantizes biases as 32-bit integers scaled by (scaleIn * scaleWeights). */
  def scaleBias(biases: Array[Float], scaleIn: Float, scaleWeights: Float): Array[Int] = {
    val scaleBias = scaleIn * scaleWeights
    if (scaleBias == 0.0f) {
      biases.map(_ => 0)
    } else {
      biases.map(b => Math.round(b / scaleBias))
    }
  }

  def getInitializer(graph: GraphProto, name: String): TensorProto = {
    graph.initializer.find(_.getName == name).getOrElse {
      throw new NoSuchElementException(s"Initializer '$name' not found in ONNX graph.")
    }
  }

  /** Compiles an ONNX model file into the concrete list of SpinalHDL plugins.
    *
    * Two stages: `OnnxFrontend.lower` walks the graph and produces a `Seq[LayerSpec]`
    * IR (shape inference, quantization, weight transposes); `IrBackend.build` turns the
    * IR into the wired plugin graph via the operator-dispatch registry. The helper
    * methods above (extract/transpose/quantize/scaleBias/getInitializer) are the shared
    * primitives the frontend calls.
    *
    * When `emitLogits` is true the chain terminates at the linear layer, so the
    * top-level output stream emits the raw INT8 class logits (neuron order) instead of
    * the argmax index -- the diagnostic tap used by `OnnxLogitInspectionTest`.
    *
    * NOTE: shape inference currently uses the historical VALID-convolution / 2x2-pool
    * approximation (auto_pad and general pooling not yet honored). See
    * docs/ARCHITECTURE_DIRECTION.md section 11.
    */
  def compileModel(filePath: String, buildEnv: BuildEnv = BuildEnv(), emitLogits: Boolean = false): Seq[FiberPlugin] = {
    val model = loadModel(filePath)
    val specs = OnnxFrontend.lower(model, OnnxFrontend.MnistCalibration, emitLogits)
    IrBackend.build(specs, buildEnv)
  }

  /** Prints a summary of nodes, inputs, outputs, and initializers in the model. */
  def inspectModel(filePath: String): Unit = {
    val model = loadModel(filePath)
    val graph = model.getGraph

    println(s"========================================================================")
    println(s"NATIVE ONNX MODEL SUMMARY: ${filePath}")
    println(s"  - IR Version:  ${model.getIrVersion}")
    println(s"  - Producer:    ${model.getProducerName} (${model.getProducerVersion})")
    println(s"  - Graph Name:  ${graph.getName}")
    println(s"========================================================================")

    println(s"\nINITIALIZERS (Trained Weights/Biases):")
    graph.initializer.foreach { init =>
      val dataTypeStr = init.getDataType match {
        case 1  => "FLOAT"
        case 2  => "UINT8"
        case 3  => "INT8"
        case 6  => "INT32"
        case 7  => "INT64"
        case other => s"UNKNOWN($other)"
      }
      val floatsCount = if (init.getDataType == 1) {
        try { s" | sample[0]=${extractFloatData(init).headOption.getOrElse(0.0f)}" } catch { case _: Throwable => "" }
      } else ""
      println(s"  - Name: '${init.getName}' | Shape: ${init.dims.mkString("x")} | Type: ${dataTypeStr}${floatsCount}")
    }

    println(s"\nCOMPUTATIONAL GRAPH NODES:")
    graph.node.zipWithIndex.foreach { case (node, idx) =>
      val op = node.getOpType
      val name = if (node.getName.nonEmpty) node.getName else s"node_${idx}"
      println(s"  [Node $idx] Op: ${op} | Name: '${name}'")
      println(s"    - Inputs:  ${node.input.mkString(", ")}")
      println(s"    - Outputs: ${node.output.mkString(", ")}")
      node.attribute.foreach { attr =>
        val valStr = if (attr.ints.nonEmpty) {
          s"ints: [${attr.ints.mkString(", ")}]"
        } else if (attr.f.isDefined) {
          s"float: ${attr.getF}"
        } else if (attr.i.isDefined) {
          s"int: ${attr.getI}"
        } else if (attr.s.isDefined && attr.getS.isValidUtf8) {
          s"string: '${attr.getS.toStringUtf8}'"
        } else {
          s"raw"
        }
        println(s"      - Attr: '${attr.getName}' = $valStr")
      }
    }
    println(s"========================================================================")
  }
}
