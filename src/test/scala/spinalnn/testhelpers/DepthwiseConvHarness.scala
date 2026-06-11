package spinalnn.testhelpers

import spinal.core._
import spinal.lib._
import spinalnn.ops.conv.DepthwiseConvCore
import spinalnn.types._

class DepthwiseConvHarness(cfg: DepthwiseConvCore.Config) extends Component {
  val io = new Bundle {
    val activationIn  = slave(Stream(Activation()))
    val activationOut = master(Stream(Activation()))
  }
  val core = DepthwiseConvCore.build(cfg, io.activationIn)
  io.activationOut << core.activationOut
}
