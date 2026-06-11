package spinalnn.bench

import spinalnn.compiler._
import spinalnn.target._

object PrintRepVggSweep extends App {

  val model = OnnxCompiler.loadModel("models/repvgg_a0-int8.onnx")
  val specs = OnnxFrontend.lowerQuantized(model, emitLogits = true)

  // ── Layer inventory ───────────────────────────────────────────────────────
  println("=== RepVGG-A0 INT8 — Layer Inventory ===")
  specs.foreach {
    case c: LayerSpec.Conv =>
      val canN32 = if (c.inputShape.channels % 32 == 0) "N=32 OK" else s"N=${c.inputShape.channels} max=${gcd(c.inputShape.channels,32)}"
      println(f"  Conv  ${c.name}%-52s  C_in=${c.inputShape.channels}%4d  C_out=${c.shape.channels}%4d  k=${c.kernelH}x${c.kernelW}  in=${c.inputShape.rows}x${c.inputShape.cols}  $canN32")
    case gap: LayerSpec.GlobalAveragePool =>
      println(f"  GAP   ${gap.name}%-52s  C=${gap.inputShape.channels}")
    case l: LayerSpec.Linear =>
      println(f"  Linear ${l.name}%-51s  in=${l.inNeurons}  out=${l.outNeurons}")
    case s =>
      println(f"  ${s.getClass.getSimpleName}%-10s  ${s.name}")
  }

  // ── N sweep @ 173 MHz (actual fmax from P&R) ──────────────────────────────
  println()
  println("=== N sweep @ 173.3 MHz — WeightStream (512-bit DMA) ===")
  println(ModelCycleEstimator.sweep(specs, ns = Seq(1, 4, 8, 16, 32), freqMHz = 173.3, weightStream = true))

  // ── Current baseline: N=16 global ─────────────────────────────────────────
  println("=== Baseline N=16 @ 173.3 MHz — per-layer breakdown ===")
  val baselineEst = ModelCycleEstimator.estimate(specs, macN = 16, weightStream = true)
  println(baselineEst.report(173.3))

  // ── Per-layer N=32 for C_in-divisible-by-32 layers ───────────────────────
  // RepVGG-A0 channel layout: 48 -> 48 -> 96 -> 192 -> 1280
  // N=32 requires C_in % 32 == 0: layers with C_in=96, 192, 1280 qualify.
  // C_in=48 layers (48%32=16) stay at N=16.
  val convSpecs = specs.collect { case c: LayerSpec.Conv => c }
  val n32layers = convSpecs
    .filter(c => c.inputShape.channels % 32 == 0 && c.inputShape.channels >= 32)
    .map(_.name -> 32)
    .toMap

  println(s"\nLayers eligible for N=32 (C_in % 32 == 0): ${n32layers.size}")
  n32layers.toSeq.sortBy(_._1).foreach { case (n, _) =>
    val c = convSpecs.find(_.name == n).get
    println(f"  ${n}%-52s  C_in=${c.inputShape.channels}  C_out=${c.shape.channels}")
  }

  val perLayerPolicy = MacParPerLayer(overrides = n32layers, default = 16)
  println("\n=== Per-layer N=32 (C_in>=32 divisible) @ 173.3 MHz ===")
  val perLayerEst = ModelCycleEstimator.estimate(specs, perLayerPolicy, weightStream = true)
  println(perLayerEst.report(173.3))

  println("=== macParAssignment (N=16 global) ===")
  println(ModelCycleEstimator.macParAssignment(specs, MacParFixed(16)))

  def gcd(a: Int, b: Int): Int = if (b == 0) a else gcd(b, a % b)
}
