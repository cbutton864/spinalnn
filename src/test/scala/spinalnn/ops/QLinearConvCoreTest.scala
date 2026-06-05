package spinalnn.ops

import org.scalatest.funsuite.AnyFunSuite
import spinal.core._
import spinal.core.sim._
import spinalnn.ops.conv.QLinearConvCore
import spinalnn.testhelpers.QLinearConvHarness
import spinalnn.types._
import scala.collection.mutable

class QLinearConvCoreTest extends AnyFunSuite {

  // Scales set so requantization is an identity: output = acc exactly.
  // RequantScale(1.0, 1.0, 1.0) -> multiplier = 2^30, shift = 30
  // output = (acc * 2^30) >> 30 = acc
  val identityInput  = QuantParams(scale = 1.0f, zeroPoint = 0)
  val identityWeight = QuantParams(scale = 1.0f, zeroPoint = 0)
  val identityOutput = QuantParams(scale = 1.0f, zeroPoint = 0)

  def compile(cfg: QLinearConvCore.Config) =
    SimConfig
      .withWave
      .workspacePath("simWorkspace/QLinearConvCoreTest")
      .compile(new QLinearConvHarness(cfg))

  def driveInputs(dut: QLinearConvHarness, values: Seq[Int]): Unit = {
    for (v <- values) {
      dut.io.activationIn.valid         #= true
      dut.io.activationIn.payload.value #= v
      dut.clockDomain.waitSamplingWhere(dut.io.activationIn.ready.toBoolean)
    }
    dut.io.activationIn.valid #= false
  }

  def collectOutputs(dut: QLinearConvHarness, count: Int, timeout: Int = 100000): Seq[Int] = {
    val results = mutable.ArrayBuffer[Int]()
    dut.io.activationOut.ready #= true
    var cycles = 0
    while (results.length < count && cycles < timeout) {
      dut.clockDomain.waitSampling()
      sleep(1)
      if (dut.io.activationOut.valid.toBoolean && dut.io.activationOut.ready.toBoolean) {
        results += dut.io.activationOut.payload.value.toInt
      }
      cycles += 1
    }
    assert(cycles < timeout, s"Timeout: collected ${results.length}/$count outputs")
    results.toSeq
  }

  // ── Test 1: 3x3x1 input, 1x1 conv, weight=1 ─────────────────────────────
  // 1x1 conv with weight 1 and identity scales: each output = corresponding input.
  // Input (HWC, C=1): [1, 2, 3, 4, 5, 6, 7, 8, 9]
  // Expected output (3x3x1): [1, 2, 3, 4, 5, 6, 7, 8, 9]
  test("3x3x1 -> 1x1 conv weight=1 identity passthrough") {
    val cfg = QLinearConvCore.Config(
      periphName  = "conv1x1",
      inputShape  = TensorShape(3, 3, 1),
      outputShape = TensorShape(3, 3, 1),
      kernelH     = 1,
      kernelW     = 1,
      inputQuant  = identityInput,
      weightQuant = identityWeight,
      outputQuant = identityOutput,
      weights     = Array(1.toByte),   // single 1x1 weight = 1
      biases      = Array(0)
    )
    compile(cfg).doSim("conv1x1_identity") { dut =>
      dut.clockDomain.forkStimulus(period = 10)
      dut.io.activationIn.valid         #= false
      dut.io.activationIn.payload.value #= 0
      dut.io.activationOut.ready        #= false
      dut.clockDomain.waitSampling(2)

      val stimulus = fork(driveInputs(dut, 1 to 9))
      val results  = collectOutputs(dut, count = 9)
      stimulus.join()

      assert(results == (1 to 9).toSeq,
        s"Expected ${(1 to 9).toList}, got $results")
    }
  }

  // ── Test 2: 3x3x1 input, 3x3 full conv, all weights=1 ───────────────────
  // Full 3x3 kernel sums all 9 input values. Output is 1x1x1.
  // acc = 1+2+...+9 = 45. Identity scales -> output = 45.
  test("3x3x1 full 3x3 conv sums to 45") {
    val cfg = QLinearConvCore.Config(
      periphName  = "conv3x3",
      inputShape  = TensorShape(3, 3, 1),
      outputShape = TensorShape(1, 1, 1),
      kernelH     = 3,
      kernelW     = 3,
      inputQuant  = identityInput,
      weightQuant = identityWeight,
      outputQuant = identityOutput,
      weights     = Array.fill(9)(1.toByte),
      biases      = Array(0)
    )
    compile(cfg).doSim("conv3x3_sum") { dut =>
      dut.clockDomain.forkStimulus(period = 10)
      dut.io.activationIn.valid         #= false
      dut.io.activationIn.payload.value #= 0
      dut.io.activationOut.ready        #= false
      dut.clockDomain.waitSampling(2)

      val stimulus = fork(driveInputs(dut, 1 to 9))
      val results  = collectOutputs(dut, count = 1)
      stimulus.join()

      assert(results == Seq(45), s"Expected Seq(45), got $results")
    }
  }

  // ── Test 3: clamping -- positive overflow ────────────────────────────────
  // 9 inputs all 15, 3x3 sum = 135. Clamped to 127.
  test("3x3x1 full 3x3 conv clamps positive overflow to 127") {
    val cfg = QLinearConvCore.Config(
      periphName  = "conv_clamp_pos",
      inputShape  = TensorShape(3, 3, 1),
      outputShape = TensorShape(1, 1, 1),
      kernelH     = 3,
      kernelW     = 3,
      inputQuant  = identityInput,
      weightQuant = identityWeight,
      outputQuant = identityOutput,
      weights     = Array.fill(9)(1.toByte),
      biases      = Array(0)
    )
    compile(cfg).doSim("conv_clamp_pos") { dut =>
      dut.clockDomain.forkStimulus(period = 10)
      dut.io.activationIn.valid         #= false
      dut.io.activationIn.payload.value #= 0
      dut.io.activationOut.ready        #= false
      dut.clockDomain.waitSampling(2)

      val stimulus = fork(driveInputs(dut, Seq.fill(9)(15)))
      val results  = collectOutputs(dut, count = 1)
      stimulus.join()

      assert(results == Seq(127), s"Expected Seq(127), got $results")
    }
  }

  // ── Test 4: clamping -- negative overflow ────────────────────────────────
  // 9 inputs all -15, sum = -135. Clamped to -128.
  test("3x3x1 full 3x3 conv clamps negative overflow to -128") {
    val cfg = QLinearConvCore.Config(
      periphName  = "conv_clamp_neg",
      inputShape  = TensorShape(3, 3, 1),
      outputShape = TensorShape(1, 1, 1),
      kernelH     = 3,
      kernelW     = 3,
      inputQuant  = identityInput,
      weightQuant = identityWeight,
      outputQuant = identityOutput,
      weights     = Array.fill(9)(1.toByte),
      biases      = Array(0)
    )
    compile(cfg).doSim("conv_clamp_neg") { dut =>
      dut.clockDomain.forkStimulus(period = 10)
      dut.io.activationIn.valid         #= false
      dut.io.activationIn.payload.value #= 0
      dut.io.activationOut.ready        #= false
      dut.clockDomain.waitSampling(2)

      val stimulus = fork(driveInputs(dut, Seq.fill(9)(-15)))
      val results  = collectOutputs(dut, count = 1)
      stimulus.join()

      assert(results == Seq(-128), s"Expected Seq(-128), got $results")
    }
  }

  // ── Test 5: non-zero bias ─────────────────────────────────────────────────
  // 3x3x1 -> 1x1 conv, weight=1, bias=10. Input all 1s.
  // acc = 1 * 9 + 10 = 19. Output = 19.
  test("3x3x1 full 3x3 conv with non-zero bias") {
    val cfg = QLinearConvCore.Config(
      periphName  = "conv_bias",
      inputShape  = TensorShape(3, 3, 1),
      outputShape = TensorShape(1, 1, 1),
      kernelH     = 3,
      kernelW     = 3,
      inputQuant  = identityInput,
      weightQuant = identityWeight,
      outputQuant = identityOutput,
      weights     = Array.fill(9)(1.toByte),
      biases      = Array(10)
    )
    compile(cfg).doSim("conv_bias") { dut =>
      dut.clockDomain.forkStimulus(period = 10)
      dut.io.activationIn.valid         #= false
      dut.io.activationIn.payload.value #= 0
      dut.io.activationOut.ready        #= false
      dut.clockDomain.waitSampling(2)

      val stimulus = fork(driveInputs(dut, Seq.fill(9)(1)))
      val results  = collectOutputs(dut, count = 1)
      stimulus.join()

      assert(results == Seq(19), s"Expected Seq(19), got $results")
    }
  }

  // ── Test 6: back-to-back inference ───────────────────────────────────────
  test("3x3x1 full 3x3 conv back-to-back correct both frames") {
    val cfg = QLinearConvCore.Config(
      periphName  = "conv_b2b",
      inputShape  = TensorShape(3, 3, 1),
      outputShape = TensorShape(1, 1, 1),
      kernelH     = 3,
      kernelW     = 3,
      inputQuant  = identityInput,
      weightQuant = identityWeight,
      outputQuant = identityOutput,
      weights     = Array.fill(9)(1.toByte),
      biases      = Array(0)
    )
    compile(cfg).doSim("conv_b2b") { dut =>
      dut.clockDomain.forkStimulus(period = 10)
      dut.io.activationIn.valid         #= false
      dut.io.activationIn.payload.value #= 0
      dut.io.activationOut.ready        #= false
      dut.clockDomain.waitSampling(2)

      for (frame <- 1 to 2) {
        val stimulus = fork(driveInputs(dut, 1 to 9))
        val results  = collectOutputs(dut, count = 1)
        stimulus.join()
        assert(results == Seq(45), s"Frame $frame: expected Seq(45), got $results")
      }
    }
  }

  // ── Test 7: SAME padding ─────────────────────────────────────────────────
  // 3x3x1 input, 3x3 all-ones kernel, SAME padding (pad 1 on every side),
  // stride 1, identity scales. Output stays 3x3x1; each output is the sum of the
  // 3x3 neighborhood with zero padding outside the input. Input (row-major):
  //   1 2 3
  //   4 5 6
  //   7 8 9
  // Expected (row-major):
  //   12 21 16
  //   27 45 33
  //   24 39 28
  test("3x3x1 -> 3x3 conv SAME padding keeps spatial size and zero-pads borders") {
    val cfg = QLinearConvCore.Config(
      periphName  = "conv_same",
      inputShape  = TensorShape(3, 3, 1),
      outputShape = TensorShape(3, 3, 1),
      kernelH     = 3,
      kernelW     = 3,
      padTop      = 1,
      padBottom   = 1,
      padLeft     = 1,
      padRight    = 1,
      inputQuant  = identityInput,
      weightQuant = identityWeight,
      outputQuant = identityOutput,
      weights     = Array.fill(9)(1.toByte),
      biases      = Array(0)
    )
    compile(cfg).doSim("conv_same") { dut =>
      dut.clockDomain.forkStimulus(period = 10)
      dut.io.activationIn.valid         #= false
      dut.io.activationIn.payload.value #= 0
      dut.io.activationOut.ready        #= false
      dut.clockDomain.waitSampling(2)

      val stimulus = fork(driveInputs(dut, 1 to 9))
      val results  = collectOutputs(dut, count = 9)
      stimulus.join()

      assert(results == Seq(12, 21, 16, 27, 45, 33, 24, 39, 28),
        s"Expected Seq(12,21,16, 27,45,33, 24,39,28), got $results")
    }
  }
}
