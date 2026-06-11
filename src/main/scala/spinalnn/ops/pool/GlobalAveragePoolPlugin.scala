package spinalnn.ops.pool

import spinal.core._
import spinal.core.fiber._
import spinal.lib._
import spinal.lib.misc.plugin._
import spinalnn._
import spinalnn.types._
import spinalnn.util._

// GlobalAveragePool plugin. Like the other operator plugins it receives its upstream
// activation stream by constructor injection (not host[ActivationSource]), so several
// pooling layers can coexist in one design. Produces a 1x1xC activation stream.
case class GlobalAveragePoolPlugin(
  cfg:      GlobalAveragePoolCore.Config,
  upstream: Handle[Stream[Activation]],
  buildEnv: BuildEnv = BuildEnv()
) extends FiberPlugin with ActivationSource {

  val activationOut: Handle[Stream[Activation]] = Handle()
  val outputShape:   TensorShape                = cfg.outputShape

  val logic = during build new Area {
    val inStream = upstream.await
    val hier     = buildEnv.useHierarchy(pluginDefault = false)

    val outStream = BuildHelper.buildBlock(
      HardType(Stream(Activation())),
      hier,
      s"${cfg.periphName}_Comp",
      inStream
    ) { pulledStream => outSig =>
      val core = GlobalAveragePoolCore.build(cfg, pulledStream)
      outSig << core.activationOut
    }

    activationOut.load(outStream)
  }
}
