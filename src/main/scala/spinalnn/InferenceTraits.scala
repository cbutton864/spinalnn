package spinalnn

import spinal.core.fiber._
import spinal.lib._
import spinalnn.types._

// Produces an activation stream. Used as the upstream connection type in
// TopIoExportPlugin only. Operator plugins (Conv, Pool, etc.) receive their
// upstream Handle directly as a constructor argument -- they do NOT call
// host[ActivationSource]. This keeps the pattern safe for repeated layer types.
trait ActivationSource {
  val activationOut: Handle[Stream[Activation]]
  val outputShape:   TensorShape
}

// Entry point for activations from top-level IO pads.
// Implemented by InputPlugin only. Unique per design -- safe to use as trait.
trait InferenceInput {
  val activationIn: Handle[Stream[Activation]]
}

// Final layer output. Implemented by exactly one plugin per design.
// TopIoExportPlugin uses host[NetworkOutput] to find and wire the output pads.
// In the Phase 1 stub, InputPlugin implements this. From Phase 3 onward,
// the last processing layer implements it.
trait NetworkOutput {
  val networkOut:  Handle[Stream[Activation]]
  val outputShape: TensorShape
}
