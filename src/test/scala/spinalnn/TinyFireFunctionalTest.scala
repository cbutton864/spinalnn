package spinalnn

import org.scalatest.funsuite.AnyFunSuite
import spinal.core.sim._
import spinalnn.compiler.{LayerSpec, LayerSpecInterpreter}
import spinalnn.testhelpers.TopSimDriver
import spinalnn.types._

/** End-to-end functional test for the fire-module (SqueezeNet-style) topology.
  *
  * Exercises: StreamFork (squeeze fanned out to two expanders), Conv1x1, Conv3x3
  * with SAME padding, Concat (channel-dimension merge), GlobalAveragePool, Linear.
  *
  * Model: 6x6x4 input
  *   squeeze  : 1×1 conv, 4→2 channels
  *   expand1x1: 1×1 conv, 2→4 channels      ─┐
  *   expand3x3: 3×3 conv (pad=1), 2→4 ch    ─┤ Concat → 6x6x8
  *   gap      : GlobalAveragePool 6x6x8 → 1x1x8
  *   linear   : 8→4 neurons
  *   (no softmax — raw int8 logits, 4 outputs)
  *
  * All layers use identity quantization (scale=1.0, zp=0) so the software
  * reference is just integer arithmetic with int8 clamping.  Hardware and
  * software must produce bit-identical outputs.
  */
class TinyFireFunctionalTest extends AnyFunSuite {

  // ── Shared quantisation params ────────────────────────────────────────────
  private val idQ = QuantParams(scale = 1.0f, zeroPoint = 0)

  // ── Model geometry ────────────────────────────────────────────────────────
  private val H = 6; private val W = 6

  // Input: 6x6x4, values cycling through 0..4
  private val inputData: Array[Int] =
    Array.tabulate(H * W * 4)(i => i % 5)

  // ── LayerSpec graph ───────────────────────────────────────────────────────
  // Weights: alternating {1, 2} so each output channel gets a distinct non-zero sum.
  private def mkWeights(n: Int): Array[Byte] = Array.tabulate(n)(i => (1 + i % 2).toByte)
  private def mkBiases(n: Int):  Array[Int]  = Array.fill(n)(0)

  private val specs: Seq[LayerSpec] = {
    val inputShape    = TensorShape(H, W, 4)
    val squeezeShape  = TensorShape(H, W, 2)
    val expandShape   = TensorShape(H, W, 4)
    val concatShape   = TensorShape(H, W, 8)
    val gapShape      = TensorShape(1, 1, 8)

    Seq(
      LayerSpec.Input("input", inputShape),

      // squeeze: 1×1, 4→2
      LayerSpec.Conv("squeeze", input = "input",
        inputShape = inputShape, shape = squeezeShape,
        kernelH = 1, kernelW = 1, strideH = 1, strideW = 1,
        padTop = 0, padBottom = 0, padLeft = 0, padRight = 0,
        inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
        weights = mkWeights(2 * 1 * 1 * 4), biases = mkBiases(2)),

      // expand 1×1: 2→4
      LayerSpec.Conv("expand_1x1", input = "squeeze",
        inputShape = squeezeShape, shape = expandShape,
        kernelH = 1, kernelW = 1, strideH = 1, strideW = 1,
        padTop = 0, padBottom = 0, padLeft = 0, padRight = 0,
        inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
        weights = mkWeights(4 * 1 * 1 * 2), biases = mkBiases(4)),

      // expand 3×3 SAME: 2→4
      LayerSpec.Conv("expand_3x3", input = "squeeze",
        inputShape = squeezeShape, shape = expandShape,
        kernelH = 3, kernelW = 3, strideH = 1, strideW = 1,
        padTop = 1, padBottom = 1, padLeft = 1, padRight = 1,
        inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
        weights = mkWeights(4 * 3 * 3 * 2), biases = mkBiases(4)),

      // Concat along channel dimension: [expand_1x1, expand_3x3] → 6x6x8
      LayerSpec.Concat("concat",
        inputs      = Seq("expand_1x1", "expand_3x3"),
        inputShapes = Seq(expandShape, expandShape)),

      // GlobalAveragePool: 6x6x8 → 1x1x8
      LayerSpec.GlobalAveragePool("gap", input = "concat",
        inputShape = concatShape, inputQuant = idQ, outputQuant = idQ),

      // Linear: 8→4
      LayerSpec.Linear("linear", input = "gap",
        inNeurons = 8, outNeurons = 4,
        inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
        weights = mkWeights(4 * 8), biases = mkBiases(4)),

      LayerSpec.Output("output", input = "linear",
        shape = TensorShape(1, 1, 4))
    )
  }

  // ── Software reference ────────────────────────────────────────────────────
  private lazy val expected: Array[Int] = LayerSpecInterpreter.run(specs, inputData)

  // ── Simulation ────────────────────────────────────────────────────────────
  private def compileTop() =
    SimConfig
      .workspacePath("simWorkspace/TinyFireFunctionalTest")
      .compile(new SpinalNNTop(Params.fromSpecs(specs)))

  test("tiny fire module: hardware output matches software reference (Concat + GAP path)") {
    println(s"\n[TinyFireFunctionalTest] software reference: ${expected.toSeq}")

    compileTop().doSim("tiny_fire") { dut =>
      dut.clockDomain.forkStimulus(period = 10)
      dut.io.activationIn.valid         #= false
      dut.io.activationIn.payload.value #= 0
      dut.io.activationOut.ready        #= false
      dut.clockDomain.waitSampling(5)

      val hw = TopSimDriver.run(dut, inputData, outputCount = 4, timeout = 200_000)

      println(s"[TinyFireFunctionalTest] hardware output:    ${hw.toSeq}")
      assert(hw.toSeq == expected.toSeq,
        s"Hardware/software mismatch!\n  expected: ${expected.toSeq}\n  got:      ${hw.toSeq}")
    }
  }
}
