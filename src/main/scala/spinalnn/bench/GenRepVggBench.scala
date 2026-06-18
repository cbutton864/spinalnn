package spinalnn.bench

import spinal.core._
import spinalnn._
import spinalnn.compiler.{OnnxCompiler, OnnxFrontend, LayerSpec}
import spinalnn.target._

/** Generates RepVGG-A0 INT8 Verilog for P&R benchmarking on Ti375N484.
  *
  * Configurations:
  *   ti375_ws_n32perlayer      — WeightStream, per-layer N=32 for C_in%32==0 layers,
  *                               N=16 default for C_in=48 layers; stem (C_in=3) → N=1.
  *   ti375_ws_n32perlayer_stemn3 — Same as above plus stem overridden to N=3.
  *                               Stem (C_in=3): 64%3≠0 → WeightRom fallback for that
  *                               layer only; costs 3 DSPs vs 1; reduces stem cycles 3×.
  *
  * Note: P>1 is not yet supported with WeightStream (QLinearConvLineCore has no P
  * path). Per-layer N overrides achieve equivalent speedup through input-channel
  * parallelism. P>1 WeightStream is tracked in FUTURE_ROADMAP.md §Phase 2.5.
  *
  * Output: rtl/repvgg_bench/{variant}/SpinalNNTop.v
  *
  * Usage:
  *   sbt "runMain spinalnn.bench.GenRepVggBench"
  *
  * Then run P&R via benchmark_repvgg_ti375/RUNMAP_spinalnn_repvgg_ti375.
  */
object GenRepVggBench extends App {

  val modelPath = "models/repvgg_a0-int8.onnx"
  val model     = OnnxCompiler.loadModel(modelPath)
  val specs     = OnnxFrontend.lowerQuantized(model, emitLogits = true)

  val convSpecs = specs.collect { case c: LayerSpec.Conv => c }

  // Identify the stem layer (C_in=3, first conv).
  val stemName = convSpecs.find(_.inputShape.channels == 3).map(_.name).getOrElse(
    throw new Exception("No stem conv with C_in=3 found in RepVGG-A0"))

  // N=32 for any layer where C_in is divisible by 32 (C_in=96, 192, 1280 in RepVGG-A0).
  // C_in=48 layers (48%32≠0) stay at default N=16 (48%16=0).
  val n32overrides: Map[String, Int] = convSpecs
    .filter(c => c.inputShape.channels % 32 == 0 && c.inputShape.channels >= 32)
    .map(_.name -> 32)
    .toMap

  println(s"[GenRepVggBench] Stem layer: $stemName")
  println(s"[GenRepVggBench] N=32 eligible layers (C_in%32==0): ${n32overrides.size}")

  val ti375 = TargetConfig(device = DeviceSpec.Ti375N484)

  val configs: Seq[(String, TargetConfig)] = Seq(
    "ti375_ws_n32perlayer" ->
      ti375.withWeightMode(WeightStream)
           .withMacPar(MacParPerLayer(n32overrides, default = 16)),

    "ti375_ws_n32perlayer_stemn3" ->
      ti375.withWeightMode(WeightStream)
           .withMacPar(MacParPerLayer(n32overrides + (stemName -> 3), default = 16))
  )

  for ((label, tgt) <- configs) {
    val dir = s"rtl/repvgg_bench/$label"
    new java.io.File(dir).mkdirs()

    val cfg = SpinalConfig(
      defaultClockDomainFrequency  = FixedFrequency(150 MHz),
      defaultConfigForClockDomains = ClockDomainConfig(
        resetKind        = ASYNC,
        resetActiveLevel = HIGH
      ),
      targetDirectory = dir
    )

    cfg.generateVerilog {
      val top = new SpinalNNTop(
        Params(profile = spinalnn.OnnxPathProfile(modelPath, emitLogits = true)).withTarget(tgt)
      )
      top.clockDomain.clock.setName("clk")
      top.clockDomain.reset.setName("reset")
      top
    }

    println(s"[GenRepVggBench] $label -> $dir/SpinalNNTop.v")
  }

  println()
  println("To run P&R on ti375_ws_n32perlayer_stemn3 (primary):")
  println("  cp rtl/repvgg_bench/ti375_ws_n32perlayer_stemn3/*.bin benchmark_repvgg_ti375/")
  println("  cd benchmark_repvgg_ti375 && ./RUNMAP_spinalnn_repvgg_ti375")
}
