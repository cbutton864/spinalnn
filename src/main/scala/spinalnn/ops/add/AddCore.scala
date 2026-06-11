package spinalnn.ops.add

import spinal.core._
import spinal.lib._
import spinalnn.types._
import spinalnn.util.PrefixArea

/** Element-wise quantized addition of two synchronized activation streams.
  *
  * Unlike Conv/Pool this is a pure streaming pipeline — no input BRAM, no FSM.
  * Both streams are consumed simultaneously one element at a time and the result
  * flows through a 4-stage registered pipeline:
  *
  *   Stage 0 → register raw a, b values
  *   Stage 1 → subtract zero-points: a_adj, b_adj
  *   Stage 2 → multiply by per-input scale: prod_A = a_adj × M_A, prod_B = b_adj × M_B
  *   Stage 3 → shift, sum, add output zero-point, clamp → result
  *
  * Latency: 4 clock cycles. Throughput: 1 element/cycle (stalls only when the
  * downstream output stream is not ready).
  *
  * Scale encoding: M_A = s_A / s_C, M_B = s_B / s_C — both precomputed as
  * (multiplier, shift) pairs using the same RequantScale arithmetic as Conv.
  * The adjusted inputs are at most 9 bits (signed), so 9×32-bit multiplies fit
  * one DSP block each — no split-16×16 pipeline needed.
  */
object AddCore {

  case class Config(
    periphName:  String,
    shape:       TensorShape,
    inputAQuant: QuantParams,
    inputBQuant: QuantParams,
    outputQuant: QuantParams
  ) {
    // M_i = s_in_i / s_out  (RequantScale(s_in, 1.0, s_out) gives s_in/s_out)
    val scaleA: RequantScale = RequantScale(inputAQuant.scale, 1.0f, outputQuant.scale)
    val scaleB: RequantScale = RequantScale(inputBQuant.scale, 1.0f, outputQuant.scale)
  }

  case class Io(activationOut: Stream[Activation])

  def build(cfg: Config,
            activationA: Stream[Activation] = null,
            activationB: Stream[Activation] = null): Io = {
    require(activationA != null, "activationA is required")
    require(activationB != null, "activationB is required")

    val adjBits = ActivationDType.adjBits          // 9: range after zp subtraction
    val multA   = S(cfg.scaleA.multiplier.toLong, 32 bits)
    val multB   = S(cfg.scaleB.multiplier.toLong, 32 bits)

    val logic = new PrefixArea(cfg.periphName) {
      val activationOut = Stream(Activation())
      activationOut.setName(s"${cfg.periphName}_activationOut")

      // ── 4-stage registered pipeline ────────────────────────────────────────
      // Each stage carries a valid bit and its payload registers.
      // A single stall signal freezes all stages when the output is blocked.

      // Stage 0: raw a and b values captured when both inputs fire.
      val s0Valid = RegInit(False)
      val s0A     = Reg(SInt(ActivationDType.bits bits)) init 0
      val s0B     = Reg(SInt(ActivationDType.bits bits)) init 0

      // Stage 1: zero-point-adjusted values.
      val s1Valid = RegInit(False)
      val s1AAdj  = Reg(SInt(adjBits bits)) init 0
      val s1BAdj  = Reg(SInt(adjBits bits)) init 0

      // Stage 2: scaled products (9-bit adjusted × 32-bit multiplier → 41-bit,
      // stored in 64-bit for safe arithmetic before the shift).
      val s2Valid  = RegInit(False)
      val s2ProdA  = Reg(SInt(64 bits)) init 0
      val s2ProdB  = Reg(SInt(64 bits)) init 0

      // Stage 3: final clamped result ready for the output stream.
      val s3Valid  = RegInit(False)
      val s3Result = Reg(SInt(ActivationDType.bits bits)) init 0

      // Stall when stage-3 holds a valid result that downstream hasn't accepted.
      val stall = s3Valid && !activationOut.ready

      // ── Output → downstream ────────────────────────────────────────────────
      activationOut.valid         := s3Valid
      activationOut.payload.value := s3Result

      // ── Pipeline advance (all stages shift together when not stalled) ───────
      when(!stall) {

        // Stage 2 → Stage 3: shift each product, sum, add output zero-point, clamp.
        s3Valid := s2Valid
        when(s2Valid) {
          val shiftedA = (s2ProdA >> cfg.scaleA.shift).resize(32)
          val shiftedB = (s2ProdB >> cfg.scaleB.shift).resize(32)
          val sum      = (shiftedA + shiftedB +
                          S(cfg.outputQuant.zeroPoint.toLong, 32 bits)).resize(32)
          s3Result :=
            Mux(sum > S(ActivationDType.maxVal, 32 bits),
                S(ActivationDType.maxVal, ActivationDType.bits bits),
            Mux(sum < S(ActivationDType.minVal, 32 bits),
                S(ActivationDType.minVal, ActivationDType.bits bits),
                sum.resize(ActivationDType.bits)))
        }

        // Stage 1 → Stage 2: multiply adjusted inputs by their scale factors.
        // 9-bit signed × 32-bit positive → 41-bit signed; fits one DSP each.
        s2Valid := s1Valid
        when(s1Valid) {
          s2ProdA := (s1AAdj.resize(41) * multA.resize(41)).resize(64)
          s2ProdB := (s1BAdj.resize(41) * multB.resize(41)).resize(64)
        }

        // Stage 0 → Stage 1: subtract zero-points.
        s1Valid := s0Valid
        when(s0Valid) {
          s1AAdj := s0A.resize(adjBits) - S(cfg.inputAQuant.zeroPoint.toLong, adjBits bits)
          s1BAdj := s0B.resize(adjBits) - S(cfg.inputBQuant.zeroPoint.toLong, adjBits bits)
        }

        // Input → Stage 0: consume one element from each stream simultaneously.
        // Both must be valid; ready is asserted only when the other is also valid.
        val inputFire = activationA.valid && activationB.valid
        s0Valid := inputFire
        when(inputFire) {
          s0A := activationA.payload.value
          s0B := activationB.payload.value
        }
      }

      // Inputs are accepted only when the pipeline is not stalled and both are valid.
      activationA.ready := !stall && activationB.valid
      activationB.ready := !stall && activationA.valid
    }

    Io(activationOut = logic.activationOut)
  }
}
