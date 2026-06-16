package spinalnn

import org.scalatest.funsuite.AnyFunSuite
import spinal.core.sim._
import spinalnn.target.{MacParFixed, TargetConfig}

/** Hardware-vs-ONNX-Runtime accuracy check for DS-CNN-S KWS (12-class, int8).
  *
  * Streams pre-quantized int8 MFCC features (49×10 = 490 values) through the full
  * SpinalNNTop RTL, captures the argmax class index from SoftmaxCore, and asserts
  * it matches the ONNX Runtime reference stored in DsCnnValidationData.
  *
  * Encoding: int8 = round(float_mfcc / 0.03137255).  The ONNX model uses uint8
  * input with zp=128; OnnxFrontend.remapZp converts that to int8 zp=0, so we
  * stream (uint8 - 128) directly — no bias-correction offset needed at runtime.
  *
  * Config: MacParFixed(8) — falls back to N=1 for C_in<8 layers (stem, depthwise).
  * Timeout: 10 000 000 cycles per inference (DS-CNN-S has a deep conv pipeline).
  */
class DsCnnValidationTest extends AnyFunSuite {

  val params = Params
    .fromOnnx("models/dscnn_s-int8.onnx")
    .withTarget(TargetConfig.default.withMacPar(MacParFixed(8)))

  def compileDsCnn() =
    SimConfig
      .withWave
      .workspacePath("simWorkspace/DsCnnValidationTest")
      .compile(new SpinalNNTop(params))

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

    var resultArgmax = -1
    var cycles       = 0
    val timeoutCycles = 10000000

    while (resultArgmax == -1 && cycles < timeoutCycles) {
      dut.clockDomain.waitSampling()
      sleep(1)
      if (dut.io.activationOut.valid.toBoolean && dut.io.activationOut.ready.toBoolean)
        resultArgmax = dut.io.activationOut.payload.value.toInt
      cycles += 1
      if (cycles % 500000 == 0)
        println(s"    [STATUS] Simulation elapsed: $cycles cycles...")
    }

    stim.join()
    assert(resultArgmax != -1, s"Pipeline timeout after $cycles cycles.")
    resultArgmax
  }

  test("DS-CNN-S hardware argmax matches ONNX Runtime for 3 MFCC inputs") {
    compileDsCnn().doSim("dscnn_validation") { dut =>
      dut.clockDomain.forkStimulus(period = 10)

      dut.io.activationIn.valid         #= false
      dut.io.activationIn.payload.value #= 0
      dut.io.activationOut.ready        #= false

      dut.clockDomain.waitSampling(5)

      val samples = Seq(
        (0, DsCnnValidationData.sample_0_input, DsCnnValidationData.sample_0_label),
        (1, DsCnnValidationData.sample_1_input, DsCnnValidationData.sample_1_label),
        (2, DsCnnValidationData.sample_2_input, DsCnnValidationData.sample_2_label)
      )

      println("\n========================================================================")
      println("DS-CNN-S HARDWARE vs ONNX RUNTIME ACCURACY VALIDATION (3 MFCC inputs)")
      println("========================================================================\n")

      var passed = 0

      for ((idx, inputBytes, trueLabel) <- samples) {
        println(s"[SAMPLE $idx] Streaming ${inputBytes.length} int8 MFCC values...")

        val t0      = simTime()
        val predicted = runInference(dut, inputBytes)
        val cycles  = (simTime() - t0) / 10

        println(s"  ONNX Runtime label : $trueLabel")
        println(s"  Hardware prediction: $predicted")
        println(s"  Latency            : $cycles cycles")

        if (predicted == trueLabel) { println("  VERDICT: PASS"); passed += 1 }
        else                         println("  VERDICT: FAIL")
        println("------------------------------------------------------------------------")

        dut.clockDomain.waitSampling(20)
      }

      println(s"\n========================================================================")
      println(s"RESULT: $passed / ${samples.length} PASSED")
      println(s"========================================================================\n")

      assert(passed == samples.length,
        s"DS-CNN-S hardware accuracy: $passed/${samples.length} — expected all correct.")
    }
  }
}
