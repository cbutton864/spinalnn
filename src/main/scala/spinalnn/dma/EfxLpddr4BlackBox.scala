package spinalnn.dma

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axi._

/**
 * SpinalHDL BlackBox wrapping the Efinix FNX Titanium on-package LPDDR4x
 * controller primitive `EFX_LPDDR4_32_V1`.
 *
 * The primitive exposes two AXI4 slave ports (AXI0 and AXI1). This wrapper
 * presents both as SpinalHDL `Axi4` (full, bidirectional) bundles so the
 * rest of the design can connect to them.
 *
 * AXI4 parameters (per port):
 *   - Data width:    512 bits (64 bytes per beat)
 *   - Address width: 33 bits
 *   - ID width:      6 bits
 *
 * Usage:
 *   val lpddr = EfxLpddr4BlackBox()
 *   lpddr.io.axi0 <> weightDmaAxi
 *
 * For simulation (not targeting real hardware), use `EfxLpddr4Model` instead.
 */
class EfxLpddr4BlackBox extends BlackBox {

  // Match the Efinity IP library primitive name.
  setDefinitionName("EFX_LPDDR4_32_V1")

  val axiCfg = WeightDmaCore.axiCfg

  val io = new Bundle {

    // ── System ────────────────────────────────────────────────────────────────
    val clk      = in  Bool()  // AXI clock (same domain used by the rest of the design)
    val rst_n    = in  Bool()  // Active-low reset
    val init_done= out Bool()  // High when LPDDR4x calibration is complete

    // ── AXI4 Port 0 (slave — driven by the AXI master in the FPGA fabric) ────
    // Write address channel
    val axi0_awid    = in  UInt(6 bits)
    val axi0_awaddr  = in  UInt(33 bits)
    val axi0_awlen   = in  UInt(8 bits)
    val axi0_awsize  = in  UInt(3 bits)
    val axi0_awburst = in  Bits(2 bits)
    val axi0_awvalid = in  Bool()
    val axi0_awready = out Bool()

    // Write data channel
    val axi0_wdata   = in  Bits(512 bits)
    val axi0_wstrb   = in  Bits(64 bits)
    val axi0_wlast   = in  Bool()
    val axi0_wvalid  = in  Bool()
    val axi0_wready  = out Bool()

    // Write response channel
    val axi0_bid     = out UInt(6 bits)
    val axi0_bresp   = out Bits(2 bits)
    val axi0_bvalid  = out Bool()
    val axi0_bready  = in  Bool()

    // Read address channel
    val axi0_arid    = in  UInt(6 bits)
    val axi0_araddr  = in  UInt(33 bits)
    val axi0_arlen   = in  UInt(8 bits)
    val axi0_arsize  = in  UInt(3 bits)
    val axi0_arburst = in  Bits(2 bits)
    val axi0_arvalid = in  Bool()
    val axi0_arready = out Bool()

    // Read data channel
    val axi0_rid     = out UInt(6 bits)
    val axi0_rdata   = out Bits(512 bits)
    val axi0_rresp   = out Bits(2 bits)
    val axi0_rlast   = out Bool()
    val axi0_rvalid  = out Bool()
    val axi0_rready  = in  Bool()

    // ── AXI4 Port 1 (slave — identical structure) ─────────────────────────────
    val axi1_awid    = in  UInt(6 bits)
    val axi1_awaddr  = in  UInt(33 bits)
    val axi1_awlen   = in  UInt(8 bits)
    val axi1_awsize  = in  UInt(3 bits)
    val axi1_awburst = in  Bits(2 bits)
    val axi1_awvalid = in  Bool()
    val axi1_awready = out Bool()

    val axi1_wdata   = in  Bits(512 bits)
    val axi1_wstrb   = in  Bits(64 bits)
    val axi1_wlast   = in  Bool()
    val axi1_wvalid  = in  Bool()
    val axi1_wready  = out Bool()

    val axi1_bid     = out UInt(6 bits)
    val axi1_bresp   = out Bits(2 bits)
    val axi1_bvalid  = out Bool()
    val axi1_bready  = in  Bool()

    val axi1_arid    = in  UInt(6 bits)
    val axi1_araddr  = in  UInt(33 bits)
    val axi1_arlen   = in  UInt(8 bits)
    val axi1_arsize  = in  UInt(3 bits)
    val axi1_arburst = in  Bits(2 bits)
    val axi1_arvalid = in  Bool()
    val axi1_arready = out Bool()

    val axi1_rid     = out UInt(6 bits)
    val axi1_rdata   = out Bits(512 bits)
    val axi1_rresp   = out Bits(2 bits)
    val axi1_rlast   = out Bool()
    val axi1_rvalid  = out Bool()
    val axi1_rready  = in  Bool()
  }

  // Map the SpinalHDL clock/reset to the primitive's ports.
  mapClockDomain(clock = io.clk, reset = io.rst_n, resetActiveLevel = LOW)

  // ── Helper: wire a full Axi4 SpinalHDL bundle to AXI4 port 0 ───────────────
  def connectAxi0(axi: Axi4): Unit = {
    // AW
    io.axi0_awvalid := axi.aw.valid
    axi.aw.ready    := io.axi0_awready
    io.axi0_awid    := axi.aw.payload.id
    io.axi0_awaddr  := axi.aw.payload.addr
    io.axi0_awlen   := axi.aw.payload.len
    io.axi0_awsize  := axi.aw.payload.size
    io.axi0_awburst := axi.aw.payload.burst
    // W
    io.axi0_wvalid  := axi.w.valid
    axi.w.ready     := io.axi0_wready
    io.axi0_wdata   := axi.w.payload.data
    io.axi0_wstrb   := axi.w.payload.strb
    io.axi0_wlast   := axi.w.payload.last
    // B
    axi.b.valid        := io.axi0_bvalid
    io.axi0_bready     := axi.b.ready
    axi.b.payload.id   := io.axi0_bid
    axi.b.payload.resp := io.axi0_bresp
    // AR
    io.axi0_arvalid := axi.ar.valid
    axi.ar.ready    := io.axi0_arready
    io.axi0_arid    := axi.ar.payload.id
    io.axi0_araddr  := axi.ar.payload.addr
    io.axi0_arlen   := axi.ar.payload.len
    io.axi0_arsize  := axi.ar.payload.size
    io.axi0_arburst := axi.ar.payload.burst
    // R
    axi.r.valid        := io.axi0_rvalid
    io.axi0_rready     := axi.r.ready
    axi.r.payload.id   := io.axi0_rid
    axi.r.payload.data := io.axi0_rdata
    axi.r.payload.resp := io.axi0_rresp
    axi.r.payload.last := io.axi0_rlast
  }

  // ── Helper: wire a read-only Axi4 bundle to AXI4 port 0 ────────────────────
  // Write channels are tied to safe values (awvalid=0, wvalid=0, bready=1).
  def connectAxi0ReadOnly(axi: Axi4ReadOnly): Unit = {
    // Tie off write channels
    io.axi0_awvalid := False
    io.axi0_awid    := 0
    io.axi0_awaddr  := 0
    io.axi0_awlen   := 0
    io.axi0_awsize  := 0
    io.axi0_awburst := 0
    io.axi0_wvalid  := False
    io.axi0_wdata   := 0
    io.axi0_wstrb   := 0
    io.axi0_wlast   := False
    io.axi0_bready  := True
    // AR
    io.axi0_arvalid := axi.ar.valid
    axi.ar.ready    := io.axi0_arready
    io.axi0_arid    := axi.ar.payload.id
    io.axi0_araddr  := axi.ar.payload.addr
    io.axi0_arlen   := axi.ar.payload.len
    io.axi0_arsize  := axi.ar.payload.size
    io.axi0_arburst := axi.ar.payload.burst
    // R
    axi.r.valid        := io.axi0_rvalid
    io.axi0_rready     := axi.r.ready
    axi.r.payload.id   := io.axi0_rid
    axi.r.payload.data := io.axi0_rdata
    axi.r.payload.resp := io.axi0_rresp
    axi.r.payload.last := io.axi0_rlast
  }

  // ── Helper: wire a read-only Axi4 bundle to AXI4 port 1 ────────────────────
  def connectAxi1ReadOnly(axi: Axi4ReadOnly): Unit = {
    io.axi1_awvalid := False
    io.axi1_awid    := 0; io.axi1_awaddr  := 0; io.axi1_awlen   := 0
    io.axi1_awsize  := 0; io.axi1_awburst := 0
    io.axi1_wvalid  := False; io.axi1_wdata := 0; io.axi1_wstrb := 0
    io.axi1_wlast   := False; io.axi1_bready := True
    io.axi1_arvalid := axi.ar.valid
    axi.ar.ready    := io.axi1_arready
    io.axi1_arid    := axi.ar.payload.id
    io.axi1_araddr  := axi.ar.payload.addr
    io.axi1_arlen   := axi.ar.payload.len
    io.axi1_arsize  := axi.ar.payload.size
    io.axi1_arburst := axi.ar.payload.burst
    axi.r.valid        := io.axi1_rvalid
    io.axi1_rready     := axi.r.ready
    axi.r.payload.id   := io.axi1_rid
    axi.r.payload.data := io.axi1_rdata
    axi.r.payload.resp := io.axi1_rresp
    axi.r.payload.last := io.axi1_rlast
  }
}

object EfxLpddr4BlackBox {
  def apply(): EfxLpddr4BlackBox = new EfxLpddr4BlackBox()
}
