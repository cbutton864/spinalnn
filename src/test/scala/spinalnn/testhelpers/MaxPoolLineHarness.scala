package spinalnn.testhelpers

import spinal.core._
import spinal.lib._
import spinalnn.ops.pool.MaxPoolLineCore
import spinalnn.types._

class MaxPoolLineHarness(cfg: MaxPoolLineCore.Config) extends Component {
  val io = new Bundle {
    val activationIn  = slave(Stream(Activation()))
    val activationOut = master(Stream(Activation()))
  }
  val core = MaxPoolLineCore.build(cfg, io.activationIn)
  io.activationOut << core.activationOut
}
