package spinalnn

import spinal.core._
import spinal.lib._
import spinal.lib.misc.plugin._
import spinalnn.types._

// Static IO shell. No RTL logic here -- only port declarations and PluginHost.
// All processing lives in FiberPlugins wired by TopIoExportPlugin.
class SpinalNNTop(params: Params = Params()) extends Component {
  val io = new Bundle {
    val activationIn  = slave(Stream(Activation()))
    val activationOut = master(Stream(Activation()))
  }

  io.activationIn.valid.setName("activation_in_valid")
  io.activationIn.ready.setName("activation_in_ready")
  io.activationIn.payload.value.setName("activation_in_data")

  io.activationOut.valid.setName("activation_out_valid")
  io.activationOut.ready.setName("activation_out_ready")
  io.activationOut.payload.value.setName("activation_out_data")

  val host = new PluginHost
  host.asHostOf(params.plugins)
}
