package spinalnn.ops

import org.scalatest.funsuite.AnyFunSuite
import spinal.core._
import spinal.core.sim._
import spinal.lib.sim.{StreamDriver, StreamMonitor}
import spinalnn.ops.concat.ConcatCore
import spinalnn.testhelpers.ConcatHarness
import spinalnn.types._
import scala.collection.mutable

class ConcatCoreTest extends AnyFunSuite {

  def compile(cfg: ConcatCore.Config) =
    SimConfig
      .withWave
      .workspacePath("simWorkspace/ConcatCoreTest")
      .compile(new ConcatHarness(cfg))

  // Drives each branch from its own queue and monitors the output stream. Uses
  // spinal.lib.sim StreamDriver/StreamMonitor so input-valid deassertion never
  // races with output sampling (the concat is a same-cycle streaming pass-through,
  // unlike the store-then-compute cores whose inputs drain before outputs appear).
  def runConcat(cfg: ConcatCore.Config, inputs: Seq[Seq[Int]]): Seq[Int] = {
    val total = inputs.map(_.length).sum
    var got: Seq[Int] = Nil
    compile(cfg).doSim(cfg.periphName) { dut =>
      dut.clockDomain.forkStimulus(period = 10)
      dut.io.activationOut.ready #= true

      val captured = mutable.ArrayBuffer[Int]()
      StreamMonitor(dut.io.activationOut, dut.clockDomain) { p =>
        captured += p.value.toInt
      }

      val queues = inputs.map(v => mutable.Queue(v: _*))
      for (i <- inputs.indices) {
        StreamDriver(dut.io.activationIns(i), dut.clockDomain) { p =>
          if (queues(i).nonEmpty) { p.value #= queues(i).dequeue(); true } else false
        }
      }

      var cycles = 0
      while (captured.length < total && cycles < 5000) {
        dut.clockDomain.waitSampling()
        cycles += 1
      }
      // settle a few cycles to confirm no spurious extra emissions
      dut.clockDomain.waitSampling(5)
      got = captured.toSeq
    }
    got
  }

  // ── Test 1: 2x2x1 + 2x2x1 -> 2x2x2 (equal channels) ─────────────────────
  // HWC concat: at each spatial position emit in0's channel then in1's channel.
  //   in0 = [10,20,30,40], in1 = [50,60,70,80]
  //   out = [10,50, 20,60, 30,70, 40,80]
  test("2x2x1 + 2x2x1 -> 2x2x2 interleaves channels per position") {
    val cfg = ConcatCore.Config("concat_eq",
      Seq(TensorShape(2, 2, 1), TensorShape(2, 2, 1)))
    val out = runConcat(cfg, Seq(Seq(10, 20, 30, 40), Seq(50, 60, 70, 80)))
    assert(out == Seq(10, 50, 20, 60, 30, 70, 40, 80),
      s"Expected Seq(10,50, 20,60, 30,70, 40,80), got $out")
  }

  // ── Test 2: 1x1x2 + 1x1x1 -> 1x1x3 (unequal channels) ───────────────────
  test("1x1x2 + 1x1x1 -> 1x1x3 respects unequal channel counts") {
    val cfg = ConcatCore.Config("concat_uneq",
      Seq(TensorShape(1, 1, 2), TensorShape(1, 1, 1)))
    val out = runConcat(cfg, Seq(Seq(1, 2), Seq(3)))
    assert(out == Seq(1, 2, 3), s"Expected Seq(1,2,3), got $out")
  }

  // ── Test 3: 2x1x2 + 2x1x1 -> 2x1x3 (unequal channels, multi-position) ───
  // in0 = pos0[1,2] pos1[3,4]; in1 = pos0[5] pos1[6]
  // out = pos0[1,2,5] pos1[3,4,6]
  test("2x1x2 + 2x1x1 -> 2x1x3 wraps correctly across positions") {
    val cfg = ConcatCore.Config("concat_multi",
      Seq(TensorShape(2, 1, 2), TensorShape(2, 1, 1)))
    val out = runConcat(cfg, Seq(Seq(1, 2, 3, 4), Seq(5, 6)))
    assert(out == Seq(1, 2, 5, 3, 4, 6), s"Expected Seq(1,2,5, 3,4,6), got $out")
  }

  // ── Test 4: three-way concat 1x1x1 + 1x1x2 + 1x1x1 -> 1x1x4 ─────────────
  test("three-way concat preserves input order") {
    val cfg = ConcatCore.Config("concat_three",
      Seq(TensorShape(1, 1, 1), TensorShape(1, 1, 2), TensorShape(1, 1, 1)))
    val out = runConcat(cfg, Seq(Seq(7), Seq(8, 9), Seq(11)))
    assert(out == Seq(7, 8, 9, 11), s"Expected Seq(7,8,9,11), got $out")
  }
}
