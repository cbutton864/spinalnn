package spinalnn.compiler

import spinal.core.{Bits, SInt}
import spinal.core.fiber.Handle
import spinal.lib.Stream
import spinal.lib.misc.plugin.FiberPlugin
import spinalnn.TopIoExportPlugin
import spinalnn.ops.activation.{ReLUCore, ReLUPlugin, SoftmaxCore, SoftmaxPlugin}
import spinalnn.ops.add.{AddCore, AddPlugin}
import spinalnn.ops.concat.{ConcatCore, ConcatPlugin}
import spinalnn.ops.conv.{DepthwiseConvCore, DepthwiseConvPlugin, QLinearConvCore, QLinearConvLineCore, QLinearConvLineCorePlugin, QLinearConvPlugin}
import spinalnn.ops.fork.{StreamForkCore, StreamForkPlugin}
import spinalnn.ops.input.InputPlugin
import spinalnn.ops.linear.{FlattenPlugin, QLinearLinearCore, QLinearLinearPlugin}
import spinalnn.dma.{WeightDmaCore, WeightDmaPlugin}
import spinalnn.ops.output.NetworkOutputPlugin
import spinalnn.ops.pool.{GlobalAveragePoolCore, GlobalAveragePoolPlugin, MaxPoolCore, MaxPoolLineCore, MaxPoolLinePlugin, MaxPoolPlugin}
import spinalnn.target.{MacParAuto, MacParFixed, MacParPerLayer, MemAuto, MemFullBuffer, MemLineBuffer, WeightMode, WeightRom, WeightStream, TargetConfig}
import spinalnn.types._
import spinalnn.util._

import scala.collection.mutable

/** Turns a `Seq[LayerSpec]` (from `OnnxFrontend`) into the concrete plugin graph.
  *
  * This is pure wiring -- no math. A symbol table maps each IR layer name to the
  * producing plugin's output `Handle`; every op resolves its upstream from the table
  * by name. The `match` below is the operator-dispatch registry: to support a new
  * ONNX operator, add a `LayerSpec` case class and one case here. Nothing else changes.
  */
object IrBackend {

  /** True when the line-buffer conv core should be used for a given conv layer.
    * QLinearConvLineCore supports all kernelH >= 1 (including 1×1 streaming).
    * macParallelism must be 1 (line core constraint). */
  private def useLineBuffer(target: TargetConfig, s: LayerSpec.Conv, resolvedN: Int): Boolean = {
    target.options.memoryStrategy match {
      case MemFullBuffer => false
      case MemLineBuffer => true
      case MemAuto =>
        val paddedH = s.inputShape.rows + s.padTop + s.padBottom
        val paddedW = s.inputShape.cols + s.padLeft + s.padRight
        val bufBits = paddedH.toLong * paddedW * s.inputShape.channels * 8L
        !target.fitsInBram(bufBits)
    }
  }

  /** True when the line-buffer MaxPool core should be used for a given pool layer. */
  private def useMaxPoolLineBuffer(target: TargetConfig, s: LayerSpec.MaxPool): Boolean = {
    if (s.poolH <= 1) return false  // degenerate pool: line buffer not beneficial
    target.options.memoryStrategy match {
      case MemFullBuffer => false
      case MemLineBuffer => true
      case MemAuto =>
        val bufBits = s.inputShape.size.toLong * 8L
        !target.fitsInBram(bufBits)
    }
  }

  /** Resolve the MAC lane count for a conv layer given the target options.
    * Falls back to N=1 if C_in is not divisible by the requested N so elaboration never fails.
    * `layerName` is used for per-layer lookup and for diagnostic messages. */
  private def macN(target: TargetConfig, inCh: Int, layerName: String): Int = {
    val requested = target.options.macParallelism match {
      case MacParAuto                      => 1
      case MacParFixed(n)                  => n
      case MacParPerLayer(overrides, dflt) => overrides.getOrElse(layerName, dflt)
    }
    if (inCh % requested == 0) requested
    else {
      System.err.println(
        s"[IrBackend] macPar($requested): C_in=$inCh not divisible for '$layerName', falling back to N=1")
      1
    }
  }

  /** Resolve the output-channel parallelism P for a conv layer.
    * Falls back to P=1 if C_out is not divisible by the requested P. */
  private def outPar(target: TargetConfig, outCh: Int, layerName: String): Int = {
    val requested = target.options.resolveOutPar(layerName)
    if (outCh % requested == 0) requested
    else {
      System.err.println(
        s"[IrBackend] outPar($requested): C_out=$outCh not divisible for '$layerName', falling back to P=1")
      1
    }
  }

  /** Resolve the effective weight mode for a single layer.
    *
    * When the global target is WeightStream, a layer whose resolved N does not evenly divide
    * 64 (the AXI beat width) cannot use the DMA beat-drain path. Such layers automatically
    * fall back to WeightRom so they can still run at the full requested N — their weights are
    * typically small enough to ROM into BRAM (e.g. conv1 with C_in=3 has only ~1.7 KB). */
  private def effectiveWeightMode(globalMode: WeightMode, n: Int, layerName: String): WeightMode =
    globalMode match {
      case WeightStream if 64 % n != 0 =>
        System.err.println(
          s"[IrBackend] '$layerName' N=$n: 64%$n≠0, incompatible with WeightStream beat drain — using WeightRom for this layer")
        WeightRom
      case mode => mode
    }

  def build(specs: Seq[LayerSpec], target: TargetConfig): Seq[FiberPlugin] = {
    val buildEnv  = target.buildEnv
    val wMode     = target.options.weightMode
    val outs      = mutable.Map[String, Handle[Stream[Activation]]]()
    val plugins   = mutable.ArrayBuffer[FiberPlugin]()

    // Collects (weightIn handle, actual, stride, numOutputCh) for WeightStream layers.
    // actual = K_H * K_W * C_in; stride = ceil(actual/64)*64 (AXI alignment).
    // Base addresses are computed in a post-pass after all layers are registered.
    type DmaEntry = (Handle[Stream[Bits]], Int, Int, Int)  // (handle, actual, stride, outC)
    val dmaEntries = mutable.ArrayBuffer[DmaEntry]()

    // Count how many downstream ops consume each tensor. A tensor consumed more than
    // once is a fan-out point and needs a StreamFork to hand each consumer its own copy.
    val consumeCount = mutable.Map[String, Int]().withDefaultValue(0)
    def consumed(spec: LayerSpec): Seq[String] = spec match {
      case s: LayerSpec.Add    => s.inputs
      case s: LayerSpec.Concat => s.inputs
      case _: LayerSpec.Input  => Nil
      case s: LayerSpec.Conv              => Seq(s.input)
      case s: LayerSpec.DepthwiseConv     => Seq(s.input)
      case s: LayerSpec.Relu              => Seq(s.input)
      case s: LayerSpec.MaxPool           => Seq(s.input)
      case s: LayerSpec.Flatten           => Seq(s.input)
      case s: LayerSpec.Linear            => Seq(s.input)
      case s: LayerSpec.Softmax           => Seq(s.input)
      case s: LayerSpec.GlobalAveragePool => Seq(s.input)
      case s: LayerSpec.Output            => Seq(s.input)
    }
    specs.foreach(s => consumed(s).foreach(n => consumeCount(n) += 1))

    // For fanned-out tensors, the queue of distinct StreamFork output Handles.
    val forkOutputs = mutable.Map[String, mutable.Queue[Handle[Stream[Activation]]]]()

    // Register a producer's output. If it fans out (consumed > 1), insert a StreamFork
    // and expose its N outputs; otherwise expose the single Handle directly.
    def publish(name: String, handle: Handle[Stream[Activation]], shape: TensorShape): Unit = {
      outs(name) = handle
      val fanout = consumeCount(name)
      if (fanout > 1) {
        val fork = StreamForkPlugin(
          StreamForkCore.Config(s"${name}_fork", shape, numOutputs = fanout), handle, buildEnv)
        plugins += fork
        forkOutputs(name) = mutable.Queue(fork.outputs: _*)
      }
    }

    // Resolve an upstream by name, drawing the next fork output for fanned-out tensors.
    def up(name: String): Handle[Stream[Activation]] =
      forkOutputs.get(name).map(_.dequeue()).getOrElse(
        outs.getOrElse(name, throw new NoSuchElementException(s"unresolved upstream '$name'")))

    specs.foreach {
      case s: LayerSpec.Input =>
        val p = InputPlugin(s.shape, buildEnv)
        plugins += p; publish(s.name, p.activationOut, s.shape)

      case s: LayerSpec.Conv =>
        val n          = macN(target, s.inputShape.channels, s.name)
        val pOut       = outPar(target, s.shape.channels, s.name)
        val layerWMode = effectiveWeightMode(wMode, n, s.name)
        val p = if (useLineBuffer(target, s, n)) {
          // Line-buffer core does not support outParallelism > 1 (no P path).
          if (pOut > 1) System.err.println(
            s"[IrBackend] '${s.name}': outParallelism=$pOut not supported by LineBuffer core, using P=1")
          QLinearConvLineCorePlugin(QLinearConvLineCore.Config(
            periphName     = s.name,
            inputShape     = s.inputShape,
            outputShape    = s.shape,
            kernelH        = s.kernelH,
            kernelW        = s.kernelW,
            strideH        = s.strideH,
            strideW        = s.strideW,
            padTop         = s.padTop,
            padBottom      = s.padBottom,
            padLeft        = s.padLeft,
            padRight       = s.padRight,
            inputQuant     = s.inputQuant,
            weightQuant    = s.weightQuant,
            outputQuant    = s.outputQuant,
            weights        = s.weights,
            biases         = s.biases,
            weightScales   = s.weightScales,
            weightMode     = layerWMode,
            macParallelism = n
          ), up(s.input), buildEnv)
        } else {
          QLinearConvPlugin(QLinearConvCore.Config(
            periphName       = s.name,
            inputShape       = s.inputShape,
            outputShape      = s.shape,
            kernelH          = s.kernelH,
            kernelW          = s.kernelW,
            strideH          = s.strideH,
            strideW          = s.strideW,
            padTop           = s.padTop,
            padBottom        = s.padBottom,
            padLeft          = s.padLeft,
            padRight         = s.padRight,
            inputQuant       = s.inputQuant,
            weightQuant      = s.weightQuant,
            outputQuant      = s.outputQuant,
            weights          = s.weights,
            biases           = s.biases,
            weightScales     = s.weightScales,
            macParallelism   = n,
            outParallelism   = pOut,
            weightMode       = layerWMode
          ), up(s.input), buildEnv)
        }
        plugins += p
        // Register DMA entry only for layers that are actually using WeightStream.
        // Layers that degraded to WeightRom (e.g. conv1 with N=3, 64%3≠0) are excluded.
        if (layerWMode == WeightStream) {
          val actual = s.kernelH * s.kernelW * s.inputShape.channels
          val stride = ((actual + 63) / 64) * 64
          val handle: Handle[Stream[Bits]] = p match {
            case lp: QLinearConvLineCorePlugin => lp.weightIn
            case cp: QLinearConvPlugin         => cp.weightIn
            case _ => throw new Exception("Unexpected conv plugin type")
          }
          dmaEntries += ((handle, actual, stride, s.shape.channels))
        }
        publish(s.name, p.activationOut, s.shape)

      case s: LayerSpec.DepthwiseConv =>
        val p = DepthwiseConvPlugin(DepthwiseConvCore.Config(
          periphName   = s.name,
          inputShape   = s.inputShape,
          outputShape  = s.shape,
          kernelH      = s.kernelH,
          kernelW      = s.kernelW,
          strideH      = s.strideH,
          strideW      = s.strideW,
          padTop       = s.padTop,
          padBottom    = s.padBottom,
          padLeft      = s.padLeft,
          padRight     = s.padRight,
          inputQuant   = s.inputQuant,
          weightQuant  = s.weightQuant,
          outputQuant  = s.outputQuant,
          weights      = s.weights,
          biases       = s.biases,
          weightScales = s.weightScales
        ), up(s.input), buildEnv)
        plugins += p; publish(s.name, p.activationOut, s.shape)

      case s: LayerSpec.Relu =>
        val p = ReLUPlugin(ReLUCore.Config(s.name, s.clampMax), s.shape, up(s.input), buildEnv)
        plugins += p; publish(s.name, p.activationOut, s.shape)

      case s: LayerSpec.MaxPool =>
        val p = if (useMaxPoolLineBuffer(target, s)) {
          MaxPoolLinePlugin(MaxPoolLineCore.Config(
            s.name, s.inputShape, s.shape, s.poolH, s.poolW, s.strideH, s.strideW), up(s.input), buildEnv)
        } else {
          MaxPoolPlugin(MaxPoolCore.Config(
            s.name, s.inputShape, s.shape, s.poolH, s.poolW, s.strideH, s.strideW), up(s.input), buildEnv)
        }
        plugins += p; publish(s.name, p.activationOut, s.shape)

      case s: LayerSpec.Add =>
        val ups = s.inputs.map(up)
        // If an Add input comes from a fanned-out tensor it went through a StreamFork.
        // The fork stalls until ALL outputs are consumed, but AddCore only consumes
        // its inputs when BOTH are valid simultaneously — creating a deadlock when
        // one arm (skip path) arrives long before the other (deep conv branch).
        // Buffer the early-arriving fork output with a FIFO so the fork can drain.
        val qA = if (consumeCount(s.inputs(0)) > 1) s.inputShapes(0).size else 0
        val qB = if (consumeCount(s.inputs(1)) > 1) s.inputShapes(1).size else 0
        val p   = AddPlugin(AddCore.Config(s.name, s.shape, s.inputAQuant, s.inputBQuant, s.outputQuant),
                            ups(0), ups(1), queueDepthA = qA, queueDepthB = qB, buildEnv)
        plugins += p; publish(s.name, p.activationOut, s.shape)

      case s: LayerSpec.Concat =>
        val ups = s.inputs.map(up)
        val p   = ConcatPlugin(ConcatCore.Config(s.name, s.inputShapes), ups, buildEnv)
        plugins += p; publish(s.name, p.activationOut, s.shape)

      case s: LayerSpec.GlobalAveragePool =>
        val p = GlobalAveragePoolPlugin(GlobalAveragePoolCore.Config(
          s.name, s.inputShape, s.shape, s.inputQuant, s.outputQuant), up(s.input), buildEnv)
        plugins += p; publish(s.name, p.activationOut, s.shape)

      case s: LayerSpec.Flatten =>
        val p = FlattenPlugin(s.inputShape, up(s.input), buildEnv)
        plugins += p; publish(s.name, p.activationOut, s.shape)

      case s: LayerSpec.Linear =>
        val p = QLinearLinearPlugin(QLinearLinearCore.Config(
          periphName  = s.name,
          inNeurons   = s.inNeurons,
          outNeurons  = s.outNeurons,
          inputQuant  = s.inputQuant,
          weightQuant = s.weightQuant,
          outputQuant = s.outputQuant,
          weights     = s.weights,
          biases      = s.biases,
          weightMode  = wMode
        ), up(s.input), buildEnv)
        plugins += p
        if (wMode == WeightStream) {
          val actual = s.inNeurons
          val stride = ((actual + 63) / 64) * 64
          val handle: Handle[Stream[Bits]] = p.weightIn
          dmaEntries += ((handle, actual, stride, s.outNeurons))
        }
        publish(s.name, p.activationOut, s.shape)

      case s: LayerSpec.Softmax =>
        val p = SoftmaxPlugin(SoftmaxCore.Config(s.name, s.numClasses), up(s.input), buildEnv)
        plugins += p; publish(s.name, p.activationOut, s.shape)

      case s: LayerSpec.Output =>
        plugins += NetworkOutputPlugin(up(s.input), s.shape)
    }

    // If any WeightStream layers were registered, build the DMA plugin.
    // Base address advances by stride*outCh (channels are stride-byte-aligned in LPDDR4x).
    if (dmaEntries.nonEmpty) {
      var baseAddr = 0L
      val descs = dmaEntries.map { case (_, actual, stride, outCh) =>
        val desc = WeightDmaCore.LayerDesc(baseAddr, actual, stride, outCh)
        baseAddr += stride.toLong * outCh
        desc
      }.toSeq
      plugins += WeightDmaPlugin(dmaEntries.map(_._1).toSeq, descs, target.options.dmaFreqMhz)
    }

    plugins += TopIoExportPlugin()
    plugins.toSeq
  }
}
