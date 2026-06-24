package spinalnn.bench

import spinal.core._
import spinalnn._
import spinalnn.compiler.{OnnxCompiler, OnnxFrontend, LayerSpec}
import spinalnn.target._

/** Generates RepVGG-A0 INT8 Verilog for P&R benchmarking on Ti375N484.
  *
  * Configurations:
  *   ti375_ws_n32perlayer        — WeightStream, N=32 where C_in%32==0, N=16 default;
  *                                 stem (C_in=3) → N=1.
  *   ti375_ws_n32perlayer_stemn3 — Same + stem N=3 (64%3≠0 → WeightRom; −20% stem cycles).
  *   ti375_ws_n32n48perlayer_stemn3 — Primary Ti375 target. Adds N=48 for all C_in=48
  *                                 layers (stages_1_0/1_1/2_0). 64%48≠0 → WeightRom
  *                                 fallback for those layers (~8 RAM10K total; negligible
  *                                 on Ti375). Gives 3× speedup on C_in=48 layers, which
  *                                 dominate ~67% of total inference cycles post-stemn3 fix.
  *                                 Expected: ~1.8× FPS over stemn3 variant.
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

  // N=32 for layers where C_in%32==0 (C_in=96, 192, 1280 in RepVGG-A0).
  // N=48 for C_in=48 layers (stages_1_0/1_1/2_0); 64%48≠0 → WeightRom fallback for those.
  // C_in=48 layers stay at default N=16 in the n32-only configs (48%32≠0, 48%16=0).
  val n32overrides: Map[String, Int] = convSpecs
    .filter(c => c.inputShape.channels % 32 == 0 && c.inputShape.channels >= 32)
    .map(_.name -> 32)
    .toMap

  val n48overrides: Map[String, Int] = convSpecs
    .filter(c => c.inputShape.channels == 48)
    .map(_.name -> 48)
    .toMap

  println(s"[GenRepVggBench] Stem layer: $stemName")
  println(s"[GenRepVggBench] N=32 eligible layers (C_in%32==0, C_in>=32): ${n32overrides.size}")
  println(s"[GenRepVggBench] N=48 eligible layers (C_in==48): ${n48overrides.size}")

  val ti375 = TargetConfig(device = DeviceSpec.Ti375N484)

  val configs: Seq[(String, TargetConfig)] = Seq(
    "ti375_ws_n32perlayer" ->
      ti375.withWeightMode(WeightStream)
           .withMacPar(MacParPerLayer(n32overrides, default = 16)),

    "ti375_ws_n32perlayer_stemn3" ->
      ti375.withWeightMode(WeightStream)
           .withMacPar(MacParPerLayer(n32overrides + (stemName -> 3), default = 16)),

    // Primary Ti375 target: N=48 on the three C_in=48 body layers (64%48≠0 → auto WeightRom
    // fallback for those layers only; all C_in>=96 layers stay WeightStream N=32).
    "ti375_ws_n32n48perlayer_stemn3" ->
      ti375.withWeightMode(WeightStream)
           .withMacPar(MacParPerLayer(n32overrides ++ n48overrides + (stemName -> 3), default = 16))
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
  println("To run P&R on ti375_ws_n32n48perlayer_stemn3 (primary):")
  println("  cp rtl/repvgg_bench/ti375_ws_n32n48perlayer_stemn3/*.bin benchmark_repvgg_ti375/")
  println("  cd benchmark_repvgg_ti375 && ./RUNMAP_spinalnn_repvgg_ti375")
}
