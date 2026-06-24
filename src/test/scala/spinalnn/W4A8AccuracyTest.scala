package spinalnn

import org.scalatest.funsuite.AnyFunSuite
import spinal.core.sim._
import spinalnn.target.{TargetConfig, WeightInt4}

/**
 * W4A8 accuracy smoke test on MNIST-8.
 *
 * Runs the same 5 validation samples as OnnxInferenceValidationTest but with
 * WeightInt4 (4-bit symmetric weight quantization, scale = max|w|/7).
 * Activations remain INT8; the requant pipeline is unchanged.
 * Threshold is >= 4/5 to allow for one INT4 rounding miss; 5/5 is expected.
 */
class W4A8AccuracyTest extends AnyFunSuite {

  val w4a8Target = TargetConfig.default.withWeightPrecision(WeightInt4)
  val w4a8Params = Params(target = w4a8Target, profile = OnnxProfile)

  def compileW4A8() =
    SimConfig
      .withWave
      .workspacePath("simWorkspace/W4A8AccuracyTest")
      .compile(new SpinalNNTop(w4a8Params))

  def quantizeInput(floats: Array[Float]): Array[Byte] =
    floats.map { f =>
      val q = Math.round(f * 127.0f)
      Math.max(-128, Math.min(127, q)).toByte
    }

  def runInference(dut: SpinalNNTop, inputBytes: Array[Byte]): Int = {
    dut.io.activationOut.ready #= true
    val stim = fork {
      for (b <- inputBytes) {
        dut.io.activationIn.valid         #= true
        dut.io.activationIn.payload.value #= b
        dut.clockDomain.waitSamplingWhere(dut.io.activationIn.ready.toBoolean)
      }
      dut.io.activationIn.valid #= false
    }
    var result = -1; var cycles = 0
    while (result == -1 && cycles < 2000000) {
      dut.clockDomain.waitSampling(); sleep(1)
      if (dut.io.activationOut.valid.toBoolean && dut.io.activationOut.ready.toBoolean)
        result = dut.io.activationOut.payload.value.toInt
      cycles += 1
    }
    stim.join()
    assert(result != -1, s"W4A8 pipeline timeout after $cycles cycles")
    result
  }

  test("W4A8 MNIST: 5-sample accuracy >= 4/5") {
    compileW4A8().doSim("w4a8_mnist") { dut =>
      dut.clockDomain.forkStimulus(period = 10)
      dut.io.activationIn.valid         #= false
      dut.io.activationIn.payload.value #= 0
      dut.io.activationOut.ready        #= false
      dut.clockDomain.waitSampling(5)

      val samples = Seq(
        (0, OnnxValidationData.sample_0_input, OnnxValidationData.sample_0_label),
        (1, OnnxValidationData.sample_1_input, OnnxValidationData.sample_1_label),
        (2, OnnxValidationData.sample_2_input, OnnxValidationData.sample_2_label),
        (3, OnnxValidationData.sample_3_input, OnnxValidationData.sample_3_label),
        (4, OnnxValidationData.sample_4_input, OnnxValidationData.sample_4_label)
      )

      println("\n========================================================================")
      println(" W4A8 MNIST ACCURACY SMOKE TEST (INT4 weights, INT8 activations)")
      println("========================================================================\n")

      var passed = 0
      for ((idx, inputFloats, trueLabel) <- samples) {
        val qInput = quantizeInput(inputFloats)
        val t0 = simTime()
        val pred = runInference(dut, qInput)
        val latency = (simTime() - t0) / 10
        val ok = pred == trueLabel
        if (ok) passed += 1
        println(f"  Sample $idx: label=$trueLabel  pred=$pred  latency=$latency cycles  ${if (ok) "PASS" else "FAIL"}")
        dut.clockDomain.waitSampling(20)
      }

      println(s"\n  ACCURACY: $passed / 5")
      println("========================================================================\n")

      assert(passed >= 4,
        s"W4A8 accuracy too low: $passed/5 (expected >= 4/5). INT4 quantization may be too coarse for this model.")
    }
  }
}
