package spinalnn.compiler

import spinalnn.types._

/** Fully-resolved, hardware-agnostic description of one network layer.
  *
  * This is the seam between graph parsing and plugin construction:
  * {{{
  *   ONNX graph --(OnnxFrontend)--> Seq[LayerSpec] --(IrBackend)--> Seq[FiberPlugin]
  * }}}
  * Each ONNX operator maps to exactly one `LayerSpec` subtype (one case class per op).
  * A spec is fully resolved at this point: shapes inferred, weights quantized and
  * transposed, quantization scales chosen. The backend does no math -- it just
  * instantiates plugins and wires them.
  *
  * `name`  is the IR tensor id; the backend symbol table maps it to the producing
  *         plugin's output `Handle`. For weight-bearing / FSM ops it doubles as the
  *         Core `periphName`, so it must stay stable for deterministic flat Verilog.
  * `input` names the upstream `LayerSpec` this op consumes. The chain is linear today;
  *         multi-input fan-in (Concat / residual Add) is a future `Seq[String]` extension.
  * `shape` is this layer's OUTPUT shape (HWC).
  */
sealed trait LayerSpec {
  def name:  String
  def shape: TensorShape
}

object LayerSpec {

  /** Entry point. Maps to InputPlugin. No upstream. */
  case class Input(name: String, shape: TensorShape) extends LayerSpec

  /** INT8 2D convolution (+ folded bias). Maps to QLinearConvPlugin.
    * `weights` are already quantized and transposed to [outCh, kH, kW, C_in].
    * Padding is realized inside the core by a zero-initialised input buffer, so
    * `inputShape` is the real (unpadded) input shape.
    * `weightScales`, when present, gives one weight scale per output channel
    * (modern per-channel INT8 quantization); `weightQuant.scale` is the per-tensor
    * fallback used when it is absent.
    */
  case class Conv(
    name:        String,
    input:       String,
    inputShape:  TensorShape,
    shape:       TensorShape,
    kernelH:     Int,
    kernelW:     Int,
    strideH:     Int,
    strideW:     Int,
    padTop:      Int,
    padBottom:   Int,
    padLeft:     Int,
    padRight:    Int,
    inputQuant:  QuantParams,
    weightQuant: QuantParams,
    outputQuant: QuantParams,
    weights:     Array[Byte],
    biases:      Array[Int],
    weightScales: Option[Array[Float]] = None,
    weightBits:  Int                   = 8
  ) extends LayerSpec

  /** Element-wise ReLU or ReLU6. Maps to ReLUPlugin.
    * `clampMax` = 127 for standard ReLU; = round(6 / outputScale) for ReLU6
    * (capped at 127 if the scale is very small). */
  case class Relu(name: String, input: String, shape: TensorShape,
                  clampMax: Int = ActivationDType.maxVal) extends LayerSpec

  /** Spatial max pooling. Maps to MaxPoolPlugin. */
  case class MaxPool(
    name:       String,
    input:      String,
    inputShape: TensorShape,
    shape:      TensorShape,
    poolH:      Int,
    poolW:      Int,
    strideH:    Int,
    strideW:    Int
  ) extends LayerSpec

  /** Element-wise quantized addition of two synchronized streams (ONNX QLinearAdd).
    * Both inputs must have the same spatial shape. Maps to AddPlugin (streaming pipeline,
    * no BRAM). The requant scales M_A = s_A/s_C and M_B = s_B/s_C are computed at
    * elaboration time.
    */
  case class Add(
    name:        String,
    inputs:      Seq[String],
    inputShapes: Seq[TensorShape],
    inputAQuant: QuantParams,
    inputBQuant: QuantParams,
    outputQuant: QuantParams
  ) extends LayerSpec {
    require(inputs.length == 2, "Add requires exactly two inputs")
    require(inputShapes.length == 2 && inputShapes(0) == inputShapes(1),
      "Add inputs must have identical shapes")
    def shape: TensorShape = inputShapes(0)
  }

  /** Channel-wise concatenation of N upstream tensors (ONNX Concat, axis = channels).
    * The first true multi-input op: `inputs` names every upstream `LayerSpec`, in order.
    * All inputs must share spatial dims; output channels are the sum. Maps to
    * ConcatPlugin (which takes a `Seq[Handle]`). Inputs must already be in the same
    * quantization (the frontend folds the surrounding Dequantize/Quantize into the
    * producing convs' output scales). */
  case class Concat(
    name:        String,
    inputs:      Seq[String],
    inputShapes: Seq[TensorShape]
  ) extends LayerSpec {
    require(inputs.length == inputShapes.length, "Concat inputs/inputShapes length mismatch")
    def shape: TensorShape =
      TensorShape(inputShapes.head.rows, inputShapes.head.cols, inputShapes.map(_.channels).sum)
  }

  /** Global average pooling over the full H x W plane (ONNX GlobalAveragePool /
    * QLinearGlobalAveragePool). Output is 1 x 1 x C. The 1/area factor is folded into
    * the requant multiplier inside the core. Maps to GlobalAveragePoolPlugin. */
  case class GlobalAveragePool(
    name:        String,
    input:       String,
    inputShape:  TensorShape,
    inputQuant:  QuantParams,
    outputQuant: QuantParams
  ) extends LayerSpec {
    def shape: TensorShape = TensorShape(1, 1, inputShape.channels)
  }

  /** INT8 depthwise (channel-wise) 2D convolution. ONNX `Conv` with `group = C_in`.
    * `weights` are transposed to `[C, kH, kW]` (inCh=1 dropped). C_in = C_out.
    * Per-channel weight scales are the default for modern exports.
    */
  case class DepthwiseConv(
    name:         String,
    input:        String,
    inputShape:   TensorShape,
    shape:        TensorShape,
    kernelH:      Int,
    kernelW:      Int,
    strideH:      Int,
    strideW:      Int,
    padTop:       Int,
    padBottom:    Int,
    padLeft:      Int,
    padRight:     Int,
    inputQuant:   QuantParams,
    weightQuant:  QuantParams,
    outputQuant:  QuantParams,
    weights:      Array[Byte],
    biases:       Array[Int],
    weightScales: Option[Array[Float]] = None
  ) extends LayerSpec

  /** Reshape H x W x C -> 1 x 1 x (H*W*C). Maps to FlattenPlugin (zero RTL). */
  case class Flatten(
    name:       String,
    input:      String,
    inputShape: TensorShape
  ) extends LayerSpec {
    def shape: TensorShape = TensorShape(1, 1, inputShape.size)
  }

  /** INT8 fully-connected layer (+ folded bias). Maps to QLinearLinearPlugin.
    * `weights` are already quantized and transposed to [outNeurons, inNeurons].
    */
  case class Linear(
    name:        String,
    input:       String,
    inNeurons:   Int,
    outNeurons:  Int,
    inputQuant:  QuantParams,
    weightQuant: QuantParams,
    outputQuant: QuantParams,
    weights:     Array[Byte],
    biases:      Array[Int]
  ) extends LayerSpec {
    def shape: TensorShape = TensorShape(1, 1, outNeurons)
  }

  /** Argmax classifier. Maps to SoftmaxPlugin. Output is the winning class index. */
  case class Softmax(name: String, input: String, numClasses: Int) extends LayerSpec {
    def shape: TensorShape = TensorShape(1, 1, 1)
  }

  /** Terminal marker. Maps to NetworkOutputPlugin. `shape` advertises the result
    * size (1x1x1 for argmax, 1x1xN for a raw-logit tap). Produces no IR output id.
    */
  case class Output(name: String, input: String, shape: TensorShape) extends LayerSpec
}
