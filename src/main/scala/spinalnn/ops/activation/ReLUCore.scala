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
    periphName: String = "relu"
    // Future: leakySlope: Float = 0.0f  for leaky ReLU variant
  )

  case class Io(activationOut: Stream[Activation])

  def build(cfg: Config, activationIn: Stream[Activation] = null): Io = {
    require(activationIn != null, "activationIn is required")

    val logic = new PrefixArea(cfg.periphName) {
      val activationOut = Stream(Activation())
      activationOut.setName(s"${cfg.periphName}_activationOut")

      activationOut.valid         := activationIn.valid
      activationIn.ready          := activationOut.ready
      activationOut.payload.value := Mux(
        activationIn.payload.value < S(0, ActivationDType.bits bits),
        S(0, ActivationDType.bits bits),
        activationIn.payload.value
      )
    }

    Io(activationOut = logic.activationOut)
  }
}
