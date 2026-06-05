package spinalnn.ops.activation

import spinal.core._
import spinal.core.fiber._
import spinal.lib._
import spinal.lib.misc.plugin._
import spinalnn._
import spinalnn.types._
import spinalnn.util._

case class ReLUPlugin(
  cfg:      ReLUCore.Config,
  shape:    TensorShape,
  upstream: Handle[Stream[Activation]],
  buildEnv: BuildEnv = BuildEnv()
) extends FiberPlugin with ActivationSource {

  val activationOut: Handle[Stream[Activation]] = Handle()
  val outputShape:   TensorShape                = shape

  val logic = during build new Area {
    val inStream = upstream.await
    val hier     = buildEnv.useHierarchy(pluginDefault = false)

    val outStream = BuildHelper.buildBlock(
      HardType(Stream(Activation())),
      hier,
      s"${cfg.periphName}_Comp",
      inStream
    ) { pulledStream => outSig =>
      val core = ReLUCore.build(cfg, pulledStream)
      outSig << core.activationOut
    }

    activationOut.load(outStream)
  }
}
