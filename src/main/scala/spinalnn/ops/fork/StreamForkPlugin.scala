package spinalnn.ops.fork

import spinal.core._
import spinal.core.fiber._
import spinal.lib._
import spinal.lib.misc.plugin._
import spinalnn._
import spinalnn.types._
import spinalnn.util._

// Fan-out plugin: the structural complement of ConcatPlugin. It takes a single
// upstream Handle and publishes a `Seq[Handle[Stream[Activation]]]` -- one per
// branch -- so several downstream plugins can each consume an independent copy of
// the same stream (e.g. the two expand convs of a SqueezeNet fire module).
//
// Unlike the single-output operators it cannot use the generic `buildBlock` helper
// (that wraps exactly one output), so the hierarchical boundary -- one slave input,
// a Vec of master outputs -- is constructed explicitly here.
case class StreamForkPlugin(
  cfg:      StreamForkCore.Config,
  upstream: Handle[Stream[Activation]],
  buildEnv: BuildEnv = BuildEnv()
) extends FiberPlugin {

  // One output Handle per fork branch. Downstream plugins take outputs(i) as their
  // single upstream constructor argument.
  val outputs: Seq[Handle[Stream[Activation]]] =
    Seq.fill(cfg.numOutputs)(Handle[Stream[Activation]]())
  val outputShape: TensorShape = cfg.shape

  val logic = during build new Area {
    val inStream = upstream.await
    val hier     = buildEnv.useHierarchy(pluginDefault = false)

    val outStreams: Seq[Stream[Activation]] =
      if (hier) {
        val block = new Component {
          val inPort   = slave(Stream(Activation()))
          val outPorts = Vec.fill(cfg.numOutputs)(master(Stream(Activation())))
          val core     = StreamForkCore.build(cfg, inPort)
          for (i <- 0 until cfg.numOutputs) outPorts(i) << core.outputs(i)
        }
        block.setDefinitionName(s"${cfg.periphName}_Comp")
        block.setName(s"${cfg.periphName}_Comp")
        block.inPort << inStream
        block.outPorts.toSeq
      } else {
        StreamForkCore.build(cfg, inStream).outputs
      }

    outputs.zip(outStreams).foreach { case (h, s) => h.load(s) }
  }
}
