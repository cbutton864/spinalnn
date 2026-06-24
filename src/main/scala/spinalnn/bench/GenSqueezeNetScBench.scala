package spinalnn.bench

import spinal.core._
import spinalnn._
import spinalnn.target.{TargetConfig, WeightStochastic, DeviceSpec}

// Generates SqueezeNet 1.0 SC (MUX-MAC stochastic) Verilog for Ti180M484 P&R.
//
// Research question (B9): At SqueezeNet/ImageNet scale, is SC BRAM-bounded or DSP-bounded?
//   INT8 N=16 WeightStream: 512/512 DSP ceiling, no headroom for larger N
//   SC N=255: 0 MAC DSPs, but ALL weights live in BRAM ROM (no WeightStream in SC path)
//   SqueezeNet INT8 WeightRom: 988 RAM10K (78% of Ti180 capacity)
//   SC adds ~12.5% for wSignRom + combAdjRom, plus actBuf per SC layer -> likely >1280 cap
//
// Key trade-off to confirm empirically:
//   SC is DSP-optimal (zero MAC DSPs) but BRAM-greedy (two ROMs per conv layer).
//   BRAM bottleneck may block SC at ImageNet scale unless WeightStream is added to SC path.
//
// Output: rtl/squeezenet_sc/sc_N255/SpinalNNTop.v + ROM .bin files
object GenSqueezeNetScBench extends App {

  val ti180 = TargetConfig(device = DeviceSpec.Ti180M484)
    .withWeightPrecision(WeightStochastic(255))

  val dir = "rtl/squeezenet_sc/sc_N255"
  new java.io.File(dir).mkdirs()

  val cfg = SpinalConfig(
    defaultClockDomainFrequency  = FixedFrequency(150 MHz),
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind        = ASYNC,
      resetActiveLevel = HIGH
    ),
    targetDirectory = dir
  )

  print(s"[GenSqueezeNetScBench] elaborating SqueezeNet SC N=255 ... ")
  cfg.generateVerilog {
    val top = new SpinalNNTop(Params.squeezenet.withTarget(ti180))
    top.clockDomain.clock.setName("clk")
    top.clockDomain.reset.setName("reset")
    top
  }
  println(s"-> $dir/SpinalNNTop.v")
  println()
  println("Next steps:")
  println("  mkdir -p benchmark_sqz_sc_n255_ti180/outflow")
  println("  cp rtl/squeezenet_sc/sc_N255/*.bin benchmark_sqz_sc_n255_ti180/")
  println("  ./pnr_run.sh benchmark_sqz_sc_n255_ti180 sqz_sc_N255_ti180")
}
