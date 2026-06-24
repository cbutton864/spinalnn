package spinalnn.bench

import spinal.core._
import spinalnn._
import spinalnn.compiler.{OnnxCompiler, OnnxFrontend, LayerSpec}
import spinalnn.target._

/** Benchmarks SqueezeNet 1.0 W4A8 on Ti180M484 to answer: does W4A8+wider-N beat INT8 DSP ceiling?
  *
  * Context:
  *   INT8 N=16 (WeightStream) hits 512/512 DSPs — hard ceiling, no headroom for N=32.
  *   W4A8 frees MAC DSPs entirely; only requant DSPs remain (~4/layer × 26 layers = ~104 total).
  *   W4A8 weights = ~600KB, fitting in Ti180 BRAM (1,280 RAM10K = 1.6MB) without WeightStream.
  *   W4A8 + WeightStream: weights stay in LPDDR4x (packed 2 nibbles/byte); no BRAM overflow.
  *     N=32 now achievable: 128 % 32 == 0 satisfies the beat-drain constraint.
  *
  * Configs:
  *   sqz_int8_n16_ws     — INT8 N=16 WeightStream (existing benchmark baseline, reproduced here)
  *   sqz_w4a8_n16_wr     — W4A8 N=16 WeightRom (same throughput; confirm DSP savings)
  *   sqz_w4a8_n32_wr     — W4A8 N=32 WeightRom (FAILED P&R: 1,484 RAM10K > Ti180 limit 1,280)
  *   sqz_w4a8_n32_ws     — W4A8 N=32 WeightStream (KEY BENCHMARK: weights in LPDDR4x, ~2× FPS)
  *
  * Usage:
  *   sbt "runMain spinalnn.bench.GenSqueezeNetW4A8Bench"
  *   then create P&R dirs and run pnr_run.sh per config
  */
object GenSqueezeNetW4A8Bench extends App {

  val modelPath = "models/squeezenet1.0-12-int8.onnx"
  val model     = OnnxCompiler.loadModel(modelPath)
  val specs     = OnnxFrontend.lowerQuantized(model, emitLogits = true)

  val convSpecs = specs.collect { case c: LayerSpec.Conv => c }
  val stemName  = convSpecs.find(_.inputShape.channels == 3).map(_.name).getOrElse(
    throw new Exception("No C_in=3 stem found"))

  println(s"[GenSqueezeNetW4A8Bench] Total conv layers: ${convSpecs.size}")
  println(s"[GenSqueezeNetW4A8Bench] Stem: $stemName (C_in=3)")

  val ti180 = TargetConfig(device = DeviceSpec.Ti180M484)

  // N=16 overrides where C_in%16==0 (most body layers); stem (C_in=3) → N=3 override
  val n16overrides: Map[String, Int] = convSpecs
    .filter(c => c.inputShape.channels % 16 == 0)
    .map(_.name -> 16).toMap + (stemName -> 3)

  // N=32 overrides where C_in%32==0; stem → N=3; C_in%32≠0 layers → N=16 default
  val n32overrides: Map[String, Int] = convSpecs
    .filter(c => c.inputShape.channels % 32 == 0)
    .map(_.name -> 32).toMap + (stemName -> 3)

  val configs: Seq[(String, TargetConfig)] = Seq(
    "sqz_int8_n16_ws" ->
      ti180.withWeightMode(WeightStream)
           .withMacPar(MacParPerLayer(n16overrides, default = 16)),

    "sqz_w4a8_n16_wr" ->
      ti180.withWeightMode(WeightRom)
           .withWeightPrecision(WeightInt4)
           .withMacPar(MacParPerLayer(n16overrides, default = 16)),

    "sqz_w4a8_n32_wr" ->
      ti180.withWeightMode(WeightRom)
           .withWeightPrecision(WeightInt4)
           .withMacPar(MacParPerLayer(n32overrides, default = 16)),

    // KEY BENCHMARK: W4A8 + WeightStream at N=32.
    // Weights stay in LPDDR4x (no BRAM overflow); DSP budget freed for wider N.
    // conv1 (C_in=3, N=3) falls back to WeightRom automatically (128%3≠0).
    // All other layers: 128%N==0 satisfied for N=16,32.
    "sqz_w4a8_n32_ws" ->
      ti180.withWeightMode(WeightStream)
           .withWeightPrecision(WeightInt4)
           .withMacPar(MacParPerLayer(n32overrides, default = 16))
  )

  for ((label, tgt) <- configs) {
    val dir = s"rtl/squeezenet_w4a8/$label"
    new java.io.File(dir).mkdirs()

    val cfg = SpinalConfig(
      defaultClockDomainFrequency  = FixedFrequency(150 MHz),
      defaultConfigForClockDomains = ClockDomainConfig(
        resetKind        = ASYNC,
        resetActiveLevel = HIGH
      ),
      targetDirectory = dir
    )

    print(s"[GenSqueezeNetW4A8Bench] generating $label ... ")
    cfg.generateVerilog {
      val top = new SpinalNNTop(
        Params(profile = OnnxPathProfile(modelPath, emitLogits = true)).withTarget(tgt)
      )
      top.clockDomain.clock.setName("clk")
      top.clockDomain.reset.setName("reset")
      top
    }
    println(s"-> $dir/SpinalNNTop.v")
  }
}
