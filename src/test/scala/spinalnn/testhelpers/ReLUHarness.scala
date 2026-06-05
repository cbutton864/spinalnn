package spinalnn.testhelpers

import spinal.core._
import spinal.lib._
import spinalnn.ops.activation.ReLUCore
import spinalnn.types._

class ReLUHarness(cfg: ReLUCore.Config) extends Component {
  val io = new Bundle {
    val activationIn  = slave(Stream(Activation()))
    val activationOut = master(Stream(Activation()))
  }
  val core = ReLUCore.build(cfg, io.activationIn)
  io.activationOut << core.activationOut
}
