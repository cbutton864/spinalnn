package spinalnn.ops.conv

import spinal.core._
import spinal.core.fiber._
import spinal.lib._
import spinal.lib.misc.plugin._
import spinalnn._
import spinalnn.target.WeightStream
import spinalnn.types._
import spinalnn.util._

// INT8 convolution plugin. Upstream activation stream is injected via the
// constructor rather than host[ActivationSource], allowing multiple Conv
// layers in one design without trait ambiguity.
case class QLinearConvPlugin(
  cfg:      QLinearConvCore.Config,
  upstream: Handle[Stream[Activation]],
  buildEnv: BuildEnv = BuildEnv()
) extends FiberPlugin with ActivationSource {

  val activationOut: Handle[Stream[Activation]] = Handle()
  val weightIn:      Handle[Stream[Bits]]        = Handle()
  val outputShape:   TensorShape                 = cfg.outputShape

  val logic = during build new Area {
    val inStream = upstream.await
    val hier     = buildEnv.useHierarchy(pluginDefault = false)

    var coreWeightIn: Stream[Bits] = null
    val outStream = BuildHelper.buildBlock(
      HardType(Stream(Activation())),
      hier,
      s"${cfg.periphName}_Comp",
      inStream
    ) { pulledStream => outSig =>
      val core = QLinearConvCore.build(cfg, pulledStream)
      if (cfg.weightMode == WeightStream) coreWeightIn = core.weightIn
      outSig << core.activationOut
    }

    if (cfg.weightMode == WeightStream) weightIn.load(coreWeightIn)
    activationOut.load(outStream)
  }
}
