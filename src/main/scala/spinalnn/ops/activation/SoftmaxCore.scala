package spinalnn.ops.activation

import spinal.core._
import spinal.lib._
import spinalnn.types._
import spinalnn.util.PrefixArea

// Softmax v1: argmax. Finds the index of the maximum logit and emits it.
// Sufficient for top-1 classification accuracy validation (MNIST, etc.).
// Full softmax (probability output) is a future extension.
//
// FSM: RECEIVE (buffer all logits, track running max) -> EMIT (output argmax index)
// Output: single SInt(8 bits) carrying the winning class index [0, numClasses-1].
object SoftmaxCore {

  case class Config(
    periphName: String = "softmax",
    numClasses: Int
  ) {
    require(numClasses > 1,  "numClasses must be > 1")
    require(numClasses < 128, "numClasses must be < 128 for SInt(8) index output")
  }

  case class Io(activationOut: Stream[Activation])

  def build(cfg: Config, activationIn: Stream[Activation] = null): Io = {
    require(activationIn != null, "activationIn is required")

    val idxBits = log2Up(cfg.numClasses)

    val logic = new PrefixArea(cfg.periphName) {

      val activationOut = Stream(Activation())
      activationOut.setName(s"${cfg.periphName}_activationOut")

      // ── FSM: false = RECEIVE, true = EMIT ────────────────────────────────
      val emitReg = RegInit(False)
      emitReg.setName(s"${cfg.periphName}_emitReg")

      val recvCntReg = Reg(UInt(log2Up(cfg.numClasses + 1) bits)) init 0
      val maxValReg  = Reg(SInt(8 bits)) init S(ActivationDType.minVal, ActivationDType.bits bits)
      val maxIdxReg  = Reg(UInt(idxBits bits)) init 0
      recvCntReg.setName(s"${cfg.periphName}_recvCntReg")
      maxValReg.setName(s"${cfg.periphName}_maxValReg")
      maxIdxReg.setName(s"${cfg.periphName}_maxIdxReg")

      // Defaults
      activationIn.ready          := False
      activationOut.valid         := False
      activationOut.payload.value := maxIdxReg.resize(8).asSInt

      // ── RECEIVE ──────────────────────────────────────────────────────────
      // Track max incrementally: first element always becomes the initial max;
      // subsequent elements replace it only if strictly greater (first wins on ties).
      when(!emitReg) {
        activationIn.ready := True
        when(activationIn.fire) {
          val isFirst = recvCntReg === U(0, recvCntReg.getWidth bits)
          val isLarger = activationIn.payload.value > maxValReg
          when(isFirst || isLarger) {
            maxValReg := activationIn.payload.value
            maxIdxReg := recvCntReg.resize(idxBits)
          }
          recvCntReg := recvCntReg + 1
          when(recvCntReg === (cfg.numClasses - 1)) {
            recvCntReg := 0
            emitReg    := True
          }
        }
      }

      // ── EMIT ─────────────────────────────────────────────────────────────
      when(emitReg) {
        activationOut.valid         := True
        activationOut.payload.value := maxIdxReg.resize(8).asSInt
        when(activationOut.fire) {
          maxValReg := S(ActivationDType.minVal, ActivationDType.bits bits)
          maxIdxReg := 0
          emitReg   := False
        }
      }
    }

    Io(activationOut = logic.activationOut)
  }
}
