package spinalnn.ops

import org.scalatest.funsuite.AnyFunSuite
import spinal.core._
import spinal.core.sim._
import spinalnn.ops.activation.SoftmaxCore
import spinalnn.testhelpers.SoftmaxHarness
import spinalnn.types._
import scala.collection.mutable

class SoftmaxCoreTest extends AnyFunSuite {

  def compile(cfg: SoftmaxCore.Config) =
    SimConfig
      .withWave
      .workspacePath("simWorkspace/SoftmaxCoreTest")
      .compile(new SoftmaxHarness(cfg))

  def runArgmax(dut: SoftmaxHarness, logits: Seq[Int]): Int = {
    val results = mutable.ArrayBuffer[Int]()
    dut.io.activationOut.ready #= true

    val stim = fork {
      for (v <- logits) {
        dut.io.activationIn.valid         #= true
        dut.io.activationIn.payload.value #= v
        dut.clockDomain.waitSamplingWhere(dut.io.activationIn.ready.toBoolean)
      }
      dut.io.activationIn.valid #= false
    }

    var cycles = 0
    while (results.isEmpty && cycles < 10000) {
      dut.clockDomain.waitSampling()
      sleep(1)
      if (dut.io.activationOut.valid.toBoolean && dut.io.activationOut.ready.toBoolean)
        results += dut.io.activationOut.payload.value.toInt
      cycles += 1
    }
    stim.join()
    assert(results.nonEmpty, "Timeout waiting for argmax output")
    results.head
  }

  test("Max in middle position: [-5, 3, 7, 1] -> argmax = 2") {
    val cfg = SoftmaxCore.Config("softmax_mid", numClasses = 4)
    compile(cfg).doSim("argmax_mid") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      assert(runArgmax(dut, Seq(-5, 3, 7, 1)) == 2)
    }
  }

  test("Max at first position: [10, 5, 3, 1] -> argmax = 0") {
    val cfg = SoftmaxCore.Config("softmax_first", numClasses = 4)
    compile(cfg).doSim("argmax_first") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      assert(runArgmax(dut, Seq(10, 5, 3, 1)) == 0)
    }
  }

  test("Max at last position: [1, 3, 5, 10] -> argmax = 3") {
    val cfg = SoftmaxCore.Config("softmax_last", numClasses = 4)
    compile(cfg).doSim("argmax_last") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      assert(runArgmax(dut, Seq(1, 3, 5, 10)) == 3)
    }
  }

  test("Ties: [5, 5, 5, 5] -> argmax = 0 (first wins)") {
    val cfg = SoftmaxCore.Config("softmax_tie", numClasses = 4)
    compile(cfg).doSim("argmax_tie") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      assert(runArgmax(dut, Seq(5, 5, 5, 5)) == 0)
    }
  }

  test("MNIST-scale (10 classes): max at index 7") {
    val cfg = SoftmaxCore.Config("softmax_mnist", numClasses = 10)
    compile(cfg).doSim("argmax_mnist") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      val logits = Seq(-10, -5, 0, 5, 10, 8, 6, 15, 3, 1)
      assert(runArgmax(dut, logits) == 7)
    }
  }

  test("Back-to-back inferences produce correct results") {
    val cfg = SoftmaxCore.Config("softmax_b2b", numClasses = 4)
    compile(cfg).doSim("argmax_b2b") { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.activationIn.valid #= false; dut.io.activationOut.ready #= false
      dut.clockDomain.waitSampling(2)
      assert(runArgmax(dut, Seq(1, 7, 3, 2)) == 1)
      assert(runArgmax(dut, Seq(4, 1, 9, 2)) == 2)
    }
  }
}
