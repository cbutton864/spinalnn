package spinalnn.ops

import org.scalatest.funsuite.AnyFunSuite
import spinal.core._
import spinal.core.sim._
import spinalnn.ops.conv.QLinearConvCore
import spinalnn.target.WeightStream
import spinalnn.testhelpers.QLinearConvHarness
import spinalnn.types._
import scala.collection.mutable

class QLinearConvCoreTest extends AnyFunSuite {

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
      weights     = Array(1.toByte),
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

  // ── WeightStream helpers ──────────────────────────────────────────────────

  // Pack weight bytes into 64-byte (512-bit) beats and feed them continuously.
  // weightsPerChActual is the number of valid bytes per output channel; the
  // rest of the last beat is padded with zeros (matching DMA behaviour).
  // This function cycles through all output channels repeatedly (per-channel
  // weights are read from the flat `weights` array in channel-major order).
  def feedWeightStreamBeats(
    dut:                QLinearConvHarness,
    weights:            Array[Byte],
    weightsPerChActual: Int,
    numOutputCh:        Int
  ): Unit = {
    val stride = ((weightsPerChActual + 63) / 64) * 64
    var ch = 0
    while (true) {
      val chBase = ch * weightsPerChActual
      // Build one channel's worth of beats (stride bytes, zero-padded).
      val buf = Array.fill[Byte](stride)(0)
      Array.copy(weights, chBase, buf, 0, weightsPerChActual)
      // Emit one beat (64 bytes = 512 bits) at a time.
      var beatOff = 0
      while (beatOff < stride) {
        var beatVal = BigInt(0)
        for (b <- 0 until 64) {
          val byteVal = BigInt(buf(beatOff + b) & 0xff)
          beatVal = beatVal | (byteVal << (b * 8))
        }
        dut.weightIn.valid   #= true
        dut.weightIn.payload #= beatVal
        dut.clockDomain.waitSamplingWhere(dut.weightIn.ready.toBoolean)
        beatOff += 64
      }
      ch = (ch + 1) % numOutputCh
    }
  }

  // ── Test 8: WeightStream matches WeightRom for 1x1 identity conv ─────────
  test("WeightStream: 3x3x1 -> 1x1 conv weight=1 matches WeightRom output") {
    val romCfg = QLinearConvCore.Config(
      periphName = "wstream_ref_1x1", inputShape = TensorShape(3, 3, 1),
      outputShape = TensorShape(3, 3, 1), kernelH = 1, kernelW = 1,
      inputQuant = identityInput, weightQuant = identityWeight,
      outputQuant = identityOutput, weights = Array(1.toByte), biases = Array(0)
    )
    val streamCfg = romCfg.copy(periphName = "wstream_1x1", weightMode = WeightStream)

    var romOut: Seq[Int]    = Nil
    var streamOut: Seq[Int] = Nil

    compile(romCfg).doSim("wstream_ref_1x1") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      val s = fork(driveInputs(dut, 1 to 9))
      romOut = collectOutputs(dut, 9); s.join()
    }

    compile(streamCfg).doSim("wstream_1x1") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.weightIn.valid #= false; dut.weightIn.payload #= 0
      dut.clockDomain.waitSampling(2)
      val wf = fork(feedWeightStreamBeats(dut, streamCfg.weights,
        streamCfg.kernelH * streamCfg.kernelW * streamCfg.inputShape.channels,
        streamCfg.outputShape.channels))
      val s  = fork(driveInputs(dut, 1 to 9))
      streamOut = collectOutputs(dut, 9); s.join(); wf.terminate()
    }

    assert(streamOut == romOut,
      s"WeightStream mismatch.\n  rom:    $romOut\n  stream: $streamOut")
  }

  // ── Test 9: WeightStream matches WeightRom for 3x3 summing conv ──────────
  test("WeightStream: 3x3x1 -> 3x3 sum conv matches WeightRom output") {
    val ws = Array.fill(9)(1.toByte)
    val romCfg = QLinearConvCore.Config(
      periphName = "wstream_ref_3x3", inputShape = TensorShape(3, 3, 1),
      outputShape = TensorShape(1, 1, 1), kernelH = 3, kernelW = 3,
      inputQuant = identityInput, weightQuant = identityWeight,
      outputQuant = identityOutput, weights = ws, biases = Array(0)
    )
    val streamCfg = romCfg.copy(periphName = "wstream_3x3", weightMode = WeightStream)

    var romOut: Seq[Int]    = Nil
    var streamOut: Seq[Int] = Nil

    compile(romCfg).doSim("wstream_ref_3x3") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      val s = fork(driveInputs(dut, 1 to 9)); romOut = collectOutputs(dut, 1); s.join()
    }

    compile(streamCfg).doSim("wstream_3x3") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.weightIn.valid #= false; dut.weightIn.payload #= 0
      dut.clockDomain.waitSampling(2)
      val wf = fork(feedWeightStreamBeats(dut, streamCfg.weights,
        streamCfg.kernelH * streamCfg.kernelW * streamCfg.inputShape.channels,
        streamCfg.outputShape.channels))
      val s  = fork(driveInputs(dut, 1 to 9))
      streamOut = collectOutputs(dut, 1); s.join(); wf.terminate()
    }

    assert(streamOut == romOut,
      s"WeightStream mismatch.\n  rom:    $romOut\n  stream: $streamOut")
  }

  // ── Test 10: WeightStream N=2 matches WeightRom ───────────────────────────
  // 1x1 conv, C_in=4, N=2: two MAC lanes per step, weights streamed.
  // Input [1,2,3,4], all-ones weights, 1 output channel. acc = 10.
  test("WeightStream N=2: 1x1 C_in=4 matches WeightRom output") {
    val ws = Array.fill(4)(1.toByte)
    val romCfg = QLinearConvCore.Config(
      periphName = "wstream_n2_ref", inputShape = TensorShape(1, 1, 4),
      outputShape = TensorShape(1, 1, 1), kernelH = 1, kernelW = 1,
      inputQuant = identityInput, weightQuant = identityWeight,
      outputQuant = identityOutput, weights = ws, biases = Array(0),
      macParallelism = 2
    )
    val streamCfg = romCfg.copy(periphName = "wstream_n2", weightMode = WeightStream)

    var romOut:    Seq[Int] = Nil
    var streamOut: Seq[Int] = Nil

    compile(romCfg).doSim("wstream_n2_ref") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      val s = fork(driveInputs(dut, Seq(1, 2, 3, 4)))
      romOut = collectOutputs(dut, 1); s.join()
    }

    compile(streamCfg).doSim("wstream_n2") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.weightIn.valid #= false; dut.weightIn.payload #= 0
      dut.clockDomain.waitSampling(2)
      val wf = fork(feedWeightStreamBeats(dut, streamCfg.weights,
        streamCfg.kernelH * streamCfg.kernelW * streamCfg.inputShape.channels,
        streamCfg.outputShape.channels))
      val s  = fork(driveInputs(dut, Seq(1, 2, 3, 4)))
      streamOut = collectOutputs(dut, 1); s.join(); wf.terminate()
    }

    assert(streamOut == romOut,
      s"WeightStream N=2 mismatch.\n  rom:    $romOut\n  stream: $streamOut")
    assert(romOut == Seq(10), s"Expected Seq(10), got $romOut")
  }

  // ── Test 11: WeightStream N=4 matches WeightRom ───────────────────────────
  // 1x1 conv, C_in=4, N=4: all four channels in one MAC step, weights streamed.
  test("WeightStream N=4: 1x1 C_in=4 matches WeightRom output") {
    val ws = Array.fill(4)(1.toByte)
    val romCfg = QLinearConvCore.Config(
      periphName = "wstream_n4_ref", inputShape = TensorShape(1, 1, 4),
      outputShape = TensorShape(1, 1, 1), kernelH = 1, kernelW = 1,
      inputQuant = identityInput, weightQuant = identityWeight,
      outputQuant = identityOutput, weights = ws, biases = Array(0),
      macParallelism = 4
    )
    val streamCfg = romCfg.copy(periphName = "wstream_n4", weightMode = WeightStream)

    var romOut:    Seq[Int] = Nil
    var streamOut: Seq[Int] = Nil

    compile(romCfg).doSim("wstream_n4_ref") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      val s = fork(driveInputs(dut, Seq(1, 2, 3, 4)))
      romOut = collectOutputs(dut, 1); s.join()
    }

    compile(streamCfg).doSim("wstream_n4") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.weightIn.valid #= false; dut.weightIn.payload #= 0
      dut.clockDomain.waitSampling(2)
      val wf = fork(feedWeightStreamBeats(dut, streamCfg.weights,
        streamCfg.kernelH * streamCfg.kernelW * streamCfg.inputShape.channels,
        streamCfg.outputShape.channels))
      val s  = fork(driveInputs(dut, Seq(1, 2, 3, 4)))
      streamOut = collectOutputs(dut, 1); s.join(); wf.terminate()
    }

    assert(streamOut == romOut,
      s"WeightStream N=4 mismatch.\n  rom:    $romOut\n  stream: $streamOut")
    assert(romOut == Seq(10), s"Expected Seq(10), got $romOut")
  }

  // ── Test 12: WeightStream N=4, multi-channel, multi-output ───────────────
  // 2x2x4 input, 1x1 conv, 2 output channels, N=4, weights streamed.
  // Each output neuron has [1,1,1,1] weights; each position sums its 4 channels.
  // Input HWC: positions (0,0)=[1,2,3,4], (0,1)=[5,6,7,8], (1,0)=[9,10,11,12], (1,1)=[13,14,15,16]
  // Output ch0: [10, 26, 42, 58]; output ch1: same (identical weights).
  // Output order: ch0@(0,0), ch1@(0,0), ch0@(0,1), ch1@(0,1), ch0@(1,0), ch1@(1,0), ch0@(1,1), ch1@(1,1)
  // Wait — QLinearConvCore iterates in (outRow, outCol, outCh) order:
  // For each spatial position: emit outCh 0 then outCh 1.
  test("WeightStream N=4: 2x2x4 input, 2 output channels, matches WeightRom") {
    val ws = Array.fill(8)(1.toByte)  // 2 channels * 4 inputs each = 8 weights total
    val romCfg = QLinearConvCore.Config(
      periphName = "wstream_n4_multi_ref", inputShape = TensorShape(2, 2, 4),
      outputShape = TensorShape(2, 2, 2), kernelH = 1, kernelW = 1,
      inputQuant = identityInput, weightQuant = identityWeight,
      outputQuant = identityOutput, weights = ws, biases = Array(0, 0),
      macParallelism = 4
    )
    val streamCfg = romCfg.copy(periphName = "wstream_n4_multi", weightMode = WeightStream)

    var romOut:    Seq[Int] = Nil
    var streamOut: Seq[Int] = Nil

    compile(romCfg).doSim("wstream_n4_multi_ref") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      val s = fork(driveInputs(dut, 1 to 16))
      romOut = collectOutputs(dut, 8); s.join()
    }

    compile(streamCfg).doSim("wstream_n4_multi") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.weightIn.valid #= false; dut.weightIn.payload #= 0
      dut.clockDomain.waitSampling(2)
      val wf = fork(feedWeightStreamBeats(dut, streamCfg.weights,
        streamCfg.kernelH * streamCfg.kernelW * streamCfg.inputShape.channels,
        streamCfg.outputShape.channels))
      val s  = fork(driveInputs(dut, 1 to 16))
      streamOut = collectOutputs(dut, 8); s.join(); wf.terminate()
    }

    assert(streamOut == romOut,
      s"WeightStream N=4 multi mismatch.\n  rom:    $romOut\n  stream: $streamOut")
  }
}
