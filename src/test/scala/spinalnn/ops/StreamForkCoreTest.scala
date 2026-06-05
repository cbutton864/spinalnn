package spinalnn.ops

import org.scalatest.funsuite.AnyFunSuite
import spinal.core._
import spinal.core.sim._
import spinal.lib.sim.{StreamDriver, StreamMonitor, StreamReadyRandomizer}
import spinalnn.ops.fork.StreamForkCore
import spinalnn.testhelpers.StreamForkHarness
import spinalnn.types._
import scala.collection.mutable

class StreamForkCoreTest extends AnyFunSuite {

  def compile(cfg: StreamForkCore.Config) =
    SimConfig
      .withWave
      .workspacePath("simWorkspace/StreamForkCoreTest")
      .compile(new StreamForkHarness(cfg))

  // Drives the single input from a queue and monitors every output branch. Every
  // branch must observe the identical element sequence (HWC order preserved).
  // randomReady exercises the async hold path -- branches accepting at different
  // rates -- which is the whole reason the default fork carries per-output tokens.
  // Uses spinal.lib.sim StreamDriver/StreamMonitor so input-valid deassertion never
  // races with output sampling on this same-cycle streaming core.
  def runFork(cfg: StreamForkCore.Config, input: Seq[Int], randomReady: Boolean): Seq[Seq[Int]] = {
    val n = cfg.numOutputs
    var got: Seq[Seq[Int]] = Nil
    compile(cfg).doSim(cfg.periphName) { dut =>
      dut.clockDomain.forkStimulus(period = 10)

      val captured = Seq.fill(n)(mutable.ArrayBuffer[Int]())
      for (i <- 0 until n) {
        StreamMonitor(dut.io.activationOuts(i), dut.clockDomain) { p =>
          captured(i) += p.value.toInt
        }
        if (randomReady) StreamReadyRandomizer(dut.io.activationOuts(i), dut.clockDomain)
        else dut.io.activationOuts(i).ready #= true
      }

      val q = mutable.Queue(input: _*)
      StreamDriver(dut.io.activationIn, dut.clockDomain) { p =>
        if (q.nonEmpty) { p.value #= q.dequeue(); true } else false
      }

      var cycles = 0
      while (captured.exists(_.length < input.length) && cycles < 8000) {
        dut.clockDomain.waitSampling()
        cycles += 1
      }
      dut.clockDomain.waitSampling(5)
      got = captured.map(_.toSeq)
    }
    got
  }

  // ── Test 1: 2-way fork, both branches always ready ──────────────────────
  test("2-way fork replicates the full sequence to both outputs") {
    val cfg = StreamForkCore.Config("fork2", TensorShape(1, 3, 1), numOutputs = 2)
    val outs = runFork(cfg, Seq(10, 20, 30), randomReady = false)
    assert(outs == Seq(Seq(10, 20, 30), Seq(10, 20, 30)), s"got $outs")
  }

  // ── Test 2: 3-way fork ──────────────────────────────────────────────────
  test("3-way fork replicates to all branches") {
    val cfg = StreamForkCore.Config("fork3", TensorShape(2, 2, 1), numOutputs = 3)
    val in   = Seq(1, 2, 3, 4)
    val outs = runFork(cfg, in, randomReady = false)
    assert(outs == Seq(in, in, in), s"got $outs")
  }

  // ── Test 3: async fork under independent random back-pressure ───────────
  // The two branches accept at different rates; the per-output linkEnable tokens
  // must hold each input element until BOTH have taken it -- no loss, no dup.
  test("async fork holds input until every branch consumes (random back-pressure)") {
    val cfg = StreamForkCore.Config("fork_bp", TensorShape(1, 6, 1), numOutputs = 2)
    val in   = Seq(5, 6, 7, 8, 9, 10)
    val outs = runFork(cfg, in, randomReady = true)
    assert(outs == Seq(in, in), s"async fork lost/duplicated data: got $outs")
  }

  // ── Test 4: synchronous (lock-step) fork variant ────────────────────────
  test("synchronous fork replicates when consumers move in lock-step") {
    val cfg  = StreamForkCore.Config("fork_sync", TensorShape(1, 4, 1), numOutputs = 2, synchronous = true)
    val in   = Seq(11, 12, 13, 14)
    val outs = runFork(cfg, in, randomReady = false)
    assert(outs == Seq(in, in), s"got $outs")
  }
}
