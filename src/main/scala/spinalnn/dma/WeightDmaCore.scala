package spinalnn.dma

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axi._

/**
 * AXI4 read master that streams per-channel weights from on-package LPDDR4x
 * to each WeightStream-mode layer's `weightIn` port.
 *
 * Sequencing: iterates layers in order. Within each layer iterates output
 * channels 0..outC-1. For each channel, issues one AXI4 burst and forwards
 * each AXI R beat verbatim as a `Stream[Bits(512 bits)]` fire — one fire per
 * beat, including any trailing padding beats. The consuming core is responsible
 * for ignoring bytes beyond `weightsPerChActual` (= K_H × K_W × C_in).
 *
 * AXI4 bus matches EFX_LPDDR4_32_V1: 512-bit data, 33-bit address, 6-bit ID.
 * One AXI beat = 64 bytes. Each channel's block in LPDDR4x must start on a
 * 64-byte boundary, so `baseAddr` and `weightsPerChStride` must be multiples of 64.
 * `weightsPerChActual` (= K_H × K_W × C_in) need not be aligned.
 */
object WeightDmaCore {

  /** AXI4 config matching one EFX_LPDDR4_32_V1 port. */
  val axiCfg: Axi4Config = Axi4Config(
    addressWidth = 33,
    dataWidth    = 512,
    idWidth      = 6,
    useId        = true,
    useRegion    = false,
    useBurst     = true,
    useLock      = false,
    useCache     = false,
    useSize      = true,
    useQos       = false,
    useLen       = true,
    useLast      = true,
    useResp      = true,
    useProt      = false,
    useStrb      = false
  )

  /**
   * Descriptor for one layer's weight layout in LPDDR4x.
   *
   * @param baseAddr           Byte address of the layer's weight block. Must be 64-byte-aligned.
   * @param weightsPerChActual Exact bytes per output channel = K_H × K_W × C_in.
   * @param weightsPerChStride Byte distance between successive channel blocks in memory
   *                           = ceil(weightsPerChActual / 64) × 64. Must be a multiple of 64.
   * @param numOutputCh        Number of output channels.
   */
  case class LayerDesc(
    baseAddr:           Long,
    weightsPerChActual: Int,
    weightsPerChStride: Int,
    numOutputCh:        Int
  ) {
    require(baseAddr >= 0 && baseAddr % 64 == 0,
      s"baseAddr $baseAddr must be non-negative and 64-byte-aligned")
    require(weightsPerChActual > 0,
      s"weightsPerChActual $weightsPerChActual must be positive")
    require(weightsPerChStride >= weightsPerChActual && weightsPerChStride % 64 == 0,
      s"weightsPerChStride $weightsPerChStride must be >= actual ($weightsPerChActual) and a multiple of 64")
    require(numOutputCh > 0, "numOutputCh must be positive")

    val beatsPerCh: Int = weightsPerChStride / 64
  }

  object LayerDesc {
    /** Convenience constructor: computes stride automatically from the actual byte count. */
    def apply(baseAddr: Long, weightsPerChActual: Int, numOutputCh: Int): LayerDesc =
      LayerDesc(
        baseAddr           = baseAddr,
        weightsPerChActual = weightsPerChActual,
        weightsPerChStride = ((weightsPerChActual + 63) / 64) * 64,
        numOutputCh        = numOutputCh
      )
  }

  /**
   * Instantiate the DMA controller in the current hardware area.
   *
   * Outputs one `Stream[Bits(512 bits)]` fire per AXI beat. Each channel issues
   * exactly `beatsPerCh` fires (including any trailing padding beats). The consuming
   * core decides which bytes within each beat are valid.
   *
   * @param layers    Per-layer weight descriptors (WeightStream layers only, in network order).
   * @param weightIns Corresponding `weightIn` streams from each layer's plugin.
   * @return          AXI4 read-only master port; connect to LPDDR4x.
   */
  def build(
    layers:    Seq[LayerDesc],
    weightIns: Seq[Stream[Bits]]
  ): Axi4ReadOnly = {
    require(layers.length == weightIns.length && layers.nonEmpty)

    val N        = layers.length
    val maxOutCh = layers.map(_.numOutputCh).max
    val maxBeats = layers.map(_.beatsPerCh).max

    // ── AXI4 master ──────────────────────────────────────────────────────────
    val axi = master(Axi4ReadOnly(axiCfg))
    axi.setName("weightDmaAxi")

    // ── Layer parameter tables (LUT ROMs, small) ──────────────────────────────
    val baseAddrTab = Vec(layers.map(l => U(l.baseAddr,           33 bits)))
    val wStrideTab  = Vec(layers.map(l => U(l.weightsPerChStride, log2Up(maxBeats * 64 + 1) bits)))
    val beatsTab    = Vec(layers.map(l => U(l.beatsPerCh,         log2Up(maxBeats + 1) bits)))
    val outChTab    = Vec(layers.map(l => U(l.numOutputCh,        log2Up(maxOutCh + 1) bits)))

    // ── FSM states ────────────────────────────────────────────────────────────
    val sAR        = U(0, 3 bits)
    val sWaitR     = U(1, 3 bits)
    val sBeatReady = U(2, 3 bits)
    val sNext      = U(3, 3 bits)

    val stateReg = Reg(UInt(3 bits)) init 0
    val layerReg = Reg(UInt(log2Up(N) bits)) init 0
    val chReg    = Reg(UInt(log2Up(maxOutCh + 1) bits)) init 0
    val beatReg  = Reg(UInt(log2Up(maxBeats + 1) bits)) init 0  // beats sent for current channel

    val beatBuf = Reg(Bits(512 bits)) init 0

    // Current layer parameters (combinatorial MUX).
    val curBase  = baseAddrTab(layerReg)
    val curStride = wStrideTab(layerReg)
    val curBeats = beatsTab(layerReg)
    val curOutCh = outChTab(layerReg)

    // ── Defaults ──────────────────────────────────────────────────────────────
    axi.ar.valid      := False
    axi.ar.payload.assignDontCare()
    axi.r.ready       := False
    for (s <- weightIns) { s.valid := False; s.payload := 0 }

    // ── sAR: issue AXI4 read request ──────────────────────────────────────────
    when(stateReg === sAR) {
      val chAddr  = (curBase + (chReg * curStride).resize(33)).resize(33)
      val beatsM1 = (curBeats - 1).resize(8)

      axi.ar.valid         := True
      axi.ar.payload.id    := 0
      axi.ar.payload.addr  := chAddr
      axi.ar.payload.len   := beatsM1
      axi.ar.payload.size  := U(6, 3 bits)   // 64 bytes / beat
      axi.ar.payload.burst := B"2'b01"        // INCR

      when(axi.ar.fire) {
        beatReg  := 0
        stateReg := sWaitR
      }
    }

    // ── sWaitR: wait for next AXI R beat ──────────────────────────────────────
    when(stateReg === sWaitR) {
      axi.r.ready := True
      when(axi.r.fire) {
        beatBuf  := axi.r.payload.data
        stateReg := sBeatReady
      }
    }

    // ── sBeatReady: forward the captured beat to the current layer's stream ───
    when(stateReg === sBeatReady) {
      for (i <- 0 until N) {
        when(layerReg === U(i, layerReg.getWidth bits)) {
          weightIns(i).valid   := True
          weightIns(i).payload := beatBuf
        }
      }

      val layerReady = (0 until N).map(i =>
        weightIns(i).ready && (layerReg === U(i, layerReg.getWidth bits))
      ).reduce(_ || _)

      when(layerReady) {
        beatReg := beatReg + 1
        when(beatReg === curBeats - 1) {
          stateReg := sNext
        } otherwise {
          stateReg := sWaitR
        }
      }
    }

    // ── sNext: advance channel / layer ────────────────────────────────────────
    when(stateReg === sNext) {
      val lastCh    = chReg === curOutCh - 1
      val lastLayer = layerReg === U(N - 1, layerReg.getWidth bits)

      chReg    := Mux(lastCh, U(0, chReg.getWidth bits), chReg + 1)
      layerReg := Mux(lastCh && lastLayer,  U(0, layerReg.getWidth bits),
                  Mux(lastCh,               layerReg + 1,
                                            layerReg))
      stateReg := sAR
    }

    axi
  }
}
