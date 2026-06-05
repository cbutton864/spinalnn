package spinalnn.ops

import org.scalatest.funsuite.AnyFunSuite
import spinal.core._
import spinal.core.sim._
import spinalnn.ops.conv.QLinearConvCore
import spinalnn.testhelpers.QLinearConvHarness
import spinalnn.types._
import scala.collection.mutable

// Validates macParallelism > 1. Uses all-ones weights so results are identical
// regardless of weight layout, and verifiable by hand (output = sum of inputs).
class QLinearConvParallelTest extends AnyFunSuite {

  val idQ = QuantParams(scale = 1.0f, zeroPoint = 0)

  def compile(cfg: QLinearConvCore.Config) =
    SimConfig
      .withWave
      .workspacePath("simWorkspace/QLinearConvParallelTest")
      .compile(new QLinearConvHarness(cfg))

  def driveInputs(dut: QLinearConvHarness, values: Seq[Int]): Unit = {
    for (v <- values) {
      dut.io.activationIn.valid         #= true
      dut.io.activationIn.payload.value #= v
      dut.clockDomain.waitSamplingWhere(dut.io.activationIn.ready.toBoolean)
    }
    dut.io.activationIn.valid #= false
  }

  def collectOutputs(dut: QLinearConvHarness, count: Int): Seq[Int] = {
    val results = mutable.ArrayBuffer[Int]()
    dut.io.activationOut.ready #= true
    var cycles = 0
    while (results.length < count && cycles < 200000) {
      dut.clockDomain.waitSampling()
      sleep(1)
      if (dut.io.activationOut.valid.toBoolean && dut.io.activationOut.ready.toBoolean)
        results += dut.io.activationOut.payload.value.toInt
      cycles += 1
    }
    assert(cycles < 200000, s"Timeout: got ${results.length}/$count")
    results.toSeq
  }

  // ── N=2: 1x1 conv, C_in=4, 2 MACs per step ───────────────────────────────
  // Input [1,2,3,4], all-ones weights, 1 output neuron.
  // acc = 1+2+3+4 = 10. Output = 10.
  test("N=2: 1x1 conv, C_in=4, sums correctly") {
    val cfg = QLinearConvCore.Config(
      periphName = "conv_n2", inputShape = TensorShape(1, 1, 4),
      outputShape = TensorShape(1, 1, 1), kernelH = 1, kernelW = 1,
      inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
      weights = Array.fill(4)(1.toByte), biases = Array(0),
      macParallelism = 2
    )
    compile(cfg).doSim("conv_n2") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      val stim = fork(driveInputs(dut, Seq(1, 2, 3, 4)))
      val out  = collectOutputs(dut, 1)
      stim.join()
      assert(out == Seq(10), s"Expected Seq(10), got $out")
    }
  }

  // ── N=4: 1x1 conv, C_in=4, all 4 channels in one step ───────────────────
  test("N=4: 1x1 conv, C_in=4, sums correctly in one ITER step") {
    val cfg = QLinearConvCore.Config(
      periphName = "conv_n4", inputShape = TensorShape(1, 1, 4),
      outputShape = TensorShape(1, 1, 1), kernelH = 1, kernelW = 1,
      inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
      weights = Array.fill(4)(1.toByte), biases = Array(0),
      macParallelism = 4
    )
    compile(cfg).doSim("conv_n4") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      val stim = fork(driveInputs(dut, Seq(1, 2, 3, 4)))
      val out  = collectOutputs(dut, 1)
      stim.join()
      assert(out == Seq(10), s"Expected Seq(10), got $out")
    }
  }

  // ── N=2, multiple spatial positions ──────────────────────────────────────
  // 2x2x2 input, 1x1 conv, 1 output channel, N=2.
  // Each output = sum of 2 input channels at that position.
  // Input HWC: [1,2, 3,4, 5,6, 7,8] -> positions (0,0)=[1,2], (0,1)=[3,4], (1,0)=[5,6], (1,1)=[7,8]
  // Output: [1+2, 3+4, 5+6, 7+8] = [3, 7, 11, 15]
  test("N=2: 2x2x2 input, 1x1 conv, correct spatial outputs") {
    val cfg = QLinearConvCore.Config(
      periphName = "conv_n2_spatial", inputShape = TensorShape(2, 2, 2),
      outputShape = TensorShape(2, 2, 1), kernelH = 1, kernelW = 1,
      inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
      weights = Array.fill(2)(1.toByte), biases = Array(0),
      macParallelism = 2
    )
    compile(cfg).doSim("conv_n2_spatial") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      val stim = fork(driveInputs(dut, Seq(1, 2, 3, 4, 5, 6, 7, 8)))
      val out  = collectOutputs(dut, 4)
      stim.join()
      assert(out == Seq(3, 7, 11, 15), s"Expected Seq(3,7,11,15), got $out")
    }
  }

  // ── N=1 and N=2 produce identical results ────────────────────────────────
  // Same weights and inputs; different parallelism should give same output.
  test("N=1 and N=2 give identical outputs for same config") {
    def run(n: Int): Seq[Int] = {
      val cfg = QLinearConvCore.Config(
        periphName = s"conv_cmp_n$n", inputShape = TensorShape(1, 1, 4),
        outputShape = TensorShape(1, 1, 1), kernelH = 1, kernelW = 1,
        inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
        weights = Array.fill(4)(1.toByte), biases = Array(0),
        macParallelism = n
      )
      var result = Seq.empty[Int]
      compile(cfg).doSim(s"conv_cmp_n$n") { dut =>
        dut.clockDomain.forkStimulus(10)
        dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
        dut.clockDomain.waitSampling(2)
        val stim = fork(driveInputs(dut, Seq(1, 2, 3, 4)))
        result = collectOutputs(dut, 1)
        stim.join()
      }
      result
    }
    assert(run(1) == run(2), "N=1 and N=2 produced different outputs")
    assert(run(1) == Seq(10))
  }
}
