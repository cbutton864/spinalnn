package spinalnn

import org.scalatest.funsuite.AnyFunSuite
import spinal.core._
import spinalnn.compiler.OnnxCompiler

class OnnxInspectionTest extends AnyFunSuite {

  test("Natively inspect MNIST standard ONNX model") {
    OnnxCompiler.inspectModel("models/mnist-8.onnx")
  }

  test("Compile ONNX model and elaborate/generate Verilog") {
    val params = Params.onnx
    val config = SpinalConfig(
      targetDirectory = "target/tmp_rtl",
      defaultClockDomainFrequency = FixedFrequency(150 MHz),
      defaultConfigForClockDomains = ClockDomainConfig(
        resetKind = ASYNC,
        resetActiveLevel = HIGH
      )
    )

    // Elaborate and generate Verilog for the ONNX-compiled network
    config.generateVerilog {
      val top = new SpinalNNTop(params)
      top.clockDomain.clock.setName("clk")
      top.clockDomain.reset.setName("reset")
      top
    }

    println("Elaboration of ONNX compiled model succeeded; Verilog written to target/tmp_rtl.")
  }
}
