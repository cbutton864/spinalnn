package spinalnn.bench

import spinal.core._
import spinalnn._
import spinalnn.target.{TargetConfig, WeightStochastic, WeightStream, DeviceSpec}

// Generates SqueezeNet 1.0 SC+WeightStream Verilog for Ti180M484 P&R.
//
// Research question (B10): Does SC+WeightStream fix the BRAM overflow seen in B9?
//   B9 (SC WeightRom): 3,046 RAM10K — overwhelmed Ti180 cap of 1,280
//   B10 (SC WeightStream): wThrRom + wSignRom replaced by DMA beat-drain.
//   Expected: ~actBuf + combAdjRom only → much less BRAM.
//
// Output: rtl/squeezenet_sc/sc_N255_ws/SpinalNNTop.v
object GenSqueezeNetScWsBench extends App {

  val ti180 = TargetConfig(device = DeviceSpec.Ti180M484)
    .withWeightPrecision(WeightStochastic(255))
    .withWeightMode(WeightStream)

  val dir = "rtl/squeezenet_sc/sc_N255_ws"
  new java.io.File(dir).mkdirs()

  val cfg = SpinalConfig(
    defaultClockDomainFrequency  = FixedFrequency(150 MHz),
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind        = ASYNC,
      resetActiveLevel = HIGH
    ),
    targetDirectory = dir
  )

  print(s"[GenSqueezeNetScWsBench] elaborating SqueezeNet SC+WeightStream N=255 ... ")
  cfg.generateVerilog {
    val top = new SpinalNNTop(Params.squeezenet.withTarget(ti180))
    top.clockDomain.clock.setName("clk")
    top.clockDomain.reset.setName("reset")
    top
  }
  println(s"-> $dir/SpinalNNTop.v")
}
