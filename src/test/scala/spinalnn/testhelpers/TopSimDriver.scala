package spinalnn.testhelpers

import spinal.core.sim._
import spinalnn.SpinalNNTop

/** Simulation driver for [[SpinalNNTop]].
  *
  * Drives the activation input stream and collects exactly `outputCount` values
  * from the activation output stream.  Works for any compiled model: the caller
  * supplies the flat HWC input tensor and the expected output element count.
  */
object TopSimDriver {

  /** Stream `input` into `dut`, collect `outputCount` output values.
    *
    * @param dut          Simulated SpinalNNTop instance (clock already started)
    * @param input        Flat HWC input tensor as Int (each value fits in SInt8)
    * @param outputCount  Number of output activations to collect before returning
    * @param timeout      Simulation cycle budget (default 500 000)
    * @return             Collected output values in order
    */
  def run(
    dut:         SpinalNNTop,
    input:       Array[Int],
    outputCount: Int,
    timeout:     Int = 500_000
  ): Array[Int] = {
    dut.io.activationOut.ready #= true

    val stim = fork {
      for (v <- input) {
        dut.io.activationIn.valid         #= true
        dut.io.activationIn.payload.value #= v
        dut.clockDomain.waitSamplingWhere(dut.io.activationIn.ready.toBoolean)
      }
      dut.io.activationIn.valid #= false
    }

    val results = Array.ofDim[Int](outputCount)
    var collected = 0
    var cycles    = 0

    while (collected < outputCount && cycles < timeout) {
      dut.clockDomain.waitSampling()
      sleep(1)
      if (dut.io.activationOut.valid.toBoolean && dut.io.activationOut.ready.toBoolean) {
        results(collected) = dut.io.activationOut.payload.value.toInt
        collected += 1
      }
      cycles += 1
      if (cycles % 100_000 == 0)
        println(s"    [TopSimDriver] $cycles cycles elapsed, $collected/$outputCount collected…")
    }

    assert(collected == outputCount,
      s"TopSimDriver timeout: collected $collected/$outputCount after $cycles cycles")
    results
  }
}
