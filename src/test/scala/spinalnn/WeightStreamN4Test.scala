package spinalnn

import org.scalatest.funsuite.AnyFunSuite
import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinalnn.compiler.LayerSpecInterpreter
import spinalnn.ops.conv.QLinearConvCore
import spinalnn.target.{WeightStream, WeightRom}
import spinalnn.types._
import spinalnn.util.PrefixArea

/**
 * Simulation test for [[QLinearConvCore]] in WeightStream mode with N=4 lanes.
 *
 * Validates the 512-bit beat drain: each beat covers 64/4 = 16 steps; only
 * stepsPerBeat/weightsPerCh of those steps hold valid data (the rest are skipped).
 * The hardware output must be bit-identical to the Scala reference.
 *
 * Topology: 4×4×4 → conv1x1(4→4, N=4, WeightStream) → output
 * (No GAP/linear; outputs are the raw per-pixel per-channel activations.)
 */
class WeightStreamN4Test extends AnyFunSuite {

  private val idQ = QuantParams(scale = 1.0f, zeroPoint = 0)
  private val N   = 4   // macParallelism
  private val H   = 4; private val W = 4
  private val C_in = 4; private val C_out = 4

  // All-twos input: deterministic, non-trivial dot products.
  private val inputFlat: Array[Byte] = Array.fill(H * W * C_in)(2.toByte)

  // Weights in transposed [outCh, kH, kW, C_in] order (1×1 kernel so kH=kW=1):
  // outCh 0: [1, 2, 1, 2]
  // outCh 1: [2, 1, 2, 1]
  // outCh 2: [1, 1, 1, 1]
  // outCh 3: [2, 2, 2, 2]
  private val weights: Array[Byte] = Array(
    1, 2, 1, 2,   // outCh 0
    2, 1, 2, 1,   // outCh 1
    1, 1, 1, 1,   // outCh 2
    2, 2, 2, 2    // outCh 3
  ).map(_.toByte)

  private val biases: Array[Int] = Array.fill(C_out)(0)

  // Software reference via the interpreter's conv logic.
  // We compute manually: input = all-2s; for each outCh sum(input[ci]*w[outCh,ci] for ci in 0..3).
  // outCh 0: 2*1+2*2+2*1+2*2 = 2+4+2+4 = 12
  // outCh 1: 2*2+2*1+2*2+2*1 = 4+2+4+2 = 12
  // outCh 2: 2*1+2*1+2*1+2*1 = 8
  // outCh 3: 2*2+2*2+2*2+2*2 = 16
  // All clamped to [-128, 127] = [12, 12, 8, 16] per pixel, H*W=16 pixels.
  private val expectedPerPixel = Seq(12, 12, 8, 16)  // [outCh 0..3] for each pixel
  // Output order: HWC → [pixel0_ch0, pixel0_ch1, pixel0_ch2, pixel0_ch3, pixel1_ch0, ...]
  private val expected: Array[Int] = Array.tabulate(H * W)(px => expectedPerPixel.toArray)
    .flatten

  // ── Component under test ──────────────────────────────────────────────────
  private val cfg = QLinearConvCore.Config(
    periphName    = "conv_ws_n4",
    inputShape    = TensorShape(H, W, C_in),
    outputShape   = TensorShape(H, W, C_out),
    kernelH = 1, kernelW = 1,
    inputQuant    = idQ,
    weightQuant   = idQ,
    outputQuant   = idQ,
    weights       = weights,
    biases        = biases,
    macParallelism = N,
    weightMode    = WeightStream
  )

  // Minimal wrapper that exposes the core's ports as top-level IOs.
  class ConvWrapper extends Component {
    val activationIn  = slave(Stream(Activation()))
    val activationOut = master(Stream(Activation()))
    val weightIn      = slave(Stream(Bits(512 bits)))

    val result = QLinearConvCore.build(cfg, activationIn)
    activationOut << result.activationOut
    weightIn      >> result.weightIn
  }

  // Build one 512-bit beat for a given output channel's weights.
  // bytes 0..N-1 carry the N lane weights; bytes N..63 are zero padding.
  private def makeBeat(outCh: Int): BigInt = {
    val beat = Array.fill(64)(0.toByte)
    for (i <- 0 until N) {
      val flatIdx = outCh * C_in + i  // transposed: [outCh, C_in] flat
      beat(i) = weights(flatIdx)
    }
    // Pack bytes into a BigInt little-endian (byte 0 = LSByte).
    beat.zipWithIndex.foldLeft(BigInt(0)) { case (acc, (b, idx)) =>
      acc | (BigInt(b.toLong & 0xFFL) << (idx * 8))
    }
  }

  test("WeightStream N=4: hardware output matches manual reference") {
    val compiled = SimConfig
      .workspacePath("simWorkspace/WeightStreamN4Test")
      .compile(new ConvWrapper())

    compiled.doSim("ws_n4") { dut =>
      dut.clockDomain.forkStimulus(period = 10)

      dut.activationIn.valid  #= false
      dut.activationIn.payload.value #= 0
      dut.activationOut.ready #= true
      dut.weightIn.valid      #= false
      dut.weightIn.payload    #= 0

      dut.clockDomain.waitSampling(5)

      // ── Weight feeder thread ─────────────────────────────────────────────
      // Supplies one 512-bit beat per output channel, once per conv cycle.
      // Repeats for each H*W output position (conv cycles C_out times per position).
      fork {
        for (_ <- 0 until H * W) {
          for (oc <- 0 until C_out) {
            val beat = makeBeat(oc)
            dut.weightIn.valid   #= true
            dut.weightIn.payload #= beat
            dut.clockDomain.waitSamplingWhere(dut.weightIn.ready.toBoolean)
            dut.weightIn.valid #= false
            dut.clockDomain.waitSampling(1)
          }
        }
      }

      // ── Activation feeder ────────────────────────────────────────────────
      fork {
        for (_ <- inputFlat) {
          dut.activationIn.valid         #= true
          dut.activationIn.payload.value #= 2
          dut.clockDomain.waitSamplingWhere(dut.activationIn.ready.toBoolean)
        }
        dut.activationIn.valid #= false
      }

      // ── Output collector ─────────────────────────────────────────────────
      val results = Array.fill(H * W * C_out)(0)
      var collected = 0
      val timeout   = 500_000
      var cycle     = 0

      while (collected < H * W * C_out && cycle < timeout) {
        dut.clockDomain.waitSampling()
        if (dut.activationOut.valid.toBoolean && dut.activationOut.ready.toBoolean) {
          results(collected) = dut.activationOut.payload.value.toInt
          collected += 1
        }
        cycle += 1
        if (cycle % 100_000 == 0)
          println(s"  [WeightStreamN4Test] $cycle cycles, $collected/${H * W * C_out} collected")
      }

      assert(collected == H * W * C_out,
        s"Timeout: collected $collected/${H * W * C_out} outputs after $cycle cycles")

      println(s"\n[WeightStreamN4Test] hardware output: ${results.toSeq}")
      println(s"[WeightStreamN4Test] expected output:  ${expected.toSeq}")
      assert(results.toSeq == expected.toSeq,
        s"Mismatch!\n  expected: ${expected.toSeq}\n  got:      ${results.toSeq}")
    }
  }
}
