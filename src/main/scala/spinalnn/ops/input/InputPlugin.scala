package spinalnn.ops.input

import spinal.core._
import spinal.core.fiber._
import spinal.lib._
import spinal.lib.misc.plugin._
import spinalnn._
import spinalnn.types._
import spinalnn.util._

// Entry point plugin. Receives activations from top-level IO pads and makes
// them available to downstream layers via ActivationSource.
// Does NOT implement NetworkOutput -- NetworkOutputPlugin handles that at the
// end of the chain, keeping host[NetworkOutput] unambiguous in all configs.
case class InputPlugin(
  shape:    TensorShape,
  buildEnv: BuildEnv = BuildEnv()
) extends FiberPlugin with InferenceInput with ActivationSource {

  val activationIn:  Handle[Stream[Activation]] = Handle()
  val activationOut: Handle[Stream[Activation]] = Handle()
  val outputShape:   TensorShape                = shape

  val logic = during build new Area {
    val inStream = activationIn.await
    activationOut.load(inStream)
  }
}
