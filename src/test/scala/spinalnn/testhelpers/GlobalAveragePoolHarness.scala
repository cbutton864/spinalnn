package spinalnn.testhelpers

import spinal.core._
import spinal.lib._
import spinalnn.ops.pool.GlobalAveragePoolCore
import spinalnn.types._

// Minimal Component wrapper for GlobalAveragePoolCore simulation.
// Exposes activationIn and activationOut as top-level Stream ports.
class GlobalAveragePoolHarness(cfg: GlobalAveragePoolCore.Config) extends Component {
  val io = new Bundle {
    val activationIn  = slave(Stream(Activation()))
    val activationOut = master(Stream(Activation()))
  }
  val core = GlobalAveragePoolCore.build(cfg, io.activationIn)
  io.activationOut << core.activationOut
}
