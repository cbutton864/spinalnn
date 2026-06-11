package spinalnn.ops.linear

import spinal.core._
import spinal.core.fiber._
import spinal.lib._
import spinal.lib.misc.plugin._
import spinalnn._
import spinalnn.target.WeightStream
import spinalnn.types._
import spinalnn.util._

case class QLinearLinearPlugin(
  cfg:      QLinearLinearCore.Config,
  upstream: Handle[Stream[Activation]],
  buildEnv: BuildEnv = BuildEnv()
) extends FiberPlugin with ActivationSource {

  val activationOut: Handle[Stream[Activation]] = Handle()
  val weightIn:      Handle[Stream[Bits]]        = Handle()
  val outputShape:   TensorShape                 = TensorShape(1, 1, cfg.outNeurons)

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
      val core = QLinearLinearCore.build(cfg, pulledStream)
      if (cfg.weightMode == WeightStream) coreWeightIn = core.weightIn
      outSig << core.activationOut
    }

    if (cfg.weightMode == WeightStream) weightIn.load(coreWeightIn)
    activationOut.load(outStream)
  }
}
