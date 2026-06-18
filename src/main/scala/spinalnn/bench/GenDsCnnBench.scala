package spinalnn.bench

import spinal.core._
import spinalnn._
import spinalnn.target._

/** Generates DS-CNN-S INT8 Verilog for P&R benchmarking on Ti90J484.
  *
  * Configuration:
  *   ti90_wr_n16_p2 — WeightRom, N=16 (PWConv), P=2 output-channel parallelism.
  *
  *   Note: P>1 requires QLinearConvCore (full-buffer path). WeightStream forces
  *   QLinearConvLineCore which ignores P, so WeightRom is used here.
  *   DS-CNN-S weights (~25 KB INT8) fit comfortably in Ti90 BRAM (6.88 Mb).
  *
  * Expected: ~190 DSP, ~290 RAM10K; fits Ti90J484 (336 DSP, 672 RAM10K).
  * Stem (C_in=1) falls back to N=1; DWConv layers have no N/P axis.
  *
  * Output: rtl/dscnn_bench/ti90_wr_n16_p2/SpinalNNTop.v
  *
  * Usage:
  *   sbt "runMain spinalnn.bench.GenDsCnnBench"
  *
  * Then run P&R via benchmark_dscnn_ti90_n16p2/RUNMAP_spinalnn_dscnn_ti90_n16p2.
  */
object GenDsCnnBench extends App {

  val modelPath = "models/dscnn_s-int8.onnx"

  val ti90 = TargetConfig(device = DeviceSpec.Ti90J484)
  val tgt  = ti90
    .withMacPar(MacParFixed(16))
    .withOutPar(2)

  val dir = "rtl/dscnn_bench/ti90_wr_n16_p2"
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
      Params(profile = OnnxPathProfile(modelPath, emitLogits = false)).withTarget(tgt)
    )
    top.clockDomain.clock.setName("clk")
    top.clockDomain.reset.setName("reset")
    top
  }

  println(s"[GenDsCnnBench] ti90_wr_n16_p2 -> $dir/SpinalNNTop.v")
  println()
  println("To run P&R:")
  println("  cp rtl/dscnn_bench/ti90_wr_n16_p2/*.bin benchmark_dscnn_ti90_n16p2/")
  println("  cd benchmark_dscnn_ti90_n16p2 && ./RUNMAP_spinalnn_dscnn_ti90_n16p2")
}
