package spinalnn.compiler

import scala.collection.mutable
import spinalnn.target.{MacParAuto, MacParByChannels, MacParFixed, MacParPerLayer, MacParallelism}

/** Analytical cycle estimator for a compiled [[LayerSpec]] IR graph.
  *
  * Walks the spec list and computes expected inference cycles per layer based on
  * the loop structure of each Core. Useful for macParallelism trade-off analysis
  * without running simulation or P&R.
  *
  * Accuracy notes:
  *  - Assumes zero back-pressure (downstream always ready).
  *  - Ignores pipeline fill/drain at layer boundaries (~3-6 cycles, negligible
  *    for production-size layers).
  *  - WeightStream DMA latency is not modelled; for large C_in layers the DMA
  *    typically hides behind compute when the weight prefetch completes before
  *    the previous output channel finishes.
  *  - [[LayerSpec.Conv]] with N > 1 falls back to N=1 when C_in is not
  *    divisible by N (mirrors IrBackend's runtime fallback).
  *  - [[LayerSpec.Conv]] layers dispatched to QLinearConvLineCore always use
  *    N=1 (the line-buffer core has no MAC lane replication).
  */
object ModelCycleEstimator {

  case class LayerStats(
    name:       String,
    opType:     String,
    cyclesEst:  Long,
    pctOfTotal: Double
  )

  case class ModelStats(
    layers:      Seq[LayerStats],
    totalCycles: Long,
    macN:        Int
  ) {
    def fpsAt(freqMHz: Double): Double = freqMHz * 1e6 / totalCycles

    def report(freqMHz: Double = 150.0): String = {
      val sb = new StringBuilder
      sb ++= f"ModelCycleEstimator  macParallelism=N=$macN  freq=${freqMHz}%.0f MHz\n"
      sb ++= f"  Total cycles : ${totalCycles}%,d\n"
      sb ++= f"  FPS estimate : ${fpsAt(freqMHz)}%.2f\n\n"
      sb ++= f"  ${"Layer"}%-44s  ${"OpType"}%-22s  ${"Cycles"}%15s  ${"Pct"}%6s\n"
      sb ++= "  " + "-" * 95 + "\n"
      for (l <- layers) {
        sb ++= f"  ${l.name}%-44s  ${l.opType}%-22s  ${l.cyclesEst}%,15d  ${l.pctOfTotal}%5.1f%%\n"
      }
      sb.result()
    }
  }

  private val pipelineDrain = 3  // pipelined multiply-accumulate tail in QLinearConvCore

  /** Estimate cycles using a full [[MacParallelism]] policy (per-layer N supported). */
  def estimate(specs: Seq[LayerSpec], policy: MacParallelism): ModelStats =
    estimate(specs, policy, weightStream = false, _ => 1)

  /** Estimate cycles (MacParallelism policy, no P). */
  def estimate(specs: Seq[LayerSpec], policy: MacParallelism, weightStream: Boolean): ModelStats =
    estimate(specs, policy, weightStream, _ => 1)

  /** Estimate cycles using a full [[MacParallelism]] policy (per-layer N and P supported).
    *
    * @param weightStream When true, adds WeightStream load overhead per output channel:
    *                     ceil(kH*kW*C_in / 64) beats × (64/N) drain cycles.
    * @param outParOf     Returns outParallelism P for a given Conv layer name.
    *                     P > 1 divides the compute term by P (the P output channel groups
    *                     share one activation pass; emit is still 1 cycle per channel).
    */
  def estimate(
    specs:        Seq[LayerSpec],
    policy:       MacParallelism,
    weightStream: Boolean,
    outParOf:     String => Int
  ): ModelStats = {
    val rawLayers: Seq[Option[LayerStats]] = specs.map {
      case c: LayerSpec.Conv =>
        val n  = resolveN(policy, c.inputShape.channels, c.name)
        val p  = outParOf(c.name).max(1)
        val cN = c.inputShape.channels / n
        val padH = c.inputShape.rows  + c.padTop  + c.padBottom
        val padW = c.inputShape.cols  + c.padLeft + c.padRight
        val rx   = padH.toLong * padW * c.inputShape.channels
        // With P output groups: compute phase runs once per group (C_out/P groups).
        val comp = c.shape.rows.toLong * c.shape.cols * (c.shape.channels / p) *
                   (cN * c.kernelH * c.kernelW + pipelineDrain)
        val wload = if (weightStream && 64 % n == 0) {
          val loadPerCh = ((c.kernelH * c.kernelW * c.inputShape.channels + 63) / 64) * (64 / n)
          (c.shape.channels / p).toLong * loadPerCh
        } else 0L
        val tag = s"conv${c.kernelH}x${c.kernelW}[N=$n,P=$p,Cin=${c.inputShape.channels},Cout=${c.shape.channels}]"
        Some(LayerStats(c.name, tag, rx + comp + wload, 0.0))
      case other =>
        estimate(Seq(other), 1).layers.headOption
    }
    val layers = rawLayers.flatten
    val total  = layers.map(_.cyclesEst).sum.max(1)
    val withPct = layers.map(l => l.copy(pctOfTotal = 100.0 * l.cyclesEst / total))
    val displayN = policy match {
      case MacParAuto           => 0
      case MacParFixed(n)       => n
      case _: MacParPerLayer    => -1
      case _: MacParByChannels  => -1
    }
    ModelStats(withPct, total, displayN)
  }

  /** Estimate cycles for every hardware-mapped layer at `macN` MAC lanes.
    * `macN` affects only [[LayerSpec.Conv]]; all other ops are unaffected.
    *
    * @param weightStream When true, adds WeightStream load overhead per output channel:
    *                     ceil(kH*kW*C_in / 64) beats × (64/N) drain cycles.
    *                     Leave false (default) for WeightRom designs.
    */
  def estimate(specs: Seq[LayerSpec], macN: Int = 1, weightStream: Boolean = false): ModelStats = {
    require(macN >= 1, s"macN must be >= 1, got $macN")

    val rawLayers: Seq[Option[LayerStats]] = specs.map {

      // ── Convolution (full-buffer QLinearConvCore or line-buffer QLinearConvLineCore) ──
      case s: LayerSpec.Conv =>
        // Resolve actual N (fall back to 1 if C_in not divisible)
        val n  = if (s.inputShape.channels % macN == 0) macN else 1
        val cN = s.inputShape.channels / n           // channels per lane
        // Reception: stream the padded input into the activation buffer
        val padH = s.inputShape.rows  + s.padTop  + s.padBottom
        val padW = s.inputShape.cols  + s.padLeft + s.padRight
        val rxCycles = padH.toLong * padW * s.inputShape.channels
        // Computation: per output pixel run C_N*kH*kW MAC steps + pipeline drain
        val macSteps = cN * s.kernelH * s.kernelW
        val computeCycles = s.shape.rows.toLong * s.shape.cols * s.shape.channels *
                            (macSteps + pipelineDrain)
        // WeightStream: reload weights from LPDDR4x before each output channel.
        // Only applicable when 64 % n == 0 (beat-drain requires integer step count).
        // When 64 % n != 0, IrBackend falls back to WeightRom for this layer; no load overhead.
        val wloadCycles = if (weightStream && 64 % n == 0) {
          val loadPerCh = ((s.kernelH * s.kernelW * s.inputShape.channels + 63) / 64) * (64 / n)
          s.shape.channels.toLong * loadPerCh
        } else 0L
        val cycles = rxCycles + computeCycles + wloadCycles
        val tag = s"conv${s.kernelH}x${s.kernelW}[N=$n,Cin=${s.inputShape.channels},Cout=${s.shape.channels}]"
        Some(LayerStats(s.name, tag, cycles, 0.0))

      // ── Depthwise convolution (no macParallelism) ──────────────────────────
      case s: LayerSpec.DepthwiseConv =>
        val rxCycles = s.inputShape.size.toLong
        val computeCycles = s.shape.rows.toLong * s.shape.cols * s.shape.channels *
                            (s.kernelH * s.kernelW + pipelineDrain)
        val cycles = rxCycles + computeCycles
        Some(LayerStats(s.name, s"dw${s.kernelH}x${s.kernelW}[C=${s.shape.channels}]", cycles, 0.0))

      // ── MaxPool ───────────────────────────────────────────────────────────
      case s: LayerSpec.MaxPool =>
        // Receive entire input + emit output; line-buffer overlaps but estimate conservatively
        val cycles = s.inputShape.size.toLong + s.shape.size.toLong
        Some(LayerStats(s.name, s"maxpool${s.poolH}x${s.poolW}", cycles, 0.0))

      // ── GlobalAveragePool ─────────────────────────────────────────────────
      case s: LayerSpec.GlobalAveragePool =>
        val cycles = s.inputShape.size.toLong + s.inputShape.channels.toLong
        Some(LayerStats(s.name, s"gap[C=${s.inputShape.channels}]", cycles, 0.0))

      // ── Fully-connected linear ────────────────────────────────────────────
      case s: LayerSpec.Linear =>
        val cycles = s.inNeurons.toLong * s.outNeurons + s.outNeurons
        Some(LayerStats(s.name, s"linear[${s.inNeurons}->${s.outNeurons}]", cycles, 0.0))

      // ── Element-wise streaming ops (ReLU, Add, Concat) ────────────────────
      case s: LayerSpec.Relu =>
        Some(LayerStats(s.name, "relu", s.shape.size.toLong, 0.0))

      case s: LayerSpec.Add =>
        Some(LayerStats(s.name, "add", s.shape.size.toLong, 0.0))

      case s: LayerSpec.Concat =>
        Some(LayerStats(s.name, "concat", s.shape.size.toLong, 0.0))

      case s: LayerSpec.Softmax =>
        Some(LayerStats(s.name, "softmax", s.numClasses.toLong, 0.0))

      // ── Zero-RTL ops ──────────────────────────────────────────────────────
      case _: LayerSpec.Input   => None
      case _: LayerSpec.Flatten => None
      case _: LayerSpec.Output  => None
    }

    val layers = rawLayers.flatten
    val total  = layers.map(_.cyclesEst).sum.max(1)
    val withPct = layers.map(l => l.copy(pctOfTotal = 100.0 * l.cyclesEst / total))
    ModelStats(withPct, total, macN)
  }

  /** Sweep `macN` values and return a compact comparison table.
    *
    * @param weightStream When true, includes WeightStream DRAM load overhead in cycle counts.
    */
  def sweep(
    specs:        Seq[LayerSpec],
    ns:           Seq[Int]    = Seq(1, 2, 4, 8, 16, 32),
    freqMHz:      Double      = 150.0,
    weightStream: Boolean     = false
  ): String = {
    val sb = new StringBuilder
    val wsTag = if (weightStream) " WeightStream" else " WeightRom"
    sb ++= f"macParallelism sweep  (freq = ${freqMHz}%.0f MHz$wsTag)\n"
    sb ++= f"  ${"N"}%-4s  ${"Total Cycles"}%20s  ${"FPS"}%10s  ${"vs N=1"}%8s\n"
    sb ++= "  " + "-" * 50 + "\n"
    val baseline = estimate(specs, 1, weightStream).totalCycles.toDouble
    for (n <- ns) {
      val est = estimate(specs, n, weightStream)
      val speedup = baseline / est.totalCycles
      sb ++= f"  ${n}%-4d  ${est.totalCycles}%,20d  ${est.fpsAt(freqMHz)}%10.2f  ${speedup}%7.2fx\n"
    }
    sb.result()
  }

  /** Resolve what N a given policy assigns to a specific conv layer.
    * Mirrors the fallback logic in IrBackend.macN — call this to verify a
    * MacParPerLayer map before elaborating hardware. */
  def resolveN(policy: MacParallelism, inCh: Int, layerName: String): Int = {
    val requested = policy match {
      case MacParAuto                          => 1
      case MacParFixed(n)                      => n
      case MacParPerLayer(overrides, dflt)     => overrides.getOrElse(layerName, dflt)
      case MacParByChannels(cm, dflt, lo)      => lo.getOrElse(layerName, cm.getOrElse(inCh, dflt))
    }
    if (inCh % requested == 0) requested else 1
  }

  /** Dry-run: show what N each Conv layer would receive under `policy`.
    * Flags fallbacks (requested N not divisible by C_in) so you can fix the map
    * before kicking off elaboration or P&R.
    *
    * Example usage:
    *   println(ModelCycleEstimator.macParAssignment(specs, MacParPerLayer(
    *     Map("conv10_1_quantized" -> 32), default = 1)))
    */
  def macParAssignment(
    specs:   Seq[LayerSpec],
    policy:  MacParallelism,
    freqMHz: Double = 150.0
  ): String = {
    val baseline = estimate(specs, 1).totalCycles.toDouble
    val sb = new StringBuilder
    sb ++= s"macParAssignment  policy=$policy\n"
    sb ++= f"  ${"Layer"}%-44s  ${"C_in"}%5s  ${"Req"}%4s  ${"Got"}%4s  ${"Note"}%-10s  ${"CyclesAt1"}%12s\n"
    sb ++= "  " + "-" * 96 + "\n"
    var totalFallbacks = 0
    for (s <- specs) s match {
      case c: LayerSpec.Conv =>
        val inCh = c.inputShape.channels
        val requested = policy match {
          case MacParAuto                          => 1
          case MacParFixed(n)                      => n
          case MacParPerLayer(overrides, dflt)     => overrides.getOrElse(c.name, dflt)
          case MacParByChannels(cm, dflt, lo)      => lo.getOrElse(c.name, cm.getOrElse(inCh, dflt))
        }
        val got  = if (inCh % requested == 0) requested else { totalFallbacks += 1; 1 }
        val note = if (got != requested) "FALLBACK" else if (got > 1) "ok" else ""
        val cycAt1 = estimate(Seq(c), 1).totalCycles
        sb ++= f"  ${c.name}%-44s  ${inCh}%5d  ${requested}%4d  ${got}%4d  ${note}%-10s  ${cycAt1}%,12d\n"
      case _ =>
    }
    sb ++= "  " + "-" * 96 + "\n"
    if (totalFallbacks > 0)
      sb ++= s"  WARNING: $totalFallbacks layer(s) fell back to N=1 due to C_in indivisibility.\n"
    else
      sb ++= s"  All Conv layers assigned without fallback.\n"
    val policyEst  = estimate(specs, policy).totalCycles
    val baseEst    = estimate(specs, 1).totalCycles
    val speedup    = baseEst.toDouble / policyEst
    sb ++= f"  Total cycles (this policy): ${policyEst}%,d  (${speedup}%.2fx vs N=1 baseline)\n"
    sb.result()
  }

  /** Conservative DSP cost estimate for a [[MacParallelism]] policy.
    *
    * Per-primitive cost (matches empirical MAP results within ~2%):
    *   Conv at N, P : P × (N MAC DSPs + 4 requant DSPs) = P × (N + 4)
    *   DWConv        : 1 MAC + 4 requant = 5  (P=1 always for DWConv)
    *   Linear        : 4 (requant multiply per output neuron; MAP packs tightly)
    *   Others        : 0
    *
    * @param outParOf Optional function that returns the P (outParallelism) for a given layer
    *                 name. Defaults to P=1 for all layers when omitted.
    */
  def dspCostOf(
    specs:     Seq[LayerSpec],
    policy:    MacParallelism,
    outParOf:  String => Int = _ => 1
  ): Int =
    specs.map {
      case c: LayerSpec.Conv =>
        val N = resolveN(policy, c.inputShape.channels, c.name)
        val P = outParOf(c.name)
        P * (N + 4)
      case _: LayerSpec.DepthwiseConv => 5
      case _: LayerSpec.Linear        => 4
      case _                          => 0
    }.sum

  /** Greedily find the per-layer N assignment that maximises estimated FPS within `dspBudget`.
    *
    * Uses a greedy fractional-knapsack: at each step, upgrade the Conv layer whose
    * next-N gives the best (cycles saved) / (DSP cost) ratio, until the budget is
    * exhausted or no further upgrades fit.
    *
    * The result is a [[MacParallelism]] policy and the estimated [[ModelStats]] under it.
    * Run one P&R with the output JSON to confirm actual fmax — the estimator optimises
    * cycles but does not model timing closure. Apply `maxN` to guard against wide MAC
    * trees that may cause fmax regression (empirical: N=32 on Ti180 → ~10% fmax drop).
    *
    * @param dspBudget   Hard DSP ceiling (e.g. 512 for Ti180, 288 for Ti90)
    * @param defaultN    Baseline N for all layers not overridden
    * @param maxN        Per-layer cap; set to 16 on Ti180 to avoid timing regression
    * @param candidateNs Ordered candidate N values; only divisors of C_in are used
    * @param weightStream Include WeightStream DMA overhead in cycle estimates
    */
  def optimizeMacPar(
    specs:        Seq[LayerSpec],
    dspBudget:    Int,
    defaultN:     Int      = 8,
    maxN:         Int      = 32,
    candidateNs:  Seq[Int] = Seq(1, 2, 4, 8, 16, 32, 64),
    weightStream: Boolean  = true
  ): (MacParallelism, ModelStats) = {

    val convLayers = specs.collect { case c: LayerSpec.Conv => c }

    // Track effective N for each Conv layer, starting from the defaultN (with fallback).
    val curN: mutable.Map[String, Int] = mutable.Map(
      convLayers.map(c => c.name -> resolveN(MacParFixed(defaultN), c.inputShape.channels, c.name)): _*
    )

    def policy: MacParallelism = {
      val overrides = curN.toMap.filter { case (name, n) =>
        val c = convLayers.find(_.name == name).get
        n != resolveN(MacParFixed(defaultN), c.inputShape.channels, name)
      }
      MacParPerLayer(overrides, defaultN)
    }

    var remaining = dspBudget - dspCostOf(specs, policy)

    var improved = true
    while (improved && remaining > 0) {
      improved = false
      var bestScore = 0.0
      var bestLayer: Option[LayerSpec.Conv] = None
      var bestNext  = 0

      for (c <- convLayers) {
        val n0 = curN(c.name)
        val nextOpt = candidateNs.find(n => n > n0 && n <= maxN && c.inputShape.channels % n == 0)
        nextOpt.foreach { n1 =>
          val deltaDSP = n1 - n0
          if (deltaDSP <= remaining) {
            val before = estimate(Seq(c), MacParFixed(n0), weightStream).totalCycles
            val after  = estimate(Seq(c), MacParFixed(n1), weightStream).totalCycles
            val score  = (before - after).toDouble / deltaDSP
            if (score > bestScore) { bestScore = score; bestLayer = Some(c); bestNext = n1 }
          }
        }
      }

      bestLayer.foreach { c =>
        remaining -= (bestNext - curN(c.name))
        curN(c.name) = bestNext
        improved = true
      }
    }

    val finalPolicy = policy
    (finalPolicy, estimate(specs, finalPolicy, weightStream))
  }

  /** Format an optimizeMacPar result as a human-readable report and JSON override snippet. */
  def optimizeReport(
    specs:        Seq[LayerSpec],
    dspBudget:    Int,
    defaultN:     Int     = 8,
    maxN:         Int     = 32,
    freqMHz:      Double  = 150.0,
    weightStream: Boolean = true
  ): String = {
    val baseStats = estimate(specs, MacParFixed(defaultN), weightStream)
    val (optPolicy, optStats) = optimizeMacPar(specs, dspBudget, defaultN, maxN,
                                               weightStream = weightStream)
    val dspBefore = dspCostOf(specs, MacParFixed(defaultN))
    val dspAfter  = dspCostOf(specs, optPolicy)
    val sb = new StringBuilder
    sb ++= s"=== optimizeMacPar  budget=$dspBudget  defaultN=$defaultN  maxN=$maxN ===\n"
    sb ++= f"  Baseline  (N=$defaultN global):  ${baseStats.totalCycles}%,12d cycles  " +
           f"${baseStats.fpsAt(freqMHz)}%7.2f FPS  DSP=$dspBefore\n"
    sb ++= f"  Optimised (per-layer):  ${optStats.totalCycles}%,12d cycles  " +
           f"${optStats.fpsAt(freqMHz)}%7.2f FPS  DSP=$dspAfter\n"
    sb ++= f"  Gain: ${100.0*(baseStats.totalCycles - optStats.totalCycles)/baseStats.totalCycles}%.1f%% fewer cycles  " +
           f"${optStats.fpsAt(freqMHz)/baseStats.fpsAt(freqMHz)}%.3fx FPS\n"
    sb ++= "\n  Overrides (add to macParallelismOverrides in JSON):\n"
    optPolicy match {
      case MacParPerLayer(overrides, _) =>
        if (overrides.isEmpty) sb ++= "  (none — defaultN is already optimal)\n"
        else overrides.toSeq.sortBy(_._1).foreach { case (name, n) =>
          sb ++= f"    \"$name\": $n\n"
        }
      case _ =>
    }
    sb.result()
  }
}
