package spinalnn.ops.sc

import spinal.core._
import spinal.core.fiber._
import spinal.lib._
import spinal.lib.misc.plugin._
import spinalnn._
import spinalnn.target.WeightStream
import spinalnn.types._
import spinalnn.util._

// Stochastic-computing conv plugin.  Wraps StochasticConvCore in the FiberPlugin
// system so IrBackend can drop it in wherever a Conv layer appears when
// WeightStochastic precision is selected.
// WeightStream mode: weightIn handle is exposed for DMA loading of packed weight bytes.
// WeightRom mode: no weightIn handle; weights are ROM'd at elaboration time.
case class StochasticConvPlugin(
  cfg:      StochasticConvCore.Config,
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
      val core = StochasticConvCore.build(cfg, pulledStream)
      if (cfg.weightMode == WeightStream) coreWeightIn = core.weightIn
      outSig << core.activationOut
    }

    if (cfg.weightMode == WeightStream) weightIn.load(coreWeightIn)
    activationOut.load(outStream)
  }
}
