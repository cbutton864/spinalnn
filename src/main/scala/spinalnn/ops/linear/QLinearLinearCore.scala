package spinalnn.ops.linear

import spinal.core._
import spinal.lib._
import spinalnn.types._
import spinalnn.util.PrefixArea

// Fully-connected INT8 layer (ONNX QLinearMatMul / Linear).
// Same RECEIVE -> LOAD_BIAS -> ITER -> EMIT FSM as QLinearConvCore but with
// no spatial indices -- just inNeuron (input dimension) and outNeuron (output).
// Weight layout: [C_out, C_in] row-major.
object QLinearLinearCore {

  case class Config(
    periphName:  String,
    inNeurons:   Int,
    outNeurons:  Int,
    inputQuant:  QuantParams,
    weightQuant: QuantParams,
    outputQuant: QuantParams,
    weights:     Array[Byte],   // [outNeurons, inNeurons] row-major
    biases:      Array[Int]     // [outNeurons]
  ) {
    require(weights.length == outNeurons * inNeurons,
      s"weights.length ${weights.length} != outNeurons*inNeurons ${outNeurons * inNeurons}")
    require(biases.length == outNeurons,
      s"biases.length ${biases.length} != outNeurons $outNeurons")

    val requant: RequantScale =
      RequantScale(inputQuant.scale, weightQuant.scale, outputQuant.scale)
  }

  case class Io(activationOut: Stream[Activation])

  def build(cfg: Config, activationIn: Stream[Activation] = null): Io = {
    require(activationIn != null, "activationIn is required")

    val inAddrBits   = log2Up(cfg.inNeurons)
    val wAddrBits    = log2Up(cfg.weights.length)
    val biasAddrBits = log2Up(cfg.biases.length)
    val outAddrBits  = log2Up(cfg.outNeurons)

    val logic = new PrefixArea(cfg.periphName) {

      // ── Memory ───────────────────────────────────────────────────────────
      val inputBuf = Mem(SInt(ActivationDType.bits bits), cfg.inNeurons)
      inputBuf.setName(s"${cfg.periphName}_inputBuf")

      val weightRom = Mem(SInt(ActivationDType.bits bits), cfg.weights.length)
      weightRom.setName(s"${cfg.periphName}_weightRom")
      weightRom.init(cfg.weights.map(b => S(b.toLong, ActivationDType.bits bits)).toSeq)

      val biasRom = Mem(SInt(32 bits), cfg.biases.length)
      biasRom.setName(s"${cfg.periphName}_biasRom")
      biasRom.init(cfg.biases.map(b => S(b.toLong, 32 bits)).toSeq)

      val activationOut = Stream(Activation())
      activationOut.setName(s"${cfg.periphName}_activationOut")

      // ── FSM ──────────────────────────────────────────────────────────────
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

      // ── Counters ─────────────────────────────────────────────────────────
      val recvCntReg   = Reg(UInt(log2Up(cfg.inNeurons  + 1) bits)) init 0
      val outNeurReg   = Reg(UInt(log2Up(cfg.outNeurons + 1) bits)) init 0
      val compCycleReg = Reg(UInt(log2Up(cfg.inNeurons  + 3) bits)) init 0
      val accumReg     = Reg(SInt(32 bits)) init 0
      val prodReg      = Reg(SInt(32 bits)) init 0
      val resultReg    = Reg(SInt(8  bits)) init 0
      val reqProdReg1  = Reg(SInt(64 bits)) init 0
      val reqProdReg2  = Reg(SInt(64 bits)) init 0
      val accumRequantReg = Reg(SInt(32 bits)) init 0

      // ── Requant Multiplier Pipeline registers ─────────────────────────────
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

      recvCntReg.setName(s"${cfg.periphName}_recvCntReg")
      outNeurReg.setName(s"${cfg.periphName}_outNeurReg")
      compCycleReg.setName(s"${cfg.periphName}_compCycleReg")
      accumReg.setName(s"${cfg.periphName}_accumReg")
      prodReg.setName(s"${cfg.periphName}_prodReg")
      resultReg.setName(s"${cfg.periphName}_resultReg")
      reqProdReg1.setName(s"${cfg.periphName}_reqProdReg1")
      reqProdReg2.setName(s"${cfg.periphName}_reqProdReg2")
      accumRequantReg.setName(s"${cfg.periphName}_accumRequantReg")
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

      // ── Pipeline Registers for RAM separation ─────────────────────────────
      val inValReg = Reg(SInt(ActivationDType.bits bits)) init 0
      val wValReg  = Reg(SInt(ActivationDType.bits bits)) init 0
      inValReg.setName(s"${cfg.periphName}_inValReg")
      wValReg.setName(s"${cfg.periphName}_wValReg")

      // ── Combinatorial BRAM address wires ──────────────────────────────────
      val inAddrComb = UInt(inAddrBits bits)
      val wAddrComb  = UInt(wAddrBits  bits)
      inAddrComb := 0
      wAddrComb  := 0

      val inValR = inputBuf.readSync(inAddrComb)
      val wValR  = weightRom.readSync(wAddrComb)

      // ── Defaults ─────────────────────────────────────────────────────────
      activationIn.ready          := False
      activationOut.valid         := False
      activationOut.payload.value := resultReg

      // ── RECEIVE ──────────────────────────────────────────────────────────
      when(stateReg === sReceive) {
        activationIn.ready := True
        when(activationIn.fire) {
          inputBuf.write(recvCntReg.resize(inAddrBits), activationIn.payload.value)
          recvCntReg := recvCntReg + 1
          when(recvCntReg === (cfg.inNeurons - 1)) {
            recvCntReg := 0
            outNeurReg := 0
            stateReg   := sLoadBias
          }
        }
      }

      // ── LOAD_BIAS ────────────────────────────────────────────────────────
      when(stateReg === sLoadBias) {
        accumReg     := biasRom.readAsync(outNeurReg.resize(biasAddrBits))
        compCycleReg := 0
        stateReg     := sCompute
      }

      // ── COMPUTE (Pipelined MAC) ──────────────────────────────────────────
      when(stateReg === sCompute) {
        compCycleReg := compCycleReg + 1

        // Stage 0: Address Generation (active for cycles 0 to inNeurons - 1)
        when(compCycleReg < cfg.inNeurons) {
          inAddrComb := compCycleReg.resize(inAddrBits)
          wAddrComb  := (outNeurReg * U(cfg.inNeurons) + compCycleReg).resize(wAddrBits)
        }

        // Stage 1: Memory output registration (active for cycles 1 to inNeurons)
        when(compCycleReg >= 1 && compCycleReg <= cfg.inNeurons) {
          inValReg := inValR
          wValReg  := wValR
        }

        // Stage 2: Multiplication (active for cycles 2 to inNeurons + 1)
        when(compCycleReg >= 2 && compCycleReg <= cfg.inNeurons + 1) {
          val inAdj = inValReg.resize(ActivationDType.adjBits) - S(cfg.inputQuant.zeroPoint.toLong,  ActivationDType.adjBits bits)
          val wAdj  = wValReg.resize(ActivationDType.adjBits)  - S(cfg.weightQuant.zeroPoint.toLong, ActivationDType.adjBits bits)
          prodReg  := (inAdj * wAdj).resize(32)
        }

        // Stage 3: Accumulation (active for cycles 3 to inNeurons + 2)
        when(compCycleReg >= 3 && compCycleReg <= cfg.inNeurons + 2) {
          val accumNew = (accumReg + prodReg).resize(32)
          accumReg := accumNew

          when(compCycleReg === (cfg.inNeurons + 2)) {
            accumRequantReg := accumNew
            stateReg        := sRequant
            compCycleReg    := 0
          }
        }
      }

      // ── REQUANT ──────────────────────────────────────────────────────────
      when(stateReg === sRequant) {
        absAReg  := Mux(accumRequantReg < 0, -accumRequantReg, accumRequantReg).asUInt
        signAReg := accumRequantReg < 0
        stateReg := sRequantMul
      }

      // ── REQUANT_MUL ──────────────────────────────────────────────────────
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

      // ── REQUANT_WAIT ─────────────────────────────────────────────────────
      when(stateReg === sRequantWait) {
        pSumReg  := pLH_Reg.resize(33) + pHL_Reg.resize(33)
        pLL_Reg2 := pLL_Reg
        pHH_Reg2 := pHH_Reg
        stateReg := sRequantWait2
      }

      // ── REQUANT_WAIT2 ────────────────────────────────────────────────────
      when(stateReg === sRequantWait2) {
        part1Reg := (pLL_Reg2.resize(64) + (pSumReg.resize(64) << 16).resized).resized
        part2Reg := (pHH_Reg2.resize(64) << 32).resized
        stateReg := sRequantWait3
      }

      // ── REQUANT_WAIT3 ────────────────────────────────────────────────────
      when(stateReg === sRequantWait3) {
        val sumPart = (part1Reg + part2Reg).resized
        val signedFinal = Mux(signAReg, -sumPart.asSInt, sumPart.asSInt)
        reqProdReg2 := signedFinal
        stateReg    := sRequantShift
      }

      // ── REQUANT_SHIFT_CLAMP ──────────────────────────────────────────────
      when(stateReg === sRequantShift) {
        val shifted = (reqProdReg2 >> cfg.requant.shift).resize(32)
        val biased  = (shifted + S(cfg.outputQuant.zeroPoint.toLong, 32 bits)).resize(32)

        resultReg := Mux(biased > S(ActivationDType.maxVal, 32 bits),  S(ActivationDType.maxVal, ActivationDType.bits bits),
                     Mux(biased < S(ActivationDType.minVal, 32 bits), S(ActivationDType.minVal, ActivationDType.bits bits),
                         biased.resize(8)))
        stateReg  := sEmit
      }

      // ── EMIT ─────────────────────────────────────────────────────────────
      when(stateReg === sEmit) {
        activationOut.valid         := True
        activationOut.payload.value := resultReg

        when(activationOut.fire) {
          val lastOut = outNeurReg === (cfg.outNeurons - 1)
          outNeurReg := Mux(lastOut, U(0, outNeurReg.getWidth bits),
                                     (outNeurReg + 1).resize(outNeurReg.getWidth))
          stateReg   := Mux(lastOut, sReceive, sLoadBias)
        }
      }
    }

    Io(activationOut = logic.activationOut)
  }
}
