package spinalnn.testhelpers

import spinal.core._
import spinal.lib._
import spinalnn.ops.conv.QLinearConvCore
import spinalnn.types._

// Minimal Component wrapper for QLinearConvCore simulation.
class QLinearConvHarness(cfg: QLinearConvCore.Config) extends Component {
  val io = new Bundle {
    val activationIn  = slave(Stream(Activation()))
    val activationOut = master(Stream(Activation()))
  }
  val core = QLinearConvCore.build(cfg, io.activationIn)
  io.activationOut << core.activationOut
}
