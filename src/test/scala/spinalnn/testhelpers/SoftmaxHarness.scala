package spinalnn.testhelpers

import spinal.core._
import spinal.lib._
import spinalnn.ops.activation.SoftmaxCore
import spinalnn.types._

class SoftmaxHarness(cfg: SoftmaxCore.Config) extends Component {
  val io = new Bundle {
    val activationIn  = slave(Stream(Activation()))
    val activationOut = master(Stream(Activation()))
  }
  val core = SoftmaxCore.build(cfg, io.activationIn)
  io.activationOut << core.activationOut
}
