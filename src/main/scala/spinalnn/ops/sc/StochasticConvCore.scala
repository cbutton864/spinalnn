package spinalnn.ops.sc

import spinal.core._
import spinal.lib._
import spinalnn.target.{WeightMode, WeightRom, WeightStream}
import spinalnn.types._
import spinalnn.util.PrefixArea

/** Stochastic-computing 2-D convolution core (Phase B, B11 line-buffer).
  *
  * Reference architecture: MUX-MAC (Lee et al. 2024 "SC CNN Reinvented").
  * Each weight × activation pair uses one AND gate per SC cycle; signed popcount
  * over `bitstreamLen` cycles approximates the integer dot product.  Zero MAC DSPs.
  *
  * MACFG implementation: one root LFSR per SNG type feeds a shift-register chain.
  * Lane b samples the root LFSR value from b cycles ago (O(1) feedback logic vs
  * the naive O(nMac) independent LFSRs).  MUX-MAC comparison bits are registered
  * outside the FSM so CountOne runs on stable values — no synthesis retiming.
  * Accurate for nMac ≤ 255 (LFSR period); degrades gracefully above that.
  *
  * Representation
  * ──────────────
  *  Weights (INT8 → SC):
  *    threshold = min(|w|×2, 254) ∈ [0,254]
  *    P(wBit=1) ≈ |w|/127  (LFSR chain, period 255, per-lane phase offset)
  *  Activations (INT8 → SC):
  *    threshold = x + 128  (shift to unsigned [0,255])
  *    P(aBit=1) = threshold/255  (LFSR chain, independent root seed)
  *
  * Signed accumulation each SC cycle
  * ────────────────────────────────────
  *  posBit(b) = wBit(b) AND aBit(b)   when w_b >= 0
  *  negBit(b) = wBit(b) AND aBit(b)   when w_b <  0
  *  cycleDelta = CountOne(posBits) − CountOne(negBits)
  *  sc_acc += cycleDelta
  *
  * Expected value after L cycles:
  *  E[sc_acc] ≈ (Σ_b w_b×x_b + bias_b) × scScale + residual
  *  where scScale = L×2/255²
  *
  * B11 Line-Buffer Architecture
  * ─────────────────────────────
  *  Replaces the full-frame actBuf = Mem(SInt(8 bits), paddedH×paddedW×C_in) with
  *  K_H narrow row Mems each of depth paddedW×C_in.  BRAM reduction ≈ H/K_H.
  *  One write port per slot (sInit and sReceiveRow muxed) enables RAM10K inference.
  *
  * FSM
  * ───
  *  sInit       (only if hasPadding) → zero-fill K_H row bufs
  *  sReceiveRow → receive one input row; advance circular write pointer;
  *                when enough rows buffered, enter compute sequence
  *  [sLoadW]    (WeightStream only) → stream packed weight bytes for one oc
  *  sLoad       (nMac+1 cycles) → load per-lane activation thresholds from
  *               circular row buf; load weights from ROM or WeightStream regs
  *  sSC         (bitstreamLen cycles) → run parallel MUX-MAC; accumulate
  *  sDecode     (1+ cycles, stalls on backpressure) → scale/clamp/emit INT8;
  *               advance to next oc/column; when last column, receive next rows
  *
  * Output ordering: HWC channel-innermost.
  */
object StochasticConvCore {

  // ── Config ────────────────────────────────────────────────────────────────
  case class Config(
    periphName:   String,
    inputShape:   TensorShape,
    outputShape:  TensorShape,
    kernelH:      Int,
    kernelW:      Int,
    strideH:      Int        = 1,
    strideW:      Int        = 1,
    padTop:       Int        = 0,
    padBottom:    Int        = 0,
    padLeft:      Int        = 0,
    padRight:     Int        = 0,
    inputQuant:   QuantParams,
    weightQuant:  QuantParams,
    outputQuant:  QuantParams,
    weights:      Array[Byte],   // layout: [C_out, kH, kW, C_in] — C_in innermost
    biases:       Array[Int],
    bitstreamLen: Int        = 255,
    weightMode:   WeightMode = WeightRom
  ) {
    require(bitstreamLen >= 16 && bitstreamLen <= 1024,
      s"bitstreamLen must be in [16,1024], got $bitstreamLen")

    val C_out = outputShape.channels
    val C_in  = inputShape.channels
    val nMac  = kernelH * kernelW * C_in

    require(weights.length == C_out * nMac,
      s"weights.length ${weights.length} != C_out×nMac ($C_out×$nMac=${C_out*nMac})")
    require(biases.length == C_out)

    val paddedH:    Int     = inputShape.rows  + padTop  + padBottom
    val paddedW:    Int     = inputShape.cols  + padLeft + padRight
    val paddedSize: Int     = paddedH * paddedW * C_in  // kept for DMA compat
    val hasPadding: Boolean = (padTop | padBottom | padLeft | padRight) != 0

    require(outputShape.rows == (paddedH - kernelH) / strideH + 1,
      s"outputShape.rows ${outputShape.rows} ≠ (${paddedH}-${kernelH})/${strideH}+1")
    require(outputShape.cols == (paddedW - kernelW) / strideW + 1,
      s"outputShape.cols ${outputShape.cols} ≠ (${paddedW}-${kernelW})/${strideW}+1")

    // Row buffer depth: one padded row per slot
    val rowBufDepth: Int = paddedW * C_in

    // Per-lane decomposition (compile-time).
    // kKh(b)    = kernel row index (selects circular slot)
    // kRowOff(b) = within-row byte offset = kw*C_in + cin
    val kKh:     Array[Int] = Array.tabulate(nMac)(b => b / (kernelW * C_in))
    val kRowOff: Array[Int] = Array.tabulate(nMac) { b =>
      (b / C_in) % kernelW * C_in + b % C_in
    }

    // Weight threshold ROM (flat, index = oc × nMac + b).
    lazy val wThrFlat: Array[Int] = Array.tabulate(C_out * nMac) { idx =>
      scala.math.min(scala.math.abs(weights(idx).toInt) * 2, 254)
    }

    // Weight sign ROM (flat, index = oc × nMac + b).  True = non-negative.
    lazy val wSignFlat: Array[Boolean] = Array.tabulate(C_out * nMac) { idx =>
      weights(idx).toInt >= 0
    }

    val scScale:  Double = bitstreamLen.toDouble * 2.0 / (255.0 * 255.0)
    val M:        Double = inputQuant.scale.toDouble * weightQuant.scale.toDouble / outputQuant.scale.toDouble
    val decodeDs: Double = M / scScale

    private val (dm, ds): (Long, Int) = {
      var v = decodeDs; var sh = 0
      while (scala.math.abs(v) < (1L << 20) && sh < 48) { v *= 2.0; sh += 1 }
      (scala.math.round(v), sh)
    }
    val decodeMult:  Long = dm.max(1L)
    val decodeShift: Int  = ds

    val combAdjFlat: Array[Int] = Array.tabulate(C_out) { oc =>
      val wSum = (0 until nMac).map(b => weights(oc * nMac + b).toInt).sum.toDouble
      scala.math.round(scScale * (biases(oc).toDouble - 128.0 * wSum)).toInt
    }

    val stepsPerBeat:  Int = 64
    val weightsStride: Int = ((nMac + 63) / 64) * 64
  }

  // ── Io ────────────────────────────────────────────────────────────────────
  case class Io(activationOut: Stream[Activation], weightIn: Stream[Bits] = null)

  // ── build ─────────────────────────────────────────────────────────────────
  def build(cfg: Config, activationIn: Stream[Activation]): Io = {
    val logic = new PrefixArea(cfg.periphName) {

      val K_H     = cfg.kernelH
      val nMac    = cfg.nMac
      val L       = cfg.bitstreamLen
      val C_out   = cfg.C_out
      val cntBits = log2Up(nMac + 1)
      val maxAcc  = nMac.toLong * L
      val accBits = log2Up(maxAcc.toInt + 1) + 2

      val slotBits       = log2Up(K_H max 2)
      val rowBufABits    = log2Up(cfg.rowBufDepth + 1)  // counter width (holds 0..depth)
      val rowBufMemABits = log2Up(cfg.rowBufDepth max 2) // Mem address width (exactly log2Up(depth))

      // ── FSM states ──────────────────────────────────────────────────────
      val sReceiveRow = U(0, 3 bits)
      val sInit       = U(1, 3 bits)
      val sLoad       = U(2, 3 bits)
      val sSC         = U(3, 3 bits)
      val sDecode     = U(4, 3 bits)
      val sLoadW      = U(5, 3 bits)

      val stateReg = Reg(UInt(3 bits)) init (if (cfg.hasPadding) 1 else 0)
      stateReg.setName(s"${cfg.periphName}_state")

      // circNext: (ptr + 1) % K_H
      def circNext(ptr: UInt): UInt =
        if (K_H == 1) U(0, slotBits bits)
        else Mux(ptr === U(K_H - 1, slotBits bits),
                 U(0, slotBits bits),
                 (ptr + 1).resize(slotBits))

      // ── K_H row Mems: one slot = one padded row ──────────────────────────
      // Single write port per Mem (sInit and sReceiveRow muxed) for RAM10K.
      val rowBufs: Seq[Mem[SInt]] = Seq.tabulate(K_H) { slot =>
        val m = Mem(SInt(8 bits), cfg.rowBufDepth)
        m.setName(s"${cfg.periphName}_rowBuf_$slot")
        m
      }

      // ── Weight ROMs (WeightRom only) ─────────────────────────────────────
      val wThrRom = if (cfg.weightMode == WeightRom) {
        val m = Mem(UInt(8 bits), C_out * nMac)
        m.setName(s"${cfg.periphName}_wThrRom")
        m.initBigInt(cfg.wThrFlat.map(BigInt(_))); m
      } else null

      val wSignRom = if (cfg.weightMode == WeightRom) {
        val m = Mem(Bool(), C_out * nMac)
        m.setName(s"${cfg.periphName}_wSignRom")
        m.initBigInt(cfg.wSignFlat.map(b => if (b) BigInt(1) else BigInt(0))); m
      } else null

      val combAdjRom = Mem(SInt(32 bits), C_out)
      combAdjRom.setName(s"${cfg.periphName}_combAdjRom")
      combAdjRom.initBigInt(cfg.combAdjFlat.map(BigInt(_)), allowNegative = true)

      // ── WeightStream registers ────────────────────────────────────────────
      val weightIn: Stream[Bits] = if (cfg.weightMode == WeightStream) {
        val s = Stream(Bits(512 bits))
        s.setName(s"${cfg.periphName}_weightIn"); s
      } else null

      val wsBeatBuf: Bits = if (cfg.weightMode == WeightStream) {
        val r = Reg(Bits(512 bits)) init 0
        r.setName(s"${cfg.periphName}_wsBeatBuf"); r
      } else null

      val wsStep: UInt = if (cfg.weightMode == WeightStream) {
        val r = Reg(UInt(log2Up(nMac + 1) bits)) init 0
        r.setName(s"${cfg.periphName}_wsStep"); r
      } else null

      val wsBeatDrain: Bool = if (cfg.weightMode == WeightStream) {
        val r = Reg(Bool()) init False
        r.setName(s"${cfg.periphName}_wsBeatDrain"); r
      } else null

      val wsBeatStep: UInt = if (cfg.weightMode == WeightStream) {
        val r = Reg(UInt(log2Up(cfg.stepsPerBeat + 1) bits)) init 0
        r.setName(s"${cfg.periphName}_wsBeatStep"); r
      } else null

      // ── MACFG ────────────────────────────────────────────────────────────
      val wRootLfsr = Reg(UInt(8 bits)) init 1
      val aRootLfsr = Reg(UInt(8 bits)) init 129
      wRootLfsr.setName(s"${cfg.periphName}_wRootLfsr")
      aRootLfsr.setName(s"${cfg.periphName}_aRootLfsr")
      wRootLfsr := StochasticNumberGenerator.nextState(wRootLfsr)
      aRootLfsr := StochasticNumberGenerator.nextState(aRootLfsr)

      val wLfsrChain = Vec.fill(nMac)(Reg(UInt(8 bits)) init 0)
      val aLfsrChain = Vec.fill(nMac)(Reg(UInt(8 bits)) init 0)
      wLfsrChain(0) := wRootLfsr
      aLfsrChain(0) := aRootLfsr
      for (b <- 1 until nMac) {
        wLfsrChain(b) := wLfsrChain(b - 1)
        aLfsrChain(b) := aLfsrChain(b - 1)
      }

      val activThresh = Vec.fill(nMac)(Reg(UInt(8 bits)) init 128)
      val wThrRegs    = Vec.fill(nMac)(Reg(UInt(8 bits)) init 0)
      val wSignRegs   = Vec.fill(nMac)(Reg(Bool())       init True)

      val sc_acc     = Reg(SInt(accBits bits)) init 0
      val combAdjReg = Reg(SInt(32 bits)) init 0
      sc_acc.setName(s"${cfg.periphName}_scAcc")

      val posBitRegs = Vec.fill(nMac)(Reg(Bool()) init False)
      val negBitRegs = Vec.fill(nMac)(Reg(Bool()) init False)
      for (b <- 0 until nMac) {
        val mBit = (wLfsrChain(b) < wThrRegs(b)) && (aLfsrChain(b) < activThresh(b))
        posBitRegs(b) := mBit &&  wSignRegs(b)
        negBitRegs(b) := mBit && !wSignRegs(b)
      }
      val posCount = CountOne(posBitRegs).resize(cntBits + 1).asSInt
      val negCount = CountOne(negBitRegs).resize(cntBits + 1).asSInt

      // ── Row-buffer circular-pointer registers ─────────────────────────────
      // rowWrPtrReg:          slot currently being written (0..K_H-1)
      // rowsUntilComputeReg:  rows still needed before next output row compute
      // realRowsRecvReg:      real input rows received this frame
      // oldestSlotReg:        slot for kh=0 — set when entering compute
      //                       = circNext(rowWrPtrReg) at the moment the row done
      //                         triggers compute (i.e. just-written slot + 1)
      val rowWrPtrReg = Reg(UInt(slotBits bits)) init (cfg.padTop % (K_H max 1))
      rowWrPtrReg.setName(s"${cfg.periphName}_rowWrPtrReg")

      val rowsUntilComputeReg = Reg(UInt(log2Up(K_H + 2) bits)) init (K_H - cfg.padTop)
      rowsUntilComputeReg.setName(s"${cfg.periphName}_rowsUntilComputeReg")

      val realRowsRecvReg = Reg(UInt(log2Up(cfg.inputShape.rows + 1) bits)) init 0
      realRowsRecvReg.setName(s"${cfg.periphName}_realRowsRecvReg")

      val oldestSlotReg = Reg(UInt(slotBits bits)) init 0
      oldestSlotReg.setName(s"${cfg.periphName}_oldestSlotReg")

      // ── Receive counters ──────────────────────────────────────────────────
      val rxAddrReg = Reg(UInt(rowBufABits bits)) init (cfg.padLeft * cfg.C_in)
      rxAddrReg.setName(s"${cfg.periphName}_rxAddrReg")
      val rxEnd = U(cfg.padLeft * cfg.C_in + cfg.inputShape.cols * cfg.C_in - 1, rowBufABits bits)

      // ── sInit counters (only when hasPadding) ─────────────────────────────
      val initSlotReg: UInt = if (cfg.hasPadding) {
        val r = Reg(UInt(slotBits bits)) init 0
        r.setName(s"${cfg.periphName}_initSlotReg"); r
      } else null

      val initAddrReg: UInt = if (cfg.hasPadding) {
        val r = Reg(UInt(rowBufABits bits)) init 0
        r.setName(s"${cfg.periphName}_initAddrReg"); r
      } else null

      // ── Compute counters ──────────────────────────────────────────────────
      val ocReg     = Reg(UInt(log2Up(C_out + 1) bits)) init 0
      val outHReg   = Reg(UInt(log2Up(cfg.outputShape.rows + 1) bits)) init 0
      val outWReg   = Reg(UInt(log2Up(cfg.outputShape.cols + 1) bits)) init 0
      val loadStep  = Reg(UInt(log2Up(nMac + 2) bits)) init 0
      val scStep    = Reg(UInt(log2Up(L + 1) bits)) init 0
      val wAddrBase = Reg(UInt(log2Up(C_out * nMac + 1) bits)) init 0

      ocReg.setName(s"${cfg.periphName}_ocReg")
      outHReg.setName(s"${cfg.periphName}_outHReg")
      outWReg.setName(s"${cfg.periphName}_outWReg")
      loadStep.setName(s"${cfg.periphName}_loadStep")
      wAddrBase.setName(s"${cfg.periphName}_wAddrBase")

      // colBaseReg = outWReg × strideW × C_in; updated in sDecode to avoid runtime multiplier
      val colBaseReg = Reg(UInt(rowBufABits bits)) init 0
      colBaseReg.setName(s"${cfg.periphName}_colBaseReg")

      // ── Output stream ─────────────────────────────────────────────────────
      val activationOut = Stream(Activation())
      activationOut.setName(s"${cfg.periphName}_activationOut")
      activationOut.valid         := False
      activationOut.payload.value := S(0, 8 bits)

      activationIn.ready := False
      if (cfg.weightMode == WeightStream) { weightIn.ready := False }

      // ── Row buf unified write ports (one write() per slot → RAM10K infer) ─
      // Mux sInit vs sReceiveRow address and data; enables OR'd.
      val isReal  = realRowsRecvReg < U(cfg.inputShape.rows)
      val rxStep  = (isReal && activationIn.fire) || !isReal
      val rxWData = Mux(isReal, activationIn.payload.value, S(0, 8 bits))

      for (slot <- 0 until K_H) {
        val doInit: Bool =
          if (cfg.hasPadding) (stateReg === sInit && initSlotReg === U(slot))
          else False
        val doRecv: Bool =
          stateReg === sReceiveRow && rowWrPtrReg === U(slot) && rxStep

        val wrEn: Bool   = doInit || doRecv
        val wrAddr: UInt =
          if (cfg.hasPadding) Mux(stateReg === sInit,
                                  initAddrReg.resize(rowBufMemABits),
                                  rxAddrReg.resize(rowBufMemABits))
          else rxAddrReg.resize(rowBufMemABits)
        val wrData: SInt =
          if (cfg.hasPadding) Mux(stateReg === sInit, S(0, 8 bits), rxWData)
          else rxWData

        rowBufs(slot).write(wrAddr, wrData, wrEn)
      }

      // ── sInit: zero-fill all K_H row bufs ───────────────────────────────
      // initSlotReg cycles 0..K_H-1; initAddrReg cycles 0..rowBufDepth-1.
      if (cfg.hasPadding) {
        when(stateReg === sInit) {
          initAddrReg := initAddrReg + 1
          when(initAddrReg === U(cfg.rowBufDepth - 1)) {
            initAddrReg := 0
            val nextSlot = circNext(initSlotReg)
            initSlotReg := nextSlot
            when(initSlotReg === U(K_H - 1, slotBits bits)) {
              initSlotReg         := 0
              rowWrPtrReg         := U(cfg.padTop % (K_H max 1), slotBits bits)
              rowsUntilComputeReg := U(K_H - cfg.padTop)
              realRowsRecvReg     := 0
              rxAddrReg           := U(cfg.padLeft * cfg.C_in, rowBufABits bits)
              ocReg               := 0
              outHReg             := 0
              outWReg             := 0
              colBaseReg          := 0
              wAddrBase           := 0
              loadStep            := 0
              stateReg            := sReceiveRow
            }
          }
        }
      }

      // ── sReceiveRow: receive one padded input row ─────────────────────────
      // isReal: real input rows remain this frame; else emit virtual pad rows.
      // rxStep advances rxAddrReg; writes handled above (unified per-slot write).
      when(stateReg === sReceiveRow) {
        activationIn.ready := isReal

        when(rxStep) {
          val rowDone = rxAddrReg === rxEnd

          rxAddrReg := Mux(rowDone,
                           U(cfg.padLeft * cfg.C_in, rowBufABits bits),
                           (rxAddrReg + 1).resize(rowBufABits))

          when(rowDone) {
            when(isReal) { realRowsRecvReg := (realRowsRecvReg + 1).resized }

            // oldestSlotReg = circNext(rowWrPtrReg) — the slot after the one
            // just written, which is the oldest in the K_H-row window.
            // Must read rowWrPtrReg HERE (old value) before advancing.
            val oldestNext = circNext(rowWrPtrReg)

            rowWrPtrReg := circNext(rowWrPtrReg)  // advance after writing

            when(rowsUntilComputeReg <= 1) {
              rowsUntilComputeReg := U(cfg.strideH)
              oldestSlotReg       := oldestNext
              loadStep            := 0
              stateReg            := (if (cfg.weightMode == WeightStream) sLoadW else sLoad)
            } otherwise {
              rowsUntilComputeReg := (rowsUntilComputeReg - 1).resized
            }
          }
        }
      }

      // ── sLoadW: stream packed weights for one oc (WeightStream only) ─────
      if (cfg.weightMode == WeightStream) {
        when(stateReg === sLoadW) {
          when(!wsBeatDrain) {
            weightIn.ready := True
            when(weightIn.fire) {
              wsBeatBuf   := weightIn.payload
              wsBeatDrain := True
              wsBeatStep  := 0
            }
          } otherwise {
            val packed = wsBeatBuf(7 downto 0).asUInt
            for (b <- 0 until nMac) {
              when(wsStep === U(b)) {
                wThrRegs(b)  := Cat(packed(6 downto 0), B"0").asUInt
                wSignRegs(b) := !packed.msb
              }
            }
            wsBeatBuf  := (wsBeatBuf >> 8).resized
            wsBeatStep := wsBeatStep + 1
            wsStep     := wsStep + 1
            when(wsStep === U(nMac - 1)) {
              wsStep      := 0
              wsBeatDrain := False
              stateReg    := sLoad
            }
            when(wsBeatStep === U(cfg.stepsPerBeat - 1)) {
              wsBeatDrain := False
            }
          }
        }
      }

      // ── sLoad: fill threshold registers from row bufs + weight source ─────
      // Cycle b (loadStep=b): drive rowAddrComb for lane b → readSync fires.
      // Cycle b+1 (loadStep=b+1): latch readSync result into activThresh(b).
      // All K_H rowBufs read at the same address; slot selected by kh(b).
      // combAdjRom issued at cycle 0, latched at cycle 1.

      val kRowOffVec   = Vec(cfg.kRowOff.map(o => U(o, rowBufABits bits)))
      val safeLoadStep = Mux(loadStep < U(nMac), loadStep, U(nMac - 1, loadStep.getWidth bits))
      val rowAddrComb  = (colBaseReg + kRowOffVec(safeLoadStep.resized)).resize(rowBufABits)

      val loadInRange = (stateReg === sLoad) && (loadStep < U(nMac))

      // All K_H row reads driven by rowAddrComb; result latched 1 cycle later.
      val rowReads: Seq[SInt] = rowBufs.map(_.readSync(rowAddrComb.resize(rowBufMemABits), enable = loadInRange))

      val wThrRead  = if (cfg.weightMode == WeightRom)
                        wThrRom.readSync((wAddrBase + loadStep).resized, enable = loadInRange)
                      else null
      val wSignRead = if (cfg.weightMode == WeightRom)
                        wSignRom.readSync((wAddrBase + loadStep).resized, enable = loadInRange)
                      else null
      val combAdjRead = combAdjRom.readSync(ocReg.resized,
                          enable = (stateReg === sLoad) && (loadStep === U(0)))

      when(stateReg === sLoad) {
        loadStep := loadStep + 1
        when(loadStep === U(1)) { combAdjReg := combAdjRead }

        for (b <- 0 until nMac) {
          when(loadStep === U(b + 1)) {
            // Select slot for kh(b): (oldestSlotReg + kKh(b)) % K_H.
            // kKh(b) is a compile-time Scala Int; Mux table indexed by oldestSlotReg.
            val khB = cfg.kKh(b)
            val rowSel: SInt =
              if (K_H == 1) rowReads(0)
              else {
                val slotVec = Vec(Seq.tabulate(K_H) { old =>
                  U((old + khB) % K_H, slotBits bits)
                })
                Vec(rowReads)(slotVec(oldestSlotReg))
              }
            activThresh(b) := (rowSel.asUInt + 128).resize(8)
            if (cfg.weightMode == WeightRom) {
              wThrRegs(b)  := wThrRead
              wSignRegs(b) := wSignRead
            }
          }
        }

        when(loadStep === U(nMac)) {
          loadStep := 0
          sc_acc   := 0
          scStep   := 0
          stateReg := sSC
        }
      }

      // ── sSC ───────────────────────────────────────────────────────────────
      when(stateReg === sSC) {
        scStep := scStep + 1
        sc_acc := sc_acc + (posCount - negCount).resize(accBits)
        when(scStep === U(L - 1)) {
          scStep   := 0
          stateReg := sDecode
        }
      }

      // ── sDecode ───────────────────────────────────────────────────────────
      when(stateReg === sDecode) {
        val corrected = (sc_acc + combAdjReg).resize(accBits + 2)
        val product   = (corrected * S(cfg.decodeMult.toInt, 32 bits)) >> cfg.decodeShift
        val biased    = product + S(cfg.outputQuant.zeroPoint.toLong, product.getWidth bits)
        val sat       = Mux(biased > S(127L,  biased.getWidth bits), S(127, 8 bits),
                        Mux(biased < S(-128L, biased.getWidth bits), S(-128, 8 bits),
                            biased.resize(8)))

        activationOut.valid         := True
        activationOut.payload.value := sat

        when(activationOut.fire) {
          val lastOc = ocReg   === U(C_out - 1)
          val lastW  = outWReg === U(cfg.outputShape.cols - 1)
          val lastH  = outHReg === U(cfg.outputShape.rows - 1)

          ocReg     := Mux(lastOc, U(0, ocReg.getWidth bits),     (ocReg + 1).resized)
          wAddrBase := Mux(lastOc, U(0, wAddrBase.getWidth bits), (wAddrBase + U(nMac)).resized)

          when(lastOc) {
            outWReg    := Mux(lastW, U(0, outWReg.getWidth bits), (outWReg + 1).resized)
            colBaseReg := Mux(lastW,
                              U(0, colBaseReg.getWidth bits),
                              (colBaseReg + U(cfg.strideW * cfg.C_in)).resize(rowBufABits))
            when(lastW) {
              outHReg := Mux(lastH, U(0, outHReg.getWidth bits), (outHReg + 1).resized)
            }
          }

          loadStep := 0

          when(lastOc && lastW) {
            when(lastH) {
              // Frame done: reset receive state for next frame
              realRowsRecvReg     := 0
              rowsUntilComputeReg := U(K_H - cfg.padTop)
              rowWrPtrReg         := U(cfg.padTop % (K_H max 1), slotBits bits)
              rxAddrReg           := U(cfg.padLeft * cfg.C_in, rowBufABits bits)
              stateReg            := (if (cfg.hasPadding) sInit else sReceiveRow)
            } otherwise {
              stateReg := sReceiveRow
            }
          } otherwise {
            val nextLoad = if (cfg.weightMode == WeightStream) sLoadW else sLoad
            stateReg := nextLoad
          }
        }
      }

    }

    Io(activationOut = logic.activationOut,
       weightIn      = if (cfg.weightMode == WeightStream) logic.weightIn else null)
  }
}
