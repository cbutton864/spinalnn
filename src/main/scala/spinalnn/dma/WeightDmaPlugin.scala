package spinalnn.dma

import spinal.core._
import spinal.core.fiber.Handle
import spinal.lib._
import spinal.lib.misc.plugin.FiberPlugin
import spinalnn.dma.WeightDmaCore.LayerDesc

/**
 * Plugin wrapper for [[WeightDmaCore]].
 *
 * Collects `weightIn` stream handles from all WeightStream-mode layers,
 * builds the DMA controller, and exposes an AXI4 read-only master port
 * that becomes a top-level IO on the enclosing Component.
 *
 * All logic runs in the inference clock domain. The LPDDR4x AXI user port
 * is connected at the same frequency — bandwidth headroom is large enough
 * (9.6 GB/s available vs ~2.4 GB/s peak demand at N=16) that a separate
 * DMA clock domain buys nothing and would add per-layer StreamFifoCC cost.
 *
 * @param weightInHandles  Per-layer `weightIn` Handle (from each layer's plugin).
 * @param layerDescs       Per-layer weight layout in LPDDR4x (parallel to handles).
 * @param dmaFreqMhz       Retained for API compatibility; currently unused.
 */
case class WeightDmaPlugin(
  weightInHandles: Seq[Handle[Stream[Bits]]],
  layerDescs:      Seq[LayerDesc],
  dmaFreqMhz:      Option[Int] = None
) extends FiberPlugin {

  require(weightInHandles.length == layerDescs.length && weightInHandles.nonEmpty,
    "WeightDmaPlugin: handles and descs must have the same positive length")

  val logic = during build new Area {
    val streams: Seq[Stream[Bits]] = weightInHandles.map(_.await)
    WeightDmaCore.build(layerDescs, streams)
  }
}
