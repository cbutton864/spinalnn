package spinalnn.ops.linear

import spinal.core._
import spinal.core.fiber._
import spinal.lib._
import spinal.lib.misc.plugin._
import spinalnn._
import spinalnn.types._
import spinalnn.util._

// Flatten: reshapes a H x W x C feature map to a 1D tensor of size H*W*C.
// Zero RTL -- the data stream is already in HWC order so no reordering is needed.
// This plugin only updates the shape descriptor so downstream operators know
// the tensor is one-dimensional.
case class FlattenPlugin(
  shape:    TensorShape,
  upstream: Handle[Stream[Activation]],
  buildEnv: BuildEnv = BuildEnv()
) extends FiberPlugin with ActivationSource {

  val activationOut: Handle[Stream[Activation]] = Handle()
  val outputShape:   TensorShape                = TensorShape(1, 1, shape.size)

  val logic = during build new Area {
    activationOut.load(upstream.await)
  }
}
