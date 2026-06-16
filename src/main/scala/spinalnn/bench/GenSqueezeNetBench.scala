package spinalnn.bench

import spinal.core._
import spinalnn._
import spinalnn.target._

/** Generates SqueezeNet Verilog variants for P&R benchmarking on Ti180M484.
  *
  * Configurations:
  *   ws_n1   — WeightStream, N=1 (old baseline)
  *   ws_n16  — WeightStream, N=16 (Phase 1 target)
  *
  * Output: rtl/squeezenet_bench/{ws_n1,ws_n16}/SpinalNNTop.v
  *
  * Usage:
  *   sbt "runMain spinalnn.bench.GenSqueezeNetBench"
  *
  * Then point the benchmark_squeezenet_ti180 P&R scripts at the desired variant.
  * The ws_n16 build is the primary candidate; ws_n1 is the reference baseline.
  */
object GenSqueezeNetBench extends App {

  val ti180 = TargetConfig(device = DeviceSpec.Ti180M484)

  val configs: Seq[(String, TargetConfig)] = Seq(
    "ws_n1" ->
      ti180.withWeightMode(WeightStream).withMacPar(MacParFixed(1)),

    "ws_n16" ->
      ti180.withWeightMode(WeightStream).withMacPar(MacParFixed(16))
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
  println("To run P&R on ws_n16:")
  println("  cp rtl/squeezenet_bench/ws_n16/SpinalNNTop.v rtl/squeezenet_flat/SpinalNNTop.v")
  println("  cd benchmark_squeezenet_ti180 && ./RUNMAP_spinalnn_squeezenet_ti180")
}
