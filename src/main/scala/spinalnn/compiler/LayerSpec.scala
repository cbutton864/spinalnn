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
    biases:      Array[Int]
  ) extends LayerSpec

  /** Element-wise ReLU. Maps to ReLUPlugin. */
  case class Relu(name: String, input: String, shape: TensorShape) extends LayerSpec

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
