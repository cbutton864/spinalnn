package spinalnn.compiler

import _root_.onnx.onnx.{ModelProto, NodeProto, TensorProto}
import spinalnn.types._

import scala.collection.mutable

/** Walks an ONNX graph and lowers it to a `Seq[LayerSpec]` (the IR consumed by
  * `IrBackend`). This is the generic frontend: it recovers the op sequence,
  * weights, biases, and shapes from the graph rather than hard-coding a topology.
  *
  * Quantization resolution has two paths:
  *  - Pre-quantized (QOperator) models carry `x_scale`/`w_scale`/`y_scale` on each
  *    node -- read them directly (the primary, calibration-free path). [TODO: wired
  *    once a QLinear* graph is exercised; the dispatch hook is marked below.]
  *  - Float models have no activation scales in the file, so they require an explicit
  *    [[OnnxFrontend.Calibration]] supplying per-layer output scales.
  *
  * Shape inference is faithful: convolutions honor `auto_pad` (SAME_UPPER / SAME_LOWER
  * / VALID) and explicit `pads`, and pooling honors `kernel_shape` / `strides`. Padding
  * is realized inside `QLinearConvCore` by a zero-initialised input buffer, so a SAME
  * convolution preserves spatial size exactly as ONNX specifies.
  */
object OnnxFrontend {

  /** Activation-scale calibration for FLOAT ONNX models. `actScales` are applied to
    * weight-bearing layers (Conv, Linear) in graph order. Pre-quantized models do not
    * need this. */
  case class Calibration(inputScale: Float, actScales: Seq[Float])

  /** Historical MNIST-8 clip ranges the compiler has always used (input 1/127,
    * conv1 4/127, conv2 8/127, fc 16/127). Reproduces the existing 80% MNIST result
    * bit-for-bit. These are hand-guessed, not calibrated -- replace with a real PTQ
    * pass (see docs/FUTURE_ROADMAP.md). */
  val MnistCalibration: Calibration =
    Calibration(1.0f / 127.0f, Seq(4.0f / 127.0f, 8.0f / 127.0f, 16.0f / 127.0f))

  def lower(model: ModelProto, calib: Calibration, emitLogits: Boolean): Seq[LayerSpec] = {
    val graph     = model.getGraph
    val initNames = graph.initializer.map(_.getName).toSet
    val producers = graph.node.flatMap(n => n.output.map(_ -> n)).toMap

    // Feature-map ops only: drop weight-side prep nodes (e.g. an initializer Reshape
    // such as MNIST's Times212_reshape1, whose input is a Parameter initializer).
    val nodes = graph.node.filterNot(n => n.input.headOption.exists(initNames))

    // Resolve a (possibly reshaped) weight name down to its backing initializer.
    def weightInit(name: String): TensorProto =
      if (initNames(name)) OnnxCompiler.getInitializer(graph, name)
      else producers.get(name)
             .map(p => weightInit(p.input.head))
             .getOrElse(throw new NoSuchElementException(
               s"weight '$name' resolves to no initializer"))

    // The bias Add immediately consuming a Conv/MatMul output (second input is a
    // constant initializer). Folded into the producing op's `biases`.
    def biasAddFor(outName: String): Option[NodeProto] =
      nodes.find(n => n.getOpType == "Add" &&
        n.input.contains(outName) && n.input.exists(initNames))

    // Graph data input (excludes the Parameter* initializers ONNX also lists as inputs).
    // NCHW [N,C,H,W] -> HWC TensorShape(H,W,C).
    val inputShape: TensorShape = {
      val in = graph.input.find(i => !initNames(i.getName))
        .getOrElse(throw new NoSuchElementException("graph has no non-initializer input"))
      val d  = in.getType.getTensorType.getShape.dim.map(_.getDimValue.toInt)
      require(d.length == 4, s"expected 4D NCHW input, got ${d.mkString("x")}")
      TensorShape(rows = d(2), cols = d(3), channels = d(1))
    }

    val specs    = mutable.ArrayBuffer[LayerSpec]()
    val consumed = mutable.Set[String]()       // bias Adds already folded
    var prevName      = "input"
    var prevShape     = inputShape
    var inScale       = calib.inputScale       // input scale of the *next* weight layer
    var flattenShape  = inputShape             // feature-map shape feeding the Flatten
    var convIdx, reluIdx, poolIdx, linIdx, wLayer = 0

    specs += LayerSpec.Input("input", inputShape)

    def nextActScale(): Float = {
      require(wLayer < calib.actScales.length,
        s"calibration supplies ${calib.actScales.length} activation scales but the model " +
          s"has more weight layers; extend Calibration.actScales")
      val s = calib.actScales(wLayer); wLayer += 1; s
    }

    def foldBias(outName: String, scaleIn: Float, scaleW: Float, outCh: Int): Array[Int] =
      biasAddFor(outName) match {
        case Some(add) =>
          consumed += add.getName
          val b = OnnxCompiler.extractFloatData(weightInit(add.input.find(initNames).get))
          OnnxCompiler.scaleBias(b, scaleIn, scaleW)
        case None => Array.fill(outCh)(0)
      }

    nodes.foreach { n =>
      if (consumed(n.getName)) {
        // already folded as a bias -- skip
      } else n.getOpType match {

        case "Conv" =>
          convIdx += 1
          val wT0  = weightInit(n.input(1))
          val dims = wT0.dims.map(_.toInt)                 // ONNX [outCh, inCh, kH, kW]
          val (outCh, inCh, kH, kW) = (dims(0), dims(1), dims(2), dims(3))
          val (qW, qBytes) = OnnxCompiler.quantizeSymmetric(OnnxCompiler.extractFloatData(wT0))
          val weights  = OnnxCompiler.transposeWeights(qBytes, outCh, inCh, kH, kW)
          val strides  = intsAttr(n, "strides").getOrElse(Seq(1, 1))
          val (sH, sW) = (strides(0), strides(1))
          val (padT, padB, padL, padR) = convPads(n, prevShape.rows, prevShape.cols, kH, kW, sH, sW)
          val outRows  = (prevShape.rows + padT + padB - kH) / sH + 1
          val outCols  = (prevShape.cols + padL + padR - kW) / sW + 1
          val outShape = TensorShape(outRows, outCols, outCh)
          val outScale = nextActScale()
          val biases   = foldBias(n.output.head, inScale, qW.scale, outCh)
          val name     = s"conv$convIdx"
          specs += LayerSpec.Conv(name, prevName, prevShape, outShape,
            kH, kW, sH, sW, padT, padB, padL, padR,
            QuantParams(inScale, 0), qW, QuantParams(outScale, 0), weights, biases)
          prevName = name; prevShape = outShape; inScale = outScale

        case "Relu" =>
          reluIdx += 1
          val name = s"relu$reluIdx"
          specs += LayerSpec.Relu(name, prevName, prevShape)
          prevName = name

        case "MaxPool" =>
          poolIdx += 1
          val kshape   = intsAttr(n, "kernel_shape").getOrElse(Seq(2, 2))
          val (kH, kW) = (kshape(0), kshape(1))
          val strides  = intsAttr(n, "strides").getOrElse(Seq(kH, kW))
          val (sH, sW) = (strides(0), strides(1))
          require(intsAttr(n, "pads").getOrElse(Seq(0, 0, 0, 0)).forall(_ == 0),
            s"MaxPool node '${n.getName}' has non-zero pads; padded pooling is not supported yet")
          val outRows  = (prevShape.rows - kH) / sH + 1
          val outCols  = (prevShape.cols - kW) / sW + 1
          val outShape = TensorShape(outRows, outCols, prevShape.channels)
          val name = s"pool$poolIdx"
          specs += LayerSpec.MaxPool(name, prevName, prevShape, outShape, kH, kW, sH, sW)
          prevName = name; prevShape = outShape

        case "Reshape" =>
          flattenShape = prevShape                         // capture pre-flatten H x W x C
          specs += LayerSpec.Flatten("flatten", prevName, flattenShape)
          prevName = "flatten"; prevShape = TensorShape(1, 1, flattenShape.size)

        case "MatMul" =>
          linIdx += 1
          val wT0 = weightInit(n.input(1))
          // ONNX linear weight flattens to [inNeurons, outNeurons] row-major.
          val outNeurons = wT0.dims.last.toInt
          val (qW, qBytes) = OnnxCompiler.quantizeSymmetric(OnnxCompiler.extractFloatData(wT0))
          val weights = OnnxCompiler.transposeLinearWeights(
            qBytes, outNeurons, flattenShape.channels, flattenShape.rows, flattenShape.cols)
          val outScale = nextActScale()
          val biases   = foldBias(n.output.head, inScale, qW.scale, outNeurons)
          val name     = s"linear$linIdx"
          specs += LayerSpec.Linear(name, prevName, flattenShape.size, outNeurons,
            QuantParams(inScale, 0), qW, QuantParams(outScale, 0), weights, biases)
          prevName = name; prevShape = TensorShape(1, 1, outNeurons); inScale = outScale

        case other =>
          throw new NotImplementedError(
            s"ONNX operator '$other' (node '${n.getName}') is not supported yet. " +
              s"Add a LayerSpec case + OnnxFrontend dispatch + IrBackend case to support it.")
      }
    }

    val numClasses = prevShape.channels
    if (emitLogits) {
      // Logit-tap mode: terminate at the linear layer; emit the raw INT8 logits.
      specs += LayerSpec.Output("output", prevName, TensorShape(1, 1, numClasses))
    } else {
      specs += LayerSpec.Softmax("softmax", prevName, numClasses)
      specs += LayerSpec.Output("output", "softmax", TensorShape(1, 1, 1))
    }
    specs.toSeq
  }

  // ── ONNX attribute readers ────────────────────────────────────────────────
  private def intsAttr(n: NodeProto, name: String): Option[Seq[Int]] =
    n.attribute.find(_.getName == name).filter(_.ints.nonEmpty).map(_.ints.map(_.toInt))

  private def strAttr(n: NodeProto, name: String): Option[String] =
    n.attribute.find(a => a.getName == name && a.s.isDefined).map(_.getS.toStringUtf8)

  /** Resolves convolution padding to (padTop, padBottom, padLeft, padRight) from the
    * node's `auto_pad` / `pads` attributes, following the ONNX Conv spec.
    */
  private def convPads(n: NodeProto, inH: Int, inW: Int, kH: Int, kW: Int, sH: Int, sW: Int)
      : (Int, Int, Int, Int) = {
    val autoPad = strAttr(n, "auto_pad").getOrElse("NOTSET")
    autoPad match {
      case "VALID" => (0, 0, 0, 0)
      case "SAME_UPPER" | "SAME_LOWER" =>
        def same(in: Int, k: Int, s: Int): (Int, Int) = {
          val out   = Math.ceil(in.toDouble / s).toInt
          val total = Math.max(0, (out - 1) * s + k - in)
          val lo    = total / 2
          val hi    = total - lo
          if (autoPad == "SAME_UPPER") (lo, hi) else (hi, lo)
        }
        val (padT, padB) = same(inH, kH, sH)
        val (padL, padR) = same(inW, kW, sW)
        (padT, padB, padL, padR)
      case _ => // NOTSET: explicit pads [H_begin, W_begin, H_end, W_end] = [T, L, B, R]
        intsAttr(n, "pads").map(p => (p(0), p(2), p(1), p(3))).getOrElse((0, 0, 0, 0))
    }
  }
}
