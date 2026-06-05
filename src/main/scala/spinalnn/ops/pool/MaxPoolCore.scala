package spinalnn.ops.pool

import spinal.core._
import spinal.lib._
import spinalnn.types._
import spinalnn.util.PrefixArea

object MaxPoolCore {

  case class Config(
    periphName:  String,
    inputShape:  TensorShape,
    outputShape: TensorShape,
    poolH:       Int = 2,
    poolW:       Int = 2,
    strideH:     Int = 2,
    strideW:     Int = 2
  ) {
    require(poolH >= 1 && poolW >= 1, "pool window must be >= 1")
    // ONNX floor-mode output formula with no padding:
    //   out = floor((in - kernel) / stride) + 1
    require(outputShape.rows == (inputShape.rows - poolH) / strideH + 1,
      s"outputShape.rows ${outputShape.rows} != (inputShape.rows ${inputShape.rows} - poolH $poolH)/strideH $strideH + 1")
    require(outputShape.cols == (inputShape.cols - poolW) / strideW + 1,
      s"outputShape.cols ${outputShape.cols} != (inputShape.cols ${inputShape.cols} - poolW $poolW)/strideW $strideW + 1")
    require(outputShape.channels == inputShape.channels, "channels must match input")
  }

  case class Io(activationOut: Stream[Activation])

  def build(cfg: Config, activationIn: Stream[Activation] = null): Io = {
    require(activationIn != null, "activationIn is required")

    val inAddrBits = log2Up(cfg.inputShape.size)

    val logic = new PrefixArea(cfg.periphName) {

      // Input activation buffer
      val inputBuf = Mem(SInt(ActivationDType.bits bits), cfg.inputShape.size)
      inputBuf.setName(s"${cfg.periphName}_inputBuf")

      val activationOut = Stream(Activation())
      activationOut.setName(s"${cfg.periphName}_activationOut")

      // ── FSM: false = RECEIVE, true = COMPUTE ─────────────────────────────
      val computeReg = RegInit(False)
      computeReg.setName(s"${cfg.periphName}_computeReg")

      // Receive counter
      val recvCntReg = Reg(UInt(log2Up(cfg.inputShape.size + 1) bits)) init 0
      recvCntReg.setName(s"${cfg.periphName}_recvCntReg")

      // Output position registers
      val outRowReg = Reg(UInt(log2Up(cfg.outputShape.rows     + 1) bits)) init 0
      val outColReg = Reg(UInt(log2Up(cfg.outputShape.cols     + 1) bits)) init 0
      val outChReg  = Reg(UInt(log2Up(cfg.outputShape.channels + 1) bits)) init 0
      outRowReg.setName(s"${cfg.periphName}_outRowReg")
      outColReg.setName(s"${cfg.periphName}_outColReg")
      outChReg.setName(s"${cfg.periphName}_outChReg")

      // Flat HWC address: row * W * C + col * C + ch
      def flatAddr(row: UInt, col: UInt, ch: UInt): UInt =
        (row * U(cfg.inputShape.cols * cfg.inputShape.channels) +
         col * U(cfg.inputShape.channels) + ch).resize(inAddrBits)

      // Sub-state counter for the sequential windowed-max read pipeline.
      val windowSize = cfg.poolH * cfg.poolW
      val phaseMax   = windowSize + 2     // terminal (emit) phase
      val phaseReg   = Reg(UInt(log2Up(phaseMax + 1) bits)) init 0
      val krReg      = Reg(UInt(log2Up(cfg.poolH + 1) bits)) init 0
      val kcReg      = Reg(UInt(log2Up(cfg.poolW + 1) bits)) init 0
      phaseReg.setName(s"${cfg.periphName}_phaseReg")
      krReg.setName(s"${cfg.periphName}_krReg")
      kcReg.setName(s"${cfg.periphName}_kcReg")

      val maxReg = Reg(SInt(ActivationDType.bits bits)) init 0
      maxReg.setName(s"${cfg.periphName}_maxReg")

      // Combinatorial address wire
      val readAddr = UInt(inAddrBits bits)
      readAddr := 0

      val readData = inputBuf.readSync(readAddr)
      val readDataReg = Reg(SInt(ActivationDType.bits bits)) init 0
      readDataReg.setName(s"${cfg.periphName}_readDataReg")

      // Defaults
      activationIn.ready          := False
      activationOut.valid         := False
      activationOut.payload.value := maxReg

      // ── RECEIVE ──────────────────────────────────────────────────────────
      when(!computeReg) {
        activationIn.ready := True
        phaseReg           := 0
        krReg              := 0
        kcReg              := 0
        when(activationIn.fire) {
          inputBuf.write(recvCntReg.resize(inAddrBits), activationIn.payload.value)
          recvCntReg := recvCntReg + 1
          when(recvCntReg === (cfg.inputShape.size - 1)) {
            recvCntReg  := 0
            outRowReg   := 0
            outColReg   := 0
            outChReg    := 0
            computeReg  := True
          }
        }
      }

      // ── COMPUTE ──────────────────────────────────────────────────────────
      // General poolH x poolW window with arbitrary stride. Window taps are read
      // one per cycle through readSync (BRAM friendly) with a 2-cycle read pipeline
      // (readSync -> readDataReg); the running max folds each tap as it arrives.
      // phaseReg sequences one output position:
      //   0 .. windowSize-1 : issue tap addresses (krReg/kcReg walk the window)
      //   2                 : first tap arrives  -> seed maxReg
      //   3 .. windowSize+1 : remaining taps     -> fold into maxReg
      //   windowSize+2      : emit, advance output position
      // For the default 2x2/stride-2 pool this reduces to the original schedule.
      when(computeReg) {
        readDataReg := readData

        val inRow = (outRowReg * U(cfg.strideH) + krReg).resize(log2Up(cfg.inputShape.rows + 1))
        val inCol = (outColReg * U(cfg.strideW) + kcReg).resize(log2Up(cfg.inputShape.cols + 1))
        val ch    = outChReg.resize(log2Up(cfg.inputShape.channels + 1))

        // Issue tap addresses for window elements 0 .. windowSize-1.
        when(phaseReg < U(windowSize)) {
          readAddr := flatAddr(inRow, inCol, ch)
          val lastKc = kcReg === U(cfg.poolW - 1)
          kcReg := Mux(lastKc, U(0, kcReg.getWidth bits), (kcReg + 1).resized)
          when(lastKc) { krReg := (krReg + 1).resized }
        }

        // Fold taps into the running max as they arrive (2-cycle read latency).
        when(phaseReg === U(2)) {
          maxReg := readDataReg
        } elsewhen (phaseReg > U(2) && phaseReg <= U(windowSize + 1)) {
          maxReg := Mux(readDataReg > maxReg, readDataReg, maxReg)
        }

        // Advance phase; emit and step the output position at the terminal phase.
        when(phaseReg < U(phaseMax)) {
          phaseReg := phaseReg + 1
        } otherwise {
          activationOut.valid := True
          when(activationOut.fire) {
            val lastCh  = outChReg  === (cfg.outputShape.channels - 1)
            val lastCol = outColReg === (cfg.outputShape.cols     - 1)
            val lastRow = outRowReg === (cfg.outputShape.rows     - 1)

            outChReg := Mux(lastCh, U(0, outChReg.getWidth bits),
                                    (outChReg + 1).resize(outChReg.getWidth))
            when(lastCh) {
              outColReg := Mux(lastCol, U(0, outColReg.getWidth bits),
                                        (outColReg + 1).resize(outColReg.getWidth))
              when(lastCol) {
                outRowReg := Mux(lastRow, U(0, outRowReg.getWidth bits),
                                          (outRowReg + 1).resize(outRowReg.getWidth))
                when(lastRow) { computeReg := False }
              }
            }
            phaseReg := 0
            krReg    := 0
            kcReg    := 0
          }
        }
      }
    }

    Io(activationOut = logic.activationOut)
  }
}
