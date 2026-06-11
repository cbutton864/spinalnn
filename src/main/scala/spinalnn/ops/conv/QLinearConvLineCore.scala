package spinalnn.ops.conv

import spinal.core._
import spinal.lib._
import spinalnn.target.{WeightMode, WeightRom, WeightStream}
import spinalnn.types._
import spinalnn.util.PrefixArea

/**
 * BRAM-efficient INT8 conv using a K_H-row circular line buffer.
 *
 * Replaces the full H×W×C input BRAM of [[QLinearConvCore]] with K_H row Mems,
 * each of depth `paddedCols × (C_in / macParallelism)` per MAC bank.
 * BRAM reduction ≈ H / K_H (e.g. 75× for 224-row input, K_H=3).
 *
 * macParallelism (N) banks the channel dimension: N MACs fire per cycle,
 * reducing compute cycles by N× with the same total BRAM footprint.
 * Requires C_in % N == 0.  For WeightStream also requires 64 % N == 0
 * (beat-drain writes N bytes per step: stepsPerBeat = 64/N).
 *
 * Dataflow: after sInit (if padding), alternates sReceiveRow / sLoadBias…sEmit.
 * Each real (or virtual pad) row is received before the next output row is computed.
 */
object QLinearConvLineCore {

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
    weightMode:      WeightMode           = WeightRom,
    macParallelism:  Int                  = 1
  ) {
    require(kernelH >= 1, s"QLinearConvLineCore requires kernelH >= 1 (got $kernelH)")
    require(macParallelism >= 1, s"macParallelism must be >= 1 (got $macParallelism)")
    require(inputShape.channels % macParallelism == 0,
      s"C_in (${inputShape.channels}) must be divisible by macParallelism ($macParallelism)")
    if (weightMode == WeightStream) {
      require(64 % macParallelism == 0,
        s"macParallelism ($macParallelism) must divide 64 for WeightStream beat-drain")
    }
    require(weights.length == outputShape.channels * kernelH * kernelW * inputShape.channels,
      s"weights.length ${weights.length} != ${outputShape.channels * kernelH * kernelW * inputShape.channels}")
    require(biases.length == outputShape.channels)
    require(padTop < kernelH,
      s"padTop ($padTop) must be < kernelH ($kernelH) for line-buffer scheduling")

    val N: Int           = macParallelism
    val C_in: Int        = inputShape.channels
    val CN: Int          = C_in / N              // channels per MAC bank
    val paddedCols: Int  = inputShape.cols + padLeft + padRight
    val hasPadding: Boolean = (padTop | padBottom | padLeft | padRight) != 0

    require(outputShape.rows == (inputShape.rows + padTop + padBottom - kernelH) / strideH + 1,
      s"outputShape.rows mismatch: got ${outputShape.rows}")
    require(outputShape.cols == (paddedCols - kernelW) / strideW + 1,
      s"outputShape.cols mismatch: got ${outputShape.cols}")

    val requant: RequantScale = RequantScale(inputQuant.scale, weightQuant.scale, outputQuant.scale)
    val perChannelRequant: Boolean = weightScales.isDefined
    val requantPerCh: Seq[RequantScale] = weightScales match {
      case Some(ws) =>
        require(ws.length == outputShape.channels)
        ws.map(w => RequantScale(inputQuant.scale, w, outputQuant.scale)).toSeq
      case None => Seq.fill(outputShape.channels)(requant)
    }

    val rowBufDepth:  Int = paddedCols * CN            // per MAC bank
    val wRomSize:     Int = outputShape.channels * kernelH * kernelW * C_in
    val weightsPerCh: Int = kernelH * kernelW * C_in
    // Per-bank weight buffer depth: weightsPerCh/N for WeightStream (single outCh),
    // wRomSize/N for WeightRom (all outCh interleaved by bank).
    val wBufSizePerBank: Int =
      if (weightMode == WeightStream) weightsPerCh / N else wRomSize / N
    val totalMacs:    Int = kernelH * kernelW * C_in   // MACs per output pixel
    val stepsPerComp: Int = kernelH * kernelW * CN     // compute steps = totalMacs / N
    val stepsPerBeat: Int = if (weightMode == WeightStream) 64 / N else 0
  }

  case class Io(activationOut: Stream[Activation], weightIn: Stream[Bits] = null)

  def build(cfg: Config, activationIn: Stream[Activation] = null): Io = {
    require(activationIn != null, "activationIn is required")

    val K_H  = cfg.kernelH
    val K_W  = cfg.kernelW
    val C    = cfg.C_in
    val N    = cfg.N
    val CN   = cfg.CN
    val outH = cfg.outputShape.rows
    val outW = cfg.outputShape.cols
    val outC = cfg.outputShape.channels
    val H    = cfg.inputShape.rows
    val W    = cfg.inputShape.cols
    val sH   = cfg.strideH
    val sW   = cfg.strideW
    val pL   = cfg.padLeft
    val pT   = cfg.padTop
    val D    = cfg.rowBufDepth    // paddedCols * CN per bank
    val T    = cfg.stepsPerComp   // K_H * K_W * CN compute steps

    val rowBufAddrBits = log2Up(D + 1)
    val wAddrBits      = log2Up(cfg.wBufSizePerBank + 1)
    val zp             = cfg.inputQuant.zeroPoint.toLong
    val slotBits       = scala.math.max(1, log2Up(K_H))

    val logic = new PrefixArea(cfg.periphName) {

      // ── K_H wide row Mems (N×8 bits each) ────────────────────────────────
      // Slot k: one N*8-bit-wide RAM of depth D = paddedCols * CN.
      // All N banks are read/written in a single wide access per cycle.
      // Byte b at bits [b*8+7 : b*8].  N separate narrow RAMs would fragment
      // into N physical blocks; one wide RAM uses the same bits far more
      // efficiently (e.g. N=16, D=64: 1 block instead of 16).
      val rowBufs: Seq[Mem[Bits]] = Seq.tabulate(K_H) { slot =>
        val m = Mem(Bits(N * 8 bits), D)
        m.setName(s"${cfg.periphName}_inputBuf_$slot")
        m
      }
      // zp repeated N times for padding / init writes
      val zpWideBits = Cat(Seq.fill(N)(B(zp.toInt & 0xFF, 8 bits)))

      // ── 1 wide weight mem (N×8 bits) ─────────────────────────────────────
      // Replaces N narrow 8-bit RAMs.  Address i stores weights[i*N..i*N+N-1]
      // (bank b was weights[i*N+b], same logical mapping, now packed).
      // For WeightRom all data is baked in; for WeightStream loaded per inference.
      val weightMem: Mem[Bits] = Mem(Bits(N * 8 bits), cfg.wBufSizePerBank)
      if (cfg.weightMode == WeightRom) {
        weightMem.setName(s"${cfg.periphName}_weightRom")
        val initData = Seq.tabulate(cfg.wBufSizePerBank) { i =>
          (0 until N).foldLeft(BigInt(0)) { (acc, b) =>
            val idx = i * N + b
            val w = if (idx < cfg.weights.length) cfg.weights(idx).toLong & 0xFFL else 0L
            acc | (BigInt(w) << (b * 8))
          }
        }
        weightMem.initBigInt(initData, allowNegative = false)
      } else {
        weightMem.setName(s"${cfg.periphName}_weightBuf")
      }

      // ── WeightStream registers ─────────────────────────────────────────────
      val weightIn: Stream[Bits] = if (cfg.weightMode == WeightStream) {
        val s = Stream(Bits(512 bits))
        s.setName(s"${cfg.periphName}_weightIn"); s
      } else null
      // wStepReg: per-bank word address during drain (0..weightsPerCh/N-1)
      val wStepReg: UInt = if (cfg.weightMode == WeightStream) {
        val r = Reg(UInt(wAddrBits bits)) init 0
        r.setName(s"${cfg.periphName}_wStepReg"); r
      } else null
      // wBeatStepReg: step within current beat (0..stepsPerBeat-1)
      val wBeatStepReg: UInt = if (cfg.weightMode == WeightStream) {
        val r = Reg(UInt(log2Up(cfg.stepsPerBeat + 1) bits)) init 0
        r.setName(s"${cfg.periphName}_wBeatStepReg"); r
      } else null
      val wBeatBuf: Bits = if (cfg.weightMode == WeightStream) {
        val r = Reg(Bits(512 bits)) init 0
        r.setName(s"${cfg.periphName}_wBeatBuf"); r
      } else null
      val wBeatDraining: Bool = if (cfg.weightMode == WeightStream) {
        val r = Reg(Bool()) init False
        r.setName(s"${cfg.periphName}_wBeatDraining"); r
      } else null

      // ── Bias and per-channel requant ROMs ──────────────────────────────────
      val biasRom = Mem(SInt(32 bits), cfg.biases.length)
      biasRom.setName(s"${cfg.periphName}_biasRom")
      biasRom.initBigInt(cfg.biases.map(BigInt(_)).toSeq, allowNegative = true)

      val reqMultRom = if (cfg.perChannelRequant) {
        val m = Mem(UInt(32 bits), outC)
        m.setName(s"${cfg.periphName}_reqMultRom")
        m.initBigInt(cfg.requantPerCh.map(r => BigInt(r.multiplier)).toSeq)
        m
      } else null

      val reqShiftRom = if (cfg.perChannelRequant) {
        val m = Mem(UInt(8 bits), outC)
        m.setName(s"${cfg.periphName}_reqShiftRom")
        m.initBigInt(cfg.requantPerCh.map(r => BigInt(r.shift)).toSeq)
        m
      } else null

      val activationOut = Stream(Activation())
      activationOut.setName(s"${cfg.periphName}_activationOut")

      // ── FSM state constants ────────────────────────────────────────────────
      val sReceiveRow   = U(0,  4 bits)
      val sLoadBias     = U(1,  4 bits)
      val sWaitBias     = U(2,  4 bits)
      val sCompute      = U(3,  4 bits)
      val sRequant      = U(4,  4 bits)
      val sRequantMul   = U(5,  4 bits)
      val sRequantWait  = U(6,  4 bits)
      val sRequantWait2 = U(7,  4 bits)
      val sRequantWait3 = U(8,  4 bits)
      val sRequantShift = U(9,  4 bits)
      val sEmit         = U(10, 4 bits)
      val sInit         = U(11, 4 bits)
      val sLoadWeights  = U(12, 4 bits)

      val initState = if (cfg.hasPadding) 11 else 0
      val stateReg  = Reg(UInt(4 bits)) init initState
      stateReg.setName(s"${cfg.periphName}_stateReg")

      // ── Row-buffer circular write pointer (0..K_H-1) ───────────────────────
      val rowWrPtrReg = Reg(UInt(slotBits bits)) init (pT % K_H)
      rowWrPtrReg.setName(s"${cfg.periphName}_rowWrPtrReg")

      val rowsUntilComputeReg = Reg(UInt(log2Up(K_H + 1) bits)) init (K_H - pT)
      rowsUntilComputeReg.setName(s"${cfg.periphName}_rowsUntilComputeReg")

      val realRowsRecvReg = Reg(UInt(log2Up(H + 1) bits)) init 0
      realRowsRecvReg.setName(s"${cfg.periphName}_realRowsRecvReg")

      // Receive phase: bank counter (0..N-1) and word-address counter.
      // Together they replace the old single rxStepReg: bankReg = step%N, wordReg = step/N.
      val rxBankReg = Reg(UInt(log2Up(N + 1) bits)) init 0
      val rxWordReg = Reg(UInt(log2Up(W * CN + 1) bits)) init 0
      rxBankReg.setName(s"${cfg.periphName}_rxBankReg")
      rxWordReg.setName(s"${cfg.periphName}_rxWordReg")

      // sInit counters.
      val initSlotReg  = Reg(UInt(slotBits bits))       init 0
      val initAddrReg  = Reg(UInt(log2Up(D + 1) bits))  init 0
      initSlotReg.setName(s"${cfg.periphName}_initSlotReg")
      initAddrReg.setName(s"${cfg.periphName}_initAddrReg")

      // Output position.
      val outRowReg = Reg(UInt(log2Up(outH + 1) bits)) init 0
      val outColReg = Reg(UInt(log2Up(outW + 1) bits)) init 0
      val outChReg  = Reg(UInt(log2Up(outC + 1) bits)) init 0
      outRowReg.setName(s"${cfg.periphName}_outRowReg")
      outColReg.setName(s"${cfg.periphName}_outColReg")
      outChReg.setName(s"${cfg.periphName}_outChReg")

      // Compute-phase position counters.
      val khCntReg     = Reg(UInt(log2Up(K_H + 1) bits))     init 0  // kernel row 0..K_H-1
      val rowStepReg   = Reg(UInt(log2Up(K_W * CN + 1) bits)) init 0  // step within kernel row (0..K_W*CN-1)
      val compCycleReg = Reg(UInt(log2Up(T + 4) bits))        init 0  // pipeline stage counter
      khCntReg.setName(s"${cfg.periphName}_khCntReg")
      rowStepReg.setName(s"${cfg.periphName}_rowStepReg")
      compCycleReg.setName(s"${cfg.periphName}_compCycleReg")

      val rowAddrBaseReg = Reg(UInt(rowBufAddrBits bits)) init 0
      val rowAddrReg     = Reg(UInt(rowBufAddrBits bits)) init 0
      val wAddrReg       = Reg(UInt(wAddrBits bits))      init 0
      rowAddrBaseReg.setName(s"${cfg.periphName}_rowAddrBaseReg")
      rowAddrReg.setName(s"${cfg.periphName}_rowAddrReg")
      wAddrReg.setName(s"${cfg.periphName}_wAddrReg")

      // Combinatorial address lines driving readSync every cycle.
      val rowAddrComb = UInt(rowBufAddrBits bits)
      val wAddrComb   = UInt(wAddrBits bits)
      rowAddrComb := rowAddrReg
      wAddrComb   := wAddrReg

      // Receive write address inside the padded row (per bank).
      // pL*(C/N) = pL*CN is the left-pad offset in bank-addressing.
      val rxAddr = U(pL * CN, rowBufAddrBits bits) + rxWordReg.resize(rowBufAddrBits)

      // ── Continuous readSync: all K_H×N row banks and all N weight banks ────
      // rowReads2D(slot)(bank): K_H wide reads, split into N byte lanes.
      // One synchronous read per slot; N bytes extracted combinationally.
      val rowWideReads: Seq[Bits] = rowBufs.map(_.readSync(rowAddrComb.resized))
      val rowReads2D: Vec[Vec[SInt]] = Vec(rowWideReads.map { wide =>
        Vec(Seq.tabulate(N) { b => wide(b * 8 + 7 downto b * 8).asSInt })
      })
      // One wide weight read; N byte lanes extracted combinationally.
      val wDataRaw: Bits = weightMem.readSync(wAddrComb.resized)
      val wValsRaw: Seq[SInt] = Seq.tabulate(N) { b => wDataRaw(b * 8 + 7 downto b * 8).asSInt }

      val biasVal     = biasRom.readSync(outChReg.resized)
      val reqMultVal  = if (cfg.perChannelRequant) reqMultRom.readSync(outChReg.resized)  else null
      val reqShiftVal = if (cfg.perChannelRequant) reqShiftRom.readSync(outChReg.resized) else null

      // ── Pipeline registers ────────────────────────────────────────────────
      val curSlotReg = Reg(UInt(slotBits bits))                init 0
      val inValRegs: Vec[SInt] = Vec(Reg(SInt(ActivationDType.bits bits)) init 0, N)
      val wValRegs:  Vec[SInt] = Vec(Reg(SInt(ActivationDType.bits bits)) init 0, N)
      curSlotReg.setName(s"${cfg.periphName}_curSlotReg")
      inValRegs.zipWithIndex.foreach { case (r,i) => r.setName(s"${cfg.periphName}_inValReg_$i") }
      wValRegs.zipWithIndex.foreach  { case (r,i) => r.setName(s"${cfg.periphName}_wValReg_$i") }

      // ── Accumulator and requant pipeline ──────────────────────────────────
      val accumReg        = Reg(SInt(32 bits)) init 0
      val prodSumReg      = Reg(SInt(32 bits)) init 0  // sum of N products per step
      val resultReg       = Reg(SInt(8 bits))  init 0
      val accumRequantReg = Reg(SInt(32 bits)) init 0
      val reqProdReg2     = Reg(SInt(64 bits)) init 0
      val signAReg        = Reg(Bool()) init False
      val absAReg         = Reg(UInt(32 bits)) init 0
      val pLL_Reg         = Reg(UInt(32 bits)) init 0
      val pLH_Reg         = Reg(UInt(32 bits)) init 0
      val pHL_Reg         = Reg(UInt(32 bits)) init 0
      val pHH_Reg         = Reg(UInt(32 bits)) init 0
      val pSumReg         = Reg(UInt(33 bits)) init 0
      val pLL_Reg2        = Reg(UInt(32 bits)) init 0
      val pHH_Reg2        = Reg(UInt(32 bits)) init 0
      val part1Reg        = Reg(UInt(64 bits)) init 0
      val part2Reg        = Reg(UInt(64 bits)) init 0
      Seq(accumReg, prodSumReg, resultReg, accumRequantReg, reqProdReg2,
          signAReg, absAReg, pLL_Reg, pLH_Reg, pHL_Reg, pHH_Reg, pSumReg,
          pLL_Reg2, pHH_Reg2, part1Reg, part2Reg
      ).zipWithIndex.foreach { case (r, i) => r.setName(s"${cfg.periphName}_rqReg_$i") }

      // ── Helpers ────────────────────────────────────────────────────────────
      def circNext(a: UInt): UInt =
        Mux(a === U(K_H - 1, a.getWidth bits),
            U(0, a.getWidth bits),
            (a + 1).resize(a.getWidth))

      def circAdd(a: UInt, b: UInt): UInt = {
        val w   = log2Up(K_H * 2 + 1)
        val sum = a.resize(w) + b.resize(w)
        Mux(sum >= U(K_H, w bits),
            (sum - U(K_H, w bits)).resize(slotBits),
            sum.resize(slotBits))
      }

      val isReal = realRowsRecvReg < U(H)

      // ── Unified wide write per slot ────────────────────────────────────────
      // sInit: write zpWideBits to the current initSlot at initAddrReg.
      // sReceiveRow real: accumulate bytes 0..N-2 in per-byte registers each fire;
      //   on lastBank fire, write all N bytes (accum + current) in one wide write.
      // sReceiveRow fill (!isReal): write zpWideBits on lastBank (no accumulate needed).
      //
      // Per-byte registers avoid partial Reg bit-slice assignment (not supported in SpinalHDL).
      val rxByteRegs: Vec[Bits] = Vec.fill(N)(Reg(Bits(8 bits)) init B(0, 8 bits))
      for (b <- 0 until N) {
        when(stateReg === sReceiveRow && isReal && activationIn.fire && rxBankReg === U(b)) {
          rxByteRegs(b) := activationIn.payload.value.asBits
        }
      }
      // Assemble wide receive data: bytes 0..N-2 from registers, byte N-1 from current input.
      val recvDataSeq: Seq[Bits] = Seq.tabulate(N) { b =>
        if (b == N - 1) activationIn.payload.value.asBits
        else rxByteRegs(b)
      }
      val recvData: Bits = Cat(recvDataSeq)  // byte 0 at LSBs, byte N-1 at MSBs

      for (slot <- 0 until K_H) {
        val isThisSlot = rowWrPtrReg === U(slot)
        val isInitSlot = initSlotReg === U(slot)
        val doLastBank = rxBankReg === U(N - 1)

        val doInit     = if (cfg.hasPadding) (stateReg === sInit && isInitSlot) else False
        val doRecvLast = stateReg === sReceiveRow && isThisSlot && isReal  && activationIn.fire && doLastBank
        val doFillLast = stateReg === sReceiveRow && isThisSlot && !isReal && doLastBank

        val wrEn   = doInit || doRecvLast || doFillLast
        val wrAddr = Mux(doInit, initAddrReg.resize(rowBufAddrBits), rxAddr.resize(rowBufAddrBits))
        val wrData = Mux(doRecvLast, recvData, zpWideBits)
        rowBufs(slot).write(wrAddr.resized, wrData, wrEn)
      }

      // ── Defaults ────────────────────────────────────────────────────────────
      activationIn.ready          := False
      activationOut.valid         := False
      activationOut.payload.value := resultReg
      if (cfg.weightMode == WeightStream) { weightIn.ready := False }

      // ── INIT ────────────────────────────────────────────────────────────────
      // Writes zp to all N banks of each slot simultaneously.
      // Runs K_H × D cycles (D = paddedCols*CN per bank, N× fewer than old K_H×paddedCols*C).
      if (cfg.hasPadding) {
        when(stateReg === sInit) {
          initAddrReg := initAddrReg + 1
          when(initAddrReg === U(D - 1)) {
            initAddrReg := 0
            initSlotReg := initSlotReg + 1
            when(initSlotReg === U(K_H - 1)) {
              initSlotReg         := 0
              rowWrPtrReg         := U(pT % K_H)
              rowsUntilComputeReg := U(K_H - pT)
              realRowsRecvReg     := 0
              rxBankReg           := 0
              rxWordReg           := 0
              outRowReg           := 0
              outColReg           := 0
              outChReg            := 0
              stateReg            := sReceiveRow
            }
          }
        }
      }

      // ── RECEIVE ROW ─────────────────────────────────────────────────────────
      // rxBankReg counts 0..N-1 per byte; rxWordReg = byte/N (word address).
      // A row is done when rxWordReg reaches W*CN-1 on the last bank.
      when(stateReg === sReceiveRow) {
        activationIn.ready := isReal

        val rxFire = (isReal && activationIn.fire) || !isReal
        when(rxFire) {
          val lastBank = rxBankReg === U(N - 1)
          rxBankReg := Mux(lastBank, U(0, rxBankReg.getWidth bits), (rxBankReg + 1).resize(rxBankReg.getWidth))
          when(lastBank) {
            rxWordReg := rxWordReg + 1
          }

          val rowDone = lastBank && rxWordReg === U(W * CN - 1)
          when(rowDone) {
            rxBankReg := 0
            rxWordReg := 0
            rowWrPtrReg := circNext(rowWrPtrReg)
            when(isReal) { realRowsRecvReg := realRowsRecvReg + 1 }

            when(rowsUntilComputeReg <= 1) {
              rowsUntilComputeReg := U(sH)
              stateReg := (if (cfg.weightMode == WeightStream) sLoadWeights else sLoadBias)
            } .otherwise {
              rowsUntilComputeReg := rowsUntilComputeReg - 1
            }
          }
        }
      }

      // ── LOAD WEIGHTS (WeightStream only) ──────────────────────────────────
      // Drain N bytes per step into the wide weight RAM at wStepReg.
      // stepsPerBeat = 64/N; beat carries stepsPerBeat × N = 64 bytes.
      if (cfg.weightMode == WeightStream) {
        when(stateReg === sLoadWeights) {
          when(!wBeatDraining) {
            weightIn.ready := True
            when(weightIn.fire) {
              wBeatBuf      := weightIn.payload
              wBeatDraining := True
              wBeatStepReg  := 0
            }
          } otherwise {
            // Write N bytes (low bits of beat buf) to wide weight RAM, advance address.
            when(wStepReg < U(cfg.weightsPerCh / N)) {
              weightMem.write(wStepReg.resized, wBeatBuf(N * 8 - 1 downto 0))
              wStepReg := wStepReg + 1
            }
            wBeatBuf     := (wBeatBuf >> (8 * N)).resized
            wBeatStepReg := wBeatStepReg + 1
            when(wBeatStepReg === U(cfg.stepsPerBeat - 1)) {
              wBeatDraining := False
              when(wStepReg >= U(cfg.weightsPerCh / N)) {
                wStepReg := 0
                stateReg := sLoadBias
              }
            }
          }
        }
      }

      // ── LOAD BIAS ──────────────────────────────────────────────────────────
      when(stateReg === sLoadBias) {
        val baseAddr = (outColReg * U(sW * CN)).resized
        rowAddrBaseReg := baseAddr
        rowAddrReg     := baseAddr
        wAddrReg       := (if (cfg.weightMode == WeightStream) U(0, wAddrBits bits)
                           else (outChReg * U(K_H * K_W * CN)).resized)
        khCntReg       := 0
        rowStepReg     := 0
        compCycleReg   := 0
        stateReg       := sWaitBias
      }

      // ── WAIT BIAS ──────────────────────────────────────────────────────────
      when(stateReg === sWaitBias) {
        accumReg := biasVal
        stateReg := sCompute
      }

      // ── COMPUTE (3-stage pipelined MAC × N) ───────────────────────────────
      when(stateReg === sCompute) {
        compCycleReg := compCycleReg + 1

        // Stage 0: present address, latch slot and kh/row counters.
        when(compCycleReg < U(T)) {
          curSlotReg := circAdd(rowWrPtrReg, khCntReg.resize(slotBits))
          wAddrReg   := wAddrReg + 1

          when(rowStepReg === U(K_W * CN - 1)) {
            rowStepReg := 0
            khCntReg   := khCntReg + 1
            rowAddrReg := rowAddrBaseReg
          } .otherwise {
            rowStepReg := rowStepReg + 1
            rowAddrReg := rowAddrReg + 1
          }
        }

        // Stage 1: capture readSync results for all N banks.
        // rowReads2D indexed by curSlotReg generates a hardware MUX over K_H options.
        when(compCycleReg >= 1 && compCycleReg <= U(T)) {
          for (b <- 0 until N) {
            inValRegs(b) := (if (K_H == 1) rowReads2D(0)(b) else rowReads2D(curSlotReg)(b))
            wValRegs(b)  := wValsRaw(b)
          }
        }

        // Stage 2: N parallel zero-point-adjusted MACs, reduce to partial sum.
        // Balanced-tree reduction gives log2(N) adder levels instead of the
        // N-1 levels of a left-fold, halving the combinational depth for N≥4.
        when(compCycleReg >= 2 && compCycleReg <= U(T + 1)) {
          val inZP = S(cfg.inputQuant.zeroPoint.toLong,  ActivationDType.adjBits bits)
          val wZP  = S(cfg.weightQuant.zeroPoint.toLong, ActivationDType.adjBits bits)
          val partials = (0 until N).map { b =>
            val inAdj = inValRegs(b).resize(ActivationDType.adjBits) - inZP
            val wAdj  = wValRegs(b).resize(ActivationDType.adjBits) - wZP
            (inAdj * wAdj).resize(32)
          }
          def treeReduce(xs: Seq[SInt]): SInt = xs match {
            case Seq(x)     => x
            case Seq(a, b)  => a + b
            case _          => treeReduce(xs.grouped(2).map(g => if (g.size == 2) g(0) + g(1) else g(0)).toSeq)
          }
          prodSumReg := treeReduce(partials).resize(32)
        }

        // Stage 3: accumulate; transition on the last MAC.
        when(compCycleReg >= 3 && compCycleReg <= U(T + 2)) {
          val accumNew = (accumReg + prodSumReg).resize(32)
          accumReg := accumNew
          when(compCycleReg === U(T + 2)) {
            accumRequantReg := accumNew
            compCycleReg    := 0
            stateReg        := sRequant
          }
        }
      }

      // ── REQUANT pipeline (unchanged from N=1) ─────────────────────────────

      when(stateReg === sRequant) {
        absAReg  := Mux(accumRequantReg < 0, -accumRequantReg, accumRequantReg).asUInt
        signAReg := accumRequantReg < 0
        stateReg := sRequantMul
      }

      when(stateReg === sRequantMul) {
        val mHW  = if (cfg.perChannelRequant) reqMultVal
                   else U(cfg.requant.multiplier, 32 bits)
        val aH = absAReg(31 downto 16); val aL = absAReg(15 downto 0)
        val bH = mHW(31 downto 16);     val bL = mHW(15 downto 0)
        pLL_Reg  := aL * bL
        pLH_Reg  := aL * bH
        pHL_Reg  := aH * bL
        pHH_Reg  := aH * bH
        stateReg := sRequantWait
      }

      when(stateReg === sRequantWait) {
        pSumReg  := pLH_Reg.resize(33) + pHL_Reg.resize(33)
        pLL_Reg2 := pLL_Reg
        pHH_Reg2 := pHH_Reg
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
        val shifted = (if (cfg.perChannelRequant) (reqProdReg2 >> reqShiftVal)
                       else                       (reqProdReg2 >> cfg.requant.shift)).resize(32)
        val biased  = (shifted + S(cfg.outputQuant.zeroPoint.toLong, 32 bits)).resize(32)
        resultReg  := Mux(biased > S(ActivationDType.maxVal, 32 bits),
                           S(ActivationDType.maxVal, ActivationDType.bits bits),
                     Mux(biased < S(ActivationDType.minVal, 32 bits),
                           S(ActivationDType.minVal, ActivationDType.bits bits),
                           biased.resize(ActivationDType.bits)))
        stateReg   := sEmit
      }

      // ── EMIT ───────────────────────────────────────────────────────────────
      when(stateReg === sEmit) {
        activationOut.valid         := True
        activationOut.payload.value := resultReg

        when(activationOut.fire) {
          val lastCh  = outChReg  === U(outC - 1)
          val lastCol = outColReg === U(outW - 1)
          val lastRow = outRowReg === U(outH - 1)

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
              when(lastRow) {
                realRowsRecvReg     := 0
                rxBankReg           := 0
                rxWordReg           := 0
                rowsUntilComputeReg := U(K_H - pT)
                rowWrPtrReg         := U(pT % K_H)
                initSlotReg         := 0
                initAddrReg         := 0
                stateReg            := (if (cfg.hasPadding) sInit else sReceiveRow)
              } .otherwise {
                stateReg := sReceiveRow
              }
            } .otherwise {
              stateReg := (if (cfg.weightMode == WeightStream) sLoadWeights else sLoadBias)
            }
          } .otherwise {
            stateReg := (if (cfg.weightMode == WeightStream) sLoadWeights else sLoadBias)
          }
        }
      }
    }

    Io(activationOut = logic.activationOut,
       weightIn      = if (cfg.weightMode == WeightStream) logic.weightIn else null)
  }
}
