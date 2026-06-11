package spinalnn.ops

import org.scalatest.funsuite.AnyFunSuite
import spinal.core.sim._
import spinalnn.ops.pool.{MaxPoolCore, MaxPoolLineCore}
import spinalnn.testhelpers.{MaxPoolHarness, MaxPoolLineHarness}
import spinalnn.types._

import scala.collection.mutable

/**
 * Verifies [[MaxPoolLineCore]] produces pixel-identical outputs to [[MaxPoolCore]]
 * for the same inputs. Tests cover 3×3 stride-2 (SqueezeNet profile) and 2×2 stride-2.
 */
class MaxPoolLineCoreTest extends AnyFunSuite {

  def compileLine(cfg: MaxPoolLineCore.Config) =
    SimConfig.withWave
      .workspacePath("simWorkspace/MaxPoolLineCoreTest")
      .compile(new MaxPoolLineHarness(cfg))

  def compileFull(cfg: MaxPoolCore.Config) =
    SimConfig.withWave
      .workspacePath("simWorkspace/MaxPoolLineCoreTest")
      .compile(new MaxPoolHarness(cfg))

  def drive(dut: MaxPoolLineHarness, values: Seq[Int]): Unit = {
    for (v <- values) {
      dut.io.activationIn.valid         #= true
      dut.io.activationIn.payload.value #= v
      dut.clockDomain.waitSamplingWhere(dut.io.activationIn.ready.toBoolean)
    }
    dut.io.activationIn.valid #= false
  }

  def driveFull(dut: MaxPoolHarness, values: Seq[Int]): Unit = {
    for (v <- values) {
      dut.io.activationIn.valid         #= true
      dut.io.activationIn.payload.value #= v
      dut.clockDomain.waitSamplingWhere(dut.io.activationIn.ready.toBoolean)
    }
    dut.io.activationIn.valid #= false
  }

  def collectLine(dut: MaxPoolLineHarness, count: Int): Seq[Int] = {
    val results = mutable.ArrayBuffer[Int]()
    dut.io.activationOut.ready #= true
    var cycles = 0
    while (results.length < count && cycles < 50000) {
      dut.clockDomain.waitSampling()
      sleep(1)
      if (dut.io.activationOut.valid.toBoolean && dut.io.activationOut.ready.toBoolean)
        results += dut.io.activationOut.payload.value.toInt
      cycles += 1
    }
    assert(cycles < 50000, s"Timeout: collected ${results.length}/$count")
    results.toSeq
  }

  def collectFull(dut: MaxPoolHarness, count: Int): Seq[Int] = {
    val results = mutable.ArrayBuffer[Int]()
    dut.io.activationOut.ready #= true
    var cycles = 0
    while (results.length < count && cycles < 50000) {
      dut.clockDomain.waitSampling()
      sleep(1)
      if (dut.io.activationOut.valid.toBoolean && dut.io.activationOut.ready.toBoolean)
        results += dut.io.activationOut.payload.value.toInt
      cycles += 1
    }
    assert(cycles < 50000, s"Timeout: collected ${results.length}/$count")
    results.toSeq
  }

  def runBothAndCompare(
    fullCfg: MaxPoolCore.Config,
    lineCfg: MaxPoolLineCore.Config,
    inputVals: Seq[Int],
    label: String
  ): Unit = {
    val outSize = fullCfg.outputShape.size
    var refOut: Seq[Int] = Nil
    var lineOut: Seq[Int] = Nil

    compileFull(fullCfg).doSim(s"${label}_full") { dut =>
      dut.clockDomain.forkStimulus(period = 10)
      dut.io.activationIn.valid         #= false
      dut.io.activationIn.payload.value #= 0
      dut.io.activationOut.ready        #= false
      dut.clockDomain.waitSampling(2)
      val stim = fork(driveFull(dut, inputVals))
      refOut = collectFull(dut, outSize)
      stim.join()
    }

    compileLine(lineCfg).doSim(s"${label}_line") { dut =>
      dut.clockDomain.forkStimulus(period = 10)
      dut.io.activationIn.valid         #= false
      dut.io.activationIn.payload.value #= 0
      dut.io.activationOut.ready        #= false
      dut.clockDomain.waitSampling(2)
      val stim = fork(drive(dut, inputVals))
      lineOut = collectLine(dut, outSize)
      stim.join()
    }

    assert(lineOut == refOut,
      s"[$label] line-buffer output differs from full-buffer.\n  ref : $refOut\n  line: $lineOut")
  }

  // ── Test 1: 4×4×1, 2×2 pool stride 2 ────────────────────────────────────
  test("4x4x1: 2x2 pool stride 2 matches full-buffer") {
    val in  = TensorShape(4, 4, 1)
    val out = TensorShape(2, 2, 1)
    runBothAndCompare(
      MaxPoolCore.Config("pool_full", in, out, 2, 2, 2, 2),
      MaxPoolLineCore.Config("pool_line", in, out, 2, 2, 2, 2),
      (1 to 16).toSeq, "2x2_s2_4x4x1"
    )
  }

  // ── Test 2: 8×8×2, 3×3 pool stride 2 (SqueezeNet profile) ───────────────
  test("8x8x2: 3x3 pool stride 2 matches full-buffer") {
    val in  = TensorShape(8, 8, 2)
    val out = TensorShape(3, 3, 2)
    val vals = (1 to in.size).map(i => (i * 7 + 3) % 200 - 100)  // varied inputs
    runBothAndCompare(
      MaxPoolCore.Config("pool_full", in, out, 3, 3, 2, 2),
      MaxPoolLineCore.Config("pool_line", in, out, 3, 3, 2, 2),
      vals, "3x3_s2_8x8x2"
    )
  }

  // ── Test 3: 6×6×3, 2×2 pool stride 2, multi-channel ────────────────────
  test("6x6x3: 2x2 pool stride 2 multi-channel matches full-buffer") {
    val in  = TensorShape(6, 6, 3)
    val out = TensorShape(3, 3, 3)
    val vals = (0 until in.size).map(i => (i * 13 + 5) % 200 - 100)
    runBothAndCompare(
      MaxPoolCore.Config("pool_full", in, out, 2, 2, 2, 2),
      MaxPoolLineCore.Config("pool_line", in, out, 2, 2, 2, 2),
      vals, "2x2_s2_6x6x3"
    )
  }

  // ── Test 4: two consecutive inferences ───────────────────────────────────
  test("3x3 pool: two consecutive inferences produce correct results") {
    val in  = TensorShape(6, 6, 2)
    val out = TensorShape(2, 2, 2)
    val cfg = MaxPoolLineCore.Config("pool_consec", in, out, 3, 3, 2, 2)
    val refCfg = MaxPoolCore.Config("pool_ref", in, out, 3, 3, 2, 2)

    val vals1 = (1 to in.size).map(i => (i * 3) % 200 - 100)
    val vals2 = (1 to in.size).map(i => (i * 7 + 11) % 200 - 100)
    var ref1: Seq[Int] = Nil; var ref2: Seq[Int] = Nil
    var line1: Seq[Int] = Nil; var line2: Seq[Int] = Nil

    compileFull(refCfg).doSim("pool_consec_full") { dut =>
      dut.clockDomain.forkStimulus(period = 10)
      dut.io.activationIn.valid #= false; dut.io.activationIn.payload.value #= 0
      dut.io.activationOut.ready #= false; dut.clockDomain.waitSampling(2)
      fork(driveFull(dut, vals1)); ref1 = collectFull(dut, out.size)
      fork(driveFull(dut, vals2)); ref2 = collectFull(dut, out.size)
    }

    compileLine(cfg).doSim("pool_consec_line") { dut =>
      dut.clockDomain.forkStimulus(period = 10)
      dut.io.activationIn.valid #= false; dut.io.activationIn.payload.value #= 0
      dut.io.activationOut.ready #= false; dut.clockDomain.waitSampling(2)
      fork(drive(dut, vals1)); line1 = collectLine(dut, out.size)
      fork(drive(dut, vals2)); line2 = collectLine(dut, out.size)
    }

    assert(line1 == ref1, s"inference 1 mismatch\n  ref : $ref1\n  line: $line1")
    assert(line2 == ref2, s"inference 2 mismatch\n  ref : $ref2\n  line: $line2")
  }
}
