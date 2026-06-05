package spinalnn.testhelpers

import spinal.core._
import spinal.lib._
import spinalnn.ops.pool.MaxPoolCore
import spinalnn.types._

// Minimal Component wrapper for MaxPoolCore simulation.
// Exposes activationIn and activationOut as top-level Stream ports.
class MaxPoolHarness(cfg: MaxPoolCore.Config) extends Component {
  val io = new Bundle {
    val activationIn  = slave(Stream(Activation()))
    val activationOut = master(Stream(Activation()))
  }
  val core = MaxPoolCore.build(cfg, io.activationIn)
  io.activationOut << core.activationOut
}
