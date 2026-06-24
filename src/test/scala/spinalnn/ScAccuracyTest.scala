package spinalnn

import org.scalatest.funsuite.AnyFunSuite
import spinal.core.sim._
import spinalnn.target.{TargetConfig, WeightStochastic}

/**
 * SC (MUX-MAC stochastic computing) accuracy smoke test on MNIST-8.
 *
 * Runs the same 5 validation samples as OnnxInferenceValidationTest using
 * WeightStochastic(bitstreamLen=255). SC is approximate, so one miss is allowed.
 *
 * SC latency per MNIST inference is dominated by:
 *   - conv2: ~800 load cycles + 255 SC cycles per output × 4096 outputs ≈ 4.3M cycles
 *   - conv1: ~25 load cycles  + 255 SC cycles per output × 18432 outputs ≈ 5.2M cycles
 * Total ~10M+ sim cycles; timeout is set to 40M to leave headroom.
 *
 * Threshold: >= 4/5 (N=255 approximation may shift one borderline digit).
 */
class ScAccuracyTest extends AnyFunSuite {

  val scTarget = TargetConfig.default.withWeightPrecision(WeightStochastic(255))
  val scParams = Params(target = scTarget, profile = OnnxProfile)

  def compileSC() =
    SimConfig
      .withWave
      .workspacePath("simWorkspace/ScAccuracyTest")
      .compile(new SpinalNNTop(scParams))

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
    val timeout = 40000000
    while (result == -1 && cycles < timeout) {
      dut.clockDomain.waitSampling(); sleep(1)
      if (dut.io.activationOut.valid.toBoolean && dut.io.activationOut.ready.toBoolean)
        result = dut.io.activationOut.payload.value.toInt
      cycles += 1
      if (cycles % 2000000 == 0)
        println(s"    [STATUS] SC simulation elapsed: $cycles cycles...")
    }
    stim.join()
    assert(result != -1, s"SC pipeline timeout after $cycles cycles (bitstreamLen=255, N=1)")
    result
  }

  test("SC MNIST: 5-sample accuracy >= 4/5 (bitstreamLen=255)") {
    compileSC().doSim("sc_mnist") { dut =>
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
      println(" SC MNIST ACCURACY SMOKE TEST (MUX-MAC stochastic, N=255, MACFG)")
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
        s"SC accuracy too low: $passed/5 (expected >= 4/5 at bitstreamLen=255, MACFG LFSR). " +
        s"SC approximation with N=255 should match INT8 on all but borderline samples.")
    }
  }
}
