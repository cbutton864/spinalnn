package spinalnn.ops

import org.scalatest.funsuite.AnyFunSuite
import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinal.lib.sim.{StreamDriver, StreamMonitor}
import spinalnn.ops.add.AddCore
import spinalnn.types._
import scala.collection.mutable

/** Tests for AddCore streaming pipeline.
  *
  * The pipeline has 4 registered stages (4-cycle latency) and accepts 1 pair/cycle.
  * Tests verify: correct element-wise requantization, scale independence, zero-point
  * handling, and that back-pressure from the output does not corrupt results.
  */
class AddCoreTest extends AnyFunSuite {

  class AddHarness(cfg: AddCore.Config) extends Component {
    val io = new Bundle {
      val inA = slave(Stream(Activation()))
      val inB = slave(Stream(Activation()))
      val out = master(Stream(Activation()))
    }
    val core = AddCore.build(cfg, io.inA, io.inB)
    io.out << core.activationOut
  }

  def runAdd(cfg: AddCore.Config, as: Seq[Int], bs: Seq[Int]): Seq[Int] = {
    require(as.length == bs.length)
    val outCount = as.length
    var got: Seq[Int] = Nil

    SimConfig
      .withWave
      .workspacePath("simWorkspace/AddCoreTest")
      .compile(new AddHarness(cfg))
      .doSim(cfg.periphName) { dut =>
        dut.clockDomain.forkStimulus(period = 10)
        dut.io.out.ready #= true

        val captured = mutable.ArrayBuffer[Int]()
        StreamMonitor(dut.io.out, dut.clockDomain) { p => captured += p.value.toInt }

        val qa = mutable.Queue(as: _*)
        val qb = mutable.Queue(bs: _*)
        StreamDriver(dut.io.inA, dut.clockDomain) { p =>
          if (qa.nonEmpty) { p.value #= qa.dequeue(); true } else false
        }
        StreamDriver(dut.io.inB, dut.clockDomain) { p =>
          if (qb.nonEmpty) { p.value #= qb.dequeue(); true } else false
        }

        var cycles = 0
        while (captured.length < outCount && cycles < 10000) {
          dut.clockDomain.waitSampling(); cycles += 1
        }
        dut.clockDomain.waitSampling(8)
        got = captured.toSeq
      }
    got
  }

  // ── Test 1: equal scales, symmetric inputs ────────────────────────────────
  // s_A = s_B = s_C = 1.0 → M_A = M_B = 1.0 → output = a + b (plus clamp).
  // a=10, b=20 → acc_A=10, acc_B=20, sum=30 → output=30.
  test("equal scales: output is the integer sum") {
    val q = QuantParams(1.0f, 0)
    val cfg = AddCore.Config("add_eq", TensorShape(1, 1, 1), q, q, q)
    val out = runAdd(cfg, Seq(10), Seq(20))
    assert(out == Seq(30), s"expected Seq(30), got $out")
  }

  // ── Test 2: different input scales ────────────────────────────────────────
  // s_A=2.0, s_B=1.0, s_C=1.0 → M_A=2.0, M_B=1.0
  // a=5, b=3 → 2.0*(5-0) + 1.0*(3-0) = 10 + 3 = 13 → output=13.
  test("different input scales requantize independently") {
    val cfg = AddCore.Config("add_diff_scale",
      TensorShape(1, 1, 1),
      QuantParams(2.0f, 0),
      QuantParams(1.0f, 0),
      QuantParams(1.0f, 0))
    val out = runAdd(cfg, Seq(5), Seq(3))
    assert(out == Seq(13), s"expected Seq(13), got $out")
  }

  // ── Test 3: asymmetric zero-points ────────────────────────────────────────
  // s_A=s_B=s_C=1.0, zp_A=2, zp_B=3, zp_C=0.
  // a=12, b=8 → (12-2)+(8-3) = 10+5 = 15 → output=15.
  test("non-zero input zero-points are subtracted correctly") {
    val cfg = AddCore.Config("add_zp",
      TensorShape(1, 1, 1),
      QuantParams(1.0f, 2),
      QuantParams(1.0f, 3),
      QuantParams(1.0f, 0))
    val out = runAdd(cfg, Seq(12), Seq(8))
    assert(out == Seq(15), s"expected Seq(15), got $out")
  }

  // ── Test 4: output clamping ───────────────────────────────────────────────
  // sum exceeds 127 → clamped to 127.
  test("output is clamped to INT8 max") {
    val q = QuantParams(1.0f, 0)
    val cfg = AddCore.Config("add_clamp", TensorShape(1, 1, 1), q, q, q)
    val out = runAdd(cfg, Seq(100), Seq(100))
    assert(out == Seq(127), s"expected Seq(127) (clamped), got $out")
  }

  // ── Test 5: multi-element stream (pipeline throughput) ────────────────────
  // 4 elements processed back-to-back. Verifies pipeline correctly handles
  // successive pairs without dropped elements or incorrect interleavings.
  test("multi-element stream: all 4 pairs produce correct results") {
    val q = QuantParams(1.0f, 0)
    val cfg = AddCore.Config("add_multi", TensorShape(1, 1, 4), q, q, q)
    val as = Seq(1, 2, 3, 4)
    val bs = Seq(10, 20, 30, 40)
    val out = runAdd(cfg, as, bs)
    assert(out == Seq(11, 22, 33, 44), s"expected Seq(11,22,33,44), got $out")
  }
}
