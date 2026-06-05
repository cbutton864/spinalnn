package spinalnn

import spinal.core._
import spinal.core.sim._
import spinalnn.types._
import spinalnn.util._

class TopLevelSimIntegrationTest extends GoldenIntegrationTest {

  // Compile the top-level small network profile for Verilator simulation.
  // We use CustomBuild/HierarchicalBuild to verify the physical component boundaries under simulation.
  def compileTop(params: Params) =
    SimConfig
      .withWave
      .workspacePath("simWorkspace/TopLevelSimIntegrationTest")
      .compile(new SpinalNNTop(params))

  test("RTL existence: Verify flat and hierarchical release files are fresh and matching") {
    verifyGoldenRtlReady()
  }

  test("Throughput and Data Flow: Small 6x6x1 network end-to-end integration feed") {
    val params = Params.small.copy(
      buildEnv = BuildEnv(HierarchicalBuild)
    )

    compileTop(params).doSim("mnist_small_integration") { dut =>
      dut.clockDomain.forkStimulus(period = 10)

      // Initialize inputs and outputs
      dut.io.activationIn.valid         #= false
      dut.io.activationIn.payload.value #= 0
      dut.io.activationOut.ready        #= false

      dut.clockDomain.waitSampling(5)

      val numInputs = params.profile match {
        case SmallProfile => 6 * 6 * 1
        case MnistProfile => 28 * 28 * 1
        case OnnxProfile  => 28 * 28 * 1
      }

      // Track start cycle
      val startCycle = simTime() / 10
      println(s"[INTEGRATION] Starting stream of $numInputs activation elements...")

      // Fork stimulus driver: streams 36 values sequentially
      val driver = fork {
        for (i <- 0 until numInputs) {
          dut.io.activationIn.valid #= true
          // Feed a positive gradient sequence [1, 2, 3..]
          dut.io.activationIn.payload.value #= (i + 1)
          dut.clockDomain.waitSamplingWhere(dut.io.activationIn.ready.toBoolean)
        }
        dut.io.activationIn.valid #= false
        println("[INTEGRATION] All input elements injected successfully.")
      }

      // Fork receiver: waits for the final network prediction
      var resultArgmax = -1
      var outputCycles = 0L

      dut.io.activationOut.ready #= true
      var cycles = 0
      val timeoutCycles = 1500

      while (resultArgmax == -1 && cycles < timeoutCycles) {
        dut.clockDomain.waitSampling()
        sleep(1)
        if (dut.io.activationOut.valid.toBoolean && dut.io.activationOut.ready.toBoolean) {
          resultArgmax = dut.io.activationOut.payload.value.toInt
          outputCycles = (simTime() / 10) - startCycle
        }
        cycles += 1
      }

      driver.join()

      assert(cycles < timeoutCycles, s"Timeout: pipeline locked up after $cycles cycles")
      assert(resultArgmax != -1, "No output classification was packeted")

      println(s"========================================================================\n" +
              s"[INTEGRATION PERFORMANCE REPORT]\n" +
              s"  - Total inputs injected:  $numInputs elements\n" +
              s"  - Pipeline processing latency: $outputCycles cycles\n" +
              s"  - Output Prediction Index:     $resultArgmax\n" +
              s"========================================================================")

      // Since weights are initialized to 0, bias is 0, inputs are positive:
      // The fully-connected (linear1) layer inputs are all positive, but weights are 0, so output accum is 0 (+ zeroPoint = 0).
      // Since all 4 classes get 0 as output logit, softmax outputs the first index (0) since ties resolve to first.
      assert(resultArgmax == 0, s"Expected tie-break argmax classification index 0, got $resultArgmax")
    }
  }
}
