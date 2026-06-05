package spinalnn.types

import spinal.core._
import spinal.lib._

// Single source of truth for activation data width.
// Change bits here and all Cores, clamping bounds, and memory types adapt.
// Long-term: parameterise Activation(bits) and thread through QuantParams
// when a second precision (INT4, BFloat16, stochastic) is actually needed.
object ActivationDType {
  val bits:    Int = 8
  val minVal:  Int = -(1 << (bits - 1))       // -128 for INT8
  val maxVal:  Int =  (1 << (bits - 1)) - 1   // 127  for INT8
  val adjBits: Int = bits + 1                 // 9    -- range after zero-point subtraction
}

// Activation: one element in a feature map stream.
// Kept as a Bundle (not raw SInt) so the arithmetic backend can be swapped
// without changing the streaming interface -- e.g. INT4, BFloat16, stochastic.
case class Activation() extends Bundle {
  val value = SInt(ActivationDType.bits bits)
}

// Tensor shape in HWC convention (height, width, channels). N=1 always.
// Streams carry rows*cols*channels activations in HWC order:
//   (row0,col0,ch0), (row0,col0,ch1), ..., (row0,col1,ch0), ...
case class TensorShape(rows: Int, cols: Int, channels: Int) {
  val size: Int = rows * cols * channels
  override def toString = s"${rows}x${cols}x${channels}"
}

// Elaboration-time quantization parameters for one tensor.
// scale and zeroPoint come from the ONNX model or training framework.
case class QuantParams(scale: Float, zeroPoint: Int) {
  require(
    zeroPoint >= ActivationDType.minVal && zeroPoint <= ActivationDType.maxVal,
    s"zeroPoint $zeroPoint out of range [${ActivationDType.minVal}, ${ActivationDType.maxVal}]"
  )
}

// Pre-computed requantization scale for one operator.
// M = scaleIn * scaleWeights / scaleOut, encoded as multiplier * 2^(-shift).
// Hardware computes: output = clamp((acc * multiplier) >> shift + zpOut, minVal, maxVal)
// Computed at elaboration time -- no floating-point in the generated RTL.
case class RequantScale(multiplier: Long, shift: Int)

object RequantScale {
  def apply(scaleIn: Float, scaleWeights: Float, scaleOut: Float): RequantScale = {
    val m  = scaleIn.toDouble * scaleWeights.toDouble / scaleOut.toDouble
    var m0 = m
    var n  = 0
    while (m0 < 0.5)  { m0 *= 2.0; n += 1 }
    while (m0 >= 1.0) { m0 /= 2.0; n -= 1 }
    val mult = Math.round(m0 * (1L << 31))
    RequantScale(mult, n + 31)
  }
}
