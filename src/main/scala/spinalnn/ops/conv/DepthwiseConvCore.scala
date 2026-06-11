package spinalnn.ops.conv

import spinal.core._
import spinal.lib._
import spinalnn.types._
import spinalnn.util.PrefixArea

/** Depthwise (channel-wise) INT8 2D convolution.
  *
  * Corresponds to an ONNX `Conv` node where `group = C_in = C_out`. Each output
  * channel has exactly one spatial filter of size `kH × kW` — no cross-channel
  * accumulation. Weight layout after transpose: `[C, kH, kW]` (inCh=1 dropped).
  *
  * Differences from `QLinearConvCore`:
  *  - totalSteps = kH × kW (no inner channel loop)
  *  - Input address increments by `C` per step (channel stride in HWC layout)
  *  - Weight address always increments by 1
  *  - No macParallelism — output/input channel count sets the natural spatial parallelism
  */
object DepthwiseConvCore {

  case class Config(
    periphName:   String,
    inputShape:   TensorShape,
    outputShape:  TensorShape,
    kernelH:      Int,
    kernelW:      Int,
    strideH:      Int         = 1,
    strideW:      Int         = 1,
    padTop:       Int         = 0,
    padBottom:    Int         = 0,
    padLeft:      Int         = 0,
    padRight:     Int         = 0,
    inputQuant:   QuantParams,
    weightQuant:  QuantParams,
    outputQuant:  QuantParams,
    weights:      Array[Byte],
    biases:       Array[Int],
    weightScales: Option[Array[Float]] = None
  ) {
    val C: Int = inputShape.channels

    require(outputShape.channels == C,
      s"depthwise: outputShape.channels ${outputShape.channels} must equal inputShape.channels $C")
    require(weights.length == C * kernelH * kernelW,
      s"weights.length ${weights.length} != ${C * kernelH * kernelW}")
    require(biases.length == C,
      s"biases.length ${biases.length} != C=$C")

    val paddedRows: Int     = inputShape.rows + padTop  + padBottom
    val paddedCols: Int     = inputShape.cols + padLeft + padRight
    val paddedSize: Int     = paddedRows * paddedCols * C
    val hasPadding: Boolean = (padTop | padBottom | padLeft | padRight) != 0

    require(outputShape.rows == (paddedRows - kernelH) / strideH + 1,
      s"outputShape.rows ${outputShape.rows} != (paddedRows $paddedRows - $kernelH)/$strideH + 1")
    require(outputShape.cols == (paddedCols - kernelW) / strideW + 1,
      s"outputShape.cols ${outputShape.cols} != (paddedCols $paddedCols - $kernelW)/$strideW + 1")

    // Receive-state constants (identical to QLinearConvCore, N=1).
    val padBaseI:    Int = padTop * paddedCols * C + padLeft * C
    val rowElemsI:   Int = inputShape.cols * C
    val rowWrapPadI: Int = (padLeft + padRight) * C + 1

    // Per-channel requant (same mechanism as QLinearConvCore).
    val requant: RequantScale = RequantScale(inputQuant.scale, weightQuant.scale, outputQuant.scale)

    val perChannelRequant: Boolean = weightScales.isDefined
    val requantPerCh: Seq[RequantScale] = weightScales match {
      case Some(ws) =>
        require(ws.length == C,
          s"weightScales.length ${ws.length} != C=$C")
        ws.map(w => RequantScale(inputQuant.scale, w, outputQuant.scale)).toSeq
      case None =>
        Seq.fill(C)(requant)
    }
  }

  case class Io(activationOut: Stream[Activation])

  def build(cfg: Config, activationIn: Stream[Activation] = null): Io = {
    require(activationIn != null, "activationIn is required")

    val C          = cfg.C
    val inAddrBits = log2Up(cfg.paddedSize + 1)
    val wAddrBits  = log2Up(C * cfg.kernelH * cfg.kernelW + 1)
    val totalSteps = cfg.kernelH * cfg.kernelW

    // Input address step deltas (in units of the flat HWC buffer index).
    // Normal step (kw += 1): jump by C (channel stride between adjacent columns).
    // Row-wrap step (kh += 1, kw = 0): jump from (kh, kW-1) to (kh+1, 0):
    //   delta = paddedCols*C - (kW-1)*C = (paddedCols - kW + 1)*C
    val inStepNorm: Int = C
    val inStepWrap: Int = (cfg.paddedCols - cfg.kernelW + 1) * C

    val logic = new PrefixArea(cfg.periphName) {

      // ── Input buffer ───────────────────────────────────────────────────────
      val inputBuf = Mem(SInt(ActivationDType.bits bits), cfg.paddedSize)
      inputBuf.setName(s"${cfg.periphName}_inputBuf")
      // Padding init is handled by sInit FSM at runtime (avoids O(paddedSize) elaboration-time AST nodes).

      // ── Weight ROM [C * kH * kW] ───────────────────────────────────────────
      val weightRom = Mem(SInt(ActivationDType.bits bits), C * cfg.kernelH * cfg.kernelW)
      weightRom.setName(s"${cfg.periphName}_weightRom")
      weightRom.initBigInt(cfg.weights.map(b => BigInt(b.toLong)).toSeq, allowNegative = true)

      // ── Bias ROM ───────────────────────────────────────────────────────────
      val biasRom = Mem(SInt(32 bits), C)
      biasRom.setName(s"${cfg.periphName}_biasRom")
      biasRom.initBigInt(cfg.biases.map(BigInt(_)).toSeq, allowNegative = true)

      // ── Per-channel requant ROMs ────────────────────────────────────────────
      val reqMultRom = if (cfg.perChannelRequant) {
        val m = Mem(UInt(32 bits), C)
        m.setName(s"${cfg.periphName}_reqMultRom")
        m.initBigInt(cfg.requantPerCh.map(r => BigInt(r.multiplier)).toSeq)
        m
      } else null
      val reqShiftRom = if (cfg.perChannelRequant) {
        val m = Mem(UInt(8 bits), C)
        m.setName(s"${cfg.periphName}_reqShiftRom")
        m.initBigInt(cfg.requantPerCh.map(r => BigInt(r.shift)).toSeq)
        m
      } else null

      // ── Output stream ──────────────────────────────────────────────────────
      val activationOut = Stream(Activation())
      activationOut.setName(s"${cfg.periphName}_activationOut")

      // ── FSM states ─────────────────────────────────────────────────────────
      val sReceive      = U(0, 4 bits)
      val sLoadBias     = U(1, 4 bits)
      val sCompute      = U(2, 4 bits)
      val sRequant      = U(3, 4 bits)
      val sRequantMul   = U(4, 4 bits)
      val sRequantWait  = U(5, 4 bits)
      val sRequantWait2 = U(6, 4 bits)
      val sRequantWait3 = U(7, 4 bits)
      val sRequantShift = U(8, 4 bits)
      val sEmit         = U(9, 4 bits)
      val sInit         = U(10, 4 bits)
      val sWaitBias     = U(11, 4 bits)

      val stateReg = Reg(UInt(4 bits)) init (if (cfg.hasPadding) 10 else 0)
      stateReg.setName(s"${cfg.periphName}_stateReg")

      // ── Receive-phase counters ──────────────────────────────────────────────
      val recvCntReg      = Reg(UInt(log2Up(cfg.inputShape.size + 1) bits)) init 0
      val padWriteAddrReg = Reg(UInt(log2Up(cfg.paddedSize + 1) bits)) init cfg.padBaseI
      val rowElemReg      = Reg(UInt(log2Up(cfg.rowElemsI + 1) bits)) init 0

      // ── Output spatial / channel counters ──────────────────────────────────
      val outRowReg = Reg(UInt(log2Up(cfg.outputShape.rows + 1) bits)) init 0
      val outColReg = Reg(UInt(log2Up(cfg.outputShape.cols + 1) bits)) init 0
      val outChReg  = Reg(UInt(log2Up(C + 1) bits)) init 0

      // ── Compute-phase pipeline registers ───────────────────────────────────
      val accumReg        = Reg(SInt(32 bits)) init 0
      val prodReg         = Reg(SInt(32 bits)) init 0
      val resultReg       = Reg(SInt(8  bits)) init 0
      val accumRequantReg = Reg(SInt(32 bits)) init 0
      val reqProdReg2     = Reg(SInt(64 bits)) init 0

      // Requant split-multiplier pipeline (identical to QLinearConvCore).
      val signAReg = Reg(Bool())    init False
      val absAReg  = Reg(UInt(32 bits)) init 0
      val pLL_Reg  = Reg(UInt(32 bits)) init 0
      val pLH_Reg  = Reg(UInt(32 bits)) init 0
      val pHL_Reg  = Reg(UInt(32 bits)) init 0
      val pHH_Reg  = Reg(UInt(32 bits)) init 0
      val pSumReg  = Reg(UInt(33 bits)) init 0
      val pLL_Reg2 = Reg(UInt(32 bits)) init 0
      val pHH_Reg2 = Reg(UInt(32 bits)) init 0
      val part1Reg = Reg(UInt(64 bits)) init 0
      val part2Reg = Reg(UInt(64 bits)) init 0

      val initAddrReg  = Reg(UInt(inAddrBits bits)) init 0
      val inAddrReg    = Reg(UInt(inAddrBits bits)) init 0
      val wAddrReg     = Reg(UInt(wAddrBits  bits)) init 0
      val compCycleReg = Reg(UInt(log2Up(totalSteps + 3) bits)) init 0
      val rowStepReg   = Reg(UInt(log2Up(cfg.kernelW + 1) bits)) init 0

      // name assignments
      recvCntReg.setName(s"${cfg.periphName}_recvCntReg")
      padWriteAddrReg.setName(s"${cfg.periphName}_padWriteAddrReg")
      rowElemReg.setName(s"${cfg.periphName}_rowElemReg")
      outRowReg.setName(s"${cfg.periphName}_outRowReg")
      outColReg.setName(s"${cfg.periphName}_outColReg")
      outChReg.setName(s"${cfg.periphName}_outChReg")
      accumReg.setName(s"${cfg.periphName}_accumReg")
      prodReg.setName(s"${cfg.periphName}_prodReg")
      resultReg.setName(s"${cfg.periphName}_resultReg")
      accumRequantReg.setName(s"${cfg.periphName}_accumRequantReg")
      reqProdReg2.setName(s"${cfg.periphName}_reqProdReg2")
      inAddrReg.setName(s"${cfg.periphName}_inAddrReg")
      wAddrReg.setName(s"${cfg.periphName}_wAddrReg")
      compCycleReg.setName(s"${cfg.periphName}_compCycleReg")
      rowStepReg.setName(s"${cfg.periphName}_rowStepReg")

      // ── BRAM read wires (readSync: address sampled this cycle, data next) ──
      val inAddrComb = UInt(inAddrBits bits)
      val wAddrComb  = UInt(wAddrBits  bits)
      inAddrComb := inAddrReg
      wAddrComb  := wAddrReg

      val inValR = inputBuf.readSync(inAddrComb.resized)
      val wValR  = weightRom.readSync(wAddrComb.resized)

      // ── ROM reads via readSync (BRAM-mappable; addresses stable across compute/requant) ──
      val biasVal     = biasRom.readSync(outChReg.resized)
      val reqMultVal  = if (cfg.perChannelRequant) reqMultRom.readSync(outChReg.resized)  else null
      val reqShiftVal = if (cfg.perChannelRequant) reqShiftRom.readSync(outChReg.resized) else null

      // ── Unified write port (single always-block → BRAM-mappable) ─────────
      val doInit = if (cfg.hasPadding) (stateReg === sInit) else False
      val doRecv = stateReg === sReceive && activationIn.fire
      val wrAddr = Mux(doInit, initAddrReg.resize(inAddrBits), padWriteAddrReg.resize(inAddrBits))
      val wrData = Mux(doInit,
        S(cfg.inputQuant.zeroPoint.toLong, ActivationDType.bits bits),
        activationIn.payload.value)
      inputBuf.write(wrAddr.resized, wrData, doInit || doRecv)

      val inValReg = Reg(SInt(ActivationDType.bits bits)) init 0
      val wValReg  = Reg(SInt(ActivationDType.bits bits)) init 0
      inValReg.setName(s"${cfg.periphName}_inValReg")
      wValReg.setName(s"${cfg.periphName}_wValReg")

      // ── Defaults ────────────────────────────────────────────────────────────
      activationIn.ready          := False
      activationOut.valid         := False
      activationOut.payload.value := resultReg

      // ── INIT (one-time per reset: fill all input buffer entries with zeroPoint) ──
      // Replaces Mem.init() which creates O(paddedSize) elaboration-time SpinalHDL
      // AST literal nodes — OOM for large feature maps like 114×114×32.
      if (cfg.hasPadding) {
        when(stateReg === sInit) {
          // Write handled by unified write port above.
          when(initAddrReg === U(cfg.paddedSize - 1)) {
            initAddrReg := 0
            stateReg    := sReceive
          } otherwise {
            initAddrReg := initAddrReg + 1
          }
        }
      }

      // ── RECEIVE ─────────────────────────────────────────────────────────────
      // Buffer the full input feature map into the (padded) input buffer in
      // HWC order. Identical to QLinearConvCore (N=1 variant).
      when(stateReg === sReceive) {
        activationIn.ready := True
        when(activationIn.fire) {
          // Write handled by unified write port above.
          val rowEnd = rowElemReg === U(cfg.rowElemsI - 1)
          rowElemReg      := Mux(rowEnd,
            U(0, rowElemReg.getWidth bits),
            (rowElemReg + 1).resized)
          padWriteAddrReg := padWriteAddrReg + Mux(rowEnd,
            U(cfg.rowWrapPadI, padWriteAddrReg.getWidth bits),
            U(1,               padWriteAddrReg.getWidth bits))
          recvCntReg := recvCntReg + 1
          when(recvCntReg === U(cfg.inputShape.size - 1)) {
            recvCntReg      := 0
            rowElemReg      := 0
            padWriteAddrReg := U(cfg.padBaseI, padWriteAddrReg.getWidth bits)
            outRowReg := 0; outColReg := 0; outChReg := 0
            stateReg  := sLoadBias
          }
        }
      }

      // ── LOAD_BIAS ────────────────────────────────────────────────────────────
      // Issue BRAM address; biasVal (readSync) is captured in sWaitBias one cycle later.
      // Input start addr:  (outRow*sH) * paddedCols * C  +  (outCol*sW) * C  +  outCh
      // Weight start addr: outCh * kH * kW
      when(stateReg === sLoadBias) {
        inAddrReg := (outRowReg * U(cfg.strideH * cfg.paddedCols * C) +
                      outColReg * U(cfg.strideW * C) +
                      outChReg).resized
        wAddrReg     := (outChReg * U(cfg.kernelH * cfg.kernelW)).resized
        compCycleReg := 0
        rowStepReg   := 0
        stateReg     := sWaitBias
      }

      // ── WAIT_BIAS ────────────────────────────────────────────────────────────
      when(stateReg === sWaitBias) {
        accumReg := biasVal
        stateReg := sCompute
      }

      // ── COMPUTE (pipelined MAC over kH * kW positions) ──────────────────────
      // 4-stage pipeline identical to QLinearConvCore:
      //   Stage 0 (cycles 0..totalSteps-1): issue BRAM address, advance addr regs
      //   Stage 1 (cycles 1..totalSteps):   register BRAM outputs
      //   Stage 2 (cycles 2..totalSteps+1): multiply (x-zx)*(w-zw)
      //   Stage 3 (cycles 3..totalSteps+2): accumulate; last cycle → sRequant
      //
      // Key difference from QLinearConvCore: input address advances by C per
      // normal step and by (paddedCols - kW + 1)*C at row-wrap (not by 1 / C_N).
      when(stateReg === sCompute) {
        compCycleReg := compCycleReg + 1

        // Stage 0: advance address registers for the next MAC step.
        when(compCycleReg < U(totalSteps)) {
          wAddrReg := wAddrReg + 1
          val isRowWrap = rowStepReg === U(cfg.kernelW - 1)
          inAddrReg := inAddrReg + Mux(isRowWrap,
            U(inStepWrap, inAddrBits bits),
            U(inStepNorm, inAddrBits bits))
          rowStepReg := Mux(isRowWrap,
            U(0, rowStepReg.getWidth bits),
            rowStepReg + 1)
        }

        // Stage 1: capture readSync outputs.
        when(compCycleReg >= 1 && compCycleReg <= U(totalSteps)) {
          inValReg := inValR
          wValReg  := wValR
        }

        // Stage 2: compute zero-point-adjusted product.
        when(compCycleReg >= 2 && compCycleReg <= U(totalSteps + 1)) {
          val inAdj = inValReg.resize(ActivationDType.adjBits) -
                      S(cfg.inputQuant.zeroPoint.toLong, ActivationDType.adjBits bits)
          val wAdj  = wValReg.resize(ActivationDType.adjBits) -
                      S(cfg.weightQuant.zeroPoint.toLong, ActivationDType.adjBits bits)
          prodReg := (inAdj * wAdj).resize(32)
        }

        // Stage 3: accumulate; transition after the final step.
        when(compCycleReg >= 3 && compCycleReg <= U(totalSteps + 2)) {
          val accumNew = (accumReg + prodReg).resize(32)
          accumReg := accumNew
          when(compCycleReg === U(totalSteps + 2)) {
            accumRequantReg := accumNew
            stateReg        := sRequant
            compCycleReg    := 0
          }
        }
      }

      // ── REQUANT (identical split-16×16 pipeline to QLinearConvCore) ─────────
      when(stateReg === sRequant) {
        absAReg  := Mux(accumRequantReg < 0, -accumRequantReg, accumRequantReg).asUInt
        signAReg := accumRequantReg < 0
        stateReg := sRequantMul
      }

      when(stateReg === sRequantMul) {
        val mHW = if (cfg.perChannelRequant) reqMultVal
                  else U(cfg.requant.multiplier, 32 bits)
        val aH = absAReg(31 downto 16); val aL = absAReg(15 downto 0)
        val bH = mHW(31 downto 16);     val bL = mHW(15 downto 0)
        pLL_Reg := aL * bL;  pLH_Reg := aL * bH
        pHL_Reg := aH * bL;  pHH_Reg := aH * bH
        stateReg := sRequantWait
      }

      when(stateReg === sRequantWait) {
        pSumReg  := pLH_Reg.resize(33) + pHL_Reg.resize(33)
        pLL_Reg2 := pLL_Reg;  pHH_Reg2 := pHH_Reg
        stateReg := sRequantWait2
      }

      when(stateReg === sRequantWait2) {
        part1Reg := (pLL_Reg2.resize(64) + (pSumReg.resize(64) << 16).resized).resized
        part2Reg := (pHH_Reg2.resize(64) << 32).resized
        stateReg := sRequantWait3
      }

      when(stateReg === sRequantWait3) {
        val sumPart     = (part1Reg + part2Reg).resized
        val signedFinal = Mux(signAReg, -sumPart.asSInt, sumPart.asSInt)
        reqProdReg2 := signedFinal
        stateReg    := sRequantShift
      }

      when(stateReg === sRequantShift) {
        val shifted = (if (cfg.perChannelRequant)
                         reqProdReg2 >> reqShiftVal
                       else
                         reqProdReg2 >> cfg.requant.shift).resize(32)
        val biased = (shifted + S(cfg.outputQuant.zeroPoint.toLong, 32 bits)).resize(32)
        resultReg := Mux(biased > S(ActivationDType.maxVal, 32 bits),
                         S(ActivationDType.maxVal, ActivationDType.bits bits),
                     Mux(biased < S(ActivationDType.minVal, 32 bits),
                         S(ActivationDType.minVal, ActivationDType.bits bits),
                         biased.resize(8)))
        stateReg := sEmit
      }

      // ── EMIT ────────────────────────────────────────────────────────────────
      // Output HWC order: channel innermost, then col, then row.
      // After each element, return to sLoadBias for the next (outRow, outCol, outCh).
      when(stateReg === sEmit) {
        activationOut.valid         := True
        activationOut.payload.value := resultReg

        when(activationOut.fire) {
          val lastCh  = outChReg  === U(C - 1)
          val lastCol = outColReg === U(cfg.outputShape.cols - 1)
          val lastRow = outRowReg === U(cfg.outputShape.rows - 1)

          outChReg := Mux(lastCh,
            U(0, outChReg.getWidth bits),
            (outChReg + 1).resize(outChReg.getWidth))
          when(lastCh) {
            outColReg := Mux(lastCol,
              U(0, outColReg.getWidth bits),
              (outColReg + 1).resize(outColReg.getWidth))
            when(lastCol) {
              outRowReg := Mux(lastRow,
                U(0, outRowReg.getWidth bits),
                (outRowReg + 1).resize(outRowReg.getWidth))
            }
          }
          stateReg := Mux(lastCh && lastCol && lastRow, sReceive, sLoadBias)
        }
      }
    }

    Io(activationOut = logic.activationOut)
  }
}
