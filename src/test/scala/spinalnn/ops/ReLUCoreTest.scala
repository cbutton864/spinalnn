package spinalnn.ops

import org.scalatest.funsuite.AnyFunSuite
import spinal.core._
import spinal.core.sim._
import spinalnn.ops.activation.ReLUCore
import spinalnn.testhelpers.ReLUHarness
import spinalnn.types._
import scala.collection.mutable

class ReLUCoreTest extends AnyFunSuite {

  val cfg = ReLUCore.Config("relu")

  def compile() =
    SimConfig
      .withWave
      .workspacePath("simWorkspace/ReLUCoreTest")
      .compile(new ReLUHarness(cfg))

  // ReLU is purely combinatorial: output is valid the same cycle as input.
  // No buffering, no RECEIVE phase. Drive one value per cycle and read the
  // output in the same cycle -- no fork needed, no race condition possible.
  def runStream(dut: ReLUHarness, inputs: Seq[Int]): Seq[Int] = {
    val results = mutable.ArrayBuffer[Int]()
    dut.io.activationOut.ready #= true

    for (v <- inputs) {
      dut.io.activationIn.valid         #= true
      dut.io.activationIn.payload.value #= v
      dut.clockDomain.waitSampling()
      sleep(1)
      results += dut.io.activationOut.payload.value.toInt
    }
    dut.io.activationIn.valid #= false
    results.toSeq
  }

  test("Positive values pass through unchanged") {
    compile().doSim("relu_positive") { dut =>
      dut.clockDomain.forkStimulus(period = 10)
      dut.io.activationIn.valid         #= false
      dut.io.activationIn.payload.value #= 0
      dut.io.activationOut.ready        #= false
      dut.clockDomain.waitSampling(2)

      val results = runStream(dut, Seq(1, 5, 50, 127))
      assert(results == Seq(1, 5, 50, 127), s"Got $results")
    }
  }

  test("Negative values become zero") {
    compile().doSim("relu_negative") { dut =>
      dut.clockDomain.forkStimulus(period = 10)
      dut.io.activationIn.valid         #= false
      dut.io.activationIn.payload.value #= 0
      dut.io.activationOut.ready        #= false
      dut.clockDomain.waitSampling(2)

      val results = runStream(dut, Seq(-1, -50, -127, -128))
      assert(results == Seq(0, 0, 0, 0), s"Got $results")
    }
  }

  test("Zero stays zero") {
    compile().doSim("relu_zero") { dut =>
      dut.clockDomain.forkStimulus(period = 10)
      dut.io.activationIn.valid         #= false
      dut.io.activationIn.payload.value #= 0
      dut.io.activationOut.ready        #= false
      dut.clockDomain.waitSampling(2)

      val results = runStream(dut, Seq(0))
      assert(results == Seq(0), s"Got $results")
    }
  }

  test("Mixed sequence: negatives clamped, positives unchanged") {
    compile().doSim("relu_mixed") { dut =>
      dut.clockDomain.forkStimulus(period = 10)
      dut.io.activationIn.valid         #= false
      dut.io.activationIn.payload.value #= 0
      dut.io.activationOut.ready        #= false
      dut.clockDomain.waitSampling(2)

      val inputs   = Seq(-5, 0, 5, -128, 127, -1, 1)
      val expected = Seq(  0, 0, 5,    0, 127,  0, 1)
      val results  = runStream(dut, inputs)
      assert(results == expected, s"Expected $expected, got $results")
    }
  }
}
