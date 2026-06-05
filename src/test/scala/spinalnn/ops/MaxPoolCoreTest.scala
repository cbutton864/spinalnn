package spinalnn.ops

import org.scalatest.funsuite.AnyFunSuite
import spinal.core._
import spinal.core.sim._
import spinalnn.ops.pool.MaxPoolCore
import spinalnn.testhelpers.MaxPoolHarness
import spinalnn.types._
import scala.collection.mutable

class MaxPoolCoreTest extends AnyFunSuite {

  def compile(cfg: MaxPoolCore.Config) =
    SimConfig
      .withWave
      .workspacePath("simWorkspace/MaxPoolCoreTest")
      .compile(new MaxPoolHarness(cfg))

  // Drive one complete feature map into activationIn, assert backpressure handling
  def driveInputs(dut: MaxPoolHarness, values: Seq[Int]): Unit = {
    for (v <- values) {
      dut.io.activationIn.valid         #= true
      dut.io.activationIn.payload.value #= v
      dut.clockDomain.waitSamplingWhere(dut.io.activationIn.ready.toBoolean)
    }
    dut.io.activationIn.valid #= false
  }

  // Collect exactly `count` output activations with a cycle timeout
  def collectOutputs(dut: MaxPoolHarness, count: Int, timeoutCycles: Int = 5000): Seq[Int] = {
    val results = mutable.ArrayBuffer[Int]()
    dut.io.activationOut.ready #= true
    var cycles = 0
    while (results.length < count && cycles < timeoutCycles) {
      dut.clockDomain.waitSampling()
      sleep(1)
      if (dut.io.activationOut.valid.toBoolean && dut.io.activationOut.ready.toBoolean) {
        results += dut.io.activationOut.payload.value.toInt
      }
      cycles += 1
    }
    assert(cycles < timeoutCycles, s"Timeout: only collected ${results.length}/$count outputs")
    results.toSeq
  }

  // ── Test 1: 4x4x1, 2x2 pool stride 2 ──────────────────────────────────
  // Input (row-major, single channel):
  //   row0: 1  2  3  4
  //   row1: 5  6  7  8
  //   row2: 9  10 11 12
  //   row3: 13 14 15 16
  //
  // Expected output (2x2x1):
  //   max(1,2,5,6)=6   max(3,4,7,8)=8
  //   max(9,10,13,14)=14  max(11,12,15,16)=16
  test("4x4x1: 2x2 pool produces correct max values") {
    val cfg = MaxPoolCore.Config(
      periphName  = "pool",
      inputShape  = TensorShape(4, 4, 1),
      outputShape = TensorShape(2, 2, 1)
    )
    compile(cfg).doSim("pool_4x4x1") { dut =>
      dut.clockDomain.forkStimulus(period = 10)
      dut.io.activationIn.valid         #= false
      dut.io.activationIn.payload.value #= 0
      dut.io.activationOut.ready        #= false
      dut.clockDomain.waitSampling(2)

      val stimulus = fork(driveInputs(dut, 1 to 16))
      val results  = collectOutputs(dut, count = 4)
      stimulus.join()

      assert(results == Seq(6, 8, 14, 16),
        s"Expected Seq(6, 8, 14, 16), got $results")
    }
  }

  // ── Test 2: 4x4x2, verifies channel indexing ───────────────────────────
  // ch0 values = 1..16, ch1 values = -(1..16)
  // HWC stream: (r0,c0,ch0)=1, (r0,c0,ch1)=-1, (r0,c1,ch0)=2, (r0,c1,ch1)=-2, ...
  //
  // Expected output (2x2x2) in HWC order:
  //   (0,0,ch0)=max(1,2,5,6)=6   (0,0,ch1)=max(-1,-2,-5,-6)=-1
  //   (0,1,ch0)=max(3,4,7,8)=8   (0,1,ch1)=max(-3,-4,-7,-8)=-3
  //   (1,0,ch0)=14               (1,0,ch1)=-9
  //   (1,1,ch0)=16               (1,1,ch1)=-11
  test("4x4x2: channel indexing correct") {
    val cfg = MaxPoolCore.Config(
      periphName  = "pool2ch",
      inputShape  = TensorShape(4, 4, 2),
      outputShape = TensorShape(2, 2, 2)
    )
    compile(cfg).doSim("pool_4x4x2") { dut =>
      dut.clockDomain.forkStimulus(period = 10)
      dut.io.activationIn.valid         #= false
      dut.io.activationIn.payload.value #= 0
      dut.io.activationOut.ready        #= false
      dut.clockDomain.waitSampling(2)

      // Build HWC-ordered input: interleave ch0 (1..16) and ch1 (-(1..16))
      val inputs = (1 to 16).flatMap(v => Seq(v, -v))
      val stimulus = fork(driveInputs(dut, inputs))
      val results  = collectOutputs(dut, count = 8)
      stimulus.join()

      assert(results == Seq(6, -1, 8, -3, 14, -9, 16, -11),
        s"Expected Seq(6, -1, 8, -3, 14, -9, 16, -11), got $results")
    }
  }

  // ── Test 3: back-to-back inference (two frames) ─────────────────────────
  // Verifies FSM returns to RECEIVE after completing one frame.
  test("4x4x1: back-to-back inference produces correct results both times") {
    val cfg = MaxPoolCore.Config(
      periphName  = "pool_b2b",
      inputShape  = TensorShape(4, 4, 1),
      outputShape = TensorShape(2, 2, 1)
    )
    compile(cfg).doSim("pool_b2b") { dut =>
      dut.clockDomain.forkStimulus(period = 10)
      dut.io.activationIn.valid         #= false
      dut.io.activationIn.payload.value #= 0
      dut.io.activationOut.ready        #= false
      dut.clockDomain.waitSampling(2)

      for (frame <- 1 to 2) {
        val stimulus = fork(driveInputs(dut, 1 to 16))
        val results  = collectOutputs(dut, count = 4)
        stimulus.join()
        assert(results == Seq(6, 8, 14, 16),
          s"Frame $frame: expected Seq(6, 8, 14, 16), got $results")
      }
    }
  }

  // ── Test 4: 6x6x1, 3x3 pool stride 3 ───────────────────────────────────
  // Generalized window (non-2x2). Input 1..36 row-major, 3x3/stride-3 -> 2x2x1.
  //   out(0,0) = max(rows0-2, cols0-2) = max(1..3,7..9,13..15)   = 15
  //   out(0,1) = max(rows0-2, cols3-5) = max(4..6,10..12,16..18) = 18
  //   out(1,0) = max(rows3-5, cols0-2) = max(19..21,25..27,31..33) = 33
  //   out(1,1) = max(rows3-5, cols3-5) = max(22..24,28..30,34..36) = 36
  test("6x6x1: 3x3 pool stride 3 produces correct max values") {
    val cfg = MaxPoolCore.Config(
      periphName  = "pool3x3",
      inputShape  = TensorShape(6, 6, 1),
      outputShape = TensorShape(2, 2, 1),
      poolH       = 3,
      poolW       = 3,
      strideH     = 3,
      strideW     = 3
    )
    compile(cfg).doSim("pool_6x6_3x3s3") { dut =>
      dut.clockDomain.forkStimulus(period = 10)
      dut.io.activationIn.valid         #= false
      dut.io.activationIn.payload.value #= 0
      dut.io.activationOut.ready        #= false
      dut.clockDomain.waitSampling(2)

      val stimulus = fork(driveInputs(dut, 1 to 36))
      val results  = collectOutputs(dut, count = 4)
      stimulus.join()

      assert(results == Seq(15, 18, 33, 36),
        s"Expected Seq(15, 18, 33, 36), got $results")
    }
  }
}
