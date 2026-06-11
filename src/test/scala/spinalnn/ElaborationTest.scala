package spinalnn

import org.scalatest.funsuite.AnyFunSuite
import spinal.core._
import spinalnn.target.{MemLineBuffer, TargetConfig, WeightStream}

class ElaborationTest extends AnyFunSuite {

  def elaborate(params: Params): Unit =
    SpinalConfig(targetDirectory = "target/tmp_rtl")
      .generateVerilog(new SpinalNNTop(params))

  // ── Small profile ─────────────────────────────────────────────────────────
  test("Small profile (6x6x1, flat) elaborates") {
    elaborate(Params.small)
  }

  test("Small profile (6x6x1, hierarchical) elaborates") {
    elaborate(Params.small.hierarchical)
  }

  // ── MNIST profile ─────────────────────────────────────────────────────────
  // Full Conv -> ReLU -> Pool -> Conv -> ReLU -> Pool -> Flatten -> Linear -> Softmax chain.
  test("MNIST profile (28x28x1, flat) elaborates") {
    elaborate(Params.mnist)
  }

  test("MNIST profile (28x28x1, hierarchical) elaborates") {
    elaborate(Params.mnist.hierarchical)
  }

  // ── WeightStream: MNIST with LPDDR4x weight streaming ─────────────────────
  // Verifies that WeightStream mode elaborates end-to-end: every conv/linear layer
  // gets a weight buffer instead of a ROM, and the WeightDmaPlugin is wired in.
  test("MNIST WeightStream (weight-streaming mode) elaborates") {
    val streamTarget = TargetConfig.default.withWeightMode(WeightStream)
    elaborate(Params.mnist.withTarget(streamTarget))
  }

  // ── SqueezeNet profile ──────────────────────────────────────────────────────
  // Pre-quantized ImageNet model: per-channel weight requant, uint8->int8 remap,
  // fire-module fan-out (StreamFork) + channel Concat, and GlobalAveragePool, all
  // at real (224x224x3 -> 1000-class) scale. Elaboration alone exercises the entire
  // backend wiring and every Core's address/width math; a full Verilator sim is
  // impractical here (billions of cycles). Skipped if the model asset is absent.
  test("SqueezeNet profile (224x224x3, flat) elaborates") {
    assume(new java.io.File("models/squeezenet1.0-12-int8.onnx").exists(),
      "models/squeezenet1.0-12-int8.onnx not present; skipping")
    elaborate(Params.squeezenet)
  }

  // ── SqueezeNet WeightStream + MemLineBuffer ────────────────────────────────
  // Target configuration for Ti180 fit: line buffers cut activation BRAM from
  // >1000 RAM10K to ~64, and weight streaming cuts weight BRAM from ~988 to ~26.
  // Combined budget should be well under Ti180's 378 RAM10K.
  test("SqueezeNet WeightStream+MemLineBuffer (Ti180 target) elaborates") {
    assume(new java.io.File("models/squeezenet1.0-12-int8.onnx").exists(),
      "models/squeezenet1.0-12-int8.onnx not present; skipping")
    val ti180Target = TargetConfig.default
      .withWeightMode(WeightStream)
      .withMemStrategy(MemLineBuffer)
    elaborate(Params.squeezenet.withTarget(ti180Target))
  }

  test("MobileNetV2 profile (224x224x3, flat) elaborates") {
    assume(new java.io.File("models/mobilenetv2-12-int8.onnx").exists(),
      "models/mobilenetv2-12-int8.onnx not present; skipping")
    elaborate(Params.mobilenetv2)
  }

  // ── MacParPerLayer ────────────────────────────────────────────────────────
  // First end-to-end validation of per-layer N assignment through IrBackend.
  // MNIST ONNX has two conv layers: conv1 (C_in=1, falls back to N=1) and
  // conv2 (C_in=8, assigned N=8). Uses WeightRom so there is no WeightStream
  // N=1 constraint to contend with.
  test("MNIST ONNX MacParPerLayer (conv2 N=8) elaborates") {
    import spinalnn.target.{MacParPerLayer, WeightRom}
    val perLayerTarget = TargetConfig.default
      .withMacPar(MacParPerLayer(Map("conv2" -> 8), default = 1))
    elaborate(Params.onnx.withTarget(perLayerTarget))
  }

  test("MNIST ONNX MacParFixed N=8 elaborates") {
    import spinalnn.target.MacParFixed
    val fixedTarget = TargetConfig.default.withMacPar(MacParFixed(8))
    elaborate(Params.onnx.withTarget(fixedTarget))
  }

  // ── WeightStream + MacParFixed(16) + dual-clock DMA ───────────────────────
  // Exercises the full Phase 2 stack: 512-bit beat DMA, N=16 lane drain in
  // QLinearConvCore, StreamFifoCC CDC bridges, and the dmaClk external pin.
  // This is the exact config we intend to submit to Efinity P&R.
  test("MNIST WeightStream + MacParFixed(16) + dmaFreq(300) elaborates") {
    import spinalnn.target.{MacParFixed, WeightStream}
    val target = TargetConfig.default
      .withWeightMode(WeightStream)
      .withMacPar(MacParFixed(16))
      .withDmaFreq(300)
    elaborate(Params.onnx.withTarget(target))
  }

  test("SqueezeNet WeightStream + MacParFixed(16) + dmaFreq(300) elaborates") {
    assume(new java.io.File("models/squeezenet1.0-12-int8.onnx").exists(),
      "models/squeezenet1.0-12-int8.onnx not present; skipping")
    import spinalnn.target.{MacParFixed, WeightStream}
    val target = TargetConfig.default
      .withWeightMode(WeightStream)
      .withMacPar(MacParFixed(16))
      .withDmaFreq(300)
      .withMemStrategy(spinalnn.target.MemLineBuffer)
    elaborate(Params.squeezenet.withTarget(target))
  }
}
