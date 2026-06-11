package spinalnn.ops.activation

import spinal.core._
import spinal.lib._
import spinalnn.types._
import spinalnn.util.PrefixArea

// ReLU: rectified linear unit. Element-wise: output = max(0, input).
//
// Unlike Conv and Pool this is a pure streaming pass-through -- no buffer,
// no FSM, no memory. Each input element is transformed combinatorially and
// emitted in the same cycle. The valid/ready signals pass straight through,
// so backpressure from downstream propagates to upstream without delay.
object ReLUCore {

  case class Config(
    periphName: String = "relu",
    clampMax:   Int    = ActivationDType.maxVal   // 127 for ReLU, round(6/outScale) for ReLU6
  ) {
    require(clampMax >= 0 && clampMax <= ActivationDType.maxVal,
      s"clampMax $clampMax out of [0, ${ActivationDType.maxVal}]")
  }

  case class Io(activationOut: Stream[Activation])

  def build(cfg: Config, activationIn: Stream[Activation] = null): Io = {
    require(activationIn != null, "activationIn is required")

    val logic = new PrefixArea(cfg.periphName) {
      val activationOut = Stream(Activation())
      activationOut.setName(s"${cfg.periphName}_activationOut")

      activationOut.valid         := activationIn.valid
      activationIn.ready          := activationOut.ready
      val clamped = activationIn.payload.value
      activationOut.payload.value :=
        Mux(clamped < S(0,             ActivationDType.bits bits), S(0,               ActivationDType.bits bits),
        Mux(clamped > S(cfg.clampMax,  ActivationDType.bits bits), S(cfg.clampMax,    ActivationDType.bits bits),
            clamped))
    }

    Io(activationOut = logic.activationOut)
  }
}
