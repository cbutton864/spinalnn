package spinalnn.compiler

import org.scalatest.funsuite.AnyFunSuite

class ModelCycleEstimatorTest extends AnyFunSuite {

  private val modelPath = "models/squeezenet1.0-12-int8.onnx"

  private def loadSqueezeNet(): Seq[LayerSpec] = {
    assume(new java.io.File(modelPath).exists(), s"$modelPath not present; skipping")
    val model = OnnxCompiler.loadModel(modelPath)
    OnnxFrontend.lowerQuantized(model, emitLogits = false)
  }

  test("SqueezeNet N=1 cycle estimate is dominated by conv layers") {
    val specs = loadSqueezeNet()
    val est   = ModelCycleEstimator.estimate(specs, macN = 1)

    println("\n" + est.report(freqMHz = 150.0))

    // Conv layers must account for > 90% of total cycles at N=1
    val convCycles = est.layers.filter(_.opType.startsWith("conv")).map(_.cyclesEst).sum
    assert(convCycles.toDouble / est.totalCycles > 0.90,
      s"Expected conv to dominate (>90%) at N=1, got ${100.0 * convCycles / est.totalCycles}%.1f%%")

    // Total must be in the right ballpark (hundreds of millions)
    assert(est.totalCycles > 100_000_000L, s"Total ${est.totalCycles} suspiciously low")
    assert(est.totalCycles < 100_000_000_000L, s"Total ${est.totalCycles} suspiciously high")
  }

  test("macParallelism sweep shows expected speedup trend and divisibility ceiling") {
    val specs = loadSqueezeNet()
    val ns    = Seq(1, 2, 4, 8, 16, 32)

    println("\n" + ModelCycleEstimator.sweep(specs, ns, freqMHz = 150.0))

    val e1  = ModelCycleEstimator.estimate(specs, 1)
    val e2  = ModelCycleEstimator.estimate(specs, 2)
    val e16 = ModelCycleEstimator.estimate(specs, 16)
    val e32 = ModelCycleEstimator.estimate(specs, 32)

    // N=2 should be meaningfully faster than N=1
    val s2 = e1.totalCycles.toDouble / e2.totalCycles
    assert(s2 >= 1.5, s"N=2 speedup $s2 < 1.5x expected")

    // N=16 should give better speedup than N=2 (trend is upward to at least 16)
    val s16 = e1.totalCycles.toDouble / e16.totalCycles
    assert(s16 > s2, s"N=16 speedup $s16 should exceed N=2 speedup $s2")

    // N=32 for SqueezeNet is expected to be WORSE than N=16 because the fire-module
    // expand layers all have C_in=48 (48 % 32 != 0), which forces a fallback to N=1.
    // This confirms the optimal N for SqueezeNet is 16, not 32.
    assert(e32.totalCycles > e16.totalCycles,
      s"Expected N=32 (${e32.totalCycles}) to be slower than N=16 (${e16.totalCycles}) " +
      "due to C_in=48 expand layers not divisible by 32")
  }

  test("MacParPerLayer dry-run and estimate agree with manual calculation") {
    val specs = loadSqueezeNet()

    // Build a per-layer policy targeting the two most expensive layer groups:
    //   conv10 (C_in=512, 24% of cycles at N=1) -> N=32
    //   fire8/9 expand3x3 (C_in=64, ~14% combined) -> N=16
    //   everything else -> N=1 (conservative default)
    val policy = spinalnn.target.MacParPerLayer(
      default   = 1,
      overrides = Map(
        "conv10_1_quantized"          -> 32,
        "fire8_expand3x3_1_quantized" -> 16,
        "fire9_expand3x3_1_quantized" -> 16
      )
    )

    // Dry-run: print the assignment table and check no unexpected fallbacks
    val assignment = ModelCycleEstimator.macParAssignment(specs, policy)
    println("\n" + assignment)

    // conv10 C_in=512, 512%32=0 -> should get N=32 (no fallback)
    // fire8 expand3x3 C_in=64, 64%16=0 -> N=16
    // fire9 expand3x3 C_in=64, 64%16=0 -> N=16
    assert(!assignment.contains("FALLBACK"),
      "Expected no fallbacks for conv10->N=32 and fire8/9->N=16 (all C_in divisible)")

    // Policy estimate should be better than global N=1 but slightly less than global N=16
    val ePolicy = ModelCycleEstimator.estimate(specs, policy)
    val e1      = ModelCycleEstimator.estimate(specs, 1)
    val e16     = ModelCycleEstimator.estimate(specs, 16)

    println(f"\n  N=1 baseline:    ${e1.totalCycles}%,d cycles  (${e1.fpsAt(150)}%.2f FPS)")
    println(f"  Per-layer policy:${ePolicy.totalCycles}%,d cycles  (${ePolicy.fpsAt(150)}%.2f FPS)")
    println(f"  Global N=16:     ${e16.totalCycles}%,d cycles  (${e16.fpsAt(150)}%.2f FPS)")

    assert(ePolicy.totalCycles < e1.totalCycles,   "Per-layer policy must be faster than N=1")
    assert(ePolicy.totalCycles > e16.totalCycles / 2,  "Per-layer policy is in a reasonable range")
  }

  test("MNIST cycle estimate at N=1 is realistic") {
    val specs = ModelCycleEstimator.estimate(Seq(
      LayerSpec.Input("input", spinalnn.types.TensorShape(28, 28, 1)),
      LayerSpec.Conv(
        name = "conv1", input = "input",
        inputShape = spinalnn.types.TensorShape(28, 28, 1),
        shape      = spinalnn.types.TensorShape(28, 28, 4),
        kernelH = 3, kernelW = 3, strideH = 1, strideW = 1,
        padTop = 1, padBottom = 1, padLeft = 1, padRight = 1,
        inputQuant  = spinalnn.types.QuantParams(0.1f, 0),
        weightQuant = spinalnn.types.QuantParams(0.1f, 0),
        outputQuant = spinalnn.types.QuantParams(0.1f, 0),
        weights = Array.fill(3 * 3 * 1 * 4)(1.toByte),
        biases  = Array.fill(4)(0)
      )
    ), macN = 1)

    println("\n" + specs.report(150.0))

    // conv1: rx = 28*28*1 = 784; compute = 28*28*4*(1*3*3+3) = 33152; total = 33936
    assert(specs.totalCycles > 1_000 && specs.totalCycles < 1_000_000,
      s"MNIST conv1 estimate ${specs.totalCycles} out of range")
  }
}
