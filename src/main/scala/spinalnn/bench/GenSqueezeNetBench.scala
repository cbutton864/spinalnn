package spinalnn.bench

import spinal.core._
import spinalnn._
import spinalnn.target._

/** Generates SqueezeNet Verilog variants for P&R benchmarking on Ti180M484.
  *
  * Configurations:
  *   ws_n1          — WeightStream, N=1 (old baseline)
  *   ws_n16         — WeightStream, N=16 (Phase 1 DMA target)
  *   ws_n16_conv1n3 — WeightStream, N=16 global with conv1 overridden to N=3.
  *                    conv1 (C_in=3) can't use the 512-bit beat drain (64%3≠0) so it
  *                    auto-falls back to WeightRom with N=3 MACs — costs 3 DSPs vs 1,
  *                    reduces conv1 cycles by ~3×, expected +1.5× total FPS.
  *
  * Output: rtl/squeezenet_bench/{ws_n1,ws_n16,ws_n16_conv1n3}/SpinalNNTop.v
  *
  * Usage:
  *   sbt "runMain spinalnn.bench.GenSqueezeNetBench"
  *
  * Then point the benchmark_squeezenet_ti180 P&R scripts at the desired variant.
  * The ws_n16_conv1n3 build is the primary candidate for the conv1-bottleneck fix.
  */
object GenSqueezeNetBench extends App {

  val ti180 = TargetConfig(device = DeviceSpec.Ti180M484)

  val configs: Seq[(String, TargetConfig)] = Seq(
    "ws_n1" ->
      ti180.withWeightMode(WeightStream).withMacPar(MacParFixed(1)),

    "ws_n16" ->
      ti180.withWeightMode(WeightStream).withMacPar(MacParFixed(16)),

    "ws_n16_conv1n3" ->
      ti180.withWeightMode(WeightStream)
           .withMacPar(MacParPerLayer(Map("conv1_1_quantized" -> 3), default = 16))
  )

  for ((label, tgt) <- configs) {
    val dir = s"rtl/squeezenet_bench/$label"
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
      val top = new SpinalNNTop(Params.squeezenet.withTarget(tgt))
      top.clockDomain.clock.setName("clk")
      top.clockDomain.reset.setName("reset")
      top
    }

    println(s"[GenSqueezeNetBench] $label -> $dir/SpinalNNTop.v")
  }

  println()
  println("To run P&R on ws_n16_conv1n3 (primary):")
  println("  cp rtl/squeezenet_bench/ws_n16_conv1n3/SpinalNNTop.v rtl/squeezenet_flat/SpinalNNTop.v")
  println("  cp rtl/squeezenet_bench/ws_n16_conv1n3/*.bin benchmark_squeezenet_ti180/")
  println("  cd benchmark_squeezenet_ti180 && ./RUNMAP_spinalnn_squeezenet_ti180")
}
