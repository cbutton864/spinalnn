package spinalnn.testhelpers

import spinal.core._
import spinal.lib._
import spinalnn.ops.concat.ConcatCore
import spinalnn.types._

// Minimal Component wrapper for ConcatCore simulation. Exposes one slave input
// Stream per concat branch (a Vec) and one master output Stream.
class ConcatHarness(cfg: ConcatCore.Config) extends Component {
  val io = new Bundle {
    val activationIns = Vec.fill(cfg.inputShapes.length)(slave(Stream(Activation())))
    val activationOut = master(Stream(Activation()))
  }
  val core = ConcatCore.build(cfg, io.activationIns.toSeq)
  io.activationOut << core.activationOut
}
