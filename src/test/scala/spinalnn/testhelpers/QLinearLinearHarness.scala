package spinalnn.testhelpers

import spinal.core._
import spinal.lib._
import spinalnn.ops.linear.QLinearLinearCore
import spinalnn.target.WeightStream
import spinalnn.types._

class QLinearLinearHarness(cfg: QLinearLinearCore.Config) extends Component {
  val io = new Bundle {
    val activationIn  = slave(Stream(Activation()))
    val activationOut = master(Stream(Activation()))
  }
  val weightIn: Stream[Bits] = if (cfg.weightMode == WeightStream) {
    val s = slave(Stream(Bits(512 bits)))
    s.setName("weightIn"); s
  } else null

  val core = QLinearLinearCore.build(cfg, io.activationIn)
  io.activationOut << core.activationOut
  if (cfg.weightMode == WeightStream) core.weightIn << weightIn
}
