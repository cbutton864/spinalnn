package spinalnn.ops

import org.scalatest.funsuite.AnyFunSuite
import spinal.core._
import spinal.core.sim._
import spinalnn.ops.linear.QLinearLinearCore
import spinalnn.target.WeightStream
import spinalnn.testhelpers.QLinearLinearHarness
import spinalnn.types._
import scala.collection.mutable

class QLinearLinearCoreTest extends AnyFunSuite {

  val idQ = QuantParams(scale = 1.0f, zeroPoint = 0)

  def compile(cfg: QLinearLinearCore.Config) =
    SimConfig
      .withWave
      .workspacePath("simWorkspace/QLinearLinearCoreTest")
      .compile(new QLinearLinearHarness(cfg))

  def driveInputs(dut: QLinearLinearHarness, values: Seq[Int]): Unit = {
    for (v <- values) {
      dut.io.activationIn.valid         #= true
      dut.io.activationIn.payload.value #= v
      dut.clockDomain.waitSamplingWhere(dut.io.activationIn.ready.toBoolean)
    }
    dut.io.activationIn.valid #= false
  }

  def collectOutputs(dut: QLinearLinearHarness, count: Int, timeout: Int = 100000): Seq[Int] = {
    val results = mutable.ArrayBuffer[Int]()
    dut.io.activationOut.ready #= true
    var cycles = 0
    while (results.length < count && cycles < timeout) {
      dut.clockDomain.waitSampling()
      sleep(1)
      if (dut.io.activationOut.valid.toBoolean && dut.io.activationOut.ready.toBoolean)
        results += dut.io.activationOut.payload.value.toInt
      cycles += 1
    }
    assert(cycles < timeout, s"Timeout: got ${results.length}/$count")
    results.toSeq
  }

  // ── Test 1: Selective weight matrix ──────────────────────────────────────
  // W = [[1,0,0],[0,1,0]], biases = [0,0], input = [3,5,7]
  // out[0] = 3*1 + 5*0 + 7*0 = 3
  // out[1] = 3*0 + 5*1 + 7*0 = 5
  test("Selective weight matrix extracts correct neurons") {
    val cfg = QLinearLinearCore.Config(
      periphName  = "linear_sel",
      inNeurons   = 3,
      outNeurons  = 2,
      inputQuant  = idQ, weightQuant = idQ, outputQuant = idQ,
      weights     = Array(1,0,0, 0,1,0).map(_.toByte),
      biases      = Array(0, 0)
    )
    compile(cfg).doSim("linear_sel") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)

      val stim = fork(driveInputs(dut, Seq(3, 5, 7)))
      val out  = collectOutputs(dut, 2)
      stim.join()
      assert(out == Seq(3, 5), s"Expected Seq(3,5), got $out")
    }
  }

  // ── Test 2: All-ones weights ──────────────────────────────────────────────
  // W = [[1,1,1],[1,1,1]], biases = [0,0], input = [3,5,7]
  // out[0] = out[1] = 3+5+7 = 15
  test("All-ones weights sum all inputs") {
    val cfg = QLinearLinearCore.Config(
      periphName  = "linear_sum",
      inNeurons   = 3,
      outNeurons  = 2,
      inputQuant  = idQ, weightQuant = idQ, outputQuant = idQ,
      weights     = Array.fill(6)(1.toByte),
      biases      = Array(0, 0)
    )
    compile(cfg).doSim("linear_sum") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)

      val stim = fork(driveInputs(dut, Seq(3, 5, 7)))
      val out  = collectOutputs(dut, 2)
      stim.join()
      assert(out == Seq(15, 15), s"Expected Seq(15,15), got $out")
    }
  }

  // ── Test 3: Non-zero bias ─────────────────────────────────────────────────
  // W = [[1,0,0],[0,1,0]], biases = [10,20], input = [3,5,7]
  // out[0] = 3 + 10 = 13,  out[1] = 5 + 20 = 25
  test("Non-zero bias added correctly") {
    val cfg = QLinearLinearCore.Config(
      periphName  = "linear_bias",
      inNeurons   = 3,
      outNeurons  = 2,
      inputQuant  = idQ, weightQuant = idQ, outputQuant = idQ,
      weights     = Array(1,0,0, 0,1,0).map(_.toByte),
      biases      = Array(10, 20)
    )
    compile(cfg).doSim("linear_bias") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)

      val stim = fork(driveInputs(dut, Seq(3, 5, 7)))
      val out  = collectOutputs(dut, 2)
      stim.join()
      assert(out == Seq(13, 25), s"Expected Seq(13,25), got $out")
    }
  }

  // ── Test 4: Positive clamping ─────────────────────────────────────────────
  // 3 inputs all 50, all-ones weights, 2 outputs: acc = 150 > 127 -> clamp
  test("Output clamped to 127 on positive overflow") {
    val cfg = QLinearLinearCore.Config(
      periphName  = "linear_clamp_pos",
      inNeurons   = 3,
      outNeurons  = 2,
      inputQuant  = idQ, weightQuant = idQ, outputQuant = idQ,
      weights     = Array.fill(6)(1.toByte),
      biases      = Array(0, 0)
    )
    compile(cfg).doSim("linear_clamp_pos") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)

      val stim = fork(driveInputs(dut, Seq.fill(3)(50)))
      val out  = collectOutputs(dut, 2)
      stim.join()
      assert(out == Seq(127, 127), s"Expected Seq(127,127), got $out")
    }
  }

  // ── Test 5: Back-to-back inference ───────────────────────────────────────
  test("Back-to-back inference produces correct results both times") {
    val cfg = QLinearLinearCore.Config(
      periphName  = "linear_b2b",
      inNeurons   = 3,
      outNeurons  = 2,
      inputQuant  = idQ, weightQuant = idQ, outputQuant = idQ,
      weights     = Array.fill(6)(1.toByte),
      biases      = Array(0, 0)
    )
    compile(cfg).doSim("linear_b2b") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)

      for (frame <- 1 to 2) {
        val stim = fork(driveInputs(dut, Seq(3, 5, 7)))
        val out  = collectOutputs(dut, 2)
        stim.join()
        assert(out == Seq(15, 15), s"Frame $frame: expected Seq(15,15), got $out")
      }
    }
  }

  // Pack weight bytes into 64-byte (512-bit) beats and feed them continuously.
  // weightsPerNeuron = inNeurons (bytes per output neuron, one entry per FC row).
  def feedWeightStream(dut: QLinearLinearHarness, weights: Array[Byte], weightsPerNeuron: Int): Unit = {
    val stride   = ((weightsPerNeuron + 63) / 64) * 64
    val numNeurs = weights.length / weightsPerNeuron
    var neuron   = 0
    while (true) {
      val nBase = neuron * weightsPerNeuron
      val buf   = Array.fill[Byte](stride)(0)
      Array.copy(weights, nBase, buf, 0, weightsPerNeuron)
      var beatOff = 0
      while (beatOff < stride) {
        var beatVal = BigInt(0)
        for (b <- 0 until 64) { beatVal = beatVal | (BigInt(buf(beatOff + b) & 0xff) << (b * 8)) }
        dut.weightIn.valid   #= true
        dut.weightIn.payload #= beatVal
        dut.clockDomain.waitSamplingWhere(dut.weightIn.ready.toBoolean)
        beatOff += 64
      }
      neuron = (neuron + 1) % numNeurs
    }
  }

  // ── Test 6: WeightStream matches WeightRom ────────────────────────────────
  // 2-output-neuron layer; streaming the weight matrix gives same results.
  test("WeightStream: linear layer matches WeightRom output") {
    val ws = Array(1, 0, 0, 0, 1, 0).map(_.toByte)  // identity-like, 2×3
    val romCfg = QLinearLinearCore.Config(
      periphName = "wsl_ref", inNeurons = 3, outNeurons = 2,
      inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
      weights = ws, biases = Array(0, 0)
    )
    val streamCfg = romCfg.copy(periphName = "wsl_linear", weightMode = WeightStream)

    var romOut: Seq[Int]    = Nil
    var streamOut: Seq[Int] = Nil

    compile(romCfg).doSim("wsl_ref") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      val s = fork(driveInputs(dut, Seq(3, 5, 7)))
      romOut = collectOutputs(dut, 2); s.join()
    }

    compile(streamCfg).doSim("wsl_linear") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.weightIn.valid #= false; dut.weightIn.payload #= 0
      dut.clockDomain.waitSampling(2)
      val wf = fork(feedWeightStream(dut, streamCfg.weights, streamCfg.inNeurons))
      val s  = fork(driveInputs(dut, Seq(3, 5, 7)))
      streamOut = collectOutputs(dut, 2); s.join(); wf.terminate()
    }

    assert(streamOut == romOut,
      s"WeightStream linear mismatch.\n  rom:    $romOut\n  stream: $streamOut")
  }
}
