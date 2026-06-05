package spinalnn.ops.output

import spinal.core._
import spinal.core.fiber._
import spinal.lib._
import spinal.lib.misc.plugin._
import spinalnn._
import spinalnn.types._

// Terminal plugin. Marks the final layer's output stream as the network result.
// Always the last plugin before TopIoExportPlugin. Zero RTL -- pure Handle wiring.
// Implemented by exactly one plugin per design so host[NetworkOutput] is unambiguous.
case class NetworkOutputPlugin(
  upstream:    Handle[Stream[Activation]],
  outputShape: TensorShape
) extends FiberPlugin with NetworkOutput {

  val networkOut: Handle[Stream[Activation]] = Handle()

  val logic = during build new Area {
    networkOut.load(upstream.await)
  }
}
