package spinalnn

import spinal.lib.misc.plugin._
import spinalnn.ops.activation.{ReLUCore, ReLUPlugin, SoftmaxCore, SoftmaxPlugin}
import spinalnn.ops.conv.{QLinearConvCore, QLinearConvPlugin}
import spinalnn.ops.input.InputPlugin
import spinalnn.ops.linear.{FlattenPlugin, QLinearLinearCore, QLinearLinearPlugin}
import spinalnn.ops.output.NetworkOutputPlugin
import spinalnn.ops.pool.{MaxPoolCore, MaxPoolPlugin}
import spinalnn.types._
import spinalnn.util._

// Network topology profiles. Add new profiles here as needed.
// The ONNX parser (Stage 5) will generate profiles directly from trained models,
// replacing the hand-coded configurations below.
sealed trait NetworkProfile
case object SmallProfile extends NetworkProfile   // 6x6x1 -- fast elaboration for tests
case object MnistProfile  extends NetworkProfile  // 28x28x1 -- full MNIST-scale topology
case object OnnxProfile   extends NetworkProfile  // Natively compiled MNIST ONNX model with full real weights
case object OnnxLogitsProfile extends NetworkProfile // OnnxProfile tapped at linear1 -- emits 10 raw INT8 logits (diagnostics)

// Central configuration. plugins() is a def -- fresh instances on every call.
case class Params(
  buildEnv: BuildEnv      = BuildEnv(),
  profile:  NetworkProfile = MnistProfile
) {
  def plugins: Seq[FiberPlugin] = profile match {
    case SmallProfile => Params.smallPlugins(buildEnv)
    case MnistProfile => Params.mnistPlugins(buildEnv)
    case OnnxProfile  => spinalnn.compiler.OnnxCompiler.compileModel("models/mnist-8.onnx", buildEnv)
    case OnnxLogitsProfile => spinalnn.compiler.OnnxCompiler.compileModel("models/mnist-8.onnx", buildEnv, emitLogits = true)
  }
}

object Params {
  def small = Params(profile = SmallProfile)
  def mnist = Params(profile = MnistProfile)
  def onnx  = Params(profile = OnnxProfile)
  def onnxLogits = Params(profile = OnnxLogitsProfile)

  // ── Small: 6x6x1 -> Conv3x3 -> Pool2x2 -> Linear -> Softmax ─────────────
  // Fast elaboration for CI and smoke tests.
  def smallPlugins(buildEnv: BuildEnv): Seq[FiberPlugin] = {
    val idQ         = QuantParams(1.0f, 0)
    val inputShape  = TensorShape(6, 6, 1)
    val conv1Shape  = TensorShape(4, 4, 1)
    val pool1Shape  = TensorShape(2, 2, 1)
    val flatShape   = TensorShape(1, 1, pool1Shape.size)

    val input   = InputPlugin(inputShape, buildEnv)
    val conv1   = QLinearConvPlugin(QLinearConvCore.Config(
      periphName = "conv1", inputShape = inputShape, outputShape = conv1Shape,
      kernelH = 3, kernelW = 3,
      inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
      weights = Array.fill(1 * 1 * 3 * 3)(0.toByte), biases = Array(0)
    ), input.activationOut, buildEnv)
    val relu1   = ReLUPlugin(ReLUCore.Config("relu1"), conv1Shape, conv1.activationOut, buildEnv)
    val pool1   = MaxPoolPlugin(MaxPoolCore.Config("pool1", conv1Shape, pool1Shape), relu1.activationOut, buildEnv)
    val flat    = FlattenPlugin(pool1Shape, pool1.activationOut, buildEnv)
    val linear1 = QLinearLinearPlugin(QLinearLinearCore.Config(
      periphName = "linear1", inNeurons = flatShape.channels, outNeurons = 4,
      inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
      weights = Array.fill(4 * flatShape.channels)(0.toByte), biases = Array.fill(4)(0)
    ), flat.activationOut, buildEnv)
    val softmax = SoftmaxPlugin(SoftmaxCore.Config("softmax", numClasses = 4), linear1.activationOut, buildEnv)

    Seq(input, conv1, relu1, pool1, flat, linear1, softmax,
        NetworkOutputPlugin(softmax.activationOut, TensorShape(1, 1, 1)),
        TopIoExportPlugin())
  }

  // ── MNIST: 28x28x1 -> Conv5x5x8 -> ReLU -> Pool -> Conv5x5x16 -> ReLU ->
  //          Pool -> Flatten -> Linear256x10 -> Softmax ─────────────────────
  // Full MNIST-scale CNN topology. Weights are zero-initialized here.
  // Stage 5 ONNX parser will replace this with weights from a trained model.
  def mnistPlugins(buildEnv: BuildEnv): Seq[FiberPlugin] = {
    val idQ = QuantParams(1.0f, 0)

    val inputShape = TensorShape(28, 28, 1)
    val conv1Shape = TensorShape(24, 24, 8)
    val pool1Shape = TensorShape(12, 12, 8)
    val conv2Shape = TensorShape(8,  8,  16)
    val pool2Shape = TensorShape(4,  4,  16)
    val flatSize   = pool2Shape.size   // 256

    val input = InputPlugin(inputShape, buildEnv)

    val conv1 = QLinearConvPlugin(QLinearConvCore.Config(
      periphName = "conv1", inputShape = inputShape, outputShape = conv1Shape,
      kernelH = 5, kernelW = 5,
      inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
      weights = Array.fill(8 * 1 * 5 * 5)(0.toByte), biases = Array.fill(8)(0)
    ), input.activationOut, buildEnv)

    val relu1 = ReLUPlugin(ReLUCore.Config("relu1"), conv1Shape, conv1.activationOut, buildEnv)

    val pool1 = MaxPoolPlugin(
      MaxPoolCore.Config("pool1", conv1Shape, pool1Shape), relu1.activationOut, buildEnv)

    val conv2 = QLinearConvPlugin(QLinearConvCore.Config(
      periphName = "conv2", inputShape = pool1Shape, outputShape = conv2Shape,
      kernelH = 5, kernelW = 5,
      inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
      weights = Array.fill(16 * 8 * 5 * 5)(0.toByte), biases = Array.fill(16)(0)
    ), pool1.activationOut, buildEnv)

    val relu2 = ReLUPlugin(ReLUCore.Config("relu2"), conv2Shape, conv2.activationOut, buildEnv)

    val pool2 = MaxPoolPlugin(
      MaxPoolCore.Config("pool2", conv2Shape, pool2Shape), relu2.activationOut, buildEnv)

    val flat = FlattenPlugin(pool2Shape, pool2.activationOut, buildEnv)

    val linear1 = QLinearLinearPlugin(QLinearLinearCore.Config(
      periphName = "linear1", inNeurons = flatSize, outNeurons = 10,
      inputQuant = idQ, weightQuant = idQ, outputQuant = idQ,
      weights = Array.fill(10 * flatSize)(0.toByte), biases = Array.fill(10)(0)
    ), flat.activationOut, buildEnv)

    val softmax = SoftmaxPlugin(
      SoftmaxCore.Config("softmax", numClasses = 10), linear1.activationOut, buildEnv)

    Seq(input, conv1, relu1, pool1, conv2, relu2, pool2, flat, linear1, softmax,
        NetworkOutputPlugin(softmax.activationOut, TensorShape(1, 1, 1)),
        TopIoExportPlugin())
  }
}
