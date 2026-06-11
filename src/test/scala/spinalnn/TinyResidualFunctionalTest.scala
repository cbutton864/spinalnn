package spinalnn

import org.scalatest.funsuite.AnyFunSuite
import spinal.core.sim._
import spinalnn.compiler.{LayerSpec, LayerSpecInterpreter}
import spinalnn.testhelpers.TopSimDriver
import spinalnn.types._

/** End-to-end functional test for the residual-Add (MobileNetV2/ResNet-style) topology.
  *
  * Exercises: StreamFork (input fanned out to the block and the skip connection),
  * Conv1x1 (pointwise expand and squeeze), Conv3x3 with SAME padding,
  * Add (element-wise residual sum with requantisation), GlobalAveragePool, Linear.
  *
  * Model: 6x6x4 input  (inverted-bottleneck style, not full MobileNetV2 depth)
  *   conv1: 1×1, 4→8  (expand)
  *   conv2: 3×3 SAME, 8→8
  *   conv3: 1×1, 8→4  (project back)
  *   add  : input + conv3  (residual, both 6x6x4)
  *   gap  : GlobalAveragePool 6x6x4 → 1x1x4
  *   linear: 4→4
  *   (raw int8 logits, 4 outputs)
  *
  * All layers use identity quantization (scale=1.0, zp=0) so the software
  * reference is just integer arithmetic with int8 clamping.  Hardware and
  * software must produce bit-identical outputs.
  */
class TinyResidualFunctionalTest extends AnyFunSuite {

  private val idQ = QuantParams(scale = 1.0f, zeroPoint = 0)

  private val H = 6; private val W = 6

  // Input: 6x6x4, values cycling through 0..4
  private val inputData: Array[Int] =
    Array.tabulate(H * W * 4)(i => i % 5)

  private def mkWeights(n: Int): Array[Byte] = Array.tabulate(n)(i => (1 + i % 2).toByte)
  private def mkBiases(n: Int):  Array[Int]  = Array.fill(n)(0)

  private val specs: Seq[LayerSpec] = {
    val inputShape = TensorShape(H, W, 4)
    val expandShape = TensorShape(H, W, 8)

    Seq(
      LayerSpec.Input("input", inputShape),

      // conv1: 1×1, 4→8 (expand)
      LayerSpec.Conv("conv1", input = "input",
        inputShape = inputShape, shape = expandShape,
        kernelH = 1, kernelW = 1, strideH = 1, strideW = 1,
        padTop = 0, padBottom = 0, padLeft = 0, padRight = 0,
        inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
        weights = mkWeights(8 * 1 * 1 * 4), biases = mkBiases(8)),

      // conv2: 3×3 SAME, 8→8
      LayerSpec.Conv("conv2", input = "conv1",
        inputShape = expandShape, shape = expandShape,
        kernelH = 3, kernelW = 3, strideH = 1, strideW = 1,
        padTop = 1, padBottom = 1, padLeft = 1, padRight = 1,
        inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
        weights = mkWeights(8 * 3 * 3 * 8), biases = mkBiases(8)),

      // conv3: 1×1, 8→4 (project back to input channels for residual)
      LayerSpec.Conv("conv3", input = "conv2",
        inputShape = expandShape, shape = inputShape,
        kernelH = 1, kernelW = 1, strideH = 1, strideW = 1,
        padTop = 0, padBottom = 0, padLeft = 0, padRight = 0,
        inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
        weights = mkWeights(4 * 1 * 1 * 8), biases = mkBiases(4)),

      // add: input + conv3 (residual connection; StreamFork is inserted for "input")
      LayerSpec.Add("add",
        inputs      = Seq("input", "conv3"),
        inputShapes = Seq(inputShape, inputShape),
        inputAQuant = idQ,
        inputBQuant = idQ,
        outputQuant = idQ),

      // GlobalAveragePool: 6x6x4 → 1x1x4
      LayerSpec.GlobalAveragePool("gap", input = "add",
        inputShape = inputShape, inputQuant = idQ, outputQuant = idQ),

      // Linear: 4→4
      LayerSpec.Linear("linear", input = "gap",
        inNeurons = 4, outNeurons = 4,
        inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
        weights = mkWeights(4 * 4), biases = mkBiases(4)),

      LayerSpec.Output("output", input = "linear",
        shape = TensorShape(1, 1, 4))
    )
  }

  private lazy val expected: Array[Int] = LayerSpecInterpreter.run(specs, inputData)

  private def compileTop() =
    SimConfig
      .workspacePath("simWorkspace/TinyResidualFunctionalTest")
      .compile(new SpinalNNTop(Params.fromSpecs(specs)))

  test("tiny residual-Add: hardware output matches software reference (Add + GAP path)") {
    println(s"\n[TinyResidualFunctionalTest] software reference: ${expected.toSeq}")

    compileTop().doSim("tiny_residual") { dut =>
      dut.clockDomain.forkStimulus(period = 10)
      dut.io.activationIn.valid         #= false
      dut.io.activationIn.payload.value #= 0
      dut.io.activationOut.ready        #= false
      dut.clockDomain.waitSampling(5)

      val hw = TopSimDriver.run(dut, inputData, outputCount = 4, timeout = 200_000)

      println(s"[TinyResidualFunctionalTest] hardware output:    ${hw.toSeq}")
      assert(hw.toSeq == expected.toSeq,
        s"Hardware/software mismatch!\n  expected: ${expected.toSeq}\n  got:      ${hw.toSeq}")
    }
  }
}
