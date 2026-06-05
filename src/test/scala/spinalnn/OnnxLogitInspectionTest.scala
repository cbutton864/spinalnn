package spinalnn

import org.scalatest.funsuite.AnyFunSuite
import spinal.core.sim._
import scala.collection.mutable.ArrayBuffer

// Diagnostic: taps the 10 raw INT8 class logits straight out of `linear1`
// (Params.onnxLogits drops softmax) and lines them up against the ONNX-Runtime
// gold logits. The point is to turn "the one wrong digit is just quantization
// error" into a measured statement: which class saturates, and whether the
// argmax actually flips because of clip-range saturation vs. irreducible rounding.
//
// The ONNX compiler quantizes the FC output with q_fc_out = 16/127, so the INT8
// logits represent the range [-16, +16]. Several gold logits exceed that (up to
// ~28), so we expect to see saturation at +127 on the strongest classes.
class OnnxLogitInspectionTest extends AnyFunSuite {

  // FC output dequantization scale (must match OnnxCompiler q_fc_out).
  val fcOutScale: Float = 16.0f / 127.0f

  def compileOnnxLogits() =
    SimConfig
      .withWave
      .workspacePath("simWorkspace/OnnxLogitInspectionTest")
      .compile(new SpinalNNTop(Params.onnxLogits))

  // Same input quantization as OnnxInferenceValidationTest: real [0,1] -> INT8 [0,127].
  def quantizeInput(floats: Array[Float]): Array[Byte] =
    floats.map { f =>
      val q = Math.round(f * 127.0f)
      Math.max(-128, Math.min(127, q)).toByte
    }

  // Streams one image and captures the 10 sequential INT8 logits from linear1.
  def runInferenceLogits(dut: SpinalNNTop, inputBytes: Array[Byte]): Array[Int] = {
    dut.io.activationOut.ready #= true
    val logits = ArrayBuffer[Int]()

    val stim = fork {
      for (b <- inputBytes) {
        dut.io.activationIn.valid #= true
        dut.io.activationIn.payload.value #= b
        dut.clockDomain.waitSamplingWhere(dut.io.activationIn.ready.toBoolean)
      }
      dut.io.activationIn.valid #= false
    }

    var cycles = 0
    val timeoutCycles = 2000000
    while (logits.length < 10 && cycles < timeoutCycles) {
      dut.clockDomain.waitSampling()
      sleep(1)
      if (dut.io.activationOut.valid.toBoolean && dut.io.activationOut.ready.toBoolean) {
        logits += dut.io.activationOut.payload.value.toInt
      }
      cycles += 1
    }

    stim.join()
    assert(logits.length == 10, s"Captured ${logits.length}/10 logits before timeout ($cycles cycles).")
    logits.toArray
  }

  def argmaxInt(a: Array[Int]): Int     = a.indices.maxBy(i => a(i))
  def argmaxFloat(a: Array[Float]): Int = a.indices.maxBy(i => a(i))

  test("HW INT8 logits vs ONNX gold -- saturation / argmax-flip diagnosis") {
    compileOnnxLogits().doSim("onnx_logit_inspection") { dut =>
      dut.clockDomain.forkStimulus(period = 10)

      dut.io.activationIn.valid         #= false
      dut.io.activationIn.payload.value #= 0
      dut.io.activationOut.ready        #= false
      dut.clockDomain.waitSampling(5)

      val samples = Seq(
        (OnnxValidationData.sample_0_input, OnnxValidationData.sample_0_logits, OnnxValidationData.sample_0_label),
        (OnnxValidationData.sample_1_input, OnnxValidationData.sample_1_logits, OnnxValidationData.sample_1_label),
        (OnnxValidationData.sample_2_input, OnnxValidationData.sample_2_logits, OnnxValidationData.sample_2_label),
        (OnnxValidationData.sample_3_input, OnnxValidationData.sample_3_logits, OnnxValidationData.sample_3_label),
        (OnnxValidationData.sample_4_input, OnnxValidationData.sample_4_logits, OnnxValidationData.sample_4_label)
      )

      println("\n================================================================================")
      println(" SPINALNN LOGIT-LEVEL DIAGNOSIS  (HW INT8 logits vs ONNX-Runtime gold)")
      println(s" FC output quant scale q_fc_out = 16/127 = ${fcOutScale}  ->  representable range [-16, +16]")
      println("================================================================================")

      var argmaxMatches = 0

      for ((idx, (inputFloats, goldLogits, trueLabel)) <- samples.zipWithIndex.map(_.swap)) {
        val qInput     = quantizeInput(inputFloats)
        val hwLogits   = runInferenceLogits(dut, qInput)
        val hwArgmax   = argmaxInt(hwLogits)
        val goldArgmax = argmaxFloat(goldLogits)
        val saturated  = hwLogits.zipWithIndex.filter { case (v, _) => v >= 127 || v <= -128 }.map(_._2)

        println(f"\n[SAMPLE $idx]  true label = $trueLabel%d   HW argmax = $hwArgmax%d   gold argmax = $goldArgmax%d   ${if (hwArgmax == goldArgmax) "MATCH" else "*** MISMATCH ***"}")
        println("  class |  HW int8 | HW dequant |  gold float | flags")
        println("  ------+----------+------------+-------------+----------------------------")
        for (c <- 0 until 10) {
          val hwDeq = hwLogits(c) * fcOutScale
          val flags = ArrayBuffer[String]()
          if (hwLogits(c) >= 127 || hwLogits(c) <= -128) flags += "SAT"
          if (c == hwArgmax)   flags += "HWmax"
          if (c == goldArgmax) flags += "GOLDmax"
          println(f"  $c%5d | ${hwLogits(c)}%8d | ${hwDeq}%10.3f | ${goldLogits(c)}%11.3f | ${flags.mkString(" ")}")
        }
        if (saturated.nonEmpty)
          println(s"  -> saturated classes: ${saturated.mkString(", ")} (gold magnitude exceeds the +-16 clip window)")

        if (hwArgmax == goldArgmax) argmaxMatches += 1
        dut.clockDomain.waitSampling(20)
      }

      println("\n================================================================================")
      println(s" TOP-1 ARGMAX AGREEMENT: $argmaxMatches / 5")
      println(" Interpretation:")
      println("   - If a MISMATCH sample shows two classes both pinned at +127 (SAT), the miss is")
      println("     clip-range saturation -> fixable by calibrating q_*_out, not irreducible noise.")
      println("   - If the winning classes differ by 1-2 INT8 LSBs with no saturation, that is")
      println("     genuine rounding error at this precision.")
      println("================================================================================\n")

      // Guard the faithful-topology result: SAME convs + real pooling classify all 5
      // samples (top-1 5/5), a measurable jump from the old VALID approximation's 4/5.
      assert(argmaxMatches >= 5, s"Logit-tap argmax agreement regressed to $argmaxMatches/5.")
    }
  }
}
