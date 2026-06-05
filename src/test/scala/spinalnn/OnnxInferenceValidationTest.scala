package spinalnn

import org.scalatest.funsuite.AnyFunSuite
import spinal.core.sim._
import spinalnn.types._
import spinalnn.util._

class OnnxInferenceValidationTest extends AnyFunSuite {

  // Compile the top-level ONNX profile with full real weights loaded from `models/mnist-8.onnx`
  def compileOnnx() =
    SimConfig
      .withWave
      .workspacePath("simWorkspace/OnnxInferenceValidationTest")
      .compile(new SpinalNNTop(Params.onnx))

  // Scales float activation input in [0, 1] to symmetric SInt8 in [0, 127]
  def quantizeInput(floats: Array[Float]): Array[Byte] = {
    floats.map { f =>
      val quantized = Math.round(f * 127.0f)
      val clamped = Math.max(-128, Math.min(127, quantized))
      clamped.toByte
    }
  }

  // Streams quantized inputs into the physical model and returns the winning digit argmax output
  def runInference(dut: SpinalNNTop, inputBytes: Array[Byte]): Int = {
    dut.io.activationOut.ready #= true

    val stim = fork {
      for (b <- inputBytes) {
        dut.io.activationIn.valid #= true
        dut.io.activationIn.payload.value #= b
        dut.clockDomain.waitSamplingWhere(dut.io.activationIn.ready.toBoolean)
      }
      dut.io.activationIn.valid #= false
    }

    var resultArgmax = -1
    var cycles = 0
    val timeoutCycles = 2000000 // Deep pipeline requires large turnaround cycle budget under Verilator

    while (resultArgmax == -1 && cycles < timeoutCycles) {
      dut.clockDomain.waitSampling()
      sleep(1)
      if (dut.io.activationOut.valid.toBoolean && dut.io.activationOut.ready.toBoolean) {
        resultArgmax = dut.io.activationOut.payload.value.toInt
      }
      cycles += 1
      if (cycles % 100000 == 0) {
        println(s"    [STATUS] Simulation elapsed: $cycles cycles...")
      }
    }

    stim.join()
    assert(resultArgmax != -1, s"Pipeline timeout / lockup after $cycles cycles.")
    resultArgmax
  }

  test("Real-world MNIST validation image inference accuracy verification") {
    compileOnnx().doSim("onnx_validation") { dut =>
      dut.clockDomain.forkStimulus(period = 10)

      // Initialize defaults
      dut.io.activationIn.valid         #= false
      dut.io.activationIn.payload.value #= 0
      dut.io.activationOut.ready        #= false

      dut.clockDomain.waitSampling(5)

      // Package test assets from OnnxValidationData
      val samples = Seq(
        (0, OnnxValidationData.sample_0_input, OnnxValidationData.sample_0_label),
        (1, OnnxValidationData.sample_1_input, OnnxValidationData.sample_1_label),
        (2, OnnxValidationData.sample_2_input, OnnxValidationData.sample_2_label),
        (3, OnnxValidationData.sample_3_input, OnnxValidationData.sample_3_label),
        (4, OnnxValidationData.sample_4_input, OnnxValidationData.sample_4_label)
      )

      println("\n========================================================================")
      println("STARTING SPINALNN INFERENCE ACCURACY COMPARISON FOR 5 VALIDATION DIGITS")
      println("========================================================================\n")

      var passingUnits = 0

      for ((idx, inputFloats, trueLabel) <- samples) {
        val qInput = quantizeInput(inputFloats)
        println(s"[TEST SAMPLE $idx] Loaded validation image for digit classification...")
        
        val startSimTime = simTime()
        val argmaxOutput = runInference(dut, qInput)
        val endSimTime = simTime()
        val stepCycles = (endSimTime - startSimTime) / 10

        println(s"  - Target Label (ONNX Runtime Gold): $trueLabel")
        println(s"  - Hardware Predict Classification: $argmaxOutput")
        println(s"  - Latency:                           $stepCycles cycles")

        if (argmaxOutput == trueLabel) {
          println(s"  - VERDICT: PASS ✅")
          passingUnits += 1
        } else {
          println(s"  - VERDICT: FAIL ❌")
        }
        println("------------------------------------------------------------------------")

        // Wait a few cycles between inferences to let pipeline settle
        dut.clockDomain.waitSampling(20)
      }

      println(s"\n========================================================================")
      println(s"ACCURACY REPORT: $passingUnits / 5 PASSED (${(passingUnits * 100) / 5}%)")
      println(s"========================================================================\n")

      // Faithful topology (SAME convs + real 3x3 pool) classifies all 5 digits.
      // The former 80% (4/5) was the VALID-padding approximation, now removed.
      assert(passingUnits >= 5, s"Classification accuracy regression: only got $passingUnits / 5 correct.")
    }
  }
}
