package spinalnn.ops.pool

import spinal.core._
import spinal.lib._
import spinalnn.types._
import spinalnn.util.PrefixArea

// Global Average Pooling (ONNX GlobalAveragePool).
//
// Computes the average of each channel over its full spatial height and width:
//   out[ch] = (1 / (H * W)) * sum_{h,w} in[h, w, ch]
// Input is streamed in HWC order, which means each channel's elements are separated
// in time. To avoid storing the entire input tensor in a massive buffer (e.g. 196 KB for
// SqueezeNet), we accumulate the 32-bit sums on-the-fly inside an ultra-slim Dual-Port RAM
// of depth C (only 4 KB for 1000 channels).
//
// Performance is optimized via:
//  - On-the-fly accumulation with zero separate initialization cycles (the first spatial
//    pixel row==0 && col==0 bypasses read-add and direct-writes the input).
//  - 1-cycle pipeline write-forwarding to handle channel count C = 1 safely.
//  - High-precision 32-bit channel accumulators; the 1/area averaging is folded into an
//    elaboration-time requant multiplier (RequantScale.forAverage), so the datapath does an
//    integer multiply + shift + clamp -- never a hardware divider.
object GlobalAveragePoolCore {

  case class Config(
    periphName:  String,
    inputShape:  TensorShape,
    outputShape: TensorShape,
    inputQuant:  QuantParams,
    outputQuant: QuantParams
  ) {
    require(outputShape.rows == 1 && outputShape.cols == 1,
      s"GlobalAveragePool output spatial size must be 1x1; got ${outputShape.rows}x${outputShape.cols}")
    require(outputShape.channels == inputShape.channels,
      s"channels must match input; got input channels ${inputShape.channels} and output ${outputShape.channels}")

    val area: Int = inputShape.rows * inputShape.cols

    // The 1/area averaging is folded into the requant multiplier so the datapath needs an
    // integer multiply + shift instead of a hardware divider:
    //   real_avg = scaleIn * (1/area) * sum(q_in - zpIn)
    //   q_out    = real_avg / scaleOut + zpOut = M * (sum(q_in) - area*zpIn) + zpOut
    // where M = scaleIn / (area * scaleOut) is encoded as (multiplier, shift).
    val requant: RequantScale =
      RequantScale.forAverage(inputQuant.scale, area, outputQuant.scale)
  }

  case class Io(activationOut: Stream[Activation])

  def build(cfg: Config, activationIn: Stream[Activation] = null): Io = {
    require(activationIn != null, "activationIn is required")

    // At least 1 bit so a single-channel (C = 1) accumulator RAM still has a real address.
    val cW = log2Up(cfg.inputShape.channels) max 1

    val logic = new PrefixArea(cfg.periphName) {

      // Accumulator RAM of depth channels, storing 32-bit signed sums.
      val accumRam = Mem(SInt(32 bits), cfg.inputShape.channels)
      accumRam.setName(s"${cfg.periphName}_accumRam")

      val activationOut = Stream(Activation())
      activationOut.setName(s"${cfg.periphName}_activationOut")

      // ── FSM states ───────────────────────────────────────────────────────
      // RECEIVE streams the frame in (on-the-fly accumulation); SETTLE waits one cycle for
      // the last write; then a per-channel READ -> REQUANT (split multiply) -> EMIT sweep.
      val sReceive      = U(0, 4 bits)
      val sSettle       = U(1, 4 bits)
      val sReadAcc      = U(2, 4 bits)
      val sRequant      = U(3, 4 bits)
      val sRequantMul   = U(4, 4 bits)
      val sRequantWait  = U(5, 4 bits)
      val sRequantWait2 = U(6, 4 bits)
      val sRequantWait3 = U(7, 4 bits)
      val sRequantShift = U(8, 4 bits)
      val sEmit         = U(9, 4 bits)

      val stateReg = Reg(UInt(4 bits)) init sReceive
      stateReg.setName(s"${cfg.periphName}_stateReg")

      // ── Receive Counters (HWC tracking) ──────────────────────────────────
      val chReg  = Reg(UInt(log2Up(cfg.inputShape.channels + 1) bits)) init 0
      val colReg = Reg(UInt(log2Up(cfg.inputShape.cols     + 1) bits)) init 0
      val rowReg = Reg(UInt(log2Up(cfg.inputShape.rows     + 1) bits)) init 0
      chReg.setName(s"${cfg.periphName}_chReg")
      colReg.setName(s"${cfg.periphName}_colReg")
      rowReg.setName(s"${cfg.periphName}_rowReg")

      // ── Pipeline registers for on-the-fly accumulation ───────────────────
      val pipelineValidReg = RegInit(False)
      val inValReg         = Reg(SInt(ActivationDType.bits bits)) init 0
      val chReg_d1         = Reg(UInt(log2Up(cfg.inputShape.channels + 1) bits)) init 0
      val rowReg_d1        = Reg(UInt(log2Up(cfg.inputShape.rows + 1) bits)) init 0
      val colReg_d1        = Reg(UInt(log2Up(cfg.inputShape.cols + 1) bits)) init 0
      pipelineValidReg.setName(s"${cfg.periphName}_pipelineValidReg")
      inValReg.setName(s"${cfg.periphName}_inValReg")
      chReg_d1.setName(s"${cfg.periphName}_chReg_d1")
      rowReg_d1.setName(s"${cfg.periphName}_rowReg_d1")
      colReg_d1.setName(s"${cfg.periphName}_colReg_d1")

      // RAM read address: the live incoming channel during RECEIVE (read-modify-write of
      // the running sum), overridden to the emit channel during the requant states below.
      val readAddr = UInt(cW bits)
      readAddr := chReg.resize(cW)
      val readData = accumRam.readSync(readAddr)

      // ── Write-forwarding bypass (correct for C = 1, no combinational loop) ──
      // accPrevReg / prevChReg / prevValidReg hold the previous *processed* pixel's running
      // sum, channel and validity. Two consecutive processed pixels share a channel only
      // when C = 1 (channels are innermost), and then readSync has not yet reflected the
      // just-written value -- so forward the registered accumulator instead of the stale
      // BRAM output. The forwarded value is a register, so there is no combinational cycle.
      val accumOld     = SInt(32 bits)
      val accumNew     = SInt(32 bits)
      val accPrevReg   = Reg(SInt(32 bits)) init 0
      val prevChReg    = Reg(UInt(log2Up(cfg.inputShape.channels + 1) bits)) init 0
      val prevValidReg = RegInit(False)
      accPrevReg.setName(s"${cfg.periphName}_accPrevReg")
      prevChReg.setName(s"${cfg.periphName}_prevChReg")
      prevValidReg.setName(s"${cfg.periphName}_prevValidReg")

      when(prevValidReg && prevChReg === chReg_d1) {
        accumOld := accPrevReg
      } otherwise {
        accumOld := readData
      }

      // First spatial position (row=0, col=0) seeds each channel's sum; elsewhere accumulate.
      when(rowReg_d1 === 0 && colReg_d1 === 0) {
        accumNew := inValReg.resize(32)
      } otherwise {
        accumNew := accumOld + inValReg.resize(32)
      }

      accumRam.write(
        enable  = pipelineValidReg,
        address = chReg_d1.resize(cW),
        data    = accumNew
      )

      // Register the running accumulator for next-cycle write-forwarding.
      when(pipelineValidReg) {
        accPrevReg := accumNew
        prevChReg  := chReg_d1
      }
      prevValidReg := pipelineValidReg

      // ── Emit + requant registers ─────────────────────────────────────────
      // Each channel's 32-bit sum becomes an INT8 output via the same split 16x16 requant
      // pipeline used by the Conv and Linear cores; cfg.requant already folds in 1/area.
      val emitChReg   = Reg(UInt(log2Up(cfg.inputShape.channels + 1) bits)) init 0
      val absAReg     = Reg(UInt(32 bits)) init 0
      val signAReg    = Reg(Bool()) init False
      val pLL_Reg     = Reg(UInt(32 bits)) init 0
      val pLH_Reg     = Reg(UInt(32 bits)) init 0
      val pHL_Reg     = Reg(UInt(32 bits)) init 0
      val pHH_Reg     = Reg(UInt(32 bits)) init 0
      val pSumReg     = Reg(UInt(33 bits)) init 0
      val pLL_Reg2    = Reg(UInt(32 bits)) init 0
      val pHH_Reg2    = Reg(UInt(32 bits)) init 0
      val part1Reg    = Reg(UInt(64 bits)) init 0
      val part2Reg    = Reg(UInt(64 bits)) init 0
      val reqProdReg2 = Reg(SInt(64 bits)) init 0
      val resultReg   = Reg(SInt(ActivationDType.bits bits)) init 0
      emitChReg.setName(s"${cfg.periphName}_emitChReg")
      absAReg.setName(s"${cfg.periphName}_absAReg")
      signAReg.setName(s"${cfg.periphName}_signAReg")
      pLL_Reg.setName(s"${cfg.periphName}_pLL_Reg")
      pLH_Reg.setName(s"${cfg.periphName}_pLH_Reg")
      pHL_Reg.setName(s"${cfg.periphName}_pHL_Reg")
      pHH_Reg.setName(s"${cfg.periphName}_pHH_Reg")
      pSumReg.setName(s"${cfg.periphName}_pSumReg")
      pLL_Reg2.setName(s"${cfg.periphName}_pLL_Reg2")
      pHH_Reg2.setName(s"${cfg.periphName}_pHH_Reg2")
      part1Reg.setName(s"${cfg.periphName}_part1Reg")
      part2Reg.setName(s"${cfg.periphName}_part2Reg")
      reqProdReg2.setName(s"${cfg.periphName}_reqProdReg2")
      resultReg.setName(s"${cfg.periphName}_resultReg")

      // ── FSM Logic ────────────────────────────────────────────────────────
      activationIn.ready          := False
      activationOut.valid         := False
      activationOut.payload.value := resultReg

      switch(stateReg) {

        is(sReceive) {
          activationIn.ready := True
          when(activationIn.fire) {
            inValReg         := activationIn.payload.value
            chReg_d1         := chReg
            colReg_d1        := colReg
            rowReg_d1        := rowReg
            pipelineValidReg := True

            // Advance coordinates in HWC order
            val lastCh  = chReg  === (cfg.inputShape.channels - 1)
            val lastCol = colReg === (cfg.inputShape.cols     - 1)
            val lastRow = rowReg === (cfg.inputShape.rows     - 1)

            chReg := Mux(lastCh, U(0, chReg.getWidth bits), (chReg + 1).resized)
            when(lastCh) {
              colReg := Mux(lastCol, U(0, colReg.getWidth bits), (colReg + 1).resized)
              when(lastCol) {
                rowReg := Mux(lastRow, U(0, rowReg.getWidth bits), (rowReg + 1).resized)
                when(lastRow) {
                  // Transition at frame completion
                  stateReg := sSettle
                }
              }
            }
          } otherwise {
            pipelineValidReg := False
          }
        }

        // Wait one cycle for the final accumulation write of the frame to settle in BRAM,
        // then start the per-channel requant + emit sweep at channel 0.
        is(sSettle) {
          pipelineValidReg := False
          emitChReg        := 0
          stateReg         := sReadAcc
        }

        // Present accumRam[emitChReg]; readSync delivers the sum next cycle (sRequant).
        is(sReadAcc) {
          readAddr := emitChReg.resize(cW)
          stateReg := sRequant
        }

        // Subtract the (constant) input zero-point bias, then split into sign + magnitude.
        is(sRequant) {
          readAddr := emitChReg.resize(cW)
          val accVal = (readData - S(cfg.area.toLong * cfg.inputQuant.zeroPoint.toLong, 32 bits)).resize(32)
          absAReg  := Mux(accVal < 0, -accVal, accVal).asUInt
          signAReg := accVal < 0
          stateReg := sRequantMul
        }

        // Split 16x16 multiply of |acc| by the 32-bit requant multiplier (area-folded).
        is(sRequantMul) {
          val mHW = U(cfg.requant.multiplier, 32 bits)
          val aH  = absAReg(31 downto 16)
          val aL  = absAReg(15 downto 0)
          val bH  = mHW(31 downto 16)
          val bL  = mHW(15 downto 0)
          pLL_Reg  := aL * bL
          pLH_Reg  := aL * bH
          pHL_Reg  := aH * bL
          pHH_Reg  := aH * bH
          stateReg := sRequantWait
        }

        is(sRequantWait) {
          pSumReg  := pLH_Reg.resize(33) + pHL_Reg.resize(33)
          pLL_Reg2 := pLL_Reg
          pHH_Reg2 := pHH_Reg
          stateReg := sRequantWait2
        }

        is(sRequantWait2) {
          part1Reg := (pLL_Reg2.resize(64) + (pSumReg.resize(64) << 16).resized).resized
          part2Reg := (pHH_Reg2.resize(64) << 32).resized
          stateReg := sRequantWait3
        }

        is(sRequantWait3) {
          val sumPart     = (part1Reg + part2Reg).resized
          val signedFinal = Mux(signAReg, -sumPart.asSInt, sumPart.asSInt)
          reqProdReg2 := signedFinal
          stateReg    := sRequantShift
        }

        // Arithmetic shift back to INT8 scale, add output zero-point, clamp to [-128,127].
        is(sRequantShift) {
          val shifted = (reqProdReg2 >> cfg.requant.shift).resize(32)
          val biased  = (shifted + S(cfg.outputQuant.zeroPoint.toLong, 32 bits)).resize(32)
          resultReg := Mux(biased > S(ActivationDType.maxVal, 32 bits),  S(ActivationDType.maxVal, ActivationDType.bits bits),
                       Mux(biased < S(ActivationDType.minVal, 32 bits), S(ActivationDType.minVal, ActivationDType.bits bits),
                           biased.resize(8)))
          stateReg := sEmit
        }

        // Emit one channel average; advance to the next channel (or finish the frame).
        is(sEmit) {
          activationOut.valid := True
          when(activationOut.fire) {
            val lastCh = emitChReg === (cfg.inputShape.channels - 1)
            when(lastCh) {
              chReg     := 0
              colReg    := 0
              rowReg    := 0
              emitChReg := 0
              stateReg  := sReceive
            } otherwise {
              emitChReg := (emitChReg + 1).resized
              stateReg  := sReadAcc
            }
          }
        }
      }
    }

    Io(activationOut = logic.activationOut)
  }
}
