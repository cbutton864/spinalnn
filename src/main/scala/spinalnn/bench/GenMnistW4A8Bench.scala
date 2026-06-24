package spinalnn.bench

import spinal.core._
import spinalnn._
import spinalnn.target.{MacParPerLayer, TargetConfig, WeightInt4, WeightStochastic}

/** Generates Verilog for precision comparison on MNIST-8 with Ti180M484.
  *
  * Four configurations (apples-to-apples on same device and model):
  *   int8_N1  — INT8, N=1 everywhere (serial baseline floor)
  *   int8_N8  — INT8, N=8 on conv2 (standard parallel; DSP multipliers)
  *   w4a8_N8  — W4A8, N=8 on conv2 (LUT shift-and-add; half weight BRAM; fewer DSPs)
  *   sc_N255  — MUX-MAC stochastic, N=255 bitstream (Lee et al. 2024; zero MAC DSPs)
  *
  * Expected resource trajectory (int8_N1 → int8_N8 → w4a8_N8 → sc_N255):
  *   DSP    — 15 → 22 → 13 → ~4 (only sDecode + linear requant remain for SC)
  *   LUT4   — ~920 → ~920 → ~2028 → TBD (SC: LFSR + popcount tree, no shift-add)
  *   RAM10K — 26 → 34 → 44 → TBD (SC: actBuf + wThrRom + wSignRom + combAdjRom)
  *   Cycles — many × N → C_out×(nMac+N+1) per spatial position (SC is throughput-limited)
  *
  * Output: rtl/mnist_w4a8/{int8_N1,int8_N8,w4a8_N8,sc_N255}/SpinalNNTop.v
  *
  * Usage:
  *   sbt "runMain spinalnn.bench.GenMnistW4A8Bench"
  *
  * Then run P&R on all configs via pnr_run.sh and compare pnr_results.tsv.
  */
object GenMnistW4A8Bench extends App {

  val configs: Seq[(String, TargetConfig)] = Seq(
    "int8_N1" ->
      TargetConfig.default,

    "int8_N8" ->
      TargetConfig.default
        .withMacPar(MacParPerLayer(Map("conv2" -> 8), default = 1)),

    "w4a8_N8" ->
      TargetConfig.default
        .withMacPar(MacParPerLayer(Map("conv2" -> 8), default = 1))
        .withWeightPrecision(WeightInt4),

    "sc_N255" ->
      TargetConfig.default
        .withWeightPrecision(WeightStochastic(255))
  )

  for ((label, tgt) <- configs) {
    val dir = s"rtl/mnist_w4a8/$label"
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
      val top = new SpinalNNTop(Params.onnx.withTarget(tgt))
      top.clockDomain.clock.setName("clk")
      top.clockDomain.reset.setName("reset")
      top
    }

    println(s"[GenMnistW4A8Bench] $label -> $dir/SpinalNNTop.v")
  }

  println()
  println("To run P&R on all four configs:")
  println("  for cfg in int8_N1 int8_N8 w4a8_N8 sc_N255; do")
  println("    ./pnr_run.sh <benchmark_dir> mnist_w4a8_${cfg} &")
  println("  done")
  println("  wait && cat pnr_results.tsv")
}
