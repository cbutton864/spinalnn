package spinalnn

import spinal.core._
import spinalnn.util._

object GenVerilog extends App {

  val cfg = SpinalConfig(
    defaultClockDomainFrequency  = FixedFrequency(150 MHz),
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind        = ASYNC,
      resetActiveLevel = HIGH
    )
  )

  def gen(params: Params, dir: String): Unit = {
    cfg.copy(targetDirectory = dir).generateVerilog {
      val top = new SpinalNNTop(params)
      top.clockDomain.clock.setName("clk")
      top.clockDomain.reset.setName("reset")
      top
    }
  }

  gen(Params.onnx,                                    "rtl/flat")
  gen(Params.onnx.copy(buildEnv = BuildEnv(HierarchicalBuild)), "rtl/hierarchical")

  println("Verilog generation complete.")
  println("  Flat:         rtl/flat/")
  println("  Hierarchical: rtl/hierarchical/")
}
