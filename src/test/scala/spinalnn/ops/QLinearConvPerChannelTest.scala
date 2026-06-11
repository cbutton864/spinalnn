package spinalnn.ops

import org.scalatest.funsuite.AnyFunSuite
import spinal.core._
import spinal.core.sim._
import spinal.lib.sim.{StreamDriver, StreamMonitor}
import spinalnn.ops.conv.QLinearConvCore
import spinalnn.testhelpers.QLinearConvHarness
import spinalnn.types._
import scala.collection.mutable

// Validates per-output-channel requantization in QLinearConvCore: each output channel
// applies its own weight scale (multiplier/shift), the modern INT8 export default.
class QLinearConvPerChannelTest extends AnyFunSuite {

  def compile(cfg: QLinearConvCore.Config) =
    SimConfig
      .withWave
      .workspacePath("simWorkspace/QLinearConvPerChannelTest")
      .compile(new QLinearConvHarness(cfg))

  def runConv(cfg: QLinearConvCore.Config, input: Seq[Int], outCount: Int): Seq[Int] = {
    var got: Seq[Int] = Nil
    compile(cfg).doSim(cfg.periphName) { dut =>
      dut.clockDomain.forkStimulus(period = 10)
      dut.io.activationOut.ready #= true

      val captured = mutable.ArrayBuffer[Int]()
      StreamMonitor(dut.io.activationOut, dut.clockDomain) { p => captured += p.value.toInt }

      val q = mutable.Queue(input: _*)
      StreamDriver(dut.io.activationIn, dut.clockDomain) { p =>
        if (q.nonEmpty) { p.value #= q.dequeue(); true } else false
      }

      var cycles = 0
      while (captured.length < outCount && cycles < 20000) {
        dut.clockDomain.waitSampling(); cycles += 1
      }
      dut.clockDomain.waitSampling(5)
      got = captured.toSeq
    }
    got
  }

  // ── Test 1: per-channel scales drive different outputs from identical weights ──
  // 1x1x1 input, 1x1 kernel, 2 output channels, both weights = 2, input x = 10.
  //   acc[oc] = x * w = 20 for both channels.
  //   ch0 scale 0.5  -> round(0.5  * 20) = 10
  //   ch1 scale 0.25 -> round(0.25 * 20) = 5
  // Per-tensor requant could not produce [10, 5] from identical weights -- only
  // per-channel requant can.
  test("two output channels apply their own weight scale") {
    val cfg = QLinearConvCore.Config(
      periphName   = "pc_basic",
      inputShape   = TensorShape(1, 1, 1),
      outputShape  = TensorShape(1, 1, 2),
      kernelH      = 1,
      kernelW      = 1,
      inputQuant   = QuantParams(1.0f, 0),
      weightQuant  = QuantParams(1.0f, 0),          // unused (weightScales present)
      outputQuant  = QuantParams(1.0f, 0),
      weights      = Array[Byte](2, 2),             // [oc0, oc1], 1x1x1 each
      biases       = Array(0, 0),
      weightScales = Some(Array(0.5f, 0.25f))
    )
    val out = runConv(cfg, Seq(10), outCount = 2)
    assert(out == Seq(10, 5), s"expected Seq(10,5), got $out")
  }

  // ── Test 2: per-tensor fallback (weightScales = None) is uniform ────────────
  // Same shape, identical weights, single weightQuant scale 0.5 -> both channels 10.
  test("per-tensor fallback applies one scale to all channels") {
    val cfg = QLinearConvCore.Config(
      periphName  = "pc_fallback",
      inputShape  = TensorShape(1, 1, 1),
      outputShape = TensorShape(1, 1, 2),
      kernelH     = 1,
      kernelW     = 1,
      inputQuant  = QuantParams(1.0f, 0),
      weightQuant = QuantParams(0.5f, 0),
      outputQuant = QuantParams(1.0f, 0),
      weights     = Array[Byte](2, 2),
      biases      = Array(0, 0)
    )
    val out = runConv(cfg, Seq(10), outCount = 2)
    assert(out == Seq(10, 10), s"expected Seq(10,10), got $out")
  }

  // ── Test 4: asymmetric z_x with SAME padding -- padded cells must not contribute ──
  // 1x1x1 input, 1x3 kernel, SAME padding (padLeft=1, padRight=1), z_x=5.
  // Input stored value = 10. Padded cells are initialised to z_x=5.
  //   left pad:   (5 − 5) × 1 = 0
  //   center:     (10 − 5) × 1 = 5
  //   right pad:  (5 − 5) × 1 = 0
  //   acc = 5, output ≈ 5  (scales = 1.0/1.0/1.0 → requant is identity)
  // If padding were initialised to 0 (the old bug):
  //   acc = (0−5)×1 + (10−5)×1 + (0−5)×1 = −5, output ≈ −5
  test("SAME-padded conv with asymmetric z_x: pad cells contribute zero") {
    val cfg = QLinearConvCore.Config(
      periphName   = "pad_zp",
      inputShape   = TensorShape(1, 1, 1),
      outputShape  = TensorShape(1, 1, 1),
      kernelH      = 1,
      kernelW      = 3,
      strideH      = 1,
      strideW      = 1,
      padTop       = 0,
      padBottom    = 0,
      padLeft      = 1,
      padRight     = 1,
      inputQuant   = QuantParams(1.0f, 5),
      weightQuant  = QuantParams(1.0f, 0),
      outputQuant  = QuantParams(1.0f, 0),
      weights      = Array[Byte](1, 1, 1),
      biases       = Array(0)
    )
    val out = runConv(cfg, Seq(10), outCount = 1)
    assert(out == Seq(5), s"expected Seq(5) (pad cells zeroed by z_x init), got $out")
  }

  // ── Test 3: per-channel across a 2x2 spatial map, 2 output channels ─────────
  // 1x1 conv, input 2x2x1 = [1,2,3,4], weights [oc0=4, oc1=4].
  //   acc[oc,pos] = in[pos] * 4
  //   ch0 scale 0.25 -> round(0.25 * 4*in) = in
  //   ch1 scale 0.5  -> round(0.5  * 4*in) = 2*in
  // HWC output order per position: [ch0, ch1].
  //   pos0 in=1 -> [1, 2]; pos1 in=2 -> [2, 4]; pos2 in=3 -> [3, 6]; pos3 in=4 -> [4, 8]
  test("per-channel scales hold across spatial positions") {
    val cfg = QLinearConvCore.Config(
      periphName   = "pc_spatial",
      inputShape   = TensorShape(2, 2, 1),
      outputShape  = TensorShape(2, 2, 2),
      kernelH      = 1,
      kernelW      = 1,
      inputQuant   = QuantParams(1.0f, 0),
      weightQuant  = QuantParams(1.0f, 0),
      outputQuant  = QuantParams(1.0f, 0),
      weights      = Array[Byte](4, 4),
      biases       = Array(0, 0),
      weightScales = Some(Array(0.25f, 0.5f))
    )
    val out = runConv(cfg, Seq(1, 2, 3, 4), outCount = 8)
    assert(out == Seq(1, 2, 2, 4, 3, 6, 4, 8), s"expected Seq(1,2, 2,4, 3,6, 4,8), got $out")
  }
}
