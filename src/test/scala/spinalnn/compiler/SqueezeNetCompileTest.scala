package spinalnn.compiler

import org.scalatest.funsuite.AnyFunSuite
import spinalnn.types.TensorShape

/** IR-structure test for the pre-quantized (QOperator) SqueezeNet reader.
  *
  * This validates `OnnxFrontend.lowerQuantized` cheaply: it parses the real
  * `squeezenet1.0-12-int8.onnx` and asserts the recovered op topology (counts,
  * input shape, fan-out, terminal) without elaborating any hardware. A full
  * Verilator sim of SqueezeNet is impractical (224x224x3 -> 26 convs is billions
  * of cycles), so structural lowering is the right validation layer here.
  *
  * The model is a gitignored binary under `models/`; the test is skipped (via
  * `assume`) when it is absent so CI stays green without the asset.
  */
class SqueezeNetCompileTest extends AnyFunSuite {

  private val modelPath = "models/squeezenet1.0-12-int8.onnx"

  private def loadSpecs(emitLogits: Boolean): Seq[LayerSpec] = {
    assume(new java.io.File(modelPath).exists(), s"$modelPath not present; skipping")
    val model = OnnxCompiler.loadModel(modelPath)
    assert(OnnxFrontend.isQuantized(model), "model should be detected as a QOperator graph")
    OnnxFrontend.lowerQuantized(model, emitLogits)
  }

  private def count[T <: LayerSpec](specs: Seq[LayerSpec])(implicit ct: scala.reflect.ClassTag[T]): Int =
    specs.count(ct.runtimeClass.isInstance)

  test("lowers SqueezeNet QOperator graph to the expected op topology") {
    val specs = loadSpecs(emitLogits = false)

    // One faithful LayerSpec per feature-map ONNX op (Q/DQ around Concats folded away).
    assert(count[LayerSpec.Conv](specs)              == 26, "expected 26 QLinearConv")
    assert(count[LayerSpec.Concat](specs)            == 8,  "expected 8 Concat (fire modules)")
    assert(count[LayerSpec.MaxPool](specs)           == 3,  "expected 3 MaxPool")
    assert(count[LayerSpec.GlobalAveragePool](specs) == 1,  "expected 1 GlobalAveragePool")
    assert(count[LayerSpec.Input](specs)             == 1,  "expected 1 Input")

    // emitLogits = false terminates with argmax: Softmax + Output(1x1x1).
    assert(count[LayerSpec.Softmax](specs) == 1, "expected 1 Softmax")
    val out = specs.collect { case o: LayerSpec.Output => o }
    assert(out.length == 1, "expected exactly one terminal Output")
    assert(out.head.shape == TensorShape(1, 1, 1), "argmax output is 1x1x1")
  }

  test("recovers the 224x224x3 input and every per-channel weight scale") {
    val specs = loadSpecs(emitLogits = false)

    val in = specs.collectFirst { case i: LayerSpec.Input => i }.get
    assert(in.shape == TensorShape(224, 224, 3), s"input should be 224x224x3, got ${in.shape}")

    // SqueezeNet int8 is per-channel: every conv must carry one weight scale per output
    // channel (the per-channel requant path), never the per-tensor fallback.
    val convs = specs.collect { case c: LayerSpec.Conv => c }
    convs.foreach { c =>
      assert(c.weightScales.isDefined, s"conv '${c.name}' lost its per-channel weight scales")
      assert(c.weightScales.get.length == c.shape.channels,
        s"conv '${c.name}' has ${c.weightScales.get.length} scales for ${c.shape.channels} out channels")
    }
  }

  test("detects fire-module fan-out (squeeze feeds both expand branches)") {
    val specs = loadSpecs(emitLogits = false)

    // Count how many specs consume each tensor. Each fire module's squeeze output
    // feeds two expand convs, so 8 tensors must be consumed at least twice.
    def consumed(s: LayerSpec): Seq[String] = s match {
      case c: LayerSpec.Concat            => c.inputs
      case c: LayerSpec.Conv              => Seq(c.input)
      case c: LayerSpec.MaxPool           => Seq(c.input)
      case c: LayerSpec.GlobalAveragePool => Seq(c.input)
      case c: LayerSpec.Softmax           => Seq(c.input)
      case c: LayerSpec.Output            => Seq(c.input)
      case _                              => Nil
    }
    val usage = specs.flatMap(consumed).groupBy(identity).view.mapValues(_.size).toMap
    val fanOuts = usage.count(_._2 >= 2)
    assert(fanOuts >= 8, s"expected >= 8 fan-out tensors (one per fire module), got $fanOuts")
  }

  test("zero-point bias correction is applied for non-zero input zp") {
    assume(new java.io.File(modelPath).exists(), s"$modelPath not present; skipping")
    val model  = OnnxCompiler.loadModel(modelPath)
    val graph  = model.getGraph
    val specs  = OnnxFrontend.lowerQuantized(model, emitLogits = true)

    val firstConv = specs.collect { case c: LayerSpec.Conv => c }.head
    val inZp      = firstConv.inputQuant.zeroPoint
    assume(inZp != 0, "model has zero input zp; correction is a no-op and cannot be validated here")

    // Locate the matching QLinearConv ONNX node and verify the bias is corrected.
    val qcNode = graph.node.find(_.getOpType == "QLinearConv").get
    assume(qcNode.input.length > 8, "first QLinearConv has no bias tensor")

    val wT         = OnnxCompiler.getInitializer(graph, qcNode.input(3))
    val rawW       = OnnxCompiler.extractInt8Bytes(wT)
    val outCh      = wT.dims(0).toInt
    val elemsPerCh = rawW.length / outCh
    val rawBias    = OnnxCompiler.extractIntData(OnnxCompiler.getInitializer(graph, qcNode.input(8)))

    val expectedBias = rawBias.zipWithIndex.map { case (b, oc) =>
      val wSum = (0 until elemsPerCh).foldLeft(0L)((s, k) => s + rawW(oc * elemsPerCh + k))
      (b.toLong - inZp.toLong * wSum).toInt
    }

    assert(firstConv.biases.sameElements(expectedBias),
      s"bias[0]: expected ${expectedBias.head}, got ${firstConv.biases.head}")
  }

  test("emitLogits exposes the 1000-class logit tap and drops Softmax") {
    val specs = loadSpecs(emitLogits = true)

    assert(count[LayerSpec.Softmax](specs) == 0, "logit-tap mode must not emit Softmax")
    val out = specs.collect { case o: LayerSpec.Output => o }
    assert(out.length == 1, "expected exactly one terminal Output")
    assert(out.head.shape == TensorShape(1, 1, 1000), s"logit output is 1x1x1000, got ${out.head.shape}")
  }
}
