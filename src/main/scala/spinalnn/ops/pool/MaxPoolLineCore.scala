package spinalnn.ops.pool

import spinal.core._
import spinal.lib._
import spinalnn.types._
import spinalnn.util.PrefixArea

/**
 * BRAM-efficient MaxPool using a poolH-row circular line buffer.
 *
 * Replaces [[MaxPoolCore]]'s full H×W×C input buffer with poolH row Mems,
 * each of depth `W × C_in`. BRAM reduction ≈ H / poolH.
 *
 * Dataflow: alternates sReceiveRow / sPool / sEmit. After receiving poolH
 * real rows, computes all output (col, channel) positions for the current
 * output row before returning to sReceiveRow for the next strideH rows.
 *
 * No padding support in this implementation (covers SqueezeNet and standard
 * ImageNet MaxPool layers which use floor-mode VALID pooling).
 */
object MaxPoolLineCore {

  case class Config(
    periphName:  String,
    inputShape:  TensorShape,
    outputShape: TensorShape,
    poolH:       Int = 3,
    poolW:       Int = 3,
    strideH:     Int = 2,
    strideW:     Int = 2
  ) {
    require(poolH >= 1 && poolW >= 1, s"pool window must be >= 1")
    require(outputShape.rows == (inputShape.rows - poolH) / strideH + 1,
      s"outputShape.rows ${outputShape.rows} != (${inputShape.rows} - $poolH) / $strideH + 1")
    require(outputShape.cols == (inputShape.cols - poolW) / strideW + 1,
      s"outputShape.cols ${outputShape.cols} != (${inputShape.cols} - $poolW) / $strideW + 1")
    require(outputShape.channels == inputShape.channels, "channels must match input")

    val C: Int           = inputShape.channels
    val W: Int           = inputShape.cols
    val H: Int           = inputShape.rows
    val rowBufDepth: Int = W * C
    val windowSize:  Int = poolH * poolW
  }

  case class Io(activationOut: Stream[Activation])

  def build(cfg: Config, activationIn: Stream[Activation]): Io = {
    require(activationIn != null, "activationIn is required")

    val K_H  = cfg.poolH
    val K_W  = cfg.poolW
    val C    = cfg.C
    val W    = cfg.W
    val H    = cfg.H
    val sH   = cfg.strideH
    val sW   = cfg.strideW
    val outH = cfg.outputShape.rows
    val outW = cfg.outputShape.cols
    val outC = cfg.outputShape.channels
    val D    = cfg.rowBufDepth

    // Number of input rows consumed by the outH pool computations.
    // consumedRows = K_H + (outH-1)*sH.  Any input rows beyond this index are
    // tail rows that must be drained without entering the ring buffer.
    val consumedRows = K_H + (outH - 1) * sH
    val nTailRows    = H - consumedRows   // 0 when H == consumedRows (e.g. pool1)

    val phaseMax       = cfg.windowSize + 2
    // Mem address width = log2Up(D) exactly. log2Up(D+1) overshoots by 1 when D is a power of 2
    // (e.g. D=4 → 3 bits, but Mem[4] expects 2-bit addresses).
    val rowBufAddrBits = scala.math.max(1, log2Up(D))
    // Ensure at least 1-bit width for slot registers (log2Up(1) = 0).
    val slotBits       = scala.math.max(1, log2Up(K_H))

    val logic = new PrefixArea(cfg.periphName) {

      // ── K_H row Mems ──────────────────────────────────────────────────────
      val rowBufs: Seq[Mem[SInt]] = Seq.tabulate(K_H) { k =>
        val m = Mem(SInt(ActivationDType.bits bits), D)
        m.setName(s"${cfg.periphName}_rowBuf_$k")
        m
      }

      val activationOut = Stream(Activation())
      activationOut.setName(s"${cfg.periphName}_activationOut")

      // ── FSM ───────────────────────────────────────────────────────────────
      val sReceiveRow = U(0, 2 bits)
      val sPool       = U(1, 2 bits)
      val sEmit       = U(2, 2 bits)

      val stateReg = Reg(UInt(2 bits)) init 0
      stateReg.setName(s"${cfg.periphName}_stateReg")

      // ── Circular row-buffer state ─────────────────────────────────────────
      // rowWrPtrReg: slot index for the NEXT incoming row.
      // After receiving K_H rows, rowWrPtrReg wraps back and circAdd(rowWrPtrReg, kr)
      // yields the slot holding the row that is kr positions back from the front.
      val rowWrPtrReg = Reg(UInt(slotBits bits)) init 0
      rowWrPtrReg.setName(s"${cfg.periphName}_rowWrPtrReg")

      val rowsUntilComputeReg = Reg(UInt(log2Up(K_H + 1) bits)) init K_H
      rowsUntilComputeReg.setName(s"${cfg.periphName}_rowsUntilComputeReg")

      val realRowsRecvReg = Reg(UInt(log2Up(H + 1) bits)) init 0
      realRowsRecvReg.setName(s"${cfg.periphName}_realRowsRecvReg")

      val rxStepReg = Reg(UInt(log2Up(W * C + 1) bits)) init 0
      rxStepReg.setName(s"${cfg.periphName}_rxStepReg")

      // ── Output position registers ─────────────────────────────────────────
      val outRowReg = Reg(UInt(log2Up(outH + 1) bits)) init 0
      val outColReg = Reg(UInt(log2Up(outW + 1) bits)) init 0
      val outChReg  = Reg(UInt(log2Up(outC + 1) bits)) init 0
      outRowReg.setName(s"${cfg.periphName}_outRowReg")
      outColReg.setName(s"${cfg.periphName}_outColReg")
      outChReg.setName(s"${cfg.periphName}_outChReg")

      // ── Pool-window counters ───────────────────────────────────────────────
      val phaseReg = Reg(UInt(log2Up(phaseMax + 1) bits)) init 0
      val krReg    = Reg(UInt(log2Up(K_H + 1) bits)) init 0
      val kcReg    = Reg(UInt(log2Up(K_W + 1) bits)) init 0
      phaseReg.setName(s"${cfg.periphName}_phaseReg")
      krReg.setName(s"${cfg.periphName}_krReg")
      kcReg.setName(s"${cfg.periphName}_kcReg")

      val maxReg = Reg(SInt(ActivationDType.bits bits)) init 0
      maxReg.setName(s"${cfg.periphName}_maxReg")

      // Slot selector for reading (registered; set one phase ahead of use).
      val curSlotReg = Reg(UInt(slotBits bits)) init 0
      curSlotReg.setName(s"${cfg.periphName}_curSlotReg")

      // ── Circular-buffer helpers ───────────────────────────────────────────
      def circNext(a: UInt): UInt =
        Mux(a === U(K_H - 1, slotBits bits),
            U(0, slotBits bits),
            (a + 1).resize(slotBits))

      def circAdd(a: UInt, b: UInt): UInt = {
        val w   = log2Up(K_H * 2 + 1)
        val sum = a.resize(w) + b.resize(w)
        Mux(sum >= U(K_H, w bits),
            (sum - U(K_H, w bits)).resize(slotBits),
            sum.resize(slotBits))
      }

      // ── Row-buffer read infrastructure ────────────────────────────────────
      // rowAddrComb drives all K_H BRAMs every cycle; curSlotReg selects
      // which readSync output to use (1-cycle BRAM latency + 1-cycle latch).
      val rowAddrComb = UInt(rowBufAddrBits bits)
      rowAddrComb := 0  // default; overridden in sPool

      val rowReads:    Vec[SInt] = Vec(rowBufs.map(_.readSync(rowAddrComb.resized)))
      val readData:    SInt      = rowReads(curSlotReg)
      val readDataReg            = Reg(SInt(ActivationDType.bits bits)) init 0
      readDataReg.setName(s"${cfg.periphName}_readDataReg")

      // ── Unified write port per slot ────────────────────────────────────────
      // Tail rows (realRowsRecvReg >= consumedRows) must not enter the ring buffer.
      for (slot <- 0 until K_H) {
        val isTailRow: Bool =
          if (nTailRows > 0) realRowsRecvReg >= U(consumedRows) else False
        val doWrite = stateReg === sReceiveRow &&
                      (rowWrPtrReg === U(slot, slotBits bits)) &&
                      activationIn.fire &&
                      !isTailRow
        rowBufs(slot).write(rxStepReg.resize(rowBufAddrBits),
                            activationIn.payload.value,
                            doWrite)
      }

      // ── Defaults ──────────────────────────────────────────────────────────
      activationIn.ready          := False
      activationOut.valid         := False
      activationOut.payload.value := maxReg

      // ── RECEIVE ROW ─────────────────────────────────────────────────────────
      when(stateReg === sReceiveRow) {
        activationIn.ready := True

        when(activationIn.fire) {
          val rowEnd = rxStepReg === U(W * C - 1)
          rxStepReg := Mux(rowEnd, U(0, rxStepReg.getWidth bits),
                                   (rxStepReg + 1).resize(rxStepReg.getWidth))

          when(rowEnd) {
            if (nTailRows > 0) {
              // When stride > 1 and H > consumedRows, tail rows arrive after the
              // last pool computation.  Drain them without touching the ring buffer.
              // realRowsRecvReg is NOT reset in sEmit.lastRow so we can detect them.
              val isTailRow: Bool = realRowsRecvReg >= U(consumedRows)
              when(isTailRow) {
                when(realRowsRecvReg === U(H - 1)) {
                  // Last tail row consumed: full reset for the next inference.
                  realRowsRecvReg := 0
                  // rowWrPtrReg / rowsUntilComputeReg were already reset in sEmit.lastRow.
                } .otherwise {
                  realRowsRecvReg := realRowsRecvReg + 1
                }
              } .otherwise {
                rowWrPtrReg     := circNext(rowWrPtrReg)
                realRowsRecvReg := realRowsRecvReg + 1
                when(rowsUntilComputeReg <= 1) {
                  rowsUntilComputeReg := U(sH)
                  krReg    := 0
                  kcReg    := 0
                  phaseReg := 0
                  stateReg := sPool
                } .otherwise {
                  rowsUntilComputeReg := rowsUntilComputeReg - 1
                }
              }
            } else {
              rowWrPtrReg     := circNext(rowWrPtrReg)
              realRowsRecvReg := realRowsRecvReg + 1
              when(rowsUntilComputeReg <= 1) {
                rowsUntilComputeReg := U(sH)
                krReg    := 0
                kcReg    := 0
                phaseReg := 0
                stateReg := sPool
              } .otherwise {
                rowsUntilComputeReg := rowsUntilComputeReg - 1
              }
            }
          }
        }
      }

      // ── POOL ────────────────────────────────────────────────────────────────
      // Runs the K_H × K_W window for the current (outCol, outCh) output pixel.
      // Phase 0..windowSize-1: issue BRAM addresses, advance kr/kc, latch curSlotReg.
      // Phase 2..windowSize+1: fold arriving taps (2-cycle read pipeline) into maxReg.
      // Phase windowSize+2 (phaseMax): transition to sEmit.
      when(stateReg === sPool) {
        readDataReg := readData   // latch every cycle; used 1 cycle later in fold

        // Stage 0: issue tap addresses, update curSlotReg for the tap being issued.
        when(phaseReg < U(cfg.windowSize)) {
          val tapAddr = (outColReg * U(sW) + kcReg.resize(outColReg.getWidth)) *
                        U(C) + outChReg.resize(rowBufAddrBits)
          rowAddrComb := tapAddr.resize(rowBufAddrBits)
          curSlotReg  := circAdd(rowWrPtrReg, krReg.resize(slotBits))

          val lastKc = kcReg === U(K_W - 1)
          kcReg := Mux(lastKc, U(0, kcReg.getWidth bits), (kcReg + 1).resized)
          when(lastKc) { krReg := (krReg + 1).resized }
        }

        // Fold taps into running max as they arrive (2-cycle latency).
        when(phaseReg === U(2)) {
          maxReg := readDataReg
        } .elsewhen(phaseReg > U(2) && phaseReg <= U(cfg.windowSize + 1)) {
          maxReg := Mux(readDataReg > maxReg, readDataReg, maxReg)
        }

        // Advance phase; emit when done.
        when(phaseReg < U(phaseMax)) {
          phaseReg := phaseReg + 1
        } .otherwise {
          phaseReg := 0
          krReg    := 0
          kcReg    := 0
          stateReg := sEmit
        }
      }

      // ── EMIT ───────────────────────────────────────────────────────────────
      // Emit one output value per clock (when ready). Advances outChReg (inner),
      // then outColReg, then outRowReg (outer) — HWC output order.
      when(stateReg === sEmit) {
        activationOut.valid         := True
        activationOut.payload.value := maxReg

        when(activationOut.fire) {
          val lastCh  = outChReg  === U(outC - 1)
          val lastCol = outColReg === U(outW - 1)
          val lastRow = outRowReg === U(outH - 1)

          outChReg := Mux(lastCh, U(0, outChReg.getWidth bits), (outChReg + 1).resized)

          when(lastCh) {
            outColReg := Mux(lastCol, U(0, outColReg.getWidth bits), (outColReg + 1).resized)

            when(lastCol) {
              // Finished all columns of this output row.
              outRowReg := Mux(lastRow, U(0, outRowReg.getWidth bits), (outRowReg + 1).resized)

              when(lastRow) {
                // All pool outputs emitted.  Reset ring-buffer control so the
                // next rows received start a fresh inference.  When nTailRows > 0,
                // do NOT reset realRowsRecvReg here — it stays at consumedRows so
                // that sReceiveRow can identify and drain the pending tail rows.
                rxStepReg           := 0
                rowsUntilComputeReg := U(K_H)
                rowWrPtrReg         := U(0, slotBits bits)
                if (nTailRows == 0) {
                  realRowsRecvReg := 0
                }
                stateReg := sReceiveRow
              } .otherwise {
                stateReg := sReceiveRow  // more rows to pool; receive strideH more
              }
            } .otherwise {
              // Next column of the same output row: reset pool and loop.
              phaseReg := 0
              krReg    := 0
              kcReg    := 0
              stateReg := sPool
            }
          } .otherwise {
            // Next channel of the same (row, col) output pixel.
            phaseReg := 0
            krReg    := 0
            kcReg    := 0
            stateReg := sPool
          }
        }
      }
    }

    Io(activationOut = logic.activationOut)
  }
}
