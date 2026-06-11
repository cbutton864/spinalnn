package spinalnn.ops.add

import spinal.core._
import spinal.core.fiber._
import spinal.lib._
import spinal.lib.misc.plugin._
import spinalnn._
import spinalnn.types._
import spinalnn.util._

case class AddPlugin(
  cfg:         AddCore.Config,
  upstreamA:   Handle[Stream[Activation]],
  upstreamB:   Handle[Stream[Activation]],
  // When an input arrives early (e.g., a skip/residual path bypassing several conv
  // layers), it must be buffered so the StreamFork feeding it can drain without
  // waiting for the slower arm.  Set queueDepthA/B to the input tensor size for
  // the arm that arrives first; leave at 0 for the slower arm.
  queueDepthA: Int = 0,
  queueDepthB: Int = 0,
  buildEnv:    BuildEnv = BuildEnv()
) extends FiberPlugin with ActivationSource {

  val activationOut: Handle[Stream[Activation]] = Handle()
  val outputShape:   TensorShape                = cfg.shape

  val logic = during build new Area {
    val inA = if (queueDepthA > 0) upstreamA.await.queue(queueDepthA) else upstreamA.await
    val inB = if (queueDepthB > 0) upstreamB.await.queue(queueDepthB) else upstreamB.await
    val core = AddCore.build(cfg, inA, inB)
    activationOut.load(core.activationOut)
  }
}
