package spinalnn.bench

import spinalnn.compiler._

object PrintSqueezeNetSweep extends App {

  val model = OnnxCompiler.loadModel("models/squeezenet1.0-12-int8.onnx")
  val specs = OnnxFrontend.lowerQuantized(model, emitLogits = false)

  // ── Layer inventory ───────────────────────────────────────────────────────
  println("=== SqueezeNet 1.0 INT8 — Layer Inventory ===")
  specs.foreach {
    case c: LayerSpec.Conv =>
      println(f"  Conv    ${c.name}%-44s  C_in=${c.inputShape.channels}%4d  C_out=${c.shape.channels}%4d  k=${c.kernelH}x${c.kernelW}  in=${c.inputShape.rows}x${c.inputShape.cols}")
    case p: LayerSpec.MaxPool =>
      println(f"  MaxPool ${p.name}%-44s  in=${p.inputShape.rows}x${p.inputShape.cols}x${p.inputShape.channels}")
    case s =>
      println(f"  ${s.getClass.getSimpleName}%-10s  ${s.name}")
  }

  // ── N sweep: WeightRom vs WeightStream, 150 MHz ───────────────────────────
  println()
  println("=== N sweep @ 150 MHz — WeightRom ===")
  println(ModelCycleEstimator.sweep(specs, ns = Seq(1, 2, 4, 8, 16, 32), freqMHz = 150.0, weightStream = false))

  println("=== N sweep @ 150 MHz — WeightStream (512-bit DMA) ===")
  println(ModelCycleEstimator.sweep(specs, ns = Seq(1, 2, 4, 8, 16, 32), freqMHz = 150.0, weightStream = true))

  // ── Per-layer N assignment check for MacParFixed(8) ───────────────────────
  println("=== macParAssignment — MacParFixed(8) ===")
  println(ModelCycleEstimator.macParAssignment(specs, spinalnn.target.MacParFixed(8)))

  println("=== macParAssignment — MacParFixed(16) ===")
  println(ModelCycleEstimator.macParAssignment(specs, spinalnn.target.MacParFixed(16)))

  // ── Per-layer config matching squeezenet_ti180_perLayer.json ─────────────
  val perLayerPolicy = spinalnn.target.MacParPerLayer(
    overrides = Map(
      "fire4_squeeze1x1_1_quantized" -> 32,
      "fire5_squeeze1x1_1_quantized" -> 32,
      "fire6_squeeze1x1_1_quantized" -> 32,
      "fire7_squeeze1x1_1_quantized" -> 32,
      "fire8_squeeze1x1_1_quantized" -> 32,
      "fire9_squeeze1x1_1_quantized" -> 32,
      "conv10_1_quantized"           -> 32
    ),
    default = 16
  )
  println("=== macParAssignment — perLayer (default=16, squeeze/conv10=32) ===")
  println(ModelCycleEstimator.macParAssignment(specs, perLayerPolicy))

  println("=== N sweep @ 150 MHz — perLayer WeightStream ===")
  val perLayerEst = ModelCycleEstimator.estimate(specs, perLayerPolicy, weightStream = true)
  println(perLayerEst.report(150.0))
}
