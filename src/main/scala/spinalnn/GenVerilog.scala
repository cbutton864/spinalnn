package spinalnn

import spinal.core._
import spinalnn.target.{DeviceSpec, TargetConfig}

object GenVerilog extends App {

  def spinalCfg(target: TargetConfig, dir: String): SpinalConfig =
    SpinalConfig(
      defaultClockDomainFrequency  = FixedFrequency(target.options.targetFreqMhz MHz),
      defaultConfigForClockDomains = ClockDomainConfig(
        resetKind        = ASYNC,
        resetActiveLevel = HIGH
      ),
      targetDirectory = dir
    )

  def gen(params: Params, dir: String): Unit = {
    spinalCfg(params.target, dir).generateVerilog {
      val top = new SpinalNNTop(params)
      top.clockDomain.clock.setName("clk")
      top.clockDomain.reset.setName("reset")
      top
    }
  }

  val ti180 = TargetConfig(device = DeviceSpec.Ti180M484)

  gen(Params.onnx.withTarget(ti180),                          "rtl/flat")
  gen(Params.onnx.withTarget(ti180).hierarchical,             "rtl/hierarchical")
  gen(Params.squeezenet.withTarget(ti180),                    "rtl/squeezenet_flat")
  gen(Params.mobilenetv2.withTarget(ti180),                   "rtl/mobilenet_flat")

  println("Verilog generation complete.")
  println(s"  Target:        ${ti180}")
  println("  Flat (MNIST):  rtl/flat/")
  println("  Hierarchical:  rtl/hierarchical/")
  println("  SqueezeNet:    rtl/squeezenet_flat/")
  println("  MobileNetV2:   rtl/mobilenet_flat/")
}
