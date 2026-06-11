package spinalnn.ops.conv

import spinal.core._
import spinal.lib._
import spinalnn.target.{WeightMode, WeightRom, WeightStream}
import spinalnn.types._
import spinalnn.util.PrefixArea

object QLinearConvCore {

  // Weight layout: [outCh, kH, kW, C_in] -- C_in innermost for parallel reads.
  // ONNX standard is [outCh, C_in, kH, kW]. Transpose before loading:
  //   weights.transpose(0, 2, 3, 1).flatten()
  // For macParallelism = 1 with single-channel inputs (C_in = 1) layouts are identical.
  case class Config(
    periphName:      String,
    inputShape:      TensorShape,
    outputShape:     TensorShape,
    kernelH:         Int,
    kernelW:         Int,
    strideH:         Int         = 1,
    strideW:         Int         = 1,
    padTop:          Int         = 0,
    padBottom:       Int         = 0,
    padLeft:         Int         = 0,
    padRight:        Int         = 0,
    inputQuant:      QuantParams,
    weightQuant:     QuantParams,
    outputQuant:     QuantParams,
    weights:         Array[Byte],
    biases:          Array[Int],
    weightScales:    Option[Array[Float]] = None,
    macParallelism:  Int         = 1,
    outParallelism:  Int         = 1,
    weightMode:      WeightMode  = WeightRom
  ) {
    require(macParallelism >= 1)
    require(outParallelism >= 1)
    require(inputShape.channels % macParallelism == 0,
      s"inputShape.channels (${inputShape.channels}) must be divisible by macParallelism ($macParallelism)")
    require(outputShape.channels % outParallelism == 0,
      s"outputShape.channels (${outputShape.channels}) must be divisible by outParallelism ($outParallelism)")
    if (weightMode == WeightStream) {
      require(outParallelism == 1,
        s"outParallelism > 1 not yet supported with WeightStream; use WeightRom for P > 1")
      require(macParallelism <= 64,
        s"macParallelism ($macParallelism) must be <= 64 for WeightStream (AXI beat width)")
      require(64 % macParallelism == 0,
        s"macParallelism ($macParallelism) must divide 64 for WeightStream (beat-drain step count must be integer)")
    }
    require(weights.length == outputShape.channels * kernelH * kernelW * inputShape.channels,
      s"weights.length ${weights.length} != ${outputShape.channels * kernelH * kernelW * inputShape.channels}")
    require(biases.length == outputShape.channels)

    val paddedRows: Int     = inputShape.rows + padTop + padBottom
    val paddedCols: Int     = inputShape.cols + padLeft + padRight
    val paddedSize: Int     = paddedRows * paddedCols * inputShape.channels
    val hasPadding: Boolean = (padTop | padBottom | padLeft | padRight) != 0

    require(outputShape.rows == (paddedRows - kernelH) / strideH + 1,
      s"outputShape.rows ${outputShape.rows} != (paddedRows $paddedRows - kernelH $kernelH)/strideH $strideH + 1")
    require(outputShape.cols == (paddedCols - kernelW) / strideW + 1,
      s"outputShape.cols ${outputShape.cols} != (paddedCols $paddedCols - kernelW $kernelW)/strideW $strideW + 1")

    val C_N: Int          = inputShape.channels / macParallelism
    val C_P: Int          = outputShape.channels / outParallelism  // output channel groups
    val weightsPerCh: Int = kernelH * kernelW * C_N               // per output channel per input lane

    // Per-input-bank weight entry count (used for both ROM init and address bits).
    // Each of the P*N banks stores C_P groups × kH × kW × C_N entries.
    val wLaneSize: Int = if (weightMode == WeightRom) C_P * kernelH * kernelW * C_N
                         else weightsPerCh  // WeightStream: per-channel buffer (P=1 required)

    // WeightStream beat geometry (P=1 only).
    val stepsPerBeat: Int = 64 / macParallelism
    val beatsPerCh:   Int = (kernelH * kernelW * inputShape.channels + 63) / 64

    val requant: RequantScale =
      RequantScale(inputQuant.scale, weightQuant.scale, outputQuant.scale)

    val perChannelRequant: Boolean = weightScales.isDefined
    val requantPerCh: Seq[RequantScale] = weightScales match {
      case Some(ws) =>
        require(ws.length == outputShape.channels,
          s"weightScales.length ${ws.length} != outputShape.channels ${outputShape.channels}")
        ws.map(w => RequantScale(inputQuant.scale, w, outputQuant.scale)).toSeq
      case None =>
        Seq.fill(outputShape.channels)(requant)
    }
  }

  // weightIn is non-null only when cfg.weightMode == WeightStream.
  case class Io(activationOut: Stream[Activation], weightIn: Stream[Bits] = null)

  def build(cfg: Config, activationIn: Stream[Activation] = null): Io = {
    require(activationIn != null, "activationIn is required")

    val N   = cfg.macParallelism
    val P   = cfg.outParallelism
    val C_N = cfg.C_N
    val C_P = cfg.C_P

    val inLaneSize   = cfg.paddedSize / N
    val inAddrBits   = log2Up(inLaneSize + 1)
    val wAddrBits    = log2Up(cfg.wLaneSize + 1)
    val biasAddrBits = log2Up(C_P + 1)

    val padBaseI    = cfg.padTop * cfg.paddedCols * cfg.inputShape.channels +
                      cfg.padLeft * cfg.inputShape.channels
    val rowElemsI   = cfg.inputShape.cols * cfg.inputShape.channels
    val rowWrapPadI = (cfg.padLeft + cfg.padRight) * cfg.inputShape.channels + 1

    val logic = new PrefixArea(cfg.periphName) {

      // ── N-banked input buffer ──────────────────────────────────────────────
      val inputBufs = Seq.tabulate(N) { i =>
        val m = Mem(SInt(ActivationDType.bits bits), inLaneSize)
        m.setName(s"${cfg.periphName}_inputBuf_$i")
        m
      }

      // ── (P×N)-banked weight memory ─────────────────────────────────────────
      // Bank (p*N + i) stores weights for output channel group p (oc % P == p)
      // and input channel lane i (ci % N == i).
      // For P=1 this degenerates to the original N banks.
      val weightRomsFlat: Seq[Mem[SInt]] = Seq.tabulate(P * N) { j =>
        val p = j / N
        val i = j % N
        val m = Mem(SInt(ActivationDType.bits bits), cfg.wLaneSize)
        if (cfg.weightMode == WeightRom) {
          m.setName(s"${cfg.periphName}_weightRom_p${p}_i${i}")
          // Enumerate weights for this bank in (ocGroup, kr, kc, stepInCN) order.
          val bankData: Seq[BigInt] = for {
            ocGroup <- 0 until C_P
            kr      <- 0 until cfg.kernelH
            kc      <- 0 until cfg.kernelW
            step    <- 0 until C_N
          } yield {
            val oc      = ocGroup * P + p
            val ci      = step * N + i
            val flatIdx = oc * (cfg.kernelH * cfg.kernelW * cfg.inputShape.channels) +
                          kr * (cfg.kernelW * cfg.inputShape.channels) +
                          kc * cfg.inputShape.channels + ci
            BigInt(cfg.weights(flatIdx).toLong)
          }
          m.initBigInt(bankData, allowNegative = true)
        } else {
          m.setName(s"${cfg.periphName}_weightBuf_i${i}")  // P=1 required for stream
        }
        m
      }

      // ── WeightStream ports and state (P=1 only) ────────────────────────────
      val weightIn: Stream[Bits] = if (cfg.weightMode == WeightStream) {
        val s = Stream(Bits(512 bits))
        s.setName(s"${cfg.periphName}_weightIn")
        s
      } else null

      val wsBeatBuf:    Bits = if (cfg.weightMode == WeightStream) Reg(Bits(512 bits)) init 0 else null
      val wsDraining:   Bool = if (cfg.weightMode == WeightStream) Reg(Bool()) init False else null
      val wsBeatIdx:    UInt = if (cfg.weightMode == WeightStream) {
        val r = Reg(UInt(log2Up(cfg.beatsPerCh + 1) bits)) init 0
        r.setName(s"${cfg.periphName}_wsBeatIdx"); r
      } else null
      val wsStepInBeat: UInt = if (cfg.weightMode == WeightStream) {
        val r = Reg(UInt(log2Up(cfg.stepsPerBeat + 1) bits)) init 0
        r.setName(s"${cfg.periphName}_wsStepInBeat"); r
      } else null

      if (cfg.weightMode == WeightStream) {
        wsBeatBuf.setName(s"${cfg.periphName}_wsBeatBuf")
        wsDraining.setName(s"${cfg.periphName}_wsDraining")
      }

      // ── P bias ROMs of depth C_P ───────────────────────────────────────────
      // Bank p stores biases for channels p, p+P, p+2P, ... (index ocGroup → channel ocGroup*P+p)
      val biasRoms: Seq[Mem[SInt]] = Seq.tabulate(P) { p =>
        val m = Mem(SInt(32 bits), C_P)
        m.setName(s"${cfg.periphName}_biasRom_p$p")
        m.initBigInt((0 until C_P).map(ocGroup => BigInt(cfg.biases(ocGroup * P + p))), allowNegative = true)
        m
      }

      // ── P per-channel requant ROM pairs ────────────────────────────────────
      val reqMultRoms: Seq[Mem[UInt]] = if (cfg.perChannelRequant) Seq.tabulate(P) { p =>
        val m = Mem(UInt(32 bits), C_P)
        m.setName(s"${cfg.periphName}_reqMultRom_p$p")
        m.initBigInt((0 until C_P).map(ocGroup => BigInt(cfg.requantPerCh(ocGroup * P + p).multiplier)))
        m
      } else Seq.empty
      val reqShiftRoms: Seq[Mem[UInt]] = if (cfg.perChannelRequant) Seq.tabulate(P) { p =>
        val m = Mem(UInt(8 bits), C_P)
        m.setName(s"${cfg.periphName}_reqShiftRom_p$p")
        m.initBigInt((0 until C_P).map(ocGroup => BigInt(cfg.requantPerCh(ocGroup * P + p).shift)))
        m
      } else Seq.empty

      // ── Output stream ──────────────────────────────────────────────────────
      val activationOut = Stream(Activation())
      activationOut.setName(s"${cfg.periphName}_activationOut")

      // ── FSM state encoding ─────────────────────────────────────────────────
      val sReceive      = U(0,  4 bits)
      val sLoadBias     = U(1,  4 bits)
      val sCompute      = U(2,  4 bits)
      val sRequant      = U(3,  4 bits)
      val sRequantMul   = U(4,  4 bits)
      val sRequantWait  = U(5,  4 bits)
      val sRequantWait2 = U(6,  4 bits)
      val sRequantWait3 = U(7,  4 bits)
      val sRequantShift = U(8,  4 bits)
      val sEmit         = U(9,  4 bits)
      val sInit         = U(10, 4 bits)
      val sWaitBias     = U(11, 4 bits)
      val sLoadWeights  = U(12, 4 bits)

      val stateReg = Reg(UInt(4 bits)) init (if (cfg.hasPadding) 10 else 0)
      stateReg.setName(s"${cfg.periphName}_stateReg")

      // ── Counters ───────────────────────────────────────────────────────────
      val recvCntReg      = Reg(UInt(log2Up(cfg.inputShape.size + 1) bits)) init 0
      val padWriteAddrReg = Reg(UInt(log2Up(cfg.paddedSize + 1) bits)) init padBaseI
      val rowElemReg      = Reg(UInt(log2Up(rowElemsI + 1) bits)) init 0
      val outRowReg  = Reg(UInt(log2Up(cfg.outputShape.rows + 1) bits)) init 0
      val outColReg  = Reg(UInt(log2Up(cfg.outputShape.cols + 1) bits)) init 0
      // outChReg = output channel GROUP index (0 to C_P-1); actual channel = outChReg*P + p
      val outChReg   = Reg(UInt(log2Up(C_P + 1) bits)) init 0

      recvCntReg.setName(s"${cfg.periphName}_recvCntReg")
      padWriteAddrReg.setName(s"${cfg.periphName}_padWriteAddrReg")
      rowElemReg.setName(s"${cfg.periphName}_rowElemReg")
      outRowReg.setName(s"${cfg.periphName}_outRowReg")
      outColReg.setName(s"${cfg.periphName}_outColReg")
      outChReg.setName(s"${cfg.periphName}_outChReg")

      // ── P accumulator and requant pipeline register sets ───────────────────
      // All P sets run in parallel through the same FSM states.
      val accumRegs        = Seq.tabulate(P) { p => val r = Reg(SInt(32 bits)) init 0; r.setName(s"${cfg.periphName}_accumReg_p$p"); r }
      val prodRegs         = Seq.tabulate(P) { p => val r = Reg(SInt(32 bits)) init 0; r.setName(s"${cfg.periphName}_prodReg_p$p"); r }
      val accumRequantRegs = Seq.tabulate(P) { p => val r = Reg(SInt(32 bits)) init 0; r.setName(s"${cfg.periphName}_accumRequantReg_p$p"); r }
      val resultRegs       = Seq.tabulate(P) { p => val r = Reg(SInt(8  bits)) init 0; r.setName(s"${cfg.periphName}_resultReg_p$p"); r }
      val reqProdReg2s     = Seq.tabulate(P) { p => val r = Reg(SInt(64 bits)) init 0; r.setName(s"${cfg.periphName}_reqProdReg2_p$p"); r }
      val signARegs        = Seq.tabulate(P) { p => val r = Reg(Bool()) init False;     r.setName(s"${cfg.periphName}_signAReg_p$p"); r }
      val absARegs         = Seq.tabulate(P) { p => val r = Reg(UInt(32 bits)) init 0; r.setName(s"${cfg.periphName}_absAReg_p$p"); r }
      val pLL_Regs         = Seq.tabulate(P) { p => val r = Reg(UInt(32 bits)) init 0; r.setName(s"${cfg.periphName}_pLL_Reg_p$p"); r }
      val pLH_Regs         = Seq.tabulate(P) { p => val r = Reg(UInt(32 bits)) init 0; r.setName(s"${cfg.periphName}_pLH_Reg_p$p"); r }
      val pHL_Regs         = Seq.tabulate(P) { p => val r = Reg(UInt(32 bits)) init 0; r.setName(s"${cfg.periphName}_pHL_Reg_p$p"); r }
      val pHH_Regs         = Seq.tabulate(P) { p => val r = Reg(UInt(32 bits)) init 0; r.setName(s"${cfg.periphName}_pHH_Reg_p$p"); r }
      val pSumRegs         = Seq.tabulate(P) { p => val r = Reg(UInt(33 bits)) init 0; r.setName(s"${cfg.periphName}_pSumReg_p$p"); r }
      val pLL_Regs2        = Seq.tabulate(P) { p => val r = Reg(UInt(32 bits)) init 0; r.setName(s"${cfg.periphName}_pLL_Reg2_p$p"); r }
      val pHH_Regs2        = Seq.tabulate(P) { p => val r = Reg(UInt(32 bits)) init 0; r.setName(s"${cfg.periphName}_pHH_Reg2_p$p"); r }
      val part1Regs        = Seq.tabulate(P) { p => val r = Reg(UInt(64 bits)) init 0; r.setName(s"${cfg.periphName}_part1Reg_p$p"); r }
      val part2Regs        = Seq.tabulate(P) { p => val r = Reg(UInt(64 bits)) init 0; r.setName(s"${cfg.periphName}_part2Reg_p$p"); r }

      // emitPReg: cycles through 0..P-1 during sEmit to serialize P output channels.
      // Only created when P > 1; when P=1 we emit immediately without a counter.
      val emitPReg: UInt = if (P > 1) {
        val r = Reg(UInt(log2Up(P) bits)) init 0
        r.setName(s"${cfg.periphName}_emitPReg")
        r
      } else null

      val initAddrReg: UInt = if (cfg.hasPadding) {
        val r = Reg(UInt(inAddrBits bits)) init 0
        r.setName(s"${cfg.periphName}_initAddrReg")
        r
      } else U(0, inAddrBits bits)

      val inAddrReg  = Reg(UInt(inAddrBits bits)) init 0
      val wAddrReg   = Reg(UInt(wAddrBits  bits)) init 0

      inAddrReg.setName(s"${cfg.periphName}_inAddrReg")
      wAddrReg.setName(s"${cfg.periphName}_wAddrReg")

      val totalSteps   = C_N * cfg.kernelH * cfg.kernelW
      val compCycleReg = Reg(UInt(log2Up(totalSteps + 3) bits)) init 0
      val rowStepReg   = Reg(UInt(log2Up(cfg.kernelW * C_N + 1) bits)) init 0

      compCycleReg.setName(s"${cfg.periphName}_compCycleReg")
      rowStepReg.setName(s"${cfg.periphName}_rowStepReg")

      // ── Combinatorial BRAM address wires ──────────────────────────────────
      val inAddrComb = UInt(inAddrBits bits)
      val wAddrComb  = UInt(wAddrBits  bits)
      inAddrComb := inAddrReg
      wAddrComb  := wAddrReg

      // Activation reads: N banks (shared across all P output channel groups).
      val inValsR = Seq.tabulate(N)(i => inputBufs(i).readSync(inAddrComb.resized))

      // Weight reads: P×N banks, all addressed by wAddrComb simultaneously.
      val wValsR = Seq.tabulate(P * N)(j => weightRomsFlat(j).readSync(wAddrComb.resized))

      // P bias reads (continuous, captured in sWaitBias).
      val biasVals = biasRoms.map(_.readSync(outChReg.resized))

      // P per-channel requant reads (continuous, used in sRequantMul).
      val reqMultVals  = if (cfg.perChannelRequant) reqMultRoms.map(_.readSync(outChReg.resized))  else null
      val reqShiftVals = if (cfg.perChannelRequant) reqShiftRoms.map(_.readSync(outChReg.resized)) else null

      // Latch registers for the pipelined MAC stage.
      val inValsReg = Seq.tabulate(N) { i =>
        val r = Reg(SInt(ActivationDType.bits bits)) init 0
        r.setName(s"${cfg.periphName}_inValsReg_$i"); r
      }
      val wValsReg = Seq.tabulate(P * N) { j =>
        val p = j / N; val i = j % N
        val r = Reg(SInt(ActivationDType.bits bits)) init 0
        r.setName(s"${cfg.periphName}_wValsReg_p${p}_i${i}"); r
      }

      // ── Lane address helpers ───────────────────────────────────────────────
      def inLaneAddr(row: UInt, col: UInt, step: UInt): UInt =
        (row * U(cfg.paddedCols * C_N) + col * U(C_N) + step).resized

      // Weight address within a bank: same formula for all P banks since they
      // all index their own per-group C_P×kH×kW×C_N address space.
      def wLaneAddr(ocGroup: UInt, kr: UInt, kc: UInt, step: UInt): UInt =
        (ocGroup * U(cfg.kernelH * cfg.kernelW * C_N) +
         kr      * U(cfg.kernelW * C_N) +
         kc      * U(C_N) + step).resized

      // ── Unified write port per input bank ─────────────────────────────────
      for (i <- 0 until N) {
        val doInit = if (cfg.hasPadding) (stateReg === sInit) else False
        val doRecv = if (N == 1)
          stateReg === sReceive && activationIn.fire
        else
          stateReg === sReceive && activationIn.fire &&
            padWriteAddrReg(log2Up(N) - 1 downto 0) === U(i, log2Up(N) bits)

        // WeightStream write to weight buffer bank (p=0, i) — P=1 required.
        val doWLoad: Bool = if (cfg.weightMode == WeightStream) {
          stateReg === sLoadWeights && wsDraining &&
            (wsBeatIdx * U(cfg.stepsPerBeat) + wsStepInBeat) < U(cfg.weightsPerCh)
        } else False

        val wrAddr: UInt = (
          if (cfg.weightMode == WeightStream)
            Mux(doWLoad,
              (wsBeatIdx * U(cfg.stepsPerBeat) + wsStepInBeat).resized,
              if (N == 1) Mux(doInit, initAddrReg.resize(inAddrBits), padWriteAddrReg.resize(inAddrBits))
              else        Mux(doInit, initAddrReg.resize(inAddrBits), (padWriteAddrReg >> log2Up(N)).resize(inAddrBits)))
          else if (N == 1) Mux(doInit, initAddrReg.resize(inAddrBits), padWriteAddrReg.resize(inAddrBits))
          else             Mux(doInit, initAddrReg.resize(inAddrBits), (padWriteAddrReg >> log2Up(N)).resize(inAddrBits))
        )

        val wLoadData: SInt = if (cfg.weightMode == WeightStream) {
          val byteOffset = (wsStepInBeat * U(N) + U(i)).resize(9)
          (wsBeatBuf >> (byteOffset @@ U(0, 3 bits))).resize(8).asSInt
        } else S(0, ActivationDType.bits bits)

        val wrData = if (cfg.weightMode == WeightStream)
          Mux(doWLoad,
            wLoadData,
            Mux(doInit,
              S(cfg.inputQuant.zeroPoint.toLong, ActivationDType.bits bits),
              activationIn.payload.value))
        else
          Mux(doInit,
            S(cfg.inputQuant.zeroPoint.toLong, ActivationDType.bits bits),
            activationIn.payload.value)

        inputBufs(i).write(wrAddr.resized, wrData, doInit || doRecv)
        // Weight buffer write: only for WeightStream (P=1), targets bank (p=0, i).
        if (cfg.weightMode == WeightStream) weightRomsFlat(i).write(wrAddr.resized, wLoadData, doWLoad)
      }

      // ── Defaults ──────────────────────────────────────────────────────────
      activationIn.ready          := False
      activationOut.valid         := False
      activationOut.payload.value := resultRegs(0)
      if (cfg.weightMode == WeightStream) weightIn.ready := False

      // ── INIT ──────────────────────────────────────────────────────────────
      if (cfg.hasPadding) {
        when(stateReg === sInit) {
          when(initAddrReg === U(inLaneSize - 1)) {
            initAddrReg := 0
            stateReg    := sReceive
          } otherwise {
            initAddrReg := initAddrReg + 1
          }
        }
      }

      // ── RECEIVE ───────────────────────────────────────────────────────────
      when(stateReg === sReceive) {
        activationIn.ready := True
        when(activationIn.fire) {
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
            outRowReg := 0; outColReg := 0; outChReg := 0
            stateReg  := (if (cfg.weightMode == WeightStream) sLoadWeights else sLoadBias)
          }
        }
      }

      // ── LOAD_WEIGHTS (WeightStream, P=1 only) ─────────────────────────────
      if (cfg.weightMode == WeightStream) {
        when(stateReg === sLoadWeights) {
          when(!wsDraining) {
            weightIn.ready := True
            when(weightIn.fire) {
              wsBeatBuf    := weightIn.payload
              wsDraining   := True
              wsStepInBeat := 0
            }
          } otherwise {
            wsStepInBeat := wsStepInBeat + 1
            when(wsStepInBeat === U(cfg.stepsPerBeat - 1)) {
              wsStepInBeat := 0
              wsDraining   := False
              wsBeatIdx    := wsBeatIdx + 1
              when(wsBeatIdx === U(cfg.beatsPerCh - 1)) {
                wsBeatIdx := 0
                stateReg  := sLoadBias
              }
            }
          }
        }
      }

      // ── LOAD_BIAS ─────────────────────────────────────────────────────────
      when(stateReg === sLoadBias) {
        inAddrReg := inLaneAddr(outRowReg * U(cfg.strideH), outColReg * U(cfg.strideW), U(0, log2Up(C_N + 1) bits)).resized
        wAddrReg  := (if (cfg.weightMode == WeightRom)
                        wLaneAddr(outChReg, U(0), U(0), U(0, log2Up(C_N + 1) bits)).resized
                      else U(0, wAddrBits bits))
        compCycleReg := 0
        rowStepReg   := 0
        stateReg     := sWaitBias
      }

      // ── WAIT_BIAS ─────────────────────────────────────────────────────────
      when(stateReg === sWaitBias) {
        for (p <- 0 until P) accumRegs(p) := biasVals(p)
        stateReg := sCompute
      }

      // ── COMPUTE (Pipelined MAC across P output groups) ─────────────────────
      val rowWrapOffset = (cfg.paddedCols - cfg.kernelW) * C_N + 1

      when(stateReg === sCompute) {
        compCycleReg := compCycleReg + 1

        when(compCycleReg < totalSteps) {
          inAddrComb := inAddrReg
          wAddrComb  := wAddrReg

          wAddrReg := wAddrReg + 1
          val isRowWrap = rowStepReg === (cfg.kernelW * C_N - 1)
          inAddrReg  := inAddrReg + Mux(isRowWrap, U(rowWrapOffset, inAddrBits bits), U(1, inAddrBits bits))
          rowStepReg := Mux(isRowWrap, U(0, rowStepReg.getWidth bits), rowStepReg + 1)
        }

        when(compCycleReg >= 1 && compCycleReg <= totalSteps) {
          for (i <- 0 until N) inValsReg(i) := inValsR(i)
          for (j <- 0 until P * N) wValsReg(j) := wValsR(j)
        }

        when(compCycleReg >= 2 && compCycleReg <= totalSteps + 1) {
          // Balanced-tree reduction: log2(N) adder levels vs N-1 for a left-fold.
          // Functionally identical for int8 inputs (partial sums never overflow 32 bits).
          def treeReduce(xs: Seq[SInt]): SInt = xs match {
            case Seq(x)    => x
            case Seq(a, b) => a + b
            case _         => treeReduce(xs.grouped(2).map(g => if (g.size == 2) g(0) + g(1) else g(0)).toSeq)
          }
          val inZP = S(cfg.inputQuant.zeroPoint.toLong,  ActivationDType.adjBits bits)
          val wZP  = S(cfg.weightQuant.zeroPoint.toLong, ActivationDType.adjBits bits)
          for (p <- 0 until P) {
            val partials = (0 until N).map { i =>
              val inAdj = inValsReg(i).resize(ActivationDType.adjBits) - inZP
              val wAdj  = wValsReg(p * N + i).resize(ActivationDType.adjBits) - wZP
              (inAdj * wAdj).resize(32)
            }
            prodRegs(p) := treeReduce(partials).resize(32)
          }
        }

        when(compCycleReg >= 3 && compCycleReg <= totalSteps + 2) {
          for (p <- 0 until P) {
            val accumNew = (accumRegs(p) + prodRegs(p)).resize(32)
            accumRegs(p) := accumNew
            when(compCycleReg === U(totalSteps + 2)) {
              accumRequantRegs(p) := accumNew
            }
          }
          when(compCycleReg === U(totalSteps + 2)) {
            stateReg     := sRequant
            compCycleReg := 0
          }
        }
      }

      // ── REQUANT pipeline (P parallel channels) ─────────────────────────────
      when(stateReg === sRequant) {
        for (p <- 0 until P) {
          absARegs(p)  := Mux(accumRequantRegs(p) < 0, -accumRequantRegs(p), accumRequantRegs(p)).asUInt
          signARegs(p) := accumRequantRegs(p) < 0
        }
        stateReg := sRequantMul
      }

      when(stateReg === sRequantMul) {
        for (p <- 0 until P) {
          val mHW = if (cfg.perChannelRequant) reqMultVals(p) else U(cfg.requant.multiplier, 32 bits)
          val aH  = absARegs(p)(31 downto 16)
          val aL  = absARegs(p)(15 downto 0)
          val bH  = mHW(31 downto 16)
          val bL  = mHW(15 downto 0)
          pLL_Regs(p) := aL * bL
          pLH_Regs(p) := aL * bH
          pHL_Regs(p) := aH * bL
          pHH_Regs(p) := aH * bH
        }
        stateReg := sRequantWait
      }

      when(stateReg === sRequantWait) {
        for (p <- 0 until P) {
          pSumRegs(p)  := pLH_Regs(p).resize(33) + pHL_Regs(p).resize(33)
          pLL_Regs2(p) := pLL_Regs(p)
          pHH_Regs2(p) := pHH_Regs(p)
        }
        stateReg := sRequantWait2
      }

      when(stateReg === sRequantWait2) {
        for (p <- 0 until P) {
          part1Regs(p) := (pLL_Regs2(p).resize(64) + (pSumRegs(p).resize(64) << 16).resized).resized
          part2Regs(p) := (pHH_Regs2(p).resize(64) << 32).resized
        }
        stateReg := sRequantWait3
      }

      when(stateReg === sRequantWait3) {
        for (p <- 0 until P) {
          val sumPart     = (part1Regs(p) + part2Regs(p)).resized
          val signedFinal = Mux(signARegs(p), -sumPart.asSInt, sumPart.asSInt)
          reqProdReg2s(p) := signedFinal
        }
        stateReg := sRequantShift
      }

      when(stateReg === sRequantShift) {
        for (p <- 0 until P) {
          val shifted = (if (cfg.perChannelRequant) (reqProdReg2s(p) >> reqShiftVals(p))
                         else (reqProdReg2s(p) >> cfg.requant.shift)).resize(32)
          val biased  = (shifted + S(cfg.outputQuant.zeroPoint.toLong, 32 bits)).resize(32)
          resultRegs(p) := Mux(biased > S(ActivationDType.maxVal, 32 bits),  S(ActivationDType.maxVal, ActivationDType.bits bits),
                           Mux(biased < S(ActivationDType.minVal, 32 bits), S(ActivationDType.minVal, ActivationDType.bits bits),
                               biased.resize(8)))
        }
        stateReg := sEmit
      }

      // ── EMIT (serial P-channel emission per spatial position) ──────────────
      when(stateReg === sEmit) {
        activationOut.valid := True

        // Select which of the P results to emit this cycle.
        if (P == 1) {
          activationOut.payload.value := resultRegs(0)
        } else {
          activationOut.payload.value := resultRegs(0)
          for (p <- 1 until P) {
            when(emitPReg === p) {
              activationOut.payload.value := resultRegs(p)
            }
          }
        }

        when(activationOut.fire) {
          val lastP: Bool = if (P == 1) True else (emitPReg === U(P - 1))

          if (P > 1) {
            emitPReg := Mux(lastP, U(0, emitPReg.getWidth bits), emitPReg + 1)
          }

          when(lastP) {
            val lastCh  = outChReg  === U(C_P - 1)
            val lastCol = outColReg === U(cfg.outputShape.cols - 1)
            val lastRow = outRowReg === U(cfg.outputShape.rows - 1)

            outChReg := Mux(lastCh,  U(0, outChReg.getWidth  bits), (outChReg  + 1).resize(outChReg.getWidth))
            when(lastCh) {
              outColReg := Mux(lastCol, U(0, outColReg.getWidth bits), (outColReg + 1).resize(outColReg.getWidth))
              when(lastCol) {
                outRowReg := Mux(lastRow, U(0, outRowReg.getWidth bits), (outRowReg + 1).resize(outRowReg.getWidth))
              }
            }
            stateReg := Mux(lastCh && lastCol && lastRow,
                          sReceive,
                          (if (cfg.weightMode == WeightStream) sLoadWeights else sLoadBias))
          }
        }
      }
    }

    Io(activationOut = logic.activationOut,
       weightIn      = if (cfg.weightMode == WeightStream) logic.weightIn else null)
  }
}
