package spinalnn.ops.conv

import spinal.core._
import spinal.lib._
import spinalnn.types._
import spinalnn.util.PrefixArea

object QLinearConvCore {

  // Weight layout: [outCh, kH, kW, C_in] -- C_in innermost for parallel reads.
  // ONNX standard is [outCh, C_in, kH, kW]. Transpose before loading:
  //   weights.transpose(0, 2, 3, 1).flatten()
  // For macParallelism = 1 with single-channel inputs (C_in = 1) layouts are identical.
  case class Config(
    periphName:     String,
    inputShape:     TensorShape,
    outputShape:    TensorShape,
    kernelH:        Int,
    kernelW:        Int,
    strideH:        Int         = 1,
    strideW:        Int         = 1,
    padTop:         Int         = 0,
    padBottom:      Int         = 0,
    padLeft:        Int         = 0,
    padRight:       Int         = 0,
    inputQuant:     QuantParams,
    weightQuant:    QuantParams,
    outputQuant:    QuantParams,
    weights:        Array[Byte],
    biases:         Array[Int],
    macParallelism: Int         = 1
  ) {
    require(macParallelism >= 1)
    require(inputShape.channels % macParallelism == 0,
      s"inputShape.channels (${inputShape.channels}) must be divisible by macParallelism ($macParallelism)")
    require(weights.length == outputShape.channels * kernelH * kernelW * inputShape.channels,
      s"weights.length ${weights.length} != ${outputShape.channels * kernelH * kernelW * inputShape.channels}")
    require(biases.length == outputShape.channels)

    // Zero-padding is realized by storing the incoming feature map into the interior
    // of a zero-initialised buffer (symmetric quant -> zeroPoint = 0, so padded taps
    // contribute 0 to the MAC). The compute walk then does a VALID convolution over
    // the padded buffer, which equals a padded convolution over the real input.
    val paddedRows: Int     = inputShape.rows + padTop + padBottom
    val paddedCols: Int     = inputShape.cols + padLeft + padRight
    val paddedSize: Int     = paddedRows * paddedCols * inputShape.channels
    val hasPadding: Boolean = (padTop | padBottom | padLeft | padRight) != 0

    require(outputShape.rows == (paddedRows - kernelH) / strideH + 1,
      s"outputShape.rows ${outputShape.rows} != (paddedRows $paddedRows - kernelH $kernelH)/strideH $strideH + 1")
    require(outputShape.cols == (paddedCols - kernelW) / strideW + 1,
      s"outputShape.cols ${outputShape.cols} != (paddedCols $paddedCols - kernelW $kernelW)/strideW $strideW + 1")

    val C_N: Int     = inputShape.channels / macParallelism
    val requant: RequantScale =
      RequantScale(inputQuant.scale, weightQuant.scale, outputQuant.scale)
  }

  case class Io(activationOut: Stream[Activation])

  def build(cfg: Config, activationIn: Stream[Activation] = null): Io = {
    require(activationIn != null, "activationIn is required")

    val N            = cfg.macParallelism
    val C_N          = cfg.C_N
    val inLaneSize   = cfg.paddedSize / N
    val wLaneSize    = cfg.weights.length  / N
    val inAddrBits   = log2Up(inLaneSize  + 1)
    val wAddrBits    = log2Up(wLaneSize   + 1)
    val biasAddrBits = log2Up(cfg.biases.length + 1)

    // Receive-time constants for writing the incoming feature map into the padded
    // buffer interior. For zero padding these reduce to a plain contiguous write.
    val padBaseI    = cfg.padTop * cfg.paddedCols * cfg.inputShape.channels +
                      cfg.padLeft * cfg.inputShape.channels
    val rowElemsI   = cfg.inputShape.cols * cfg.inputShape.channels   // elems per real row
    val rowWrapPadI = (cfg.padLeft + cfg.padRight) * cfg.inputShape.channels + 1

    val logic = new PrefixArea(cfg.periphName) {

      // ── N-banked input buffer ──────────────────────────────────────────────
      // Bank i stores activations at global positions i, i+N, i+2N, ...
      // When padding is active the buffer is zero-initialised so untouched pad
      // cells read as 0 (= zeroPoint) every frame.
      val inputBufs = Seq.tabulate(N) { i =>
        val m = Mem(SInt(ActivationDType.bits bits), inLaneSize)
        m.setName(s"${cfg.periphName}_inputBuf_$i")
        if (cfg.hasPadding) m.init(Seq.fill(inLaneSize)(S(0, ActivationDType.bits bits)))
        m
      }

      // ── N-banked weight ROM (interleaved initialisation) ───────────────────
      val weightRoms = Seq.tabulate(N) { i =>
        val m = Mem(SInt(ActivationDType.bits bits), wLaneSize)
        m.setName(s"${cfg.periphName}_weightRom_$i")
        m.init(cfg.weights.indices.filter(_ % N == i)
          .map(j => S(cfg.weights(j).toLong, ActivationDType.bits bits)).toSeq)
        m
      }

      // ── Bias ROM (small -- readAsync sufficient) ───────────────────────────
      val biasRom = Mem(SInt(32 bits), cfg.biases.length)
      biasRom.setName(s"${cfg.periphName}_biasRom")
      biasRom.init(cfg.biases.map(b => S(b.toLong, 32 bits)).toSeq)

      // ── Output stream ──────────────────────────────────────────────────────
      val activationOut = Stream(Activation())
      activationOut.setName(s"${cfg.periphName}_activationOut")

      // ── FSM ────────────────────────────────────────────────────────────────
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

      val stateReg = Reg(UInt(4 bits)) init 0
      stateReg.setName(s"${cfg.periphName}_stateReg")

      // ── Counters ───────────────────────────────────────────────────────────
      val recvCntReg = Reg(UInt(log2Up(cfg.inputShape.size + 1) bits)) init 0
      // Padded write address + per-row element counter (for padded RECEIVE).
      val padWriteAddrReg = Reg(UInt(log2Up(cfg.paddedSize + 1) bits)) init padBaseI
      val rowElemReg      = Reg(UInt(log2Up(rowElemsI + 1) bits)) init 0
      val outRowReg  = Reg(UInt(log2Up(cfg.outputShape.rows     + 1) bits)) init 0
      val outColReg  = Reg(UInt(log2Up(cfg.outputShape.cols     + 1) bits)) init 0
      val outChReg   = Reg(UInt(log2Up(cfg.outputShape.channels + 1) bits)) init 0
      val accumReg   = Reg(SInt(32 bits)) init 0
      val prodReg    = Reg(SInt(32 bits)) init 0
      val resultReg  = Reg(SInt(8  bits)) init 0
      val reqProdReg1 = Reg(SInt(64 bits)) init 0
      val reqProdReg2 = Reg(SInt(64 bits)) init 0
      val accumRequantReg = Reg(SInt(32 bits)) init 0

      // ── Requant Multiplier Pipeline registers ───────────────────────────
      val signAReg     = Reg(Bool()) init False
      val absAReg      = Reg(UInt(32 bits)) init 0
      val pLL_Reg      = Reg(UInt(32 bits)) init 0
      val pLH_Reg      = Reg(UInt(32 bits)) init 0
      val pHL_Reg      = Reg(UInt(32 bits)) init 0
      val pHH_Reg      = Reg(UInt(32 bits)) init 0
      val pSumReg      = Reg(UInt(33 bits)) init 0
      val pLL_Reg2     = Reg(UInt(32 bits)) init 0
      val pHH_Reg2     = Reg(UInt(32 bits)) init 0
      val part1Reg     = Reg(UInt(64 bits)) init 0
      val part2Reg     = Reg(UInt(64 bits)) init 0
      
      val inAddrReg  = Reg(UInt(inAddrBits bits)) init 0
      val wAddrReg   = Reg(UInt(wAddrBits bits)) init 0

      val totalSteps = C_N * cfg.kernelH * cfg.kernelW
      val compCycleReg = Reg(UInt(log2Up(totalSteps + 3) bits)) init 0
      val rowStepReg = Reg(UInt(log2Up(cfg.kernelW * C_N + 1) bits)) init 0

      recvCntReg.setName(s"${cfg.periphName}_recvCntReg")
      padWriteAddrReg.setName(s"${cfg.periphName}_padWriteAddrReg")
      rowElemReg.setName(s"${cfg.periphName}_rowElemReg")
      outRowReg.setName(s"${cfg.periphName}_outRowReg")
      outColReg.setName(s"${cfg.periphName}_outColReg")
      outChReg.setName(s"${cfg.periphName}_outChReg")
      accumReg.setName(s"${cfg.periphName}_accumReg")
      prodReg.setName(s"${cfg.periphName}_prodReg")
      resultReg.setName(s"${cfg.periphName}_resultReg")
      reqProdReg1.setName(s"${cfg.periphName}_reqProdReg1")
      reqProdReg2.setName(s"${cfg.periphName}_reqProdReg2")
      accumRequantReg.setName(s"${cfg.periphName}_accumRequantReg")
      inAddrReg.setName(s"${cfg.periphName}_inAddrReg")
      wAddrReg.setName(s"${cfg.periphName}_wAddrReg")
      compCycleReg.setName(s"${cfg.periphName}_compCycleReg")
      rowStepReg.setName(s"${cfg.periphName}_rowStepReg")
      signAReg.setName(s"${cfg.periphName}_signAReg")
      absAReg.setName(s"${cfg.periphName}_absAReg")
      pLL_Reg.setName(s"${cfg.periphName}_pLL_Reg")
      pLH_Reg.setName(s"${cfg.periphName}_pLH_Reg")
      pHL_Reg.setName(s"${cfg.periphName}_pHL_Reg")
      pHH_Reg.setName(s"${cfg.periphName}_pHH_Reg")
      pSumReg.setName(s"${cfg.periphName}_pSumReg")
      pLL_Reg2.setName(s"${cfg.periphName}_pLL_Reg2")
      pHH_Reg2.setName(s"${cfg.periphName}_pHH_Reg2")
      part1Reg.setName(s"${cfg.periphName}_part1Reg")
      part2Reg.setName(s"${cfg.periphName}_part2Reg")

      // ── Combinatorial BRAM address wires ──────────────────────────────────────
      // readSync samples the address at the clock edge ending sCompute Stage 0; the
      // data output is valid during Stage 1 (exactly one cycle later).
      val inAddrComb = UInt(inAddrBits bits)
      val wAddrComb  = UInt(wAddrBits  bits)
      inAddrComb := inAddrReg
      wAddrComb  := wAddrReg

      val inValsR = Seq.tabulate(N)(i => inputBufs(i).readSync(inAddrComb.resized))
      val wValsR  = Seq.tabulate(N)(i => weightRoms(i).readSync(wAddrComb.resized))

      // ── Pipeline Registers for RAM separation ───────────────────────────
      val inValsReg = Seq.tabulate(N) { i =>
        val r = Reg(SInt(ActivationDType.bits bits)) init 0
        r.setName(s"${cfg.periphName}_inValsReg_$i")
        r
      }
      val wValsReg  = Seq.tabulate(N) { i =>
        val r = Reg(SInt(ActivationDType.bits bits)) init 0
        r.setName(s"${cfg.periphName}_wValsReg_$i")
        r
      }

      // ── Lane address helpers ───────────────────────────────────────────────
      // Input: lane addr = inRow * cols * C_N + inCol * C_N + kStep
      def inLaneAddr(row: UInt, col: UInt, step: UInt): UInt =
        (row * U(cfg.paddedCols * C_N) + col * U(C_N) + step).resized

      // Weight [outCh, kH, kW, C_in]: outCh*kH*kW*C_N + kRow*kW*C_N + kCol*C_N + step
      def wLaneAddr(oc: UInt, kr: UInt, kc: UInt, step: UInt): UInt =
        (oc * U(cfg.kernelH * cfg.kernelW * C_N) +
         kr * U(cfg.kernelW * C_N) +
         kc * U(C_N) + step).resized

      // ── Defaults ──────────────────────────────────────────────────────────
      activationIn.ready          := False
      activationOut.valid         := False
      activationOut.payload.value := resultReg

      // ── RECEIVE ────────────────────────────────────────────────────────────
      // Activations arrive in HWC order and are written into the *padded* buffer
      // interior. padWriteAddrReg tracks the padded global position; pad cells are
      // never written and stay 0 (buffer init). For zero padding this reduces to a
      // plain contiguous write (padWriteAddrReg == recvCntReg).
      when(stateReg === sReceive) {
        activationIn.ready := True
        when(activationIn.fire) {
          if (N == 1) {
            inputBufs(0).write(padWriteAddrReg.resized, activationIn.payload.value)
          } else {
            for (i <- 0 until N) {
              when(padWriteAddrReg(log2Up(N) - 1 downto 0) === U(i, log2Up(N) bits)) {
                inputBufs(i).write((padWriteAddrReg >> log2Up(N)).resized, activationIn.payload.value)
              }
            }
          }
          val rowEnd = rowElemReg === U(rowElemsI - 1)
          rowElemReg      := Mux(rowEnd, U(0, rowElemReg.getWidth bits), (rowElemReg + 1).resized)
          padWriteAddrReg := padWriteAddrReg + Mux(rowEnd,
                               U(rowWrapPadI, padWriteAddrReg.getWidth bits),
                               U(1,           padWriteAddrReg.getWidth bits))
          recvCntReg := recvCntReg + 1
          when(recvCntReg === (cfg.inputShape.size - 1)) {
            recvCntReg      := 0
            rowElemReg      := 0
            padWriteAddrReg := U(padBaseI, padWriteAddrReg.getWidth bits)
            outRowReg  := 0; outColReg := 0; outChReg := 0
            stateReg   := sLoadBias
          }
        }
      }

      // ── LOAD_BIAS ──────────────────────────────────────────────────────────
      when(stateReg === sLoadBias) {
        accumReg := biasRom.readAsync(outChReg.resized)
        
        // Compute initial addresses sequentially using BRAM address helpers
        inAddrReg := inLaneAddr(outRowReg * U(cfg.strideH), outColReg * U(cfg.strideW), U(0, log2Up(C_N + 1) bits)).resized
        wAddrReg  := wLaneAddr(outChReg, U(0), U(0), U(0, log2Up(C_N + 1) bits)).resized
        
        compCycleReg := 0
        rowStepReg   := 0
        stateReg     := sCompute
      }

      // ── COMPUTE (Pipelined MAC) ─────────────────────────────────────────
      val rowWrapOffset = (cfg.paddedCols - cfg.kernelW) * C_N + 1

      when(stateReg === sCompute) {
        compCycleReg := compCycleReg + 1

        // Stage 0: Address Generation / Driving (active for cycles 0 to totalSteps - 1)
        when(compCycleReg < totalSteps) {
          inAddrComb := inAddrReg
          wAddrComb  := wAddrReg

          // Increment address registers for the next step sequentially.
          // This keeps address math out of the timing critical path!
          wAddrReg := wAddrReg + 1
          val isRowWrap = rowStepReg === (cfg.kernelW * C_N - 1)
          inAddrReg  := inAddrReg + Mux(isRowWrap, U(rowWrapOffset, inAddrBits bits), U(1, inAddrBits bits))
          rowStepReg := Mux(isRowWrap, U(0, rowStepReg.getWidth bits), rowStepReg + 1)
        }

        // Stage 1: Memory Output Registration (active for cycles 1 to totalSteps)
        when(compCycleReg >= 1 && compCycleReg <= totalSteps) {
          for (i <- 0 until N) {
            inValsReg(i) := inValsR(i)
            wValsReg(i)  := wValsR(i)
          }
        }

        // Stage 2: Multiplication (active for cycles 2 to totalSteps + 1)
        when(compCycleReg >= 2 && compCycleReg <= totalSteps + 1) {
          val macProducts = Seq.tabulate(N) { i =>
            val inAdj = inValsReg(i).resize(ActivationDType.adjBits) - S(cfg.inputQuant.zeroPoint.toLong,  ActivationDType.adjBits bits)
            val wAdj  = wValsReg(i).resize(ActivationDType.adjBits)  - S(cfg.weightQuant.zeroPoint.toLong, ActivationDType.adjBits bits)
            (inAdj * wAdj).resize(32)
          }
          val macSum  = macProducts.reduce((a, b) => (a + b).resize(32))
          prodReg    := macSum
        }

        // Stage 3: Accumulation (active for cycles 3 to totalSteps + 2)
        when(compCycleReg >= 3 && compCycleReg <= totalSteps + 2) {
          val accumNew = (accumReg + prodReg).resize(32)
          accumReg := accumNew

          when(compCycleReg === (totalSteps + 2)) {
            accumRequantReg := accumNew
            stateReg        := sRequant
            compCycleReg    := 0
          }
        }
      }

      // ── REQUANT ────────────────────────────────────────────────────────────
      when(stateReg === sRequant) {
        absAReg  := Mux(accumRequantReg < 0, -accumRequantReg, accumRequantReg).asUInt
        signAReg := accumRequantReg < 0
        stateReg := sRequantMul
      }

      // ── REQUANT_MUL ────────────────────────────────────────────────────────
      when(stateReg === sRequantMul) {
        val mHW  = U(cfg.requant.multiplier, 32 bits)
        val aH   = absAReg(31 downto 16)
        val aL   = absAReg(15 downto 0)
        val bH   = mHW(31 downto 16)
        val bL   = mHW(15 downto 0)

        pLL_Reg  := aL * bL
        pLH_Reg  := aL * bH
        pHL_Reg  := aH * bL
        pHH_Reg  := aH * bH

        stateReg := sRequantWait
      }

      // ── REQUANT_WAIT ───────────────────────────────────────────────────────
      when(stateReg === sRequantWait) {
        pSumReg  := pLH_Reg.resize(33) + pHL_Reg.resize(33)
        pLL_Reg2 := pLL_Reg
        pHH_Reg2 := pHH_Reg
        stateReg := sRequantWait2
      }

      // ── REQUANT_WAIT2 ──────────────────────────────────────────────────────
      when(stateReg === sRequantWait2) {
        part1Reg := (pLL_Reg2.resize(64) + (pSumReg.resize(64) << 16).resized).resized
        part2Reg := (pHH_Reg2.resize(64) << 32).resized
        stateReg := sRequantWait3
      }

      // ── REQUANT_WAIT3 ──────────────────────────────────────────────────────
      when(stateReg === sRequantWait3) {
        val sumPart = (part1Reg + part2Reg).resized
        val signedFinal = Mux(signAReg, -sumPart.asSInt, sumPart.asSInt)
        reqProdReg2 := signedFinal
        stateReg    := sRequantShift
      }

      // ── REQUANT_SHIFT_CLAMP ────────────────────────────────────────────────
      when(stateReg === sRequantShift) {
        val shifted = (reqProdReg2 >> cfg.requant.shift).resize(32)
        val biased  = (shifted + S(cfg.outputQuant.zeroPoint.toLong, 32 bits)).resize(32)
        resultReg  := Mux(biased > S(ActivationDType.maxVal, 32 bits),  S(ActivationDType.maxVal, ActivationDType.bits bits),
                      Mux(biased < S(ActivationDType.minVal, 32 bits), S(ActivationDType.minVal, ActivationDType.bits bits),
                          biased.resize(8)))
        stateReg   := sEmit
      }

      // ── EMIT ───────────────────────────────────────────────────────────────
      when(stateReg === sEmit) {
        activationOut.valid         := True
        activationOut.payload.value := resultReg

        when(activationOut.fire) {
          val lastCh  = outChReg  === (cfg.outputShape.channels - 1)
          val lastCol = outColReg === (cfg.outputShape.cols     - 1)
          val lastRow = outRowReg === (cfg.outputShape.rows     - 1)

          outChReg := Mux(lastCh,  U(0, outChReg.getWidth  bits), (outChReg  + 1).resize(outChReg.getWidth))
          when(lastCh) {
            outColReg := Mux(lastCol, U(0, outColReg.getWidth bits), (outColReg + 1).resize(outColReg.getWidth))
            when(lastCol) {
              outRowReg := Mux(lastRow, U(0, outRowReg.getWidth bits), (outRowReg + 1).resize(outRowReg.getWidth))
            }
          }
          stateReg := Mux(lastCh && lastCol && lastRow, sReceive, sLoadBias)
        }
      }
    }

    Io(activationOut = logic.activationOut)
  }
}
