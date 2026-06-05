package spinalnn.ops.concat

import spinal.core._
import spinal.core.fiber._
import spinal.lib._
import spinal.lib.misc.plugin._
import spinalnn._
import spinalnn.types._
import spinalnn.util._

// Channel-wise concat plugin. This is the first fan-in operator: instead of a single
// `upstream` Handle, it takes a `Seq[Handle[Stream[Activation]]]` (one per branch) as a
// constructor argument -- the natural multi-input extension of the existing pattern.
// Producers wire their output Handles in directly, so the same plugin type can appear
// repeatedly (e.g. every SqueezeNet fire module) without trait ambiguity.
case class ConcatPlugin(
  cfg:       ConcatCore.Config,
  upstreams: Seq[Handle[Stream[Activation]]],
  buildEnv:  BuildEnv = BuildEnv()
) extends FiberPlugin with ActivationSource {

  val activationOut: Handle[Stream[Activation]] = Handle()
  val outputShape:   TensorShape                = cfg.outputShape

  val logic = during build new Area {
    val inStreams = upstreams.map(_.await)
    val hier      = buildEnv.useHierarchy(pluginDefault = false)

    val outStream = BuildHelper.buildBlock(
      HardType(Stream(Activation())),
      hier,
      s"${cfg.periphName}_Comp",
      inStreams
    ) { pulledStreams => outSig =>
      val core = ConcatCore.build(cfg, pulledStreams)
      outSig << core.activationOut
    }

    activationOut.load(outStream)
  }
}
