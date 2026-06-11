package spinalnn.bench

import spinalnn.compiler._
import spinalnn.target._

/** Demonstrate the auto N-sweep optimiser on RepVGG-A0 and DS-CNN-S.
  *
  * Runs entirely at build time — no P&R needed. Outputs:
  *   1. optimizeReport for each model (budget, gain, JSON overrides)
  *   2. Per-layer breakdown under the optimised policy
  *
  * Usage:  sbt "runMain spinalnn.bench.PrintNOptimize"
  */
object PrintNOptimize extends App {

  // ── RepVGG-A0 on Ti180 (512 DSP budget, maxN=16 avoids timing regression) ──
  println("=" * 70)
  println("RepVGG-A0 INT8  —  Ti180M484  (512 DSP, maxN=16, 173.3 MHz)")
  println("=" * 70)

  val repvggModel = OnnxCompiler.loadModel("models/repvgg_a0-int8.onnx")
  val repvggSpecs = OnnxFrontend.lowerQuantized(repvggModel, emitLogits = true)

  println(ModelCycleEstimator.optimizeReport(
    specs        = repvggSpecs,
    dspBudget    = 512,
    defaultN     = 8,
    maxN         = 16,
    freqMHz      = 173.3,
    weightStream = true
  ))

  val (repvggPolicy, repvggStats) = ModelCycleEstimator.optimizeMacPar(
    specs        = repvggSpecs,
    dspBudget    = 512,
    defaultN     = 8,
    maxN         = 16,
    weightStream = true
  )
  println("--- Per-layer breakdown (optimised policy) ---")
  println(repvggStats.report(173.3))

  // ── DS-CNN-S on Ti180 (512 DSP budget, maxN=16, 206.9 MHz) ──────────────
  println("=" * 70)
  println("DS-CNN-S INT8  —  Ti180M484  (512 DSP, maxN=16, 206.9 MHz)")
  println("=" * 70)

  val dscnnModel = OnnxCompiler.loadModel("models/dscnn_s-int8.onnx")
  val dscnnSpecs = OnnxFrontend.lowerQuantized(dscnnModel, emitLogits = true)

  println(ModelCycleEstimator.optimizeReport(
    specs        = dscnnSpecs,
    dspBudget    = 512,
    defaultN     = 8,
    maxN         = 16,
    freqMHz      = 206.9,
    weightStream = true
  ))

  val (dscnnPolicy, dscnnStats) = ModelCycleEstimator.optimizeMacPar(
    specs        = dscnnSpecs,
    dspBudget    = 512,
    defaultN     = 8,
    maxN         = 16,
    weightStream = true
  )
  println("--- Per-layer breakdown (optimised policy) ---")
  println(dscnnStats.report(206.9))

  // ── DS-CNN-S on Ti90 (288 DSP budget — smallest Titanium) ───────────────
  println("=" * 70)
  println("DS-CNN-S INT8  —  Ti90  (288 DSP, maxN=16, 206.9 MHz)")
  println("=" * 70)

  println(ModelCycleEstimator.optimizeReport(
    specs        = dscnnSpecs,
    dspBudget    = 288,
    defaultN     = 8,
    maxN         = 16,
    freqMHz      = 206.9,
    weightStream = true
  ))

  // ── DS-CNN-S P=4 on PWConv — WeightRom (no LPDDR4x), Ti90 target ────────
  val pwconvNames = Set(
    "_blocks_blocks_0_pw_Conv_output_0_quantized",
    "_blocks_blocks_1_pw_Conv_output_0_quantized",
    "_blocks_blocks_2_pw_Conv_output_0_quantized",
    "_blocks_blocks_3_pw_Conv_output_0_quantized"
  )
  val p4OutParOf: String => Int = name => if (pwconvNames(name)) 4 else 1
  val p1Stats = ModelCycleEstimator.estimate(dscnnSpecs, MacParFixed(8), weightStream = false)
  val p4Stats = ModelCycleEstimator.estimate(dscnnSpecs, MacParFixed(8), weightStream = false, outParOf = p4OutParOf)
  val dspP4   = ModelCycleEstimator.dspCostOf(dscnnSpecs, MacParFixed(8), p4OutParOf)
  println("=" * 70)
  println("DS-CNN-S P=4 PWConv  —  WeightRom  (Ti90 target, N=8)")
  println("=" * 70)
  println(f"  P=1  (baseline WeightRom N=8): ${p1Stats.totalCycles}%,12d cycles  ${p1Stats.fpsAt(150.0)}%7.2f FPS @ 150 MHz  DSP=${ModelCycleEstimator.dspCostOf(dscnnSpecs, MacParFixed(8))}%d")
  println(f"  P=4  (PWConv P=4, WeightRom):  ${p4Stats.totalCycles}%,12d cycles  ${p4Stats.fpsAt(150.0)}%7.2f FPS @ 150 MHz  DSP=$dspP4%d")
  println(f"  Gain: ${p1Stats.totalCycles.toDouble / p4Stats.totalCycles}%.2fx FPS  (${"%.1f".format((1.0 - p4Stats.totalCycles.toDouble/p1Stats.totalCycles)*100)}%% fewer cycles)")
  println("--- Per-layer breakdown (P=4 policy) ---")
  println(p4Stats.report(150.0))
}
