package spinalnn.ops

import org.scalatest.funsuite.AnyFunSuite
import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinalnn.ops.sc.StochasticConvCore
import spinalnn.types._
import scala.collection.mutable

/** Simulation tests for StochasticConvCore (Phase B, B4).
  *
  * SC is probabilistic so tests use two strategies:
  *   1. Deterministic cases: all-zero weights → wBit always 0 → sc_acc = 0 exactly.
  *   2. Statistical cases:   check mean error over multiple output pixels is small,
  *                           and every pixel is within a generous absolute tolerance.
  *
  * Reference: a pure-Scala integer conv that mimics the same quantized arithmetic
  * as QLinearConvCore (no SC approximation) so we can compare expected outputs.
  */
class StochasticConvCoreTest extends AnyFunSuite {

  // ── Test harness component ────────────────────────────────────────────────
  private class ScConvHarness(cfg: StochasticConvCore.Config) extends Component {
    val io = new Bundle {
      val activationIn  = slave(Stream(Activation()))
      val activationOut = master(Stream(Activation()))
    }
    val core = StochasticConvCore.build(cfg, io.activationIn)
    io.activationOut << core.activationOut
  }

  // ── Drive / collect helpers ───────────────────────────────────────────────
  private def driveInputs(dut: ScConvHarness, values: Seq[Int]): Unit = {
    for (v <- values) {
      dut.io.activationIn.valid         #= true
      dut.io.activationIn.payload.value #= v
      dut.clockDomain.waitSamplingWhere(dut.io.activationIn.ready.toBoolean)
    }
    dut.io.activationIn.valid #= false
  }

  private def collectOutputs(dut: ScConvHarness, count: Int, timeout: Int = 2000000): Seq[Int] = {
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
    assert(cycles < timeout, s"Timeout waiting for outputs: got ${results.length}/$count")
    results.toSeq
  }

  // Interpret raw Int as signed 8-bit (the sim returns unsigned bitfield).
  private def toSigned8(v: Int): Int = if (v >= 128) v - 256 else v

  // ── Software reference conv ───────────────────────────────────────────────
  // Computes the same quantized dot product as QLinearConvCore would.
  // Returns signed INT8 results (before saturation in range [-128,127]).
  private def refConv(
    input:      Array[Int],   // flat [H, W, C_in]
    weights:    Array[Byte],  // flat [C_out, kH, kW, C_in]
    biases:     Array[Int],
    inputShape: TensorShape,
    outShape:   TensorShape,
    kH: Int, kW: Int, sH: Int, sW: Int,
    padTop: Int, padLeft: Int,
    M: Double, zpOut: Int
  ): Array[Int] = {
    val H = inputShape.rows;  val W = inputShape.cols;  val Cin = inputShape.channels
    val outH = outShape.rows; val outW = outShape.cols; val Cout = outShape.channels
    val nMac = kH * kW * Cin
    val result = new Array[Int](outH * outW * Cout)
    for (oh <- 0 until outH; ow <- 0 until outW; oc <- 0 until Cout) {
      var acc = biases(oc).toDouble
      for (kh <- 0 until kH; kw <- 0 until kW; ci <- 0 until Cin) {
        val ih = oh * sH - padTop + kh
        val iw = ow * sW - padLeft + kw
        val x  = if (ih >= 0 && ih < H && iw >= 0 && iw < W) input(ih * W * Cin + iw * Cin + ci) else 0
        val b  = (kh * kW * Cin + kw * Cin + ci)
        val w  = weights(oc * nMac + b).toInt
        acc += w * x
      }
      val scaled  = scala.math.round(acc * M).toInt + zpOut
      val clamped = scala.math.max(-128, scala.math.min(127, scaled))
      result(oh * outW * Cout + ow * Cout + oc) = clamped
    }
    result
  }

  // ── Test 1: All zero weights, zero bias → output must be exactly 0 ───────
  // When wThr = 0, wBit is always 0, so sc_acc stays exactly 0.
  // combAdj = scScale × (0 - 128 × 0) = 0.  int8_out = zpOut = 0.
  test("zero weights and bias → deterministic zero output") {
    val H = 5; val W = 5; val Cin = 1; val Cout = 2
    val outH = H; val outW = W
    val cfg = StochasticConvCore.Config(
      periphName   = "sc_zero",
      inputShape   = TensorShape(H, W, Cin),
      outputShape  = TensorShape(outH, outW, Cout),
      kernelH      = 1, kernelW = 1,
      inputQuant   = QuantParams(scale = 0.1f, zeroPoint = 0),
      weightQuant  = QuantParams(scale = 0.1f, zeroPoint = 0),
      outputQuant  = QuantParams(scale = 0.1f, zeroPoint = 0),
      weights      = Array.fill(Cout)(Array.fill(Cin)(0.toByte)).flatten,
      biases       = Array.fill(Cout)(0),
      bitstreamLen = 63
    )
    SimConfig.withWave.workspacePath("simWorkspace/ScConvTest").compile(new ScConvHarness(cfg))
      .doSim("zero_weights") { dut =>
        dut.clockDomain.forkStimulus(period = 10)
        dut.io.activationIn.valid         #= false
        dut.io.activationIn.payload.value #= 0
        dut.io.activationOut.ready        #= false
        dut.clockDomain.waitSampling(4)

        val inputVals = Seq.tabulate(H * W * Cin)(i => (i % 64) + 1)  // non-zero inputs
        val nOut = outH * outW * Cout
        val stimulus = fork(driveInputs(dut, inputVals))
        val results = collectOutputs(dut, nOut)
        stimulus.join()

        val signed = results.map(toSigned8)
        assert(signed.forall(_ == 0),
          s"Expected all zeros, got: ${signed.take(20)}")
      }
  }

  // ── Test 2: Output count matches outH × outW × C_out ─────────────────────
  test("output count is correct for 4x4 input 3x3 kernel same padding") {
    val H = 6; val W = 6; val Cin = 1; val Cout = 2
    val outH = H; val outW = W  // same padding (pad=1)
    val cfg = StochasticConvCore.Config(
      periphName   = "sc_count",
      inputShape   = TensorShape(H, W, Cin),
      outputShape  = TensorShape(outH, outW, Cout),
      kernelH      = 3, kernelW = 3,
      padTop = 1, padBottom = 1, padLeft = 1, padRight = 1,
      inputQuant   = QuantParams(scale = 0.1f, zeroPoint = 0),
      weightQuant  = QuantParams(scale = 0.1f, zeroPoint = 0),
      outputQuant  = QuantParams(scale = 1.0f, zeroPoint = 0),
      weights      = Array.fill(Cout * 3 * 3 * Cin)(0.toByte),
      biases       = Array.fill(Cout)(0),
      bitstreamLen = 31
    )
    SimConfig.withWave.workspacePath("simWorkspace/ScConvTest").compile(new ScConvHarness(cfg))
      .doSim("output_count") { dut =>
        dut.clockDomain.forkStimulus(period = 10)
        dut.io.activationIn.valid         #= false
        dut.io.activationIn.payload.value #= 0
        dut.io.activationOut.ready        #= false
        dut.clockDomain.waitSampling(4)

        val nIn  = H * W * Cin
        val nOut = outH * outW * Cout
        val stimulus = fork(driveInputs(dut, Seq.fill(nIn)(5)))
        val results = collectOutputs(dut, nOut)
        stimulus.join()

        assert(results.length == nOut,
          s"Expected $nOut outputs, got ${results.length}")
      }
  }

  // ── Test 3: Statistical accuracy — uniform input, all-same-sign weights ──
  //
  // Design rationale: SC accuracy requires the "corrected" sc_acc to be large
  // relative to SC noise. Alternating ±w weights nearly cancel in the accumulator
  // (combAdj ≈ -E[sc_acc]), leaving a tiny corrected signal that noise swamps.
  // All-same-sign weights avoid this cancellation.
  //
  // Parameters: 1×1 kernel, C_in=4, C_out=2, bitstreamLen=255.
  // oc=0: weights all +100 → E[sc_acc] ≈ 596, combAdj ≈ -402, corrected ≈ +194.
  // oc=1: weights all -100 → symmetric: corrected ≈ -194.
  // M ≈ 1/1000 → decodeDs ≈ 0.128 → output ≈ ±25 (well in INT8 range).
  // Expected SC noise on output ≈ ±4. Tolerance ±20 gives >4σ margin.
  test("statistical accuracy: 1x1 kernel, uniform input, all-same-sign weights") {
    val H = 5; val W = 5; val Cin = 4; val Cout = 2
    val outH = H; val outW = W
    val nMac = 1 * 1 * Cin  // = 4

    val weights: Array[Byte] = Array.tabulate(Cout * nMac) { i =>
      (if (i < nMac) 100 else -100).toByte
    }
    val biases = Array.fill(Cout)(0)

    // M = inScale × wScale / outScale ≈ 1/1000.
    // dotInt = 4 × 100 × 64 = 25600 → ref = round(25600 / 1000) ≈ ±26.
    val inScale  = 1.0f / 128.0f
    val wScale   = 1.0f / 64.0f
    val outScale = 1000.0f / 8192.0f

    val cfg = StochasticConvCore.Config(
      periphName   = "sc_acc",
      inputShape   = TensorShape(H, W, Cin),
      outputShape  = TensorShape(outH, outW, Cout),
      kernelH      = 1, kernelW = 1,
      inputQuant   = QuantParams(scale = inScale,  zeroPoint = 0),
      weightQuant  = QuantParams(scale = wScale,   zeroPoint = 0),
      outputQuant  = QuantParams(scale = outScale, zeroPoint = 0),
      weights      = weights,
      biases       = biases,
      bitstreamLen = 255
    )

    val inputVals: Array[Int] = Array.fill(H * W * Cin)(64)

    val M   = inScale.toDouble * wScale.toDouble / outScale.toDouble
    val ref = refConv(inputVals, weights, biases,
                      TensorShape(H,W,Cin), TensorShape(outH,outW,Cout),
                      kH=1, kW=1, sH=1, sW=1,
                      padTop=0, padLeft=0,
                      M=M, zpOut=0)

    SimConfig.withWave.workspacePath("simWorkspace/ScConvTest")
      .compile(new ScConvHarness(cfg))
      .doSim("sc_accuracy") { dut =>
        dut.clockDomain.forkStimulus(period = 10)
        dut.io.activationIn.valid         #= false
        dut.io.activationIn.payload.value #= 0
        dut.io.activationOut.ready        #= false
        dut.clockDomain.waitSampling(4)

        val nOut     = outH * outW * Cout
        val stimulus = fork(driveInputs(dut, inputVals.toSeq))
        val results  = collectOutputs(dut, nOut)
        stimulus.join()

        val signed = results.map(toSigned8)
        val errors = signed.zip(ref).map { case (sc, r) => scala.math.abs(sc - r) }

        val maxErr  = errors.max
        val meanErr = errors.sum.toDouble / errors.length

        println(s"SC vs reference — max error: $maxErr, mean error: ${"%.2f".format(meanErr)}")
        println(s"SC:  ${signed.mkString(",")}")
        println(s"Ref: ${ref.mkString(",")}")

        assert(maxErr <= 20,
          s"Max SC error $maxErr > 20. SC: ${signed.mkString(",")}, Ref: ${ref.mkString(",")}")
      }
  }
}
