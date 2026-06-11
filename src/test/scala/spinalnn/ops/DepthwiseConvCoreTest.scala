package spinalnn.ops

import org.scalatest.funsuite.AnyFunSuite
import spinal.core._
import spinal.core.sim._
import spinal.lib.sim.{StreamDriver, StreamMonitor}
import spinalnn.ops.conv.DepthwiseConvCore
import spinalnn.testhelpers.DepthwiseConvHarness
import spinalnn.types._
import scala.collection.mutable

class DepthwiseConvCoreTest extends AnyFunSuite {

  def compile(cfg: DepthwiseConvCore.Config) =
    SimConfig
      .withWave
      .workspacePath("simWorkspace/DepthwiseConvCoreTest")
      .compile(new DepthwiseConvHarness(cfg))

  def runDw(cfg: DepthwiseConvCore.Config, input: Seq[Int], outCount: Int): Seq[Int] = {
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
      while (captured.length < outCount && cycles < 50000) {
        dut.clockDomain.waitSampling(); cycles += 1
      }
      dut.clockDomain.waitSampling(5)
      got = captured.toSeq
    }
    got
  }

  // ── Test 1: channels are independent ─────────────────────────────────────
  // 1x1x2 input, 1x1 kernel. Each channel has its own weight; verify the two
  // outputs come from entirely separate filter paths.
  //   ch0: input=10, weight=3  → acc=30 → output≈30
  //   ch1: input= 4, weight=2  → acc= 8 → output≈ 8
  // HWC output order: [ch0, ch1] = [30, 8].
  test("channels produce independent outputs") {
    val cfg = DepthwiseConvCore.Config(
      periphName  = "dw_indep",
      inputShape  = TensorShape(1, 1, 2),
      outputShape = TensorShape(1, 1, 2),
      kernelH     = 1,
      kernelW     = 1,
      inputQuant  = QuantParams(1.0f, 0),
      weightQuant = QuantParams(1.0f, 0),
      outputQuant = QuantParams(1.0f, 0),
      weights     = Array[Byte](3, 2),   // [ch0_w, ch1_w]; 1x1 kernel per channel
      biases      = Array(0, 0)
    )
    // Input HWC: (row0,col0,ch0)=10, (row0,col0,ch1)=4
    val out = runDw(cfg, Seq(10, 4), outCount = 2)
    assert(out == Seq(30, 8), s"expected Seq(30,8), got $out")
  }

  // ── Test 2: spatial kernel sums correctly ─────────────────────────────────
  // 3x3x1 input, 3x3 kernel, no padding → 1x1x1 output.
  // All weights = 1; input = [1..9]; expected acc = 1+2+…+9 = 45.
  test("3x3 kernel accumulates all spatial positions") {
    val cfg = DepthwiseConvCore.Config(
      periphName  = "dw_spatial",
      inputShape  = TensorShape(3, 3, 1),
      outputShape = TensorShape(1, 1, 1),
      kernelH     = 3,
      kernelW     = 3,
      inputQuant  = QuantParams(1.0f, 0),
      weightQuant = QuantParams(1.0f, 0),
      outputQuant = QuantParams(1.0f, 0),
      weights     = Array.fill(9)(1.toByte),
      biases      = Array(0)
    )
    val out = runDw(cfg, (1 to 9).toSeq, outCount = 1)
    assert(out == Seq(45), s"expected Seq(45), got $out")
  }

  // ── Test 3: per-channel weight scales ────────────────────────────────────
  // 1x1x2, 1x1 kernel. Both channels have weight=2, input=10, but different
  // per-channel scales: 0.5 and 0.25.
  //   acc[both] = 10*2 = 20
  //   ch0 scale 0.5  → round(0.5  * 20) = 10
  //   ch1 scale 0.25 → round(0.25 * 20) = 5
  test("per-channel weight scales produce distinct outputs") {
    val cfg = DepthwiseConvCore.Config(
      periphName   = "dw_perchan",
      inputShape   = TensorShape(1, 1, 2),
      outputShape  = TensorShape(1, 1, 2),
      kernelH      = 1,
      kernelW      = 1,
      inputQuant   = QuantParams(1.0f, 0),
      weightQuant  = QuantParams(1.0f, 0),
      outputQuant  = QuantParams(1.0f, 0),
      weights      = Array[Byte](2, 2),
      biases       = Array(0, 0),
      weightScales = Some(Array(0.5f, 0.25f))
    )
    val out = runDw(cfg, Seq(10, 10), outCount = 2)
    assert(out == Seq(10, 5), s"expected Seq(10,5), got $out")
  }

  // ── Test 4: SAME padding with asymmetric z_x ──────────────────────────────
  // 1x1x1 input, 1x3 kernel, SAME padding (padLeft=1, padRight=1), z_x=5.
  // Input stored value = 10. Pad cells are initialised to z_x=5.
  //   left pad:  (5−5)×1 = 0
  //   center:    (10−5)×1 = 5
  //   right pad: (5−5)×1 = 0   →  acc = 5,  output ≈ 5
  // If pads were zero-initialised (bug): acc = (0−5)×1+(10−5)×1+(0−5)×1 = −5.
  test("SAME padding with asymmetric z_x: pad cells do not contribute") {
    val cfg = DepthwiseConvCore.Config(
      periphName  = "dw_pad_zp",
      inputShape  = TensorShape(1, 1, 1),
      outputShape = TensorShape(1, 1, 1),
      kernelH     = 1,
      kernelW     = 3,
      padTop      = 0,
      padBottom   = 0,
      padLeft     = 1,
      padRight    = 1,
      inputQuant  = QuantParams(1.0f, 5),
      weightQuant = QuantParams(1.0f, 0),
      outputQuant = QuantParams(1.0f, 0),
      weights     = Array[Byte](1, 1, 1),
      biases      = Array(0)
    )
    val out = runDw(cfg, Seq(10), outCount = 1)
    assert(out == Seq(5), s"expected Seq(5), got $out")
  }

  // ── Test 5: multi-channel with 3x3 SAME padding ───────────────────────────
  // 3x3x2 input, 3x3 kernel, SAME padding → 3x3x2 output.
  // Weights for ch0 = all 1s: each output sums a 3x3 neighbourhood.
  // Weights for ch1 = all 0s: output is always 0 (bias 0, acc 0).
  // Corner position (0,0) sees only 1/4 of the kernel (top-left quadrant) due
  // to SAME padding; remaining 3/4 tap zero-padded cells → they contribute 0.
  // For ch0: sum of reachable values at corner (0,0) = input[0,0,0] + input[0,1,0]
  //   + input[1,0,0] + input[1,1,0] (since padding fills the border with zp=0).
  //   Input (all channels): [[1,2,3],[4,5,6],[7,8,9]] HWC = [1,0,2,0,...] for ch0/ch1.
  //   Corner (0,0) ch0: pads contribute 0 (zp=0); reachable = 1+2+4+5 = 12.
  test("3x3 SAME padding: corner output uses only in-bounds values") {
    // 3x3x2, values 1..9 for ch0, zeros for ch1
    val inputVals = (1 to 9).flatMap(v => Seq(v, 0))  // HWC interleaved

    val cfg = DepthwiseConvCore.Config(
      periphName  = "dw_same3x3",
      inputShape  = TensorShape(3, 3, 2),
      outputShape = TensorShape(3, 3, 2),
      kernelH     = 3,
      kernelW     = 3,
      padTop      = 1, padBottom = 1, padLeft = 1, padRight = 1,
      inputQuant  = QuantParams(1.0f, 0),
      weightQuant = QuantParams(1.0f, 0),
      outputQuant = QuantParams(1.0f, 0),
      weights     = Array.fill(9)(1.toByte) ++ Array.fill(9)(0.toByte), // ch0=all-1, ch1=all-0
      biases      = Array(0, 0)
    )
    val out = runDw(cfg, inputVals, outCount = 3 * 3 * 2)

    // HWC output: for each position, [ch0_val, ch1_val]. ch1 is always 0.
    // ch0 corner (0,0): sum of {1,2,4,5} = 12
    assert(out(0) == 12, s"corner (0,0) ch0: expected 12, got ${out(0)}")
    assert(out(1) == 0,  s"corner (0,0) ch1: expected 0, got ${out(1)}")

    // ch0 center (1,1): full 3x3 sum of all values = 1+2+3+4+5+6+7+8+9 = 45
    // HWC index for (row=1, col=1, ch=0) = 1*3*2 + 1*2 + 0 = 8
    assert(out(8) == 45, s"center (1,1) ch0: expected 45, got ${out(8)}")
  }
}
