package spinalnn.testhelpers

import spinal.core._
import spinal.lib._
import spinalnn.ops.fork.StreamForkCore
import spinalnn.types._

// Minimal Component wrapper for StreamForkCore simulation: one slave input Stream,
// a Vec of master output Streams (one per fork branch).
class StreamForkHarness(cfg: StreamForkCore.Config) extends Component {
  val io = new Bundle {
    val activationIn   = slave(Stream(Activation()))
    val activationOuts = Vec.fill(cfg.numOutputs)(master(Stream(Activation())))
  }
  val core = StreamForkCore.build(cfg, io.activationIn)
  for (i <- 0 until cfg.numOutputs) io.activationOuts(i) << core.outputs(i)
}
