package spinalnn.ops.concat

import spinal.core._
import spinal.lib._
import spinalnn.types._
import spinalnn.util.PrefixArea

// Channel-wise concatenation of N activation streams (ONNX Concat, axis = channels).
//
// All inputs share the same spatial dimensions (rows x cols); their channel counts
// may differ. Because streams are HWC (channel innermost), concatenating along the
// channel axis is a pure streaming mux: at every spatial position emit input0's
// channels, then input1's channels, ... in order. No buffering, no BRAM, full
// throughput (one element per cycle when downstream is ready).
//
// This is the first multi-input operator -- it exercises fan-in wiring. Producers
// of the N inputs run as independent feedforward branches; backpressure on the
// non-selected inputs is safe (no deadlock for a feedforward DAG).
object ConcatCore {

  case class Config(
    periphName:  String,
    inputShapes: Seq[TensorShape]
  ) {
    require(inputShapes.length >= 2, "Concat needs at least 2 inputs")
    require(
      inputShapes.forall(s => s.rows == inputShapes.head.rows && s.cols == inputShapes.head.cols),
      s"all Concat inputs must share spatial dims; got ${inputShapes.mkString(", ")}"
    )
    val rows:        Int         = inputShapes.head.rows
    val cols:        Int         = inputShapes.head.cols
    val outChannels: Int         = inputShapes.map(_.channels).sum
    val outputShape: TensorShape = TensorShape(rows, cols, outChannels)
  }

  case class Io(activationOut: Stream[Activation])

  def build(cfg: Config, activationIns: Seq[Stream[Activation]] = null): Io = {
    require(activationIns != null, "activationIns is required")
    require(activationIns.length == cfg.inputShapes.length,
      s"stream count ${activationIns.length} != inputShapes ${cfg.inputShapes.length}")

    val N      = cfg.inputShapes.length
    val maxCh  = cfg.inputShapes.map(_.channels).max
    val cntW   = log2Up(maxCh + 1)

    val logic = new PrefixArea(cfg.periphName) {
      val activationOut = Stream(Activation())
      activationOut.setName(s"${cfg.periphName}_activationOut")

      // selReg = which input is currently being forwarded; chCntReg = channel index
      // within that input. When chCntReg reaches the selected input's channel count,
      // advance to the next input (wrapping after the last), which steps the spatial
      // position implicitly as the inputs keep streaming.
      val selReg   = Reg(UInt(log2Up(N) bits)) init 0
      val chCntReg = Reg(UInt(cntW bits)) init 0
      selReg.setName(s"${cfg.periphName}_selReg")
      chCntReg.setName(s"${cfg.periphName}_chCntReg")

      // Defaults (prevent latches): no input ready, no output.
      for (i <- 0 until N) activationIns(i).ready := False
      activationOut.valid         := False
      activationOut.payload.value := activationIns(0).payload.value

      // Channel count of the currently-selected input.
      val cSel = UInt(cntW bits)
      cSel := U(cfg.inputShapes(0).channels, cntW bits)

      switch(selReg) {
        for (i <- 0 until N) {
          is(i) {
            activationOut.valid         := activationIns(i).valid
            activationIns(i).ready      := activationOut.ready
            activationOut.payload.value := activationIns(i).payload.value
            cSel                        := U(cfg.inputShapes(i).channels, cntW bits)
          }
        }
      }

      when(activationOut.fire) {
        when(chCntReg === (cSel - 1)) {
          chCntReg := 0
          selReg   := Mux(selReg === U(N - 1), U(0, selReg.getWidth bits), (selReg + 1).resized)
        } otherwise {
          chCntReg := (chCntReg + 1).resized
        }
      }
    }

    Io(activationOut = logic.activationOut)
  }
}
