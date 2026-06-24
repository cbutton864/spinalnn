package spinalnn.ops

import org.scalatest.funsuite.AnyFunSuite
import spinal.core._
import spinal.core.sim._
import spinalnn.ops.conv.{QLinearConvCore, QLinearConvLineCore}
import spinalnn.target.WeightStream
import spinalnn.testhelpers.{QLinearConvHarness, QLinearConvLineCoreHarness}
import spinalnn.types._
import scala.collection.mutable

/**
 * Verifies [[QLinearConvLineCore]] produces pixel-identical outputs to [[QLinearConvCore]]
 * for the same conv configuration, for both padded (SAME) and unpadded (VALID) convolutions,
 * and across two consecutive inferences (which exercises the sInit reset path).
 */
class QLinearConvLineCoreTest extends AnyFunSuite {

  val idQ = QuantParams(scale = 1.0f, zeroPoint = 0)

  def compileRef(cfg: QLinearConvCore.Config) =
    SimConfig.withWave
      .workspacePath("simWorkspace/QLinearConvLineCoreTest")
      .compile(new QLinearConvHarness(cfg))

  def compileLine(cfg: QLinearConvLineCore.Config) =
    SimConfig.withWave
      .workspacePath("simWorkspace/QLinearConvLineCoreTest")
      .compile(new QLinearConvLineCoreHarness(cfg))

  def driveRef(dut: QLinearConvHarness, values: Seq[Int]): Unit = {
    for (v <- values) {
      dut.io.activationIn.valid         #= true
      dut.io.activationIn.payload.value #= v
      dut.clockDomain.waitSamplingWhere(dut.io.activationIn.ready.toBoolean)
    }
    dut.io.activationIn.valid #= false
  }

  def driveLine(dut: QLinearConvLineCoreHarness, values: Seq[Int]): Unit = {
    for (v <- values) {
      dut.io.activationIn.valid         #= true
      dut.io.activationIn.payload.value #= v
      dut.clockDomain.waitSamplingWhere(dut.io.activationIn.ready.toBoolean)
    }
    dut.io.activationIn.valid #= false
  }

  def collectRef(dut: QLinearConvHarness, count: Int): Seq[Int] = {
    val out = mutable.ArrayBuffer[Int]()
    dut.io.activationOut.ready #= true
    var cycles = 0
    while (out.length < count && cycles < 500000) {
      dut.clockDomain.waitSampling(); sleep(1)
      if (dut.io.activationOut.valid.toBoolean) out += dut.io.activationOut.payload.value.toInt
      cycles += 1
    }
    assert(cycles < 500000, s"Timeout collecting ref outputs (got ${out.length}/$count)")
    out.toSeq
  }

  def collectLine(dut: QLinearConvLineCoreHarness, count: Int): Seq[Int] = {
    val out = mutable.ArrayBuffer[Int]()
    dut.io.activationOut.ready #= true
    var cycles = 0
    while (out.length < count && cycles < 500000) {
      dut.clockDomain.waitSampling(); sleep(1)
      if (dut.io.activationOut.valid.toBoolean) out += dut.io.activationOut.payload.value.toInt
      cycles += 1
    }
    assert(cycles < 500000, s"Timeout collecting line outputs (got ${out.length}/$count)")
    out.toSeq
  }

  // Shared conv parameters used across tests.
  val H = 5; val W = 5; val Cin = 1; val Cout = 2; val KH = 3; val KW = 3

  // All-ones weights: [Cout, KH, KW, Cin] layout after transpose.
  val weights = Array.fill(Cout * KH * KW * Cin)(1.toByte)
  val biases  = Array.fill(Cout)(0)

  // ── Test 1: SAME-padded conv, line-buffer == full-buffer ─────────────────
  // 5×5×1 input, 3×3 kernel, SAME (pad=1 all sides), 2 output channels.
  // With all-ones weights and identity quant, each output pixel is the sum
  // of its 3×3 neighborhood (smaller near borders due to zero-padding).
  test("SAME-padded 5x5x1 -> 3x3 -> 5x5x2: line-buffer matches full-buffer") {
    val input  = TensorShape(H, W, Cin)
    val output = TensorShape(H, W, Cout)  // SAME padding preserves spatial dims

    val refCfg = QLinearConvCore.Config(
      periphName = "ref_same", inputShape = input, outputShape = output,
      kernelH = KH, kernelW = KW,
      padTop = 1, padBottom = 1, padLeft = 1, padRight = 1,
      inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
      weights = weights, biases = biases
    )
    val lineCfg = QLinearConvLineCore.Config(
      periphName = "line_same", inputShape = input, outputShape = output,
      kernelH = KH, kernelW = KW,
      padTop = 1, padBottom = 1, padLeft = 1, padRight = 1,
      inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
      weights = weights, biases = biases
    )

    val stimulus = (1 to H * W * Cin).map(_ % 20 - 10)   // -10..9, deterministic
    val outCount = H * W * Cout

    var refOut  = Seq.empty[Int]
    var lineOut = Seq.empty[Int]

    compileRef(refCfg).doSim("same_ref") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      val s = fork(driveRef(dut, stimulus))
      refOut = collectRef(dut, outCount)
      s.join()
    }

    compileLine(lineCfg).doSim("same_line") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      val s = fork(driveLine(dut, stimulus))
      lineOut = collectLine(dut, outCount)
      s.join()
    }

    assert(refOut == lineOut,
      s"Line-buffer mismatch on SAME conv.\n  ref:  $refOut\n  line: $lineOut")
  }

  // ── Test 2: VALID conv (no padding), line-buffer == full-buffer ───────────
  // 5×5×1 input, 3×3 VALID conv → 3×3×2 output.
  test("VALID 5x5x1 -> 3x3 -> 3x3x2: line-buffer matches full-buffer") {
    val input  = TensorShape(H, W, Cin)
    val output = TensorShape(3, 3, Cout)  // VALID: output shrinks

    val refCfg = QLinearConvCore.Config(
      periphName = "ref_valid", inputShape = input, outputShape = output,
      kernelH = KH, kernelW = KW,
      inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
      weights = weights, biases = biases
    )
    val lineCfg = QLinearConvLineCore.Config(
      periphName = "line_valid", inputShape = input, outputShape = output,
      kernelH = KH, kernelW = KW,
      inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
      weights = weights, biases = biases
    )

    val stimulus = (1 to H * W * Cin).map(_ % 20 - 10)
    val outCount = 3 * 3 * Cout

    var refOut  = Seq.empty[Int]
    var lineOut = Seq.empty[Int]

    compileRef(refCfg).doSim("valid_ref") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      val s = fork(driveRef(dut, stimulus))
      refOut = collectRef(dut, outCount)
      s.join()
    }

    compileLine(lineCfg).doSim("valid_line") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      val s = fork(driveLine(dut, stimulus))
      lineOut = collectLine(dut, outCount)
      s.join()
    }

    assert(refOut == lineOut,
      s"Line-buffer mismatch on VALID conv.\n  ref:  $refOut\n  line: $lineOut")
  }

  // ── Test 3: Two consecutive inferences, SAME padding ──────────────────────
  // Verifies the sInit reset path runs correctly between inferences.
  // Both inferences use different input values; each line-buffer output must
  // match the corresponding full-buffer output.
  test("SAME conv: two consecutive inferences give correct results") {
    val input  = TensorShape(H, W, Cin)
    val output = TensorShape(H, W, Cout)
    val outCount = H * W * Cout

    val stim1 = (1  to H * W * Cin).map(_ % 20 - 10)
    val stim2 = (11 to H * W * Cin + 10).map(_ % 20 - 10)

    val refCfg = QLinearConvCore.Config(
      periphName = "ref_2inf", inputShape = input, outputShape = output,
      kernelH = KH, kernelW = KW,
      padTop = 1, padBottom = 1, padLeft = 1, padRight = 1,
      inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
      weights = weights, biases = biases
    )
    val lineCfg = QLinearConvLineCore.Config(
      periphName = "line_2inf", inputShape = input, outputShape = output,
      kernelH = KH, kernelW = KW,
      padTop = 1, padBottom = 1, padLeft = 1, padRight = 1,
      inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
      weights = weights, biases = biases
    )

    var refOut1  = Seq.empty[Int]; var refOut2  = Seq.empty[Int]
    var lineOut1 = Seq.empty[Int]; var lineOut2 = Seq.empty[Int]

    compileRef(refCfg).doSim("ref_2inf") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      val s1 = fork(driveRef(dut, stim1))
      refOut1 = collectRef(dut, outCount); s1.join()
      val s2 = fork(driveRef(dut, stim2))
      refOut2 = collectRef(dut, outCount); s2.join()
    }

    compileLine(lineCfg).doSim("line_2inf") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      val s1 = fork(driveLine(dut, stim1))
      lineOut1 = collectLine(dut, outCount); s1.join()
      val s2 = fork(driveLine(dut, stim2))
      lineOut2 = collectLine(dut, outCount); s2.join()
    }

    assert(refOut1 == lineOut1,
      s"Line-buffer inference-1 mismatch.\n  ref:  $refOut1\n  line: $lineOut1")
    assert(refOut2 == lineOut2,
      s"Line-buffer inference-2 mismatch.\n  ref:  $refOut2\n  line: $lineOut2")
  }

  def feedWeightStream(
    dut:           QLinearConvLineCoreHarness,
    weights:       Array[Byte],
    weightsPerCh:  Int,
    numOutputCh:   Int
  ): Unit = {
    val stride = ((weightsPerCh + 63) / 64) * 64
    var ch     = 0
    while (true) {
      val chBase = ch * weightsPerCh
      val buf    = Array.fill[Byte](stride)(0)
      Array.copy(weights, chBase, buf, 0, weightsPerCh)
      var beatOff = 0
      while (beatOff < stride) {
        var beatVal = BigInt(0)
        for (b <- 0 until 64) { beatVal = beatVal | (BigInt(buf(beatOff + b) & 0xff) << (b * 8)) }
        dut.weightIn.valid   #= true
        dut.weightIn.payload #= beatVal
        dut.clockDomain.waitSamplingWhere(dut.weightIn.ready.toBoolean)
        beatOff += 64
      }
      ch = (ch + 1) % numOutputCh
    }
  }

  // ── Test 4: WeightStream line-buffer matches WeightRom line-buffer ─────────
  // VALID 5×5 → 3×3×2, same config but weights streamed at runtime.
  test("WeightStream: VALID line-buffer matches WeightRom output") {
    val input  = TensorShape(H, W, Cin)
    val output = TensorShape(3, 3, Cout)

    val romCfg = QLinearConvLineCore.Config(
      periphName = "wsl_ref_valid", inputShape = input, outputShape = output,
      kernelH = KH, kernelW = KW,
      inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
      weights = weights, biases = biases
    )
    val streamCfg = romCfg.copy(periphName = "wsl_valid", weightMode = WeightStream)

    val stimulus = (1 to H * W * Cin).map(_ % 20 - 10)
    val outCount = 3 * 3 * Cout
    var romOut: Seq[Int]    = Nil
    var streamOut: Seq[Int] = Nil

    compileLine(romCfg).doSim("wsl_ref_valid") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      val s = fork(driveLine(dut, stimulus))
      romOut = collectLine(dut, outCount); s.join()
    }

    compileLine(streamCfg).doSim("wsl_valid") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.weightIn.valid #= false; dut.weightIn.payload #= 0
      dut.clockDomain.waitSampling(2)
      val wCh = streamCfg.kernelH * streamCfg.kernelW * streamCfg.inputShape.channels
      val wf = fork(feedWeightStream(dut, streamCfg.weights, wCh, streamCfg.outputShape.channels))
      val s  = fork(driveLine(dut, stimulus))
      streamOut = collectLine(dut, outCount); s.join(); wf.terminate()
    }

    assert(streamOut == romOut,
      s"WeightStream line-buffer mismatch (VALID).\n  rom:    $romOut\n  stream: $streamOut")
  }

  // ── Test 5: 1×1 conv (kernelH=1) line-buffer == full-buffer ─────────────────
  // Exercises the kernelH=1 path where QLinearConvLineCore uses a single row buffer.
  // Input 5×5×2, 1×1 kernel, 3 output channels.
  test("1x1 conv: kernelH=1 line-buffer matches full-buffer") {
    val h = 5; val w = 5; val cin = 2; val cout = 3
    val input  = TensorShape(h, w, cin)
    val output = TensorShape(h, w, cout)
    val w11    = Array.tabulate(cout * cin)(i => ((i * 7 + 3) % 60 - 30).toByte)
    val b11    = Array.fill(cout)(0)

    val refCfg = QLinearConvCore.Config(
      periphName = "ref_1x1", inputShape = input, outputShape = output,
      kernelH = 1, kernelW = 1,
      inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
      weights = w11, biases = b11
    )
    val lineCfg = QLinearConvLineCore.Config(
      periphName = "line_1x1", inputShape = input, outputShape = output,
      kernelH = 1, kernelW = 1,
      inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
      weights = w11, biases = b11
    )

    val stimulus = (1 to h * w * cin).map(i => (i * 3 + 1) % 20 - 10)
    val outCount = h * w * cout

    var refOut  = Seq.empty[Int]
    var lineOut = Seq.empty[Int]

    compileRef(refCfg).doSim("1x1_ref") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      val s = fork(driveRef(dut, stimulus))
      refOut = collectRef(dut, outCount)
      s.join()
    }

    compileLine(lineCfg).doSim("1x1_line") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      val s = fork(driveLine(dut, stimulus))
      lineOut = collectLine(dut, outCount)
      s.join()
    }

    assert(refOut == lineOut,
      s"1×1 conv mismatch.\n  ref:  $refOut\n  line: $lineOut")
  }

  // ── Test 6: WeightStream line-buffer, SAME padding ─────────────────────────
  test("WeightStream: SAME line-buffer matches WeightRom output") {
    val input  = TensorShape(H, W, Cin)
    val output = TensorShape(H, W, Cout)

    val romCfg = QLinearConvLineCore.Config(
      periphName = "wsl_ref_same", inputShape = input, outputShape = output,
      kernelH = KH, kernelW = KW,
      padTop = 1, padBottom = 1, padLeft = 1, padRight = 1,
      inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
      weights = weights, biases = biases
    )
    val streamCfg = romCfg.copy(periphName = "wsl_same", weightMode = WeightStream)

    val stimulus = (1 to H * W * Cin).map(_ % 20 - 10)
    val outCount = H * W * Cout
    var romOut: Seq[Int]    = Nil
    var streamOut: Seq[Int] = Nil

    compileLine(romCfg).doSim("wsl_ref_same") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      val s = fork(driveLine(dut, stimulus))
      romOut = collectLine(dut, outCount); s.join()
    }

    compileLine(streamCfg).doSim("wsl_same") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.weightIn.valid #= false; dut.weightIn.payload #= 0
      dut.clockDomain.waitSampling(2)
      val wCh = streamCfg.kernelH * streamCfg.kernelW * streamCfg.inputShape.channels
      val wf = fork(feedWeightStream(dut, streamCfg.weights, wCh, streamCfg.outputShape.channels))
      val s  = fork(driveLine(dut, stimulus))
      streamOut = collectLine(dut, outCount); s.join(); wf.terminate()
    }

    assert(streamOut == romOut,
      s"WeightStream line-buffer mismatch (SAME).\n  rom:    $romOut\n  stream: $streamOut")
  }

  // ── N>1 tests: line-buffer with macParallelism > 1 ─────────────────────────

  // Helper: run line-buffer at macParallelism=N against N=1 reference and compare.
  def checkLineBufNvsRef(
    label:  String,
    input:  TensorShape,
    output: TensorShape,
    kH: Int, kW: Int,
    pTop: Int = 0, pBot: Int = 0, pLeft: Int = 0, pRight: Int = 0,
    macN: Int,
    ws:   Array[Byte],
    bs:   Array[Int]
  ): Unit = {
    val refCfg = QLinearConvLineCore.Config(
      periphName = s"${label}_n1", inputShape = input, outputShape = output,
      kernelH = kH, kernelW = kW,
      padTop = pTop, padBottom = pBot, padLeft = pLeft, padRight = pRight,
      inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
      weights = ws, biases = bs, macParallelism = 1
    )
    val parCfg = refCfg.copy(periphName = s"${label}_n$macN", macParallelism = macN)
    val stimulus = (1 to input.size).map(i => (i * 7 + 3) % 20 - 10)
    val outCount = output.size
    var refOut = Seq.empty[Int]
    var parOut = Seq.empty[Int]

    compileLine(refCfg).doSim(s"${label}_n1") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      val s = fork(driveLine(dut, stimulus))
      refOut = collectLine(dut, outCount); s.join()
    }
    compileLine(parCfg).doSim(s"${label}_n$macN") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      val s = fork(driveLine(dut, stimulus))
      parOut = collectLine(dut, outCount); s.join()
    }
    assert(parOut == refOut,
      s"[$label] N=$macN mismatch at ${output.size} outputs.\n  ref: $refOut\n  got: $parOut")
  }



  // 3×3 conv, C_in=4, N=2
  test("N=2: 3x3 conv, C_in=4, VALID: line-buffer N=2 matches N=1") {
    val cin = 4; val cout = 3; val h = 5; val w = 5
    val input  = TensorShape(h, w, cin)
    val output = TensorShape(3, 3, cout)
    val ws = Array.tabulate(cout * 3 * 3 * cin)(i => ((i * 5 + 1) % 30 - 15).toByte)
    val bs = Array.fill(cout)(0)
    checkLineBufNvsRef("n2_3x3", input, output, 3, 3, macN = 2, ws = ws, bs = bs)
  }

  // 1×1 conv, C_in=4, N=4
  test("N=4: 1x1 conv, C_in=4, SAME: line-buffer N=4 matches N=1") {
    val cin = 4; val cout = 2; val h = 6; val w = 6
    val input  = TensorShape(h, w, cin)
    val output = TensorShape(h, w, cout)
    val ws = Array.tabulate(cout * cin)(i => ((i * 3 + 2) % 20 - 10).toByte)
    val bs = Array.fill(cout)(0)
    checkLineBufNvsRef("n4_1x1_same", input, output, 1, 1,
      pTop = 0, pBot = 0, pLeft = 0, pRight = 0, macN = 4, ws = ws, bs = bs)
  }

  // 3×3 conv, C_in=8, N=8, SAME padding
  test("N=8: 3x3 conv, C_in=8, SAME: line-buffer N=8 matches N=1") {
    val cin = 8; val cout = 4; val h = 5; val w = 5
    val input  = TensorShape(h, w, cin)
    val output = TensorShape(h, w, cout)
    val ws = Array.tabulate(cout * 3 * 3 * cin)(i => ((i * 11 + 5) % 40 - 20).toByte)
    val bs = Array.fill(cout)(0)
    checkLineBufNvsRef("n8_3x3_same", input, output, 3, 3,
      pTop = 1, pBot = 1, pLeft = 1, pRight = 1, macN = 8, ws = ws, bs = bs)
  }

  // 3×3 conv, C_in=16, N=16, VALID, two inferences
  test("N=16: 3x3 conv, C_in=16, VALID: two consecutive inferences correct") {
    val cin = 16; val cout = 4; val h = 5; val w = 5
    val input  = TensorShape(h, w, cin)
    val output = TensorShape(3, 3, cout)
    val ws = Array.tabulate(cout * 3 * 3 * cin)(i => ((i * 13 + 7) % 60 - 30).toByte)
    val bs = Array.fill(cout)(0)
    val refCfg = QLinearConvLineCore.Config(
      periphName = "n16_two_n1", inputShape = input, outputShape = output,
      kernelH = 3, kernelW = 3,
      inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
      weights = ws, biases = bs, macParallelism = 1
    )
    val parCfg = refCfg.copy(periphName = "n16_two_n16", macParallelism = 16)
    val stim = (1 to input.size).map(i => (i * 7 + 3) % 20 - 10)
    val stim2 = stim.map(v => -v)
    val outCount = output.size
    var refOut1 = Seq.empty[Int]; var refOut2 = Seq.empty[Int]
    var parOut1 = Seq.empty[Int]; var parOut2 = Seq.empty[Int]

    compileLine(refCfg).doSim("n16_two_n1") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      fork(driveLine(dut, stim ++ stim2))
      refOut1 = collectLine(dut, outCount)
      refOut2 = collectLine(dut, outCount)
    }
    compileLine(parCfg).doSim("n16_two_n16") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      fork(driveLine(dut, stim ++ stim2))
      parOut1 = collectLine(dut, outCount)
      parOut2 = collectLine(dut, outCount)
    }
    assert(parOut1 == refOut1, s"N=16 inf-1 mismatch.\n  ref: $refOut1\n  got: $parOut1")
    assert(parOut2 == refOut2, s"N=16 inf-2 mismatch.\n  ref: $refOut2\n  got: $parOut2")
  }

  // ── W4A8 tests: INT4 weight hardware matches INT8 reference ──────────────────
  // Strategy: pick weights in [-8, 7] and set weightQuant.scale = max(|w|)/7.
  // Both the INT8 reference (same bytes, same scale) and the W4A8 hardware
  // perform wAdj = w - 0 = w with identical requant params → must give same output.

  def checkW4A8vsInt8Ref(
    label:  String,
    input:  TensorShape,
    output: TensorShape,
    kH: Int, kW: Int,
    pTop: Int = 0, pBot: Int = 0, pLeft: Int = 0, pRight: Int = 0,
    macN: Int,
    ws:   Array[Byte],
    bs:   Array[Int],
    wScale: Float
  ): Unit = {
    // INT8 reference uses the same bytes and the INT4-derived wScale so that
    // RequantScale (multiplier, shift) is identical in both paths.
    val refCfg = QLinearConvLineCore.Config(
      periphName = s"${label}_int8", inputShape = input, outputShape = output,
      kernelH = kH, kernelW = kW,
      padTop = pTop, padBottom = pBot, padLeft = pLeft, padRight = pRight,
      inputQuant = idQ, weightQuant = QuantParams(wScale, 0), outputQuant = idQ,
      weights = ws, biases = bs, macParallelism = macN
    )
    val w4a8Cfg = refCfg.copy(periphName = s"${label}_w4a8", weightBits = 4)

    val stimulus = (1 to input.size).map(i => (i * 7 + 3) % 14 - 7)  // [-7, 6]: small to avoid overflow
    val outCount = output.size
    var refOut  = Seq.empty[Int]
    var w4a8Out = Seq.empty[Int]

    compileLine(refCfg).doSim(s"${label}_int8") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      val s = fork(driveLine(dut, stimulus))
      refOut = collectLine(dut, outCount); s.join()
    }
    compileLine(w4a8Cfg).doSim(s"${label}_w4a8") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      val s = fork(driveLine(dut, stimulus))
      w4a8Out = collectLine(dut, outCount); s.join()
    }
    assert(w4a8Out == refOut,
      s"[$label] W4A8 vs INT8-ref mismatch.\n  ref:  $refOut\n  got:  $w4a8Out")
  }

  test("W4A8 N=1: VALID 3x3 conv C_in=1 matches INT8 ref") {
    val ws = Array[Byte](-3, 5, -2, 7, 1, -4, 3, -6, 2)  // 9 weights in [-8, 7]
    val wMax = ws.map(_.abs).max.toFloat
    checkW4A8vsInt8Ref("w4a8_n1_valid", TensorShape(5, 5, 1), TensorShape(3, 3, 1),
      3, 3, macN = 1, ws = ws, bs = Array(0), wScale = wMax / 7.0f)
  }

  test("W4A8 N=2: VALID 3x3 conv C_in=2 matches INT8 ref") {
    val cout = 2; val cin = 2; val h = 5; val w = 5
    val ws = Array.tabulate(cout * 3 * 3 * cin)(i => (((i * 5 + 1) % 15) - 7).toByte)
    val wMax = ws.map(_.abs).max.toFloat
    checkW4A8vsInt8Ref("w4a8_n2_valid", TensorShape(h, w, cin), TensorShape(3, 3, cout),
      3, 3, macN = 2, ws = ws, bs = Array.fill(cout)(0), wScale = wMax / 7.0f)
  }

  test("W4A8 N=4: SAME 3x3 conv C_in=4 matches INT8 ref") {
    val cout = 2; val cin = 4; val h = 5; val w = 5
    val ws = Array.tabulate(cout * 3 * 3 * cin)(i => (((i * 3 + 2) % 15) - 7).toByte)
    val wMax = ws.map(_.abs).max.toFloat
    checkW4A8vsInt8Ref("w4a8_n4_same", TensorShape(h, w, cin), TensorShape(h, w, cout),
      3, 3, pTop = 1, pBot = 1, pLeft = 1, pRight = 1,
      macN = 4, ws = ws, bs = Array.fill(cout)(0), wScale = wMax / 7.0f)
  }

  test("W4A8 N=4: two consecutive inferences correct") {
    val cout = 2; val cin = 4; val h = 5; val w = 5
    val ws = Array.tabulate(cout * 3 * 3 * cin)(i => (((i * 11 + 5) % 15) - 7).toByte)
    val bs = Array.fill(cout)(0)
    val wMax = ws.map(_.abs).max.toFloat
    val wScale = wMax / 7.0f
    val cfg4 = QLinearConvLineCore.Config(
      periphName = "w4a8_2inf_w4a8", inputShape = TensorShape(h, w, cin), outputShape = TensorShape(h, w, cout),
      kernelH = 3, kernelW = 3, padTop = 1, padBottom = 1, padLeft = 1, padRight = 1,
      inputQuant = idQ, weightQuant = QuantParams(wScale, 0), outputQuant = idQ,
      weights = ws, biases = bs, macParallelism = 4, weightBits = 4
    )
    val cfg8 = cfg4.copy(periphName = "w4a8_2inf_int8", weightBits = 8)
    val stim1 = (1 to h * w * cin).map(i => (i * 7 + 3) % 14 - 7)
    val stim2 = stim1.map(-_)
    val outCount = h * w * cout
    var ref1 = Seq.empty[Int]; var ref2 = Seq.empty[Int]
    var w4a8_1 = Seq.empty[Int]; var w4a8_2 = Seq.empty[Int]

    compileLine(cfg8).doSim("w4a8_2inf_int8") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      fork(driveLine(dut, stim1 ++ stim2))
      ref1 = collectLine(dut, outCount)
      ref2 = collectLine(dut, outCount)
    }
    compileLine(cfg4).doSim("w4a8_2inf_w4a8") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      fork(driveLine(dut, stim1 ++ stim2))
      w4a8_1 = collectLine(dut, outCount)
      w4a8_2 = collectLine(dut, outCount)
    }
    assert(w4a8_1 == ref1, s"W4A8 inf-1 mismatch.\n  ref: $ref1\n  got: $w4a8_1")
    assert(w4a8_2 == ref2, s"W4A8 inf-2 mismatch.\n  ref: $ref2\n  got: $w4a8_2")
  }

  // WeightStream N=8: VALID 3×3 conv, C_in=8
  test("N=8 WeightStream: 3x3 C_in=8 VALID matches WeightRom N=8") {
    val cin = 8; val cout = 4; val h = 5; val w = 5
    val input  = TensorShape(h, w, cin)
    val output = TensorShape(3, 3, cout)
    val ws = Array.tabulate(cout * 3 * 3 * cin)(i => ((i * 7 + 5) % 40 - 20).toByte)
    val bs = Array.fill(cout)(0)
    val romCfg = QLinearConvLineCore.Config(
      periphName = "n8_ws_rom", inputShape = input, outputShape = output,
      kernelH = 3, kernelW = 3,
      inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
      weights = ws, biases = bs, macParallelism = 8
    )
    val streamCfg = romCfg.copy(periphName = "n8_ws_stream", weightMode = WeightStream)
    val stimulus  = (1 to input.size).map(i => (i * 5 + 1) % 20 - 10)
    val outCount  = output.size
    var romOut    = Seq.empty[Int]
    var streamOut = Seq.empty[Int]

    compileLine(romCfg).doSim("n8_ws_rom") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      val s = fork(driveLine(dut, stimulus))
      romOut = collectLine(dut, outCount); s.join()
    }
    compileLine(streamCfg).doSim("n8_ws_stream") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.weightIn.valid #= false; dut.weightIn.payload #= 0
      dut.clockDomain.waitSampling(2)
      val wCh = streamCfg.kernelH * streamCfg.kernelW * streamCfg.inputShape.channels
      val wf = fork(feedWeightStream(dut, streamCfg.weights, wCh, streamCfg.outputShape.channels))
      val s  = fork(driveLine(dut, stimulus))
      streamOut = collectLine(dut, outCount); s.join(); wf.terminate()
    }
    assert(streamOut == romOut,
      s"N=8 WeightStream mismatch.\n  rom:    $romOut\n  stream: $streamOut")
  }

  // ── W4A8 WeightStream tests ────────────────────────────────────────────────
  // Pack N INT4 nibbles per drain step (N×4 bits); stride = ceil(weightsPerCh/2/64)*64 bytes.
  // Lower nibble = even-indexed weight, upper nibble = odd-indexed weight within each byte.

  def feedWeightStreamW4A8(
    dut:          QLinearConvLineCoreHarness,
    weights:      Array[Byte],   // one weight per element, values in [-8..7]
    weightsPerCh: Int,
    numOutputCh:  Int
  ): Unit = {
    val bytesPerCh = (weightsPerCh + 1) / 2
    val stride     = ((bytesPerCh + 63) / 64) * 64
    var ch = 0
    while (true) {
      val chBase = ch * weightsPerCh
      val buf    = Array.fill[Byte](stride)(0)
      for (i <- 0 until weightsPerCh) {
        val nibble  = weights(chBase + i) & 0xF   // keep 4 bits (2's complement nibble)
        val byteIdx = i / 2
        if (i % 2 == 0) buf(byteIdx) = nibble.toByte
        else            buf(byteIdx) = (buf(byteIdx) | (nibble << 4)).toByte
      }
      var beatOff = 0
      while (beatOff < stride) {
        var beatVal = BigInt(0)
        for (b <- 0 until 64) beatVal = beatVal | (BigInt(buf(beatOff + b) & 0xFF) << (b * 8))
        dut.weightIn.valid   #= true
        dut.weightIn.payload #= beatVal
        dut.clockDomain.waitSamplingWhere(dut.weightIn.ready.toBoolean)
        beatOff += 64
      }
      ch = (ch + 1) % numOutputCh
    }
  }

  // ── Test: W4A8 WeightStream VALID conv matches W4A8 WeightRom ─────────────
  test("W4A8 WeightStream: VALID 3x3 C_in=4 N=4 matches WeightRom output") {
    val cin = 4; val cout = 4; val h = 5; val w = 5
    val input  = TensorShape(h, w, cin)
    val output = TensorShape(3, 3, cout)
    val ws = Array.tabulate(cout * 3 * 3 * cin)(i => (((i * 5 + 3) % 15) - 7).toByte)
    val bs = Array.fill(cout)(0)
    val wMax = ws.map(b => math.abs(b.toInt)).max.toFloat
    val wScale = wMax / 7.0f

    val romCfg = QLinearConvLineCore.Config(
      periphName = "w4a8_ws_rom", inputShape = input, outputShape = output,
      kernelH = 3, kernelW = 3,
      inputQuant = idQ, weightQuant = QuantParams(wScale, 0), outputQuant = idQ,
      weights = ws, biases = bs, macParallelism = 4, weightBits = 4
    )
    val streamCfg = romCfg.copy(periphName = "w4a8_ws_stream", weightMode = WeightStream)

    val stimulus = (1 to input.size).map(i => (i * 7 + 3) % 14 - 7)
    val outCount = output.size
    var romOut: Seq[Int]    = Nil
    var streamOut: Seq[Int] = Nil

    compileLine(romCfg).doSim("w4a8_ws_rom") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      val s = fork(driveLine(dut, stimulus))
      romOut = collectLine(dut, outCount); s.join()
    }

    compileLine(streamCfg).doSim("w4a8_ws_stream") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.weightIn.valid #= false; dut.weightIn.payload #= 0
      dut.clockDomain.waitSampling(2)
      val wCh = streamCfg.kernelH * streamCfg.kernelW * streamCfg.inputShape.channels
      val wf = fork(feedWeightStreamW4A8(dut, streamCfg.weights, wCh, streamCfg.outputShape.channels))
      val s  = fork(driveLine(dut, stimulus))
      streamOut = collectLine(dut, outCount); s.join(); wf.terminate()
    }

    assert(streamOut == romOut,
      s"W4A8 WeightStream VALID mismatch.\n  rom:    $romOut\n  stream: $streamOut")
  }

  // ── Test: W4A8 WeightStream two consecutive inferences ────────────────────
  test("W4A8 WeightStream: SAME 3x3 C_in=4 N=4 two consecutive inferences correct") {
    val cin = 4; val cout = 2; val h = 5; val w = 5
    val input  = TensorShape(h, w, cin)
    val output = TensorShape(h, w, cout)
    val ws = Array.tabulate(cout * 3 * 3 * cin)(i => (((i * 11 + 1) % 15) - 7).toByte)
    val bs = Array.fill(cout)(0)
    val wMax = ws.map(b => math.abs(b.toInt)).max.toFloat
    val wScale = wMax / 7.0f

    val romCfg = QLinearConvLineCore.Config(
      periphName = "w4a8_ws2_rom", inputShape = input, outputShape = output,
      kernelH = 3, kernelW = 3,
      padTop = 1, padBottom = 1, padLeft = 1, padRight = 1,
      inputQuant = idQ, weightQuant = QuantParams(wScale, 0), outputQuant = idQ,
      weights = ws, biases = bs, macParallelism = 4, weightBits = 4
    )
    val streamCfg = romCfg.copy(periphName = "w4a8_ws2_stream", weightMode = WeightStream)

    val stim1 = (1 to input.size).map(i => (i * 7 + 3) % 14 - 7)
    val stim2 = stim1.map(-_)
    val outCount = output.size
    var romOut1: Seq[Int] = Nil; var romOut2: Seq[Int] = Nil
    var wsOut1: Seq[Int]  = Nil; var wsOut2: Seq[Int]  = Nil

    compileLine(romCfg).doSim("w4a8_ws2_rom") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      fork(driveLine(dut, stim1 ++ stim2))
      romOut1 = collectLine(dut, outCount)
      romOut2 = collectLine(dut, outCount)
    }

    compileLine(streamCfg).doSim("w4a8_ws2_stream") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.weightIn.valid #= false; dut.weightIn.payload #= 0
      dut.clockDomain.waitSampling(2)
      val wCh = streamCfg.kernelH * streamCfg.kernelW * streamCfg.inputShape.channels
      val wf = fork(feedWeightStreamW4A8(dut, streamCfg.weights, wCh, streamCfg.outputShape.channels))
      fork(driveLine(dut, stim1 ++ stim2))
      wsOut1 = collectLine(dut, outCount)
      wsOut2 = collectLine(dut, outCount)
      wf.terminate()
    }

    assert(wsOut1 == romOut1, s"W4A8 WeightStream SAME inf-1 mismatch.\n  rom: $romOut1\n  ws:  $wsOut1")
    assert(wsOut2 == romOut2, s"W4A8 WeightStream SAME inf-2 mismatch.\n  rom: $romOut2\n  ws:  $wsOut2")
  }
}
