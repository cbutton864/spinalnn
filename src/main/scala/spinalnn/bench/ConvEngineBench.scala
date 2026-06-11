package spinalnn.bench

import spinal.core._
import spinal.lib._
import spinalnn.ops.conv.QLinearConvCore
import spinalnn.types._

/** Synthesizable single-engine timing/area benchmark for the per-channel
  * `QLinearConvCore` datapath.
  *
  * All stream IO is registered at the top boundary, so the critical path reported
  * by synthesis/P&R is the internal compute datapath -- the MAC, the pipelined
  * split-16x16 requant multiplier, and the per-channel variable barrel shifter --
  * rather than I/O pad timing.
  *
  * The config supplies per-channel `weightScales`, so the per-channel requant ROMs
  * (`reqMultRom`/`reqShiftRom`) and the variable-shift barrel shifter are exercised.
  * That is the datapath that ships for SqueezeNet-class (per-channel) models and has
  * never been through synthesis/P&R -- the existing 172/280 MHz benchmark numbers are
  * the older per-tensor (constant-shift) path.
  *
  * The conv dimensions are deliberately small: the critical path is a property of the
  * datapath, not of the layer size, so a small layer P&Rs quickly and fits any part
  * while reporting the same combinational depth as a full-size SqueezeNet layer.
  */
class ConvEngineBench(cfg: QLinearConvCore.Config) extends Component {
  val io = new Bundle {
    val inValid  = in  Bool()
    val inValue  = in  SInt(ActivationDType.bits bits)
    val inReady  = out Bool()
    val outValid = out Bool()
    val outValue = out SInt(ActivationDType.bits bits)
    val outReady = in  Bool()
  }

  // ── Registered input boundary ──────────────────────────────────────────────
  val inValidR  = RegNext(io.inValid)  init False
  val inValueR  = RegNext(io.inValue)  init 0
  val outReadyR = RegNext(io.outReady) init False

  val inStream = Stream(Activation())
  inStream.valid         := inValidR
  inStream.payload.value := inValueR

  // ── Device under test ──────────────────────────────────────────────────────
  val core = QLinearConvCore.build(cfg, inStream)
  core.activationOut.ready := outReadyR

  // ── Registered output boundary ─────────────────────────────────────────────
  io.inReady  := RegNext(inStream.ready)                   init False
  io.outValid := RegNext(core.activationOut.valid)         init False
  io.outValue := RegNext(core.activationOut.payload.value) init 0
}

object ConvEngineBench {
  /** Representative SqueezeNet-style fire-module convolution:
    * 8x8x16 -> 8x8x32, 3x3 kernel, stride 1, pad 1, with per-channel weight
    * quantization (one requant scale per output channel).
    *
    * `macParallelism` (N) must divide inCh (16). Valid values: 1, 2, 4, 8, 16.
    * Higher N replicates MAC lanes: more DSPs and weight ROM banks, lower cycle count.
    *
    * Weights and biases are non-zero so synthesis does not optimize away the ROMs.
    * Per-channel scales are distinct so the requant ROMs and barrel shifter see real data.
    */
  def benchConfig(macParallelism: Int = 1): QLinearConvCore.Config = {
    val inCh  = 16
    val outCh = 32
    val k     = 3
    val wlen  = outCh * k * k * inCh
    require(inCh % macParallelism == 0,
      s"benchConfig: inCh ($inCh) must be divisible by macParallelism ($macParallelism)")
    QLinearConvCore.Config(
      periphName     = s"bench_N$macParallelism",
      inputShape     = TensorShape(8, 8, inCh),
      outputShape    = TensorShape(8, 8, outCh),
      kernelH = k, kernelW = k,
      strideH = 1, strideW = 1,
      padTop = 1, padBottom = 1, padLeft = 1, padRight = 1,
      inputQuant     = QuantParams(0.05f, -128),
      weightQuant    = QuantParams(0.01f, 0),
      outputQuant    = QuantParams(0.08f, -128),
      weights        = Array.tabulate(wlen)(i => (((i % 13) - 6)).toByte),
      biases         = Array.tabulate(outCh)(oc => oc * 32 - 256),
      weightScales   = Some(Array.tabulate(outCh)(oc => 0.002f + oc * 0.0006f)),
      macParallelism = macParallelism
    )
  }
}

/** Emits the conv-engine benchmark for a single macParallelism value.
  *
  * Usage:
  *   sbt "runMain spinalnn.bench.GenConvBench"        # N=1 (default)
  *   sbt "runMain spinalnn.bench.GenConvBench 4"      # N=4
  *   sbt "runMain spinalnn.bench.GenConvBench 8"      # N=8
  *
  * Output: rtl/bench/conv_N<N>/ConvEngineBench.v
  */
object GenConvBench extends App {
  val n = if (args.nonEmpty) args(0).toInt else 1
  val dir = s"rtl/bench/conv_N$n"
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
    val top = new ConvEngineBench(ConvEngineBench.benchConfig(n))
    top.clockDomain.clock.setName("clk")
    top.clockDomain.reset.setName("reset")
    top
  }
  println(s"Conv engine benchmark N=$n -> $dir/ConvEngineBench.v")
}

/** Emits Verilog for N=1,2,4,8,16 in one shot for P&R comparison.
  *
  * Usage: sbt "runMain spinalnn.bench.GenConvBenchSweep"
  *
  * Output: rtl/bench/conv_N{1,2,4,8,16}/ConvEngineBench.v
  */
object GenConvBenchSweep extends App {
  val ns = Seq(1, 2, 4, 8, 16)
  for (n <- ns) {
    val dir = s"rtl/bench/conv_N$n"
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
      val top = new ConvEngineBench(ConvEngineBench.benchConfig(n))
      top.clockDomain.clock.setName("clk")
      top.clockDomain.reset.setName("reset")
      top
    }
    println(s"  N=$n -> $dir/ConvEngineBench.v")
  }
  println("Done. Run Efinity P&R on each rtl/bench/conv_N*/ConvEngineBench.v to compare timing and resources.")
}
