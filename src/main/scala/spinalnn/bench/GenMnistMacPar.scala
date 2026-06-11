package spinalnn.bench

import spinal.core._
import spinalnn._
import spinalnn.target._

/** Generates Verilog for MNIST MacParallelism comparison runs.
  *
  * Three configurations:
  *   N1            — MacParAuto (N=1 everywhere, baseline)
  *   perLayer_N8   — MacParPerLayer(conv2->8, default=1): conv1 keeps N=1, conv2 uses N=8
  *   fixed_N8      — MacParFixed(8): conv2 gets N=8, conv1 falls back to N=1 (same DSPs as perLayer)
  *
  * Output: rtl/mnist_macpar/{N1,perLayer_N8,fixed_N8}/SpinalNNTop.v
  *
  * Usage:
  *   sbt "runMain spinalnn.bench.GenMnistMacPar"
  *
  * Then run P&R on each output directory to compare resource utilisation and
  * maximum frequency.  The DSP count between perLayer_N8 and fixed_N8 should
  * be identical (conv2 N=8 in both cases); the baseline N1 shows the DSP floor.
  */
object GenMnistMacPar extends App {

  val configs: Seq[(String, TargetConfig)] = Seq(
    "N1" ->
      TargetConfig.default,

    "perLayer_N8" ->
      TargetConfig.default.withMacPar(
        MacParPerLayer(Map("conv2" -> 8), default = 1)),

    "fixed_N8" ->
      TargetConfig.default.withMacPar(MacParFixed(8))
  )

  for ((label, tgt) <- configs) {
    val dir = s"rtl/mnist_macpar/$label"
    new java.io.File(dir).mkdirs()

    val cfg = SpinalConfig(
      defaultClockDomainFrequency  = FixedFrequency(150 MHz),
      defaultConfigForClockDomains = ClockDomainConfig(
        resetKind        = ASYNC,
        resetActiveLevel = HIGH
      ),
      targetDirectory = dir
    )

    cfg.generateVerilog {
      val top = new SpinalNNTop(Params.onnx.withTarget(tgt))
      top.clockDomain.clock.setName("clk")
      top.clockDomain.reset.setName("reset")
      top
    }

    println(s"[GenMnistMacPar] $label -> $dir/SpinalNNTop.v")
  }
}
