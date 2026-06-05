package spinalnn.compiler

import spinal.core.fiber.Handle
import spinal.lib.Stream
import spinal.lib.misc.plugin.FiberPlugin
import spinalnn.TopIoExportPlugin
import spinalnn.ops.activation.{ReLUCore, ReLUPlugin, SoftmaxCore, SoftmaxPlugin}
import spinalnn.ops.conv.{QLinearConvCore, QLinearConvPlugin}
import spinalnn.ops.input.InputPlugin
import spinalnn.ops.linear.{FlattenPlugin, QLinearLinearCore, QLinearLinearPlugin}
import spinalnn.ops.output.NetworkOutputPlugin
import spinalnn.ops.pool.{MaxPoolCore, MaxPoolPlugin}
import spinalnn.types._
import spinalnn.util._

import scala.collection.mutable

/** Turns a `Seq[LayerSpec]` (from `OnnxFrontend`) into the concrete plugin graph.
  *
  * This is pure wiring -- no math. A symbol table maps each IR layer name to the
  * producing plugin's output `Handle`; every op resolves its upstream from the table
  * by name. The `match` below is the operator-dispatch registry: to support a new
  * ONNX operator, add a `LayerSpec` case class and one case here. Nothing else changes.
  */
object IrBackend {

  def build(specs: Seq[LayerSpec], buildEnv: BuildEnv): Seq[FiberPlugin] = {
    val outs    = mutable.Map[String, Handle[Stream[Activation]]]()
    val plugins = mutable.ArrayBuffer[FiberPlugin]()

    def up(name: String): Handle[Stream[Activation]] =
      outs.getOrElse(name, throw new NoSuchElementException(s"unresolved upstream '$name'"))

    specs.foreach {
      case s: LayerSpec.Input =>
        val p = InputPlugin(s.shape, buildEnv)
        plugins += p; outs(s.name) = p.activationOut

      case s: LayerSpec.Conv =>
        val p = QLinearConvPlugin(QLinearConvCore.Config(
          periphName  = s.name,
          inputShape  = s.inputShape,
          outputShape = s.shape,
          kernelH     = s.kernelH,
          kernelW     = s.kernelW,
          strideH     = s.strideH,
          strideW     = s.strideW,
          padTop      = s.padTop,
          padBottom   = s.padBottom,
          padLeft     = s.padLeft,
          padRight    = s.padRight,
          inputQuant  = s.inputQuant,
          weightQuant = s.weightQuant,
          outputQuant = s.outputQuant,
          weights     = s.weights,
          biases      = s.biases
        ), up(s.input), buildEnv)
        plugins += p; outs(s.name) = p.activationOut

      case s: LayerSpec.Relu =>
        val p = ReLUPlugin(ReLUCore.Config(s.name), s.shape, up(s.input), buildEnv)
        plugins += p; outs(s.name) = p.activationOut

      case s: LayerSpec.MaxPool =>
        val p = MaxPoolPlugin(MaxPoolCore.Config(
          s.name, s.inputShape, s.shape, s.poolH, s.poolW, s.strideH, s.strideW), up(s.input), buildEnv)
        plugins += p; outs(s.name) = p.activationOut

      case s: LayerSpec.Flatten =>
        val p = FlattenPlugin(s.inputShape, up(s.input), buildEnv)
        plugins += p; outs(s.name) = p.activationOut

      case s: LayerSpec.Linear =>
        val p = QLinearLinearPlugin(QLinearLinearCore.Config(
          periphName  = s.name,
          inNeurons   = s.inNeurons,
          outNeurons  = s.outNeurons,
          inputQuant  = s.inputQuant,
          weightQuant = s.weightQuant,
          outputQuant = s.outputQuant,
          weights     = s.weights,
          biases      = s.biases
        ), up(s.input), buildEnv)
        plugins += p; outs(s.name) = p.activationOut

      case s: LayerSpec.Softmax =>
        val p = SoftmaxPlugin(SoftmaxCore.Config(s.name, s.numClasses), up(s.input), buildEnv)
        plugins += p; outs(s.name) = p.activationOut

      case s: LayerSpec.Output =>
        plugins += NetworkOutputPlugin(up(s.input), s.shape)
    }

    plugins += TopIoExportPlugin()
    plugins.toSeq
  }
}
