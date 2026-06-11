package spinalnn.compiler

import spinalnn.types.QuantParams
import scala.collection.mutable

/** Pure-Scala forward pass over a compiled [[LayerSpec]] graph.
  *
  * Mirrors the quantized integer math of each hardware Core so tests can compare
  * hardware simulation output against a reference value without needing ONNX Runtime.
  *
  * Data layout everywhere: HWC (row-major, channels innermost).
  * Weight layout for Conv/DepthwiseConv: [outCh][kH][kW][inCh] (matches LayerSpec docs).
  * Weight layout for Linear: [outNeurons][inNeurons].
  *
  * Quantization math (same as hardware):
  *   acc      = sum(kh,kw,ic) (x[h+kh,w+kw,ic] - x_zp) * (w[oc,kh,kw,ic] - w_zp) + bias[oc]
  *   M[oc]    = x_scale * w_scale[oc] / y_scale
  *   output   = clamp(round(acc * M[oc]) + y_zp, -128, 127)
  *
  * For tests that use identity quantization (all scale=1.0, all zp=0), this
  * simplifies to: output = clamp(acc + bias, -128, 127).
  */
object LayerSpecInterpreter {

  // HWC index helper
  private def hwcIdx(r: Int, c: Int, ch: Int, cols: Int, channels: Int): Int =
    (r * cols + c) * channels + ch

  private def clamp8(v: Long): Int = math.max(-128, math.min(127, v.toInt))

  private def wScale(spec: LayerSpec.Conv, oc: Int): Float =
    spec.weightScales.map(_(oc)).getOrElse(spec.weightQuant.scale)

  private def wScaleDw(spec: LayerSpec.DepthwiseConv, ch: Int): Float =
    spec.weightScales.map(_(ch)).getOrElse(spec.weightQuant.scale)

  // ── Conv ──────────────────────────────────────────────────────────────────
  private def runConv(input: Array[Int], s: LayerSpec.Conv): Array[Int] = {
    val inH = s.inputShape.rows;  val inW = s.inputShape.cols;  val inC = s.inputShape.channels
    val outH = s.shape.rows;      val outW = s.shape.cols;      val outC = s.shape.channels
    val out = Array.ofDim[Int](outH * outW * outC)
    for (oh <- 0 until outH; ow <- 0 until outW; oc <- 0 until outC) {
      var acc = 0L
      for (kh <- 0 until s.kernelH; kw <- 0 until s.kernelW; ic <- 0 until inC) {
        val ih = oh * s.strideH + kh - s.padTop
        val iw = ow * s.strideW + kw - s.padLeft
        val x = if (ih >= 0 && ih < inH && iw >= 0 && iw < inW)
          input(hwcIdx(ih, iw, ic, inW, inC)) - s.inputQuant.zeroPoint
        else
          -s.inputQuant.zeroPoint
        val wIdx = ((oc * s.kernelH + kh) * s.kernelW + kw) * inC + ic
        val w = s.weights(wIdx).toInt - s.weightQuant.zeroPoint
        acc += x.toLong * w
      }
      acc += s.biases(oc)
      val M = s.inputQuant.scale.toDouble * wScale(s, oc) / s.outputQuant.scale
      out(hwcIdx(oh, ow, oc, outW, outC)) = clamp8(math.round(acc * M) + s.outputQuant.zeroPoint)
    }
    out
  }

  // ── DepthwiseConv ─────────────────────────────────────────────────────────
  private def runDepthwiseConv(input: Array[Int], s: LayerSpec.DepthwiseConv): Array[Int] = {
    val inH = s.inputShape.rows; val inW = s.inputShape.cols; val inC = s.inputShape.channels
    val outH = s.shape.rows;     val outW = s.shape.cols;     val outC = s.shape.channels
    val out = Array.ofDim[Int](outH * outW * outC)
    for (oh <- 0 until outH; ow <- 0 until outW; ch <- 0 until outC) {
      var acc = 0L
      for (kh <- 0 until s.kernelH; kw <- 0 until s.kernelW) {
        val ih = oh * s.strideH + kh - s.padTop
        val iw = ow * s.strideW + kw - s.padLeft
        val x = if (ih >= 0 && ih < inH && iw >= 0 && iw < inW)
          input(hwcIdx(ih, iw, ch, inW, inC)) - s.inputQuant.zeroPoint
        else
          -s.inputQuant.zeroPoint
        val wIdx = (ch * s.kernelH + kh) * s.kernelW + kw  // [C][kH][kW]
        val w = s.weights(wIdx).toInt - s.weightQuant.zeroPoint
        acc += x.toLong * w
      }
      acc += s.biases(ch)
      val M = s.inputQuant.scale.toDouble * wScaleDw(s, ch) / s.outputQuant.scale
      out(hwcIdx(oh, ow, ch, outW, outC)) = clamp8(math.round(acc * M) + s.outputQuant.zeroPoint)
    }
    out
  }

  // ── ReLU ──────────────────────────────────────────────────────────────────
  private def runRelu(input: Array[Int], s: LayerSpec.Relu): Array[Int] =
    input.map(v => math.max(0, math.min(s.clampMax, v)))

  // ── MaxPool ───────────────────────────────────────────────────────────────
  private def runMaxPool(input: Array[Int], s: LayerSpec.MaxPool): Array[Int] = {
    val inH = s.inputShape.rows; val inW = s.inputShape.cols; val inC = s.inputShape.channels
    val outH = s.shape.rows;     val outW = s.shape.cols
    val out = Array.ofDim[Int](outH * outW * inC)
    for (oh <- 0 until outH; ow <- 0 until outW; ch <- 0 until inC) {
      var best = Int.MinValue
      for (kh <- 0 until s.poolH; kw <- 0 until s.poolW) {
        val ih = oh * s.strideH + kh
        val iw = ow * s.strideW + kw
        if (ih < inH && iw < inW) best = best max input(hwcIdx(ih, iw, ch, inW, inC))
      }
      out(hwcIdx(oh, ow, ch, outW, inC)) = best
    }
    out
  }

  // ── GlobalAveragePool ─────────────────────────────────────────────────────
  private def runGap(input: Array[Int], s: LayerSpec.GlobalAveragePool): Array[Int] = {
    val inH = s.inputShape.rows; val inW = s.inputShape.cols; val inC = s.inputShape.channels
    val area = inH * inW
    val out = Array.ofDim[Int](inC)
    val M = s.inputQuant.scale.toDouble / (s.outputQuant.scale * area)
    for (ch <- 0 until inC) {
      var sum = 0L
      for (h <- 0 until inH; w <- 0 until inW)
        sum += input(hwcIdx(h, w, ch, inW, inC)) - s.inputQuant.zeroPoint
      out(ch) = clamp8(math.round(sum * M) + s.outputQuant.zeroPoint)
    }
    out
  }

  // ── Linear ────────────────────────────────────────────────────────────────
  private def runLinear(input: Array[Int], s: LayerSpec.Linear): Array[Int] = {
    val out = Array.ofDim[Int](s.outNeurons)
    val M = s.inputQuant.scale.toDouble * s.weightQuant.scale / s.outputQuant.scale
    for (oc <- 0 until s.outNeurons) {
      var acc = 0L
      for (ic <- 0 until s.inNeurons) {
        val x = input(ic) - s.inputQuant.zeroPoint
        val w = s.weights(oc * s.inNeurons + ic).toInt - s.weightQuant.zeroPoint
        acc += x.toLong * w
      }
      acc += s.biases(oc)
      out(oc) = clamp8(math.round(acc * M) + s.outputQuant.zeroPoint)
    }
    out
  }

  // ── Add ───────────────────────────────────────────────────────────────────
  private def runAdd(a: Array[Int], b: Array[Int], s: LayerSpec.Add): Array[Int] = {
    val MA = s.inputAQuant.scale.toDouble / s.outputQuant.scale
    val MB = s.inputBQuant.scale.toDouble / s.outputQuant.scale
    val zp = s.outputQuant.zeroPoint
    Array.tabulate(a.length) { i =>
      val va = (a(i) - s.inputAQuant.zeroPoint).toDouble
      val vb = (b(i) - s.inputBQuant.zeroPoint).toDouble
      clamp8(math.round(va * MA + vb * MB) + zp)
    }
  }

  // ── Concat ────────────────────────────────────────────────────────────────
  private def runConcat(inputs: Seq[Array[Int]], s: LayerSpec.Concat): Array[Int] = {
    val H = s.inputShapes.head.rows
    val W = s.inputShapes.head.cols
    val outC = s.shape.channels
    val out = Array.ofDim[Int](H * W * outC)
    var chOffset = 0
    for ((inp, shape) <- inputs zip s.inputShapes) {
      val C = shape.channels
      for (h <- 0 until H; w <- 0 until W; c <- 0 until C)
        out(hwcIdx(h, w, chOffset + c, W, outC)) = inp(hwcIdx(h, w, c, W, C))
      chOffset += C
    }
    out
  }

  // ── Softmax (argmax) ──────────────────────────────────────────────────────
  private def runSoftmax(input: Array[Int], s: LayerSpec.Softmax): Array[Int] =
    Array(input.zipWithIndex.maxBy(_._1)._2)

  // ── Main forward pass ─────────────────────────────────────────────────────
  /** Run `specs` over `inputData` (HWC flat array) and return the output tensor. */
  def run(specs: Seq[LayerSpec], inputData: Array[Int]): Array[Int] = {
    val tensors = mutable.Map[String, Array[Int]]()

    for (spec <- specs) spec match {
      case s: LayerSpec.Input   => tensors(s.name) = inputData
      case s: LayerSpec.Conv    => tensors(s.name) = runConv(tensors(s.input), s)
      case s: LayerSpec.DepthwiseConv => tensors(s.name) = runDepthwiseConv(tensors(s.input), s)
      case s: LayerSpec.Relu    => tensors(s.name) = runRelu(tensors(s.input), s)
      case s: LayerSpec.MaxPool => tensors(s.name) = runMaxPool(tensors(s.input), s)
      case s: LayerSpec.GlobalAveragePool => tensors(s.name) = runGap(tensors(s.input), s)
      case s: LayerSpec.Linear  => tensors(s.name) = runLinear(tensors(s.input), s)
      case s: LayerSpec.Add     =>
        val a = tensors(s.inputs(0)); val b = tensors(s.inputs(1))
        tensors(s.name) = runAdd(a, b, s)
      case s: LayerSpec.Concat  =>
        tensors(s.name) = runConcat(s.inputs.map(tensors), s)
      case s: LayerSpec.Softmax =>
        tensors(s.name) = runSoftmax(tensors(s.input), s)
      case s: LayerSpec.Flatten =>
        tensors(s.name) = tensors(s.input)  // data layout unchanged
      case s: LayerSpec.Output  =>
        return tensors(s.input)
    }

    throw new IllegalStateException("LayerSpec graph has no Output node")
  }
}
