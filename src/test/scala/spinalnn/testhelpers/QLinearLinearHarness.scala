package spinalnn.testhelpers

import spinal.core._
import spinal.lib._
import spinalnn.ops.linear.QLinearLinearCore
import spinalnn.types._

class QLinearLinearHarness(cfg: QLinearLinearCore.Config) extends Component {
  val io = new Bundle {
    val activationIn  = slave(Stream(Activation()))
    val activationOut = master(Stream(Activation()))
  }
  val core = QLinearLinearCore.build(cfg, io.activationIn)
  io.activationOut << core.activationOut
}
