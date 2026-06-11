package spinalnn.ops

import org.scalatest.funsuite.AnyFunSuite
import spinal.core.sim._
import spinalnn.ops.conv.QLinearConvCore
import spinalnn.testhelpers.QLinearConvHarness
import spinalnn.types._
import scala.collection.mutable
import scala.util.Random

/** Tests for outParallelism P > 1 in QLinearConvCore.
  *
  * Each test runs the same configuration at P=1 (reference) and P>1 (DUT),
  * feeding identical inputs, and asserts that the output sequences match exactly.
  * This validates:
  *   - Correct weight bank initialisation for P groups.
  *   - Correct parallel MAC accumulation across P output-channel groups.
  *   - Sequential P-channel emission order (ch 0, ch 1, ..., C_out-1 per pixel).
  *   - Back-to-back inference across multiple frames.
  */
class QLinearConvOutParallelTest extends AnyFunSuite {

  val iq = QuantParams(scale = 1.0f, zeroPoint = 0)
  val wq = QuantParams(scale = 1.0f, zeroPoint = 0)
  val oq = QuantParams(scale = 1.0f, zeroPoint = 0)

  def compile(cfg: QLinearConvCore.Config) =
    SimConfig
      .withWave
      .workspacePath("simWorkspace/QLinearConvOutParallelTest")
      .compile(new QLinearConvHarness(cfg))

  def driveAndCollect(dut: QLinearConvHarness, inputs: Seq[Int], nOut: Int): Seq[Int] = {
    val results = mutable.ArrayBuffer[Int]()
    dut.io.activationOut.ready #= true
    val stim = fork {
      for (v <- inputs) {
        dut.io.activationIn.valid         #= true
        dut.io.activationIn.payload.value #= v
        dut.clockDomain.waitSamplingWhere(dut.io.activationIn.ready.toBoolean)
      }
      dut.io.activationIn.valid #= false
    }
    var cycles = 0
    while (results.length < nOut && cycles < 500000) {
      dut.clockDomain.waitSampling()
      sleep(1)
      if (dut.io.activationOut.valid.toBoolean && dut.io.activationOut.ready.toBoolean)
        results += dut.io.activationOut.payload.value.toInt
      cycles += 1
    }
    stim.join()
    assert(results.length == nOut, s"Timeout: got ${results.length}/$nOut")
    results.toSeq
  }

  def runBoth(tag: String, cfg1: QLinearConvCore.Config, cfgP: QLinearConvCore.Config,
              inputs: Seq[Int], nOut: Int): Unit = {
    var refOut: Seq[Int] = Nil
    var dutOut: Seq[Int] = Nil

    compile(cfg1).doSim(s"${tag}_P1") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      refOut = driveAndCollect(dut, inputs, nOut)
    }
    compile(cfgP).doSim(s"${tag}_PP") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      dutOut = driveAndCollect(dut, inputs, nOut)
    }
    assert(dutOut == refOut,
      s"$tag: P=${cfgP.outParallelism} output mismatch.\n  P=1: $refOut\n  P=${cfgP.outParallelism}: $dutOut")
  }

  // ── Test 1: P=2, 1×1 conv, C_in=1, C_out=2, identity weights ─────────────
  // Input: 2×2 image (4 pixels). Each output channel has weight 1.
  // Expected: two copies of the input stream (ch0 then ch1 per pixel).
  test("P=2: 2x2x1 -> 1x1 conv C_out=2 identity matches P=1") {
    val ws    = Array(1.toByte, 1.toByte)  // [oc=0,ci=0], [oc=1,ci=0]
    val bias  = Array(0, 0)
    val input = (1 to 4).toSeq
    val nOut  = 4 * 2  // 4 spatial × 2 channels

    val cfg1 = QLinearConvCore.Config(
      periphName = "op_p2_ref", inputShape = TensorShape(2, 2, 1), outputShape = TensorShape(2, 2, 2),
      kernelH = 1, kernelW = 1, inputQuant = iq, weightQuant = wq, outputQuant = oq,
      weights = ws, biases = bias, macParallelism = 1, outParallelism = 1
    )
    val cfgP = cfg1.copy(periphName = "op_p2_dut", outParallelism = 2)
    runBoth("p2_identity", cfg1, cfgP, input, nOut)
  }

  // ── Test 2: P=4, 1×1 conv, C_in=4, C_out=4, N=4 (full input parallelism) ──
  // With N=4 and C_in=4, each channel is computed in 1 MAC step.
  // With P=4, all 4 output channels are computed in the same pass → max parallelism.
  // Weights: channel oc uses only weight[oc, ci=oc] = (oc+1), rest 0.
  // Input [1,2,3,4]: output ch0 = 1*1 = 1, ch1 = 2*2 = 4, ch2 = 3*3 = 9, ch3 = 4*4 = 16.
  test("P=4 N=4: 1x1 C_in=4 C_out=4 diagonal weights matches P=1") {
    // Weight layout [C_out, C_in] = 4×4 matrix:
    // oc=0: [1,0,0,0], oc=1: [0,2,0,0], oc=2: [0,0,3,0], oc=3: [0,0,0,4]
    val ws = Array[Byte](
      1, 0, 0, 0,   // oc=0
      0, 2, 0, 0,   // oc=1
      0, 0, 3, 0,   // oc=2
      0, 0, 0, 4    // oc=3
    )
    val bias  = Array(0, 0, 0, 0)
    val input = Seq(1, 2, 3, 4)  // single 1×1 pixel with 4 channels
    val nOut  = 4                 // 1 spatial × 4 channels

    val cfg1 = QLinearConvCore.Config(
      periphName = "op_p4n4_ref", inputShape = TensorShape(1, 1, 4), outputShape = TensorShape(1, 1, 4),
      kernelH = 1, kernelW = 1, inputQuant = iq, weightQuant = wq, outputQuant = oq,
      weights = ws, biases = bias, macParallelism = 4, outParallelism = 1
    )
    val cfgP = cfg1.copy(periphName = "op_p4n4_dut", outParallelism = 4)

    var refOut: Seq[Int] = Nil
    var dutOut: Seq[Int] = Nil

    compile(cfg1).doSim("op_p4n4_P1") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      refOut = driveAndCollect(dut, input, nOut)
    }
    compile(cfgP).doSim("op_p4n4_PP") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      dutOut = driveAndCollect(dut, input, nOut)
    }

    assert(dutOut == refOut, s"P=4/N=4 mismatch.\n  P=1: $refOut\n  P=4: $dutOut")
    assert(refOut == Seq(1, 4, 9, 16), s"Wrong values: $refOut")
  }

  // ── Test 3: P=2, 3×3 conv, SAME padding, C_out=2, random weights ──────────
  // Validates that the weight bank layout is correct for larger kernels.
  test("P=2: 3x3 SAME padding C_out=2 random weights matches P=1") {
    val rng = new Random(42)
    // Weights [C_out=2, kH=3, kW=3, C_in=1] (9 weights per output channel)
    val ws   = Array.fill(2 * 9)(rng.nextInt(7).toByte)
    val bias = Array(0, 0)
    val input = (1 to 9).toSeq   // 3×3 image, C_in=1
    val nOut  = 9 * 2             // 9 spatial positions × 2 channels

    val cfg1 = QLinearConvCore.Config(
      periphName = "op_p2_3x3_ref", inputShape = TensorShape(3, 3, 1), outputShape = TensorShape(3, 3, 2),
      kernelH = 3, kernelW = 3, padTop = 1, padBottom = 1, padLeft = 1, padRight = 1,
      inputQuant = iq, weightQuant = wq, outputQuant = oq,
      weights = ws, biases = bias, macParallelism = 1, outParallelism = 1
    )
    val cfgP = cfg1.copy(periphName = "op_p2_3x3_dut", outParallelism = 2)
    runBoth("p2_3x3_same", cfg1, cfgP, input, nOut)
  }

  // ── Test 4: P=4, 3×3 conv, C_in=4, C_out=4, N=2 ─────────────────────────
  // Realistic shape closer to a small network body layer.
  test("P=4: 2x2 input, 3x3 SAME conv, C_in=4 C_out=4 N=2 matches P=1") {
    val rng   = new Random(7)
    val ws    = Array.fill(4 * 9 * 4)(rng.nextInt(5).toByte)  // [C_out=4, kH=3, kW=3, C_in=4]
    val bias  = Array.fill(4)(rng.nextInt(10))
    val input = (1 to 2 * 2 * 4).toSeq   // 2×2×4 spatial*channel
    val nOut  = 2 * 2 * 4                 // 4 spatial × 4 channels

    val cfg1 = QLinearConvCore.Config(
      periphName = "op_p4_3x3_ref",
      inputShape = TensorShape(2, 2, 4), outputShape = TensorShape(2, 2, 4),
      kernelH = 3, kernelW = 3, padTop = 1, padBottom = 1, padLeft = 1, padRight = 1,
      inputQuant = iq, weightQuant = wq, outputQuant = oq,
      weights = ws, biases = bias, macParallelism = 2, outParallelism = 1
    )
    val cfgP = cfg1.copy(periphName = "op_p4_3x3_dut", outParallelism = 4)
    runBoth("p4_3x3_cin4", cfg1, cfgP, input, nOut)
  }

  // ── Test 5: P=4 back-to-back inference ────────────────────────────────────
  test("P=4: back-to-back inference produces identical results") {
    val ws    = Array[Byte](1, 0, 0, 0,  0, 1, 0, 0,  0, 0, 1, 0,  0, 0, 0, 1)
    val bias  = Array(0, 0, 0, 0)
    val input = (1 to 4).toSeq
    val nOut  = 4

    val cfgP = QLinearConvCore.Config(
      periphName = "op_p4_b2b", inputShape = TensorShape(1, 1, 4), outputShape = TensorShape(1, 1, 4),
      kernelH = 1, kernelW = 1, inputQuant = iq, weightQuant = wq, outputQuant = oq,
      weights = ws, biases = bias, macParallelism = 4, outParallelism = 4
    )

    compile(cfgP).doSim("op_p4_b2b") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)

      var first: Seq[Int] = Nil
      for (frame <- 1 to 3) {
        val out = driveAndCollect(dut, input, nOut)
        if (frame == 1) first = out
        else assert(out == first, s"Frame $frame differs: $out vs $first")
      }
    }
  }
}
