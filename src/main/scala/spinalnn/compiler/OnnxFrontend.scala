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

        case "Clip" =>
          // Clip(min=0, max=6) = ReLU6. The max attribute maps to clampMax in INT8 domain.
          // If no max (or max > 6), treat as plain ReLU (clampMax = 127).
          reluIdx += 1
          val name     = s"relu$reluIdx"
          val clipMax  = floatAttr(n, "max").orElse(intsAttr(n, "max").map(_.head.toFloat)).getOrElse(Float.MaxValue)
          val clampMax = if (clipMax <= 6.1f)
            Math.min(ActivationDType.maxVal, Math.round(clipMax / inScale))
          else ActivationDType.maxVal
          specs += LayerSpec.Relu(name, prevName, prevShape, clampMax)
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

  // ── Pre-quantized (QOperator) graphs ──────────────────────────────────────

  /** True when the graph is in the ONNX QOperator quantization format (QLinearConv etc.),
    * as opposed to a float graph that needs calibration. */
  def isQuantized(model: ModelProto): Boolean =
    model.getGraph.node.exists(_.getOpType == "QLinearConv")

  /** Lowers a pre-quantized QOperator ONNX graph to the IR. Scales and zero-points are
    * read directly off the nodes (no calibration). Two model facts drive the design:
    *
    *  - uint8 activations are remapped to signed int8 by subtracting 128 from the
    *    zero-point. The real value `scale*(q - zp)` is unchanged, the existing int8
    *    datapath needs no modification, and ReLU stays fused (the uint8 `[0,255]` clamp
    *    with zp 0 equals int8 saturation after the remap). Weights are already int8.
    *  - Concats are wrapped by Dequantize -> Concat(float) -> Quantize because the
    *    branches carry different scales. We fold that triplet away by overriding each
    *    producing conv's OUTPUT quantization to the Quantize node's (scale, zp); both
    *    branches then share one quantization and Concat becomes a direct int8 concat.
    */
  def lowerQuantized(model: ModelProto, emitLogits: Boolean): Seq[LayerSpec] = {
    val graph     = model.getGraph
    val initNames = graph.initializer.map(_.getName).toSet
    val nodes     = graph.node

    def init(name: String): TensorProto      = OnnxCompiler.getInitializer(graph, name)
    def scalarF(name: String): Float          = OnnxCompiler.extractFloatData(init(name))(0)
    def vecF(name: String): Array[Float]      = OnnxCompiler.extractFloatData(init(name))
    // Read a scalar zero-point. ONNX stores INT8/UINT8 scalars in either int32_data or
    // packed raw_data (and an absent tensor means zp 0). uint8 zero-points are then
    // remapped to signed int8 by subtracting 128; int8 zero-points pass through.
    def remapZp(name: String): Int = {
      val t      = init(name)
      val isU8   = t.getDataType == 2                                   // 2 = UINT8
      val rawOpt = t.rawData.map(_.toByteArray).filter(_.nonEmpty)
      val v =
        if (t.int32Data.nonEmpty) { val x = t.int32Data.head; if (isU8) x & 0xFF else x }
        else rawOpt.map(r => if (isU8) r(0) & 0xFF else r(0).toInt).getOrElse(0)
      if (isU8) v - 128 else v
    }

    // ONNX tensor names (e.g. "fire2/squeeze1x1_1_quantized") become Core periphNames and
    // thus generated signal/memory names, so they must be valid Verilog identifiers. Map
    // any non-alphanumeric/underscore character to '_'. Applied uniformly to every name
    // emitted into a LayerSpec, so producer ids and consumer references stay consistent.
    def san(s: String): String = {
      val r = s.replaceAll("[^A-Za-z0-9_]", "_")
      if (r.isEmpty || r.head.isDigit) "n" + r else r
    }

    // Graph data input (NCHW [N,C,H,W] -> HWC).
    val inVi       = graph.input.find(i => !initNames(i.getName))
      .getOrElse(throw new NoSuchElementException("graph has no non-initializer input"))
    val inDataName = inVi.getName
    val inDims     = inVi.getType.getTensorType.getShape.dim.map(_.getDimValue.toInt)
    require(inDims.length == 4, s"expected 4D NCHW input, got ${inDims.mkString("x")}")
    val inputShape = TensorShape(inDims(2), inDims(3), inDims(1))

    // ── Quantize/Dequantize/Reshape aliasing ─────────────────────────────────
    // Q/DQ nodes rename a tensor between int8 and float views — both carry the same
    // data, so consumers resolve through them transparently (no hardware emitted).
    // Reshape is also treated as a transparent alias: in our static HWC layout, a
    // Reshape from (1,1,C) to (1,C) is a no-op — the data order is identical.
    val aliasOf = mutable.Map[String, String]()
    nodes.foreach { n =>
      n.getOpType match {
        case "DequantizeLinear"                                    => aliasOf(n.output.head) = n.input.head
        case "QuantizeLinear" if n.input.head != inDataName        => aliasOf(n.output.head) = n.input.head
        case "Reshape" | "Flatten"                                 => aliasOf(n.output.head) = n.input.head
        case _                                                     =>
      }
    }
    def resolve(name: String): String = aliasOf.get(name) match {
      case Some(prev) => resolve(prev)
      case None       => name
    }

    // Nodes that emit no hardware.
    val skipNodes: Set[String] = nodes.collect {
      case n if n.getOpType == "DequantizeLinear"                             => n.getName
      case n if n.getOpType == "QuantizeLinear" && n.input.head != inDataName => n.getName
      case n if n.getOpType == "Reshape" || n.getOpType == "Flatten"          => n.getName
    }.toSet

    // Pre-pass: collect all shape-computation outputs (Constant, Shape, Gather,
    // Unsqueeze/Squeeze, and any Concat whose inputs are all shape/constant tensors).
    // This runs before the main loop so the set is complete regardless of node order
    // (e.g. Constant nodes may appear after the Concat that consumes them).
    val shapeOpOutputs = mutable.Set[String]()
    var changed = true
    while (changed) {
      changed = false
      nodes.foreach { n =>
        n.getOpType match {
          case "Constant" | "Shape" | "Gather" | "Unsqueeze" | "Squeeze" =>
            if (n.output.exists(!shapeOpOutputs(_))) {
              shapeOpOutputs ++= n.output; changed = true
            }
          case "Concat" if n.input.forall(i => initNames(i) || shapeOpOutputs(i)) =>
            if (n.output.exists(!shapeOpOutputs(_))) {
              shapeOpOutputs ++= n.output; changed = true
            }
          case _ =>
        }
      }
    }

    // Forward consumer map over the raw graph: tensor name -> nodes that read it.
    val consumersOf: Map[String, Seq[NodeProto]] =
      nodes.flatMap(n => n.input.map(_ -> n)).groupBy(_._1).map { case (k, v) => k -> v.map(_._2) }

    // The (scaleName, zpName) every branch of a Concat must requantize to: the closing
    // Quantize reachable from the Concat output, seen through a transparent (monotonic)
    // MaxPool. Forcing both expand convolutions to that one quantization makes the Concat
    // a pure int8 channel concat.
    def closingQuant(concatOut: String): Option[(String, String)] = {
      var cur  = concatOut
      var hops = 0
      while (hops < 8) {
        hops += 1
        val cons = consumersOf.getOrElse(cur, Nil)
        cons.find(_.getOpType == "QuantizeLinear") match {
          case Some(q) => return Some((q.input(1), q.input(2)))
          case None    => cons.find(_.getOpType == "MaxPool") match {
            case Some(mp) => cur = mp.output.head
            case None     => return None
          }
        }
      }
      None
    }

    // Output-quant override per producing convolution, keyed by the conv's int8 output
    // tensor: set to the shared Concat quantization for every branch feeding a Concat.
    val producerOutQuant = mutable.Map[String, (String, String)]()
    nodes.filter(_.getOpType == "Concat").foreach { c =>
      closingQuant(c.output.head).foreach { q =>
        c.input.foreach(b => producerOutQuant(resolve(b)) = q)
      }
    }

    val specs   = mutable.ArrayBuffer[LayerSpec]()
    val shapeOf = mutable.Map[String, TensorShape]()

    nodes.foreach { n =>
      if (skipNodes(n.getName)) {
        // Quantize/Dequantize alias -- nothing to emit.
      } else n.getOpType match {

        case "QuantizeLinear" =>
          // Input boundary (the only un-aliased Quantize): the quantized tensor is the
          // network input stream.
          specs += LayerSpec.Input(san(n.output.head), inputShape)
          shapeOf(n.output.head) = inputShape

        case "QLinearConv" =>
          val src   = resolve(n.input.head)
          val wT    = init(n.input(3))                       // [outCh, inCh/group, kH, kW]
          val wdims = wT.dims.map(_.toInt)
          val (outCh, inChPerGroup, kH, kW) = (wdims(0), wdims(1), wdims(2), wdims(3))
          val group   = intAttr(n, "group").getOrElse(1)
          val strides = intsAttr(n, "strides").getOrElse(Seq(1, 1))
          val (sH, sW) = (strides(0), strides(1))
          val inShape  = shapeOf(src)
          val (padT, padB, padL, padR) = convPads(n, inShape.rows, inShape.cols, kH, kW, sH, sW)
          val outRows  = (inShape.rows + padT + padB - kH) / sH + 1
          val outCols  = (inShape.cols + padL + padR - kW) / sW + 1
          val inQuant  = QuantParams(scalarF(n.input(1)), remapZp(n.input(2)))
          val (oScale, oZp) = producerOutQuant.getOrElse(n.output.head, (n.input(6), n.input(7)))
          val outQuant = QuantParams(scalarF(oScale), remapZp(oZp))
          val wScales  = vecF(n.input(4))
          val rawW    = OnnxCompiler.extractInt8Bytes(wT)
          val weights = OnnxCompiler.transposeWeights(rawW, outCh, inChPerGroup, kH, kW)
          val biasRaw = if (n.input.length > 8) OnnxCompiler.extractIntData(init(n.input(8)))
                        else Array.fill(outCh)(0)
          val biases  = zpBiasCorrect(biasRaw, rawW, outCh, inQuant.zeroPoint)
          val isDepthwise = group > 1 && group == inShape.channels && outCh == inShape.channels
          if (isDepthwise) {
            // Depthwise: outCh = C = inShape.channels, inChPerGroup = 1.
            // weights after transpose: [C, kH, kW, 1] = [C, kH, kW].
            val outShape = TensorShape(outRows, outCols, inShape.channels)
            specs += LayerSpec.DepthwiseConv(san(n.output.head), san(src), inShape, outShape,
              kH, kW, sH, sW, padT, padB, padL, padR,
              inQuant, QuantParams(wScales(0), 0), outQuant, weights, biases, Some(wScales))
            shapeOf(n.output.head) = outShape
          } else {
            val outShape = TensorShape(outRows, outCols, outCh)
            specs += LayerSpec.Conv(san(n.output.head), san(src), inShape, outShape,
              kH, kW, sH, sW, padT, padB, padL, padR,
              inQuant, QuantParams(wScales(0), 0), outQuant, weights, biases, Some(wScales))
            shapeOf(n.output.head) = outShape
          }

        case "MaxPool" =>
          val src      = resolve(n.input.head)
          val inShape  = shapeOf(src)
          val kshape   = intsAttr(n, "kernel_shape").getOrElse(Seq(2, 2))
          val (kH, kW) = (kshape(0), kshape(1))
          val strides  = intsAttr(n, "strides").getOrElse(Seq(kH, kW))
          val (sH, sW) = (strides(0), strides(1))
          require(intsAttr(n, "pads").getOrElse(Seq(0, 0, 0, 0)).forall(_ == 0),
            s"MaxPool '${n.getName}' has non-zero pads; padded pooling is not supported yet")
          val outRows  = (inShape.rows - kH) / sH + 1
          val outCols  = (inShape.cols - kW) / sW + 1
          val outShape = TensorShape(outRows, outCols, inShape.channels)
          specs += LayerSpec.MaxPool(san(n.output.head), san(src), inShape, outShape, kH, kW, sH, sW)
          shapeOf(n.output.head) = outShape

        case "Concat" if n.input.forall(i => initNames(i) || shapeOpOutputs(i)) =>
          () // shape-computation concat (e.g. dynamic flatten target) — skip

        case "Concat" =>
          val ins         = n.input.map(resolve).toSeq
          val inputShapes = ins.map(shapeOf)
          val outShape    = TensorShape(inputShapes.head.rows, inputShapes.head.cols,
                                        inputShapes.map(_.channels).sum)
          specs += LayerSpec.Concat(san(n.output.head), ins.map(san), inputShapes)
          shapeOf(n.output.head) = outShape

        case "QLinearGlobalAveragePool" =>
          val src      = resolve(n.input.head)
          val inShape  = shapeOf(src)
          val inQuant  = QuantParams(scalarF(n.input(1)), remapZp(n.input(2)))
          val outQuant = QuantParams(scalarF(n.input(3)), remapZp(n.input(4)))
          val outShape = TensorShape(1, 1, inShape.channels)
          specs += LayerSpec.GlobalAveragePool(san(n.output.head), san(src), inShape, inQuant, outQuant)
          shapeOf(n.output.head) = outShape

        case "QLinearAdd" =>
          // Inputs: A, A_scale, A_zp, B, B_scale, B_zp, C_scale, C_zp
          val srcA   = resolve(n.input(0))
          val srcB   = resolve(n.input(3))
          val inShape = shapeOf(srcA)
          require(shapeOf(srcB) == inShape,
            s"QLinearAdd '${n.getName}': input shapes must match")
          val inAQuant = QuantParams(scalarF(n.input(1)), remapZp(n.input(2)))
          val inBQuant = QuantParams(scalarF(n.input(4)), remapZp(n.input(5)))
          val outQuant = QuantParams(scalarF(n.input(6)), remapZp(n.input(7)))
          specs += LayerSpec.Add(san(n.output.head), Seq(san(srcA), san(srcB)),
            Seq(inShape, inShape), inAQuant, inBQuant, outQuant)
          shapeOf(n.output.head) = inShape

        case "Softmax" =>
          val src        = resolve(n.input.head)
          val numClasses = shapeOf(src).channels
          if (emitLogits) {
            specs += LayerSpec.Output("output", san(src), TensorShape(1, 1, numClasses))
          } else {
            specs += LayerSpec.Softmax("softmax", san(src), numClasses)
            specs += LayerSpec.Output("output", "softmax", TensorShape(1, 1, 1))
          }

        case "Constant" | "Shape" | "Gather" | "Unsqueeze" | "Squeeze" =>
          () // pre-pass already handled; no feature-map output

        case "QGemm" =>
          // Quantized generalised matrix multiply: Y = alpha*(A ⊗ B) + beta*C.
          // MobileNetV2 uses transB=1, alpha=1, beta=1, so this is identical to
          // QLinearLinear. Input order: A, a_scale, a_zp, B, b_scale, b_zp, C, y_scale, y_zp.
          // With transB=1 the weight is stored [outNeurons, inNeurons] — already the layout
          // our QLinearLinearCore expects, so no transposition is needed.
          val src       = resolve(n.input(0))
          val inShape   = shapeOf(src)
          val inQuant   = QuantParams(scalarF(n.input(1)), remapZp(n.input(2)))
          val wT        = init(n.input(3))
          val wScale    = scalarF(n.input(4))
          val outQuant  = QuantParams(scalarF(n.input(7)), remapZp(n.input(8)))
          val outN      = wT.dims(0).toInt
          val inN       = wT.dims(1).toInt
          val weights   = OnnxCompiler.extractInt8Bytes(wT) // [outN, inN] — use directly
          val biasRaw   = if (n.input.length > 6) OnnxCompiler.extractIntData(init(n.input(6)))
                          else Array.fill(outN)(0)
          val biases    = zpBiasCorrect(biasRaw, weights, outN, inQuant.zeroPoint)
          val name      = san(n.output.head)
          specs += LayerSpec.Linear(name, san(src), inN, outN,
            inQuant, QuantParams(wScale, 0), outQuant, weights, biases)
          shapeOf(n.output.head) = TensorShape(1, 1, outN)

        case other =>
          throw new NotImplementedError(
            s"Quantized ONNX operator '$other' (node '${n.getName}') is not supported yet. " +
              s"Add a case to OnnxFrontend.lowerQuantized.")
      }
    }

    // Emit a terminal Output if no Softmax node was encountered (e.g. MobileNetV2
    // ends with QGemm directly, with no Softmax in the quantized graph).
    if (!specs.exists(_.isInstanceOf[LayerSpec.Output])) {
      val last = specs.filterNot(_.isInstanceOf[LayerSpec.Input]).last
      if (emitLogits) {
        specs += LayerSpec.Output("output", last.name, last.shape)
      } else {
        specs += LayerSpec.Softmax("softmax", last.name, last.shape.channels)
        specs += LayerSpec.Output("output", "softmax", TensorShape(1, 1, 1))
      }
    }

    specs.toSeq
  }

  /** Folds the input zero-point into int32 biases so the hardware accumulator
    * can compute `x_q ⊗ w_q + bias` instead of `(x_q - zp) ⊗ w_q + B`.
    *
    * Derivation: the correct int32 accumulation is
    *   acc[oc] = Σ_k (x_q[k] - zp) * w_q[oc,k] + B[oc]
    *           = Σ_k x_q[k]*w_q[oc,k]  -  zp * Σ_k w_q[oc,k]  +  B[oc]
    * so bias_corrected[oc] = B[oc] - zp * Σ_k w_q[oc,k].
    *
    * `rawW` must be in ONNX [outCh, ...] order (before any transposition).
    * Returns `biases` unchanged when zp == 0.
    */
  private def zpBiasCorrect(biases: Array[Int], rawW: Array[Byte], outCh: Int, inZp: Int): Array[Int] = {
    if (inZp == 0) return biases
    val elemsPerCh = rawW.length / outCh
    biases.zipWithIndex.map { case (b, oc) =>
      val wSum = (0 until elemsPerCh).foldLeft(0L)((s, k) => s + rawW(oc * elemsPerCh + k))
      (b.toLong - inZp.toLong * wSum).toInt
    }
  }

  // ── ONNX attribute readers ────────────────────────────────────────────────
  private def intsAttr(n: NodeProto, name: String): Option[Seq[Int]] =
    n.attribute.find(_.getName == name).filter(_.ints.nonEmpty).map(_.ints.map(_.toInt))

  private def floatAttr(n: NodeProto, name: String): Option[Float] =
    n.attribute.find(a => a.getName == name && a.f.isDefined).map(_.getF)

  // Reads a scalar integer ONNX attribute (stored as `a.i`, not as `a.ints`).
  // Handles both INT and INTS storage for robustness.
  private def intAttr(n: NodeProto, name: String): Option[Int] =
    n.attribute.find(_.getName == name).flatMap { a =>
      if (a.i.isDefined) Some(a.getI.toInt)
      else if (a.ints.nonEmpty) Some(a.ints.head.toInt)
      else None
    }

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
