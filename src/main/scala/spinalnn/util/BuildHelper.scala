package spinalnn.util

import spinal.core._
import spinal.lib._

// Named wrapper block. Saves manual prefixing on child nets.
class PrefixArea(prefix: String) extends Area {
  this.setName(prefix)
}

// BuildMode / BuildEnv -- build strategy control.
// Plugins accept a `buildEnv: BuildEnv` parameter and call `buildEnv.useHierarchy(default)`
// when deciding whether to create a Component boundary. Set the mode once in Params and it
// propagates to every plugin without per-plugin flag management.
//   FlatBuild         -> always flat   (pluginDefault ignored)
//   HierarchicalBuild -> always hier   (pluginDefault ignored)
//   CustomBuild       -> uses pluginDefault (each plugin decides independently)
sealed trait BuildMode
case object HierarchicalBuild extends BuildMode
case object FlatBuild         extends BuildMode
case object CustomBuild       extends BuildMode

case class BuildEnv(
    mode:            BuildMode     = FlatBuild,
    globalHierarchy: Option[Boolean] = None
) {
  def useHierarchy(pluginDefault: Boolean): Boolean =
    globalHierarchy.getOrElse {
      mode match {
        case HierarchicalBuild => true
        case FlatBuild         => false
        case CustomBuild       => pluginDefault
      }
    }
}

object BuildHelper {

  def autoPull[T](signal: T, enabled: Boolean): T = {
    if (!enabled) signal
    else signal match {
      case d: Data   => d.pull().asInstanceOf[T]
      case (a, b)    => (autoPull(a, true), autoPull(b, true)).asInstanceOf[T]
      case (a, b, c) => (autoPull(a, true), autoPull(b, true), autoPull(c, true)).asInstanceOf[T]
      case (a, b, c, d) =>
        (autoPull(a, true), autoPull(b, true), autoPull(c, true), autoPull(d, true)).asInstanceOf[T]
      case seq: Seq[_] => seq.map(item => autoPull(item, true)).asInstanceOf[T]
      case opt: Option[_] => opt.map(item => autoPull(item, true)).asInstanceOf[T]
      case other =>
        SpinalError(
          s"Auto-pulling failed: ${other.getClass.getName} is not a supported wire or connection type."
        )
        other
    }
  }

  def prepareInput[I](input: I): (I, () => Unit) = input match {
    case s: spinal.lib.Stream[_] =>
      val port = spinal.lib.slave(cloneOf(s)).asInstanceOf[s.type]
      (port.asInstanceOf[I], () => { port << s })
    case ms: IMasterSlave with Data =>
      val port = spinal.lib.slave(cloneOf(ms)).asInstanceOf[ms.type]
      (port.asInstanceOf[I], () => { port.asInstanceOf[Data] <> ms.asInstanceOf[Data] })
    case d: Data =>
      val port = spinal.core.in(cloneOf(d)).asInstanceOf[d.type]
      (port.asInstanceOf[I], () => { port := d })
    case (a, b) =>
      val (pa, ca) = prepareInput(a); val (pb, cb) = prepareInput(b)
      ((pa, pb).asInstanceOf[I], () => { ca(); cb() })
    case (a, b, c) =>
      val (pa, ca) = prepareInput(a); val (pb, cb) = prepareInput(b); val (pc, cc) = prepareInput(c)
      ((pa, pb, pc).asInstanceOf[I], () => { ca(); cb(); cc() })
    case (a, b, c, d) =>
      val (pa, ca) = prepareInput(a); val (pb, cb) = prepareInput(b)
      val (pc, cc) = prepareInput(c); val (pd, cd) = prepareInput(d)
      ((pa, pb, pc, pd).asInstanceOf[I], () => { ca(); cb(); cc(); cd() })
    case seq: Seq[_] =>
      val prepped = seq.map(item => prepareInput(item))
      (prepped.map(_._1).asInstanceOf[I], () => prepped.foreach(_._2()))
    case opt: Option[_] =>
      val prepped = opt.map(item => prepareInput(item))
      (prepped.map(_._1).asInstanceOf[I], () => prepped.foreach(_._2()))
    case other => (other, () => {})
  }

  def buildBlock[T <: Data](
      outputType:   HardType[T],
      hierarchical: Boolean,
      name:         String
  )(body: T => Unit): T = {
    if (hierarchical) {
      val block = new Component {
        val outSig = outputType() match {
          case ms: IMasterSlave => master(ms).asInstanceOf[T]
          case other            => out(other)
        }
        body(outSig)
      }
      block.setDefinitionName(name)
      block.setName(name)
      block.outSig
    } else {
      val sig = outputType()
      body(sig)
      sig
    }
  }

  def buildBlock[T <: Data, K](
      outputType:   HardType[T],
      hierarchical: Boolean,
      name:         String,
      inputs:       K
  )(body: K => T => Unit): T = {
    if (hierarchical) {
      var connectionFn: () => Unit = null
      val block = new Component {
        val outSig = outputType() match {
          case ms: IMasterSlave => master(ms).asInstanceOf[T]
          case other            => out(other)
        }
        val (pulledInputs, conn) = prepareInput(inputs)
        connectionFn = conn
        body(pulledInputs)(outSig)
      }
      connectionFn()
      block.setDefinitionName(name)
      block.setName(name)
      block.outSig
    } else {
      val sig = outputType()
      body(inputs)(sig)
      sig
    }
  }

  def buildSubsystem[T](hierarchical: Boolean, name: String)(body: => T): T = {
    if (hierarchical) {
      var result: T = null.asInstanceOf[T]
      val block = new Component { result = body }
      block.setDefinitionName(name)
      block.setName(name)
      result
    } else {
      body
    }
  }
}
