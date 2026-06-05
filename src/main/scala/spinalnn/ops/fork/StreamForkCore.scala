package spinalnn.ops.fork

import spinal.core._
import spinal.lib._
import spinalnn.types._
import spinalnn.util.PrefixArea

// Fan-out: replicate one activation stream to N identical output streams (the
// structural complement of ConcatCore's fan-in). Every output carries the exact
// same HWC element sequence as the input. This is what lets one producer feed
// several parallel branches -- e.g. a SqueezeNet "fire" module whose squeeze
// output drives two independent expand convolutions.
//
// Default (synchronous = false) is the safe, general async fork: each output has
// its own back-pressure and the input element is held until *every* output has
// accepted it (per-output linkEnable token). Branches may therefore consume at
// different rates without losing or duplicating data. synchronous = true is a
// lower-area variant that fires all outputs together (only valid when every
// consumer is guaranteed ready in lock-step).
object StreamForkCore {

  case class Config(
    periphName:  String,
    shape:       TensorShape,
    numOutputs:  Int,
    synchronous: Boolean = false
  ) {
    require(numOutputs >= 2, "fork needs at least 2 outputs")
  }

  case class Io(outputs: Seq[Stream[Activation]])

  def build(cfg: Config, activationIn: Stream[Activation] = null): Io = {
    require(activationIn != null, "activationIn is required")

    val logic = new PrefixArea(cfg.periphName) {
      val outputs = Seq.tabulate(cfg.numOutputs) { i =>
        val s = Stream(Activation())
        s.setName(s"${cfg.periphName}_out$i")
        s
      }

      if (cfg.synchronous) {
        // All outputs fire together: the input advances only when every output is
        // ready, so no holding state is needed.
        activationIn.ready := outputs.map(_.ready).reduce(_ && _)
        outputs.foreach { o =>
          o.valid         := activationIn.valid && activationIn.ready
          o.payload.value := activationIn.payload.value
        }
      } else {
        // Async fork: linkEnable(i) is True while output i still owes the current
        // input element. The input is consumed only once every owed output accepts
        // it; outputs that already fired hold off (linkEnable low) until then.
        val linkEnable = Vec(RegInit(True), cfg.numOutputs)
        linkEnable.zipWithIndex.foreach { case (r, i) =>
          r.setName(s"${cfg.periphName}_linkEnable$i")
        }

        activationIn.ready := True
        for (i <- 0 until cfg.numOutputs) {
          when(!outputs(i).ready && linkEnable(i)) { activationIn.ready := False }
        }

        for (i <- 0 until cfg.numOutputs) {
          outputs(i).valid         := activationIn.valid && linkEnable(i)
          outputs(i).payload.value := activationIn.payload.value
          when(outputs(i).fire) { linkEnable(i) := False }
        }

        // Once the input element is fully delivered (ready high), re-arm all links
        // for the next element. This overrides the per-output clears above.
        when(activationIn.ready) { linkEnable.foreach(_ := True) }
      }
    }

    Io(outputs = logic.outputs)
  }
}
