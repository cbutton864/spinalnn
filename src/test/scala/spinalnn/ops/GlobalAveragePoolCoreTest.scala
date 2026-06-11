package spinalnn.ops

import org.scalatest.funsuite.AnyFunSuite
import spinal.core._
import spinal.core.sim._
import spinal.lib.sim.{StreamDriver, StreamMonitor}
import spinalnn.ops.pool.GlobalAveragePoolCore
import spinalnn.testhelpers.GlobalAveragePoolHarness
import spinalnn.types._
import scala.collection.mutable

class GlobalAveragePoolCoreTest extends AnyFunSuite {

  def compile(cfg: GlobalAveragePoolCore.Config) =
    SimConfig
      .withWave
      .workspacePath("simWorkspace/GlobalAveragePoolCoreTest")
      .compile(new GlobalAveragePoolHarness(cfg))

  // Streams one HWC frame in and collects the C channel averages. GAP is store-then-
  // compute (outputs only appear after the whole frame is consumed), but we still use
  // StreamDriver/StreamMonitor for race-free capture, matching the house test style.
  def runGap(cfg: GlobalAveragePoolCore.Config, input: Seq[Int]): Seq[Int] = {
    val channels = cfg.outputShape.channels
    var got: Seq[Int] = Nil
    compile(cfg).doSim(cfg.periphName) { dut =>
      dut.clockDomain.forkStimulus(period = 10)
      dut.io.activationOut.ready #= true

      val captured = mutable.ArrayBuffer[Int]()
      StreamMonitor(dut.io.activationOut, dut.clockDomain) { p =>
        captured += p.value.toInt
      }

      val q = mutable.Queue(input: _*)
      StreamDriver(dut.io.activationIn, dut.clockDomain) { p =>
        if (q.nonEmpty) { p.value #= q.dequeue(); true } else false
      }

      var cycles = 0
      while (captured.length < channels && cycles < 5000) {
        dut.clockDomain.waitSampling()
        cycles += 1
      }
      dut.clockDomain.waitSampling(5)
      got = captured.toSeq
    }
    got
  }

  def cfg(name: String, in: TensorShape, scaleIn: Float, scaleOut: Float): GlobalAveragePoolCore.Config =
    GlobalAveragePoolCore.Config(
      periphName  = name,
      inputShape  = in,
      outputShape = TensorShape(1, 1, in.channels),
      inputQuant  = QuantParams(scaleIn, 0),
      outputQuant = QuantParams(scaleOut, 0)
    )

  // ── Test 1: 2x2x1, plain average (scaleIn == scaleOut) ──────────────────
  // sum = 10+20+30+40 = 100, area = 4 -> 100/4 = 25.
  test("2x2x1 averages a single channel") {
    val out = runGap(cfg("gap_1ch", TensorShape(2, 2, 1), 1.0f, 1.0f), Seq(10, 20, 30, 40))
    assert(out == Seq(25), s"expected Seq(25), got $out")
  }

  // ── Test 2: 2x2x2, independent per-channel averages ─────────────────────
  // ch0 = [8,8,8,8] -> 8 ; ch1 = [16,16,16,16] -> 16. HWC stream interleaves channels.
  test("2x2x2 averages each channel independently") {
    val in  = Seq(8, 16, 8, 16, 8, 16, 8, 16)
    val out = runGap(cfg("gap_2ch", TensorShape(2, 2, 2), 1.0f, 1.0f), in)
    assert(out == Seq(8, 16), s"expected Seq(8,16), got $out")
  }

  // ── Test 3: 1x4x1, C = 1 streaming (exercises write-forwarding bypass) ──
  // All four elements land in the single channel-0 accumulator back-to-back.
  // sum = 100, area = 4 -> 25.
  test("1x4x1 accumulates a single channel back-to-back (bypass path)") {
    val out = runGap(cfg("gap_c1", TensorShape(1, 4, 1), 1.0f, 1.0f), Seq(10, 20, 30, 40))
    assert(out == Seq(25), s"expected Seq(25), got $out")
  }

  // ── Test 4: negative values + INT8 clamp (sign path) ────────────────────
  // sum = -512, area = 4 -> -128 (exactly the INT8 floor).
  test("negative averages clamp to the INT8 minimum") {
    val out = runGap(cfg("gap_neg", TensorShape(2, 2, 1), 1.0f, 1.0f), Seq(-128, -128, -128, -128))
    assert(out == Seq(-128), s"expected Seq(-128), got $out")
  }

  // ── Test 5: non-unity scale exercises the requant multiplier ────────────
  // scaleIn = 2, scaleOut = 1, area = 4 -> M = 2/(4*1) = 0.5.
  // sum = 16 -> 16 * 0.5 = 8.
  test("requant applies input/output scale ratio") {
    val out = runGap(cfg("gap_scale", TensorShape(2, 2, 1), 2.0f, 1.0f), Seq(4, 4, 4, 4))
    assert(out == Seq(8), s"expected Seq(8), got $out")
  }
}
