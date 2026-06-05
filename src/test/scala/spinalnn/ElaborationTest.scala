package spinalnn

import org.scalatest.funsuite.AnyFunSuite
import spinal.core._
import spinalnn.util._

class ElaborationTest extends AnyFunSuite {

  def elaborate(params: Params): Unit =
    SpinalConfig(targetDirectory = "target/tmp_rtl")
      .generateVerilog(new SpinalNNTop(params))

  // ── Small profile ─────────────────────────────────────────────────────────
  test("Small profile (6x6x1, flat) elaborates") {
    elaborate(Params.small)
  }

  test("Small profile (6x6x1, hierarchical) elaborates") {
    elaborate(Params.small.copy(buildEnv = BuildEnv(HierarchicalBuild)))
  }

  // ── MNIST profile ─────────────────────────────────────────────────────────
  // Full Conv -> ReLU -> Pool -> Conv -> ReLU -> Pool -> Flatten -> Linear -> Softmax chain.
  test("MNIST profile (28x28x1, flat) elaborates") {
    elaborate(Params.mnist)
  }

  test("MNIST profile (28x28x1, hierarchical) elaborates") {
    elaborate(Params.mnist.copy(buildEnv = BuildEnv(HierarchicalBuild)))
  }
}
