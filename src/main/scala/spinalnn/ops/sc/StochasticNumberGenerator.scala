package spinalnn.ops.sc

import spinal.core._

/** Fibonacci maximal-length 8-bit LFSR stochastic number generator (B1).
  *
  * Converts an unsigned 8-bit threshold to a 1-bit stochastic bitstream:
  *   P(bit = 1) ≈ threshold / 255
  *
  * Polynomial: x^8 + x^4 + x^3 + x^2 + 1 (primitive, period = 255).
  * Right-shifting LFSR: new_bit7 = fb; bits 7..1 shift to 6..0; bit 0 is dropped.
  * Feedback: fb = r(0) ^ r(2) ^ r(3) ^ r(4)  (taps at polynomial exponents 0,2,3,4).
  * Any non-zero seed produces a valid 255-cycle maximal sequence.
  *
  * Different seeds produce statistically independent bitstreams — crucial for
  * separating weight and activation SNGs from the same MAC lane.
  */
object StochasticNumberGenerator {
  val lfsrBits = 8

  // Fibonacci LFSR next-state for x^8+x^4+x^3+x^2+1.
  // Correct taps are r(0),r(2),r(3),r(4) — NOT r(7),r(5),r(4),r(3).
  // The former puts the LSB in the feedback path so all 255 non-zero states
  // form one cycle; the latter drops the LSB and gets stuck at 0 for seeds < 8.
  def nextState(r: UInt): UInt = {
    val fb = r(0) ^ r(2) ^ r(3) ^ r(4)
    (fb ## r(7 downto 1)).asUInt
  }
}

/** One LFSR-based SNG lane. The threshold is sampled every cycle from `io.threshold`;
  * the LFSR advances unconditionally. `seed` must be non-zero and unique per lane.
  */
class StochasticNumberGenerator(seed: Int) extends Component {
  import StochasticNumberGenerator._
  require(seed >= 1 && seed <= 255, s"SNG seed must be in [1,255], got $seed")

  val io = new Bundle {
    val threshold = in  UInt(lfsrBits bits)  // P(bit=1) ≈ threshold / 255
    val bit       = out Bool()
  }

  val lfsr = Reg(UInt(lfsrBits bits)) init seed
  lfsr := nextState(lfsr)
  io.bit := lfsr < io.threshold
}
