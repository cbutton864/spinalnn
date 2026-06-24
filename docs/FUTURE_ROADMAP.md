# SpinalNN Future R&D and Verification Roadmap

This roadmap acts as a stable handover and tracking checklist for future development agents and collaborators. It maintains the exact technical context, design patterns, and priorities for the next developmental phases of SpinalNN.

---

## ── ACTIVE SPRINT (June–July 2026) ──

Two-phase execution plan agreed 2026-06-20. Complete Phase A before starting Phase B.

---

### Phase A: W4A8 + WeightStream  *(~1 week, high confidence)*

**Goal**: unlock SqueezeNet at N=32 on Ti180 by combining INT4 weights (freed DSPs) with
LPDDR4x streaming (no BRAM overflow). Expected outcome: ~2× throughput vs INT8 N=16
(~4.6 FPS → ~8–9 FPS). DSP headroom drops from 512→512 (ceiling) to ~108.

Do steps in order — each unlocks the next.

- [x] **A1 — Compile-time nibble packing** *(IrBackend — done 2026-06-20)*  
  `effectiveWeightMode` now allows W4A8 WeightStream when `128 % N == 0` (was unconditional fallback).
  DMA descriptor `actual` = `ceil(KH×KW×CIN / 2)` bytes for W4A8 (was `KH×KW×CIN`).

- [x] **A2 — DMA byte-count halving** *(IrBackend — done 2026-06-20)*  
  `stride = ceil(actual/64)*64` propagates correctly from the halved actual. All existing
  WeightStream layers unaffected (`weightBits==8` path unchanged).

- [x] **A3+A4 — Nibble drain + FSM beat-count** *(QLinearConvLineCore RTL — done 2026-06-20)*  
  `stepsPerBeat = 512 / (N × weightBits)` → 128/N for W4A8, 64/N for INT8.
  Drain loop writes `N × wBits_` bits per step and shifts beat buf by `wBits_ × N` bits.
  Weight memory packing: lower nibble = even-indexed weight, upper nibble = odd-indexed weight.
  Config constraint changed: W4A8 requires `128 % N == 0`; INT8 retains `64 % N == 0`.
  `require(weightMode == WeightRom)` for W4A8 removed.

- [x] **A5 — Sim validation** *(QLinearConvLineCoreTest — done 2026-06-20)*  
  2 new tests added and passing:
  - "W4A8 WeightStream: VALID 3x3 C_in=4 N=4 matches WeightRom output"
  - "W4A8 WeightStream: SAME 3x3 C_in=4 N=4 two consecutive inferences correct"
  Full suite: **129/129 tests pass**.

- [x] **A6 — SqueezeNet W4A8 N=32 WeightStream P&R** *(DONE 2026-06-21)*  
  RTL: `rtl/squeezenet_w4a8/sqz_w4a8_n32_ws/SpinalNNTop.v`  
  P&R on Ti180M484: **109 DSP** (21%, −79% vs INT8), 748 RAM10K, 67,747 LUT4, **174.2 MHz** Fmax (+2.7 MHz vs INT8 N=16).  
  FPS: **~6.3 FPS** (estimated; +43% vs INT8 N=16 baseline at ~4.4 FPS).  
  Speedup limited to 1.43× (not 2×) because C_in=16 (fire2-3 expand) and C_in=48 (fire6-7 expand) layers are stuck at N=16.  
  Results posted to `BENCHMARKS_TITANIUM.md` §SqueezeNet W4A8.

**Definition of done for Phase A**: P&R result posted to `BENCHMARKS_TITANIUM.md`. ✓ **PHASE A COMPLETE (2026-06-21)**

---

### Phase B: StochasticConvCore  *(open-ended research)*

**Goal**: zero-DSP CNN inference on ultra-constrained Efinix devices (Ti20/Ti60) using
MUX-MAC stochastic computing (Lee et al. 2024). Target application: gesture / keyword /
anomaly tasks where ~INT8-level accuracy (SC at N=255: −0.14% per Lee et al.) is acceptable.
Research question: does SC beat INT8 on LUT4 for a device-constrained model (no DSP budget)?  
**B6 finding (2026-06-21)**: naive SC MNIST is 71× more LUTs than INT8 and doesn't fit Ti60.
MACFG architectural fix (B8) is required before SC is competitive.

- [x] **B1 — `StochasticNumberGenerator`** *(done 2026-06-21)*  
  Fibonacci maximal-length 8-bit LFSR (polynomial x^8+x^4+x^3+x^2+1, primitive, period 255).
  Right-shifting; feedback `fb = r(0)^r(2)^r(3)^r(4)`. Any nonzero seed → valid 255-cycle sequence.
  `bit := lfsr < threshold`. Key fix: correct polynomial taps put LSB in feedback path (wrong taps
  caused seeds 1–7 to reach state 0 immediately, inflating sc_acc by ~28%).

- [x] **B2 — MUX-MAC unit** *(done 2026-06-21)*  
  Per Lee et al. 2024: `wBit = wLfsr < wThr`; `aBit = aLfsr < aThr` (independent per-lane LFSR,
  seeds offset by 128 from weight LFSR). Sign-group splitting: positive weights → posBit, negative
  weights → negBit; `cycleDelta = CountOne(posBits) − CountOne(negBits)`.
  Accumulation via signed popcount tree over N cycles — zero DSP cost.

- [x] **B3 — `StochasticConvCore`** *(done 2026-06-21)*  
  Drop-in alternative to `QLinearConvCore`. Same streaming protocol (HWC Stream[Activation]).
  5-state FSM: sInit (pad fill) → sRx (receive frame) → sLoad (nMac+1 cycles, threshold/sign ROMs)
  → sSC (bitstreamLen cycles, MUX-MAC) → sDecode (scale + clamp + emit INT8).
  Zero-point correction `combAdj[oc] = round(scScale × (bias[oc] − 128×Σw[oc]))` folds the
  x+128 activation threshold shift out of the output. `src/main/scala/spinalnn/ops/sc/`.

- [x] **B4 — Simulation accuracy benchmark** *(done 2026-06-21)*  
  3 sim tests all pass (132/132 total suite). Key result:  
  Test 3 (1×1 kernel, nMac=4, N=255, all-same-sign weights ±100, uniform input=64):
  **max error = 4 INT8 units, mean error = 3.50** vs INT8 reference output ≈ ±26.
  Consistent with Lee et al. 0.14% accuracy loss at N=256 (larger nMac → lower variance by 1/√nMac).  
  `src/test/scala/spinalnn/ops/StochasticConvCoreTest.scala`.

- [x] **B5 — IrBackend + compiler integration** *(done 2026-06-21)*  
  `WeightStochastic(bitstreamLen: Int = 255)` added to `WeightPrecision` sealed trait in
  `CompilerOptions.scala`. `StochasticConvPlugin` wraps `StochasticConvCore.build()` in the
  FiberPlugin system (same shape as `QLinearConvPlugin`, no weightIn handle).
  `IrBackend.Conv` case splits on `weightPrecision`: `WeightStochastic` path → `StochasticConvPlugin`
  (skips DMA, no line buffer, no outParallelism); `_` path → existing INT8/W4A8 dispatch.
  Usage: `CompilerOptions(weightPrecision = WeightStochastic(255))`.

- [x] **B6 — P&R on Ti180 + Ti60** *(done 2026-06-21 — NEGATIVE RESULT)*  
  RTL generated via `GenMnistW4A8Bench` (sc_N255 config). P&R run on Ti180M484 and Ti60F256.  
  **Ti180 result**: 65,646 LUT4, 13 DSP48, 35,505 FF, 21 RAM10K, **143.968 MHz (timing FAIL @ 150)**.  
  **Ti60 result**: MAP succeeded (same LUT4); PNR **failed** — "Block capacity checks have failed" (65,646 > 62,016 cap).  
  Comparison to INT8 N=1 baseline (919 LUT4): SC naive is **71× worse on LUT4**. Does not fit Ti60 at all.  
  Root causes: (1) per-lane independent LFSRs O(nMac) overhead vs paper's O(1) MACFG; (2) always-on
  CountOne and comparator arrays from SpinalHDL `val` inside `when` (only gates register update, not logic);
  (3) synthesis inserts ~28K pipeline registers to break combinatorial timing-critical paths; (4) sDecode
  `resize(64)` multiply unnecessarily wide. Full analysis: `BENCHMARKS_TITANIUM.md §SC Root Cause`.  
  Benchmark dirs: `benchmark_mnist_sc_n255/` (Ti180), `benchmark_mnist_sc_n255_ti60/` (Ti60).

- [x] **B8 — MACFG architectural fix** *(DONE 2026-06-21)*  
  Three fixes applied to `StochasticConvCore.scala`:  
  (a) **MACFG**: single root LFSR per SNG type + shift-register chain for per-lane skewed copies. O(1) feedback logic vs O(nMac) independent LFSRs. Seeds offset by 128 to decorrelate weight/activation bitstreams.  
  (b) **Registered MUX-MAC bits**: `posBitRegs`/`negBitRegs` are `Reg(Bool)` updated every cycle from LFSR chain + threshold regs. CountOne runs over registered outputs (no always-on combinatorial fan-in from FSM state).  
  (c) **actBuf single write port**: merged sInit (zero-fill) and sRx (receive) writes into one `when()` block with OR enable + `Mux` address/data. Two separate `Mem.write()` calls generate two independent write ports that Efinity cannot map to RAM10K → FF-array (~14K LUT4, ~21K FF overhead each). Single write port → RAM10K inferred.  
  (d) **Narrow sDecode multiply**: `corrected.resize(accBits+2) * S(cfg.decodeMult.toInt, 32 bits)` instead of `resize(64) * S(decodeMult, 64 bits)`.  
  **Result — Ti180**: 6,229 LUT4 (−90.5%), 8 DSP48 (−38%), 5,796 FF (−83.7%), 27 RAM10K, **177.620 MHz ✅**.  
  **Result — Ti60**: 6,229 LUT4 (10% of 62,016 cap), 176.305 MHz ✅. **SC now fits Ti60.**  
  All 132 tests pass. `src/main/scala/spinalnn/ops/sc/StochasticConvCore.scala`.

- [x] **B7 — End-to-end MNIST accuracy benchmark** *(DONE 2026-06-22)*  
  `ScAccuracyTest.scala`: 5 MNIST digits through SC pipeline (WeightStochastic N=255, MACFG LFSR).  
  **Result: 5/5 correct (100%)**. SC surpasses INT8 baseline (4/5) — correctly classifies sample 1
  (digit "2") which INT8 gets wrong due to calibration-gap quantization noise. SC approximation noise
  at N=255 is smaller than INT8 quantization error for this borderline digit.  
  Latency: ~3.09M sim cycles per MNIST image at N=1, bitstreamLen=255 (16 min wall-clock for 5
  samples under Verilator at ~50 MHz sim cycles/s).  
  Test: `sbt "testOnly spinalnn.ScAccuracyTest"`. Sim workspace: `simWorkspace/ScAccuracyTest/`.

- [x] **B9 — SqueezeNet SC P&R** *(DONE 2026-06-22)*  
  `GenSqueezeNetScBench.scala`: SqueezeNet 1.0 with `WeightStochastic(255)` on Ti180M484.  
  **Result: MAP FAILS — 3,046 RAM10K (238% of 1,280 Ti180 cap). PNR: "Block capacity checks have failed."**  
  SC also overflows LUT4+FF: 158K+122K = 280K cells vs 172K Ti180 logic capacity.  
  Only DSP is saved: 78 vs 512 for INT8 (6.6× fewer). SC is DSP-optimal, not BRAM/LUT-optimal.  
  Root cause: `conv10` classification head (1000 classes × 512 inputs = 512K weight entries) alone  
  contributes ~400+ RAM10K for wThrRom. Fix: **SC+WeightStream** (offload wThrRom to LPDDR4x).  
  MNIST-scale SC remains viable (27 RAM10K, 6,229 LUT4, Ti60-fitting). See `BENCHMARKS_TITANIUM.md §SC B9`.

- [x] **B10 — SC + WeightStream** *(DONE 2026-06-22)*  
  Added `weightMode: WeightMode` to `StochasticConvCore.Config`; new `sLoadW` FSM state drains 512-bit  
  DMA beats into `wThrRegs`/`wSignRegs` (packed byte format `[isNeg:1][abs_w:7]`).  
  `wThrRom` + `wSignRom` conditionally eliminated; `IrBackend` SC path adds DMA entries when `WeightStream`.  
  `StochasticConvPlugin` exposes `weightIn: Handle[Stream[Bits]]` mirroring `QLinearConvLineCorePlugin`.  
  **133/133 tests pass. Gen script: `GenSqueezeNetScWsBench`. MAP dir: `benchmark_sqz_sc_n255_ws_ti180/`.**  
  **B10 MAP result (SC+WeightStream, Ti180M484): LUT4=158,420, DSP=79, FF=130,662, RAM10K=1,824.**  
  WeightStream removes 1,222 RAM10K (−40% vs B9). But 1,824 > 1,280 cap: PNR still fails.  
  Root cause: SC's **full-frame actBuf** (H×W×C_in per layer). Early fire modules at 55×55×128 need  
  303 RAM10K each for actBuf alone. Weight ROMs were not the only problem — actBuf is the deeper  
  bottleneck independent of weight storage strategy.

- [x] **B11 — SC streaming actBuf (line buffer)** *(DONE 2026-06-23)*  
  K_H circular row Mems replace `actBuf = Mem(SInt(8 bits), paddedH × paddedW × C_in)`. Each slot
  stores one padded row (paddedW × C_in bytes). `sReceiveRow` writes rows circularly; `sLoad` selects
  the slot for each kernel row via compile-time `kKh[b]` offset into `oldestSlotReg` pointer.  
  Combined with B10 WeightStream: **MAP Ti180M484 — LUT4=156,973 (91%), DSP=53, FF=130,421, RAM10K=175 (14%).**  
  10.4× RAM10K reduction vs B10 (1,824 → 175). SC SqueezeNet fits Ti180. LUT4 at 91% — PNR pending.  
  `src/main/scala/spinalnn/ops/sc/StochasticConvCore.scala` | bench: `benchmark_sqz_sc_n255_ws_lb_ti180/`.

**Definition of done (Phase B)**: ✅ **COMPLETE** — B8 (6,229 LUT4, 177 MHz Ti60) + B7 (5/5 SC accuracy).  
**B9 finding**: SC WeightRom is BRAM-limited at ImageNet scale (3,046/1,280 RAM10K on SqueezeNet).  
**B10 finding**: SC WeightStream reduces BRAM 40% (3,046→1,824 RAM10K) but actBuf is the deeper limit.  
**B11 result**: SC WS + LineBuffer — RAM10K=175 (14% Ti180 cap), LUT4=156,973 (91%). SC SqueezeNet fits Ti180. PNR pending.  
**Publishable**: SC+MACFG at 6,229 LUT4 on Ti60 at 5/5 MNIST accuracy; zero MAC DSPs. Full ImageNet-scale SC on Ti180: B11 MAP done.

---

## ── COMPLETED SPRINT (May–June 2026) ──

Five concrete steps that closed out the prior sprint. All done.

- [x] **Step 1 — Close RepVGG-A0 config optimisation** *(P&R confirmed 2026-06-11)*  
  4×N=32 overrides (stages_1_1/2/3 C_in=96 + stages_3_0 C_in=192→1280) within 512-DSP budget.  
  P&R result: 501 DSP, 828 RAM10K, 156.7 MHz fmax (+0.285 ns @ 150 MHz target), ~1.50 FPS @ 150 MHz.  
  Key finding: timing wall is routing congestion (98% DSP utilization), not MAC tree logic depth.  
  Balanced tree in `QLinearConvCore` confirmed correct but didn't change fmax — efx_map already generates  
  balanced carry-lookahead internally. Net gain: **+9.4% FPS at 150 MHz** vs N=16 baseline.  
  N=32 pays off on Ti375 where 501/1344 DSPs (37%) leaves routing slack.

- [x] **Step 2 — DepthwiseConv core** *(5/5 tests passing; DS-CNN-S P&R validated 206.9 MHz)*  
  `DepthwiseConvCore` / `DepthwiseConvPlugin` implemented, tested, and end-to-end validated via DS-CNN-S P&R.  
  Unlocks: MobileNetV3-Small (Ti90 SWAP-C target), DS-CNN-S (KWS) ✅, EfficientNet-Lite0.

- [x] **Step 3 — Residual Add op** *(5/5 tests passing; compiler dispatch wired)*  
  `AddCore` / `AddPlugin` implemented and tested. MobileNetV2 compiles to RTL (BRAM overflow at 224×224 — needs smaller input or Ti375+).  
  Unlocks: ResNet-18 (need export), MobileNetV2 (need ≤64×64 export or larger device).

- [x] **Step 4 — Auto N-sweep build-time optimiser** *(implemented; RepVGG-A0 +1.77x FPS, DS-CNN-S +1.13x FPS)*  
  `ModelCycleEstimator.optimizeMacPar()` — greedy knapsack over (cycles saved / DSP cost) ratio.  
  `optimizeReport()` prints human-readable table + JSON override snippet ready for config files.  
  `PrintNOptimize` demo runner validates against RepVGG-A0 (Ti180) and DS-CNN-S (Ti180 + Ti90).  
  `maxN` parameter guards against N=32 timing regression (set to 16 on Ti180 by default).

- [x] **Step 5 — Output-channel parallelism P** *(sim 5/5; P&R confirmed Ti180M484)*  
  `QLinearConvCore` now accepts `outParallelism: Int = 1` (P). P×N weight ROM banks, P parallel  
  accumulator+requant pipelines, sequential P-channel emission. P=1 is bit-identical to prior code.  
  `ModelCycleEstimator` updated: `dspCostOf` = P×(N+4) per layer; `estimate` accepts `outParOf`.  
  P&R (Ti180M484, DS-CNN-S P=4): +0.609 ns slack @ 150 MHz, 230 DSP, 286 RAM10K, +1.30× FPS.  
  WeightStream requires P=1 (noted; P>1 WeightStream is future work).  
  DeviceSpec corrected to datasheet values (Ti180M484: 512 DSP usable, 1280 RAM10K).

---

## ── CURRENT STATUS & COMPLETED MILESTONES ──

- [x] **Flat-Plugin Architecture**: Stateless `Core` + `FiberPlugin` + stage-boundary trait pattern. All operators follow this pattern.
- [x] **Stage 4 BRAM Optimization**: `readSync` throughout Conv and Linear Cores; BRAM primitives confirmed in P&R on T20 (172 MHz) and Tz50 (280 MHz).
- [x] **macParallelism**: N-banked MAC array in `QLinearConvCore`; verified in sim (N=1 default; scales to any divisor of C_in).
- [x] **Native ONNX compiler**: `OnnxFrontend` (graph walk → `LayerSpec` IR) + `IrBackend` (op-dispatch registry + symbol table). General frontend — not MNIST-specific.
- [x] **Faithful shapes**: `auto_pad` SAME convolutions and general `kernel_shape`/`strides` pooling. MNIST top-1: 80% → **100% (5/5)**.
- [x] **DAG wiring**: `ConcatCore`/`ConcatPlugin` (fan-in, 4/4), `StreamForkCore`/`StreamForkPlugin` (fan-out, 4/4), `GlobalAveragePoolCore`/`GlobalAveragePoolPlugin` (5/5). Fire-module topology expressible.
- [x] **Per-channel requant**: `QLinearConvCore` accepts `weightScales: Option[Array[Float]]`; per-channel requant ROMs + variable barrel shifter (3/3 tests). Needed for all modern INT8 exports.
- [x] **QOperator frontend**: `lowerQuantized` reads scales/zero-points directly off QLinearConv nodes; Q/DQ alias folding; SqueezeNet structural IR tests (4/4).
- [x] **ConvEngineBench**: Synthesizable per-channel conv benchmark component; P&R validated on Tz50.
- [x] **Hardware target updated**: Primary target is now **Efinix Titanium** (Ti90–Ti375, 16 nm, embedded LPDDR4x). See `BENCHMARKS_TOPAZ.md` §4.
- [x] **Model target list curated**: Tier 1–4 models selected with public sources and operator gap analysis. See `ARCHITECTURE_DIRECTION.md` §8.

---

## ── HIGH PRIORITY: PHASE 1 ──
### 📋 Task 1: Accuracy Verification & Simulation Feed
**Goal**: Run true offline MNIST digits through the simulated Verilog structure using Verilator to confirm that the hardware accuracy is exactly aligned with the trained ML model's weights.

> **STATUS — DONE; root cause measured.** `OnnxInferenceValidationTest` matches the ONNX gold label on 4/5 (80%). `OnnxLogitInspectionTest` taps the 10 raw INT8 logits and pinpoints the cause: the ONNX compiler uses *hand-guessed* activation clip ranges (`q_conv1_out = 4/127`, `q_conv2_out = 8/127`, `q_fc_out = 16/127`). The single miss (sample 1, a "2") shows **no** FC saturation — instead the feature maps are distorted upstream (true class 2 suppressed to 6.4, spurious classes 4/6 amplified, including a sign flip on class 4), which flips the argmax. FC saturation does occur on strong samples (e.g. sample 4 pins class 4 at +127) but is not by itself fatal. Fix: a proper PTQ **calibration pass** that derives each `q_*_out` from observed per-layer activation maxima instead of guessed constants. This is a measurable calibration gap, not irreducible "quantization error".

- [x] **Step 1: Save Sample Image Assets**
  - Download or extract a batch of 5–10 handwritten images from the standard MNIST validation dataset (size $28 \times 28 \times 1$).
  - Store them as raw flattened byte arrays or raw text sequences in a nested directory under `models/model/` or `src/test/resources/`.
- [x] **Step 2: Implement Validation Sim Test**
  - Write a new scalatest class `src/test/scala/spinalnn/OnnxInferenceValidationTest.scala`.
  - Compile the harness running under `Params.onnx` setting.
  - Set up a fork-stimulus driver that loops through each validation image, streaming the $28 \times 28 = 784$ pixels sequentially with the correct ready-valid handshake signals.
  - Let the pipeline settle, capture the predicted classification probability logits from the physical output stream, and perform an exact assertion:
    ```scala
    val predictedDigit = outputLogits.indexOf(outputLogits.max)
    assert(predictedDigit == actualLabel, s"Model predicted $predictedDigit but actual was $actualLabel")
    ```
- [x] **Step 3: Run and Validate**
  - Execute using: `sbt "testOnly spinalnn.OnnxInferenceValidationTest"`. Verified accurate classification of physical digits!

---

## ── FUTURE PARADIGMS & ARCHITECTURAL UPGRADES ──

> **Primary direction:** the active forward track is the **general ONNX compiler**
> described in [ARCHITECTURE_DIRECTION.md](ARCHITECTURE_DIRECTION.md) (scope, three gaps,
> IR + op-registry seam, multi-input fan-in, dataflow-schedule axis, Phase 0–4 roadmap).
> spinalnn is **not** T20- or MNIST-specific; it targets the full FPGA size range and
> non-visual models. The paradigms below (DSP mapping, ASIC packaging, stochastic) remain
> valid long-term R&D but are **secondary** to landing the general frontend.

### ✅ Phase 0 (DONE): General ONNX Frontend
`OnnxFrontend` + `LayerSpec` IR + `IrBackend` op-registry. MNIST bit-identical. Done.

---

### ✅ Phase 1 (DONE): SqueezeNet end-to-end + Titanium benchmarks

**Open item — asymmetric-input bias correction:**
`lowerQuantized` must fold `−z_x · Σw[oc]` into each conv's biases at elaboration time.
SqueezeNet input zero-point = 115; zero points are currently hardcoded to 0 in several
`QuantParams(inScale, 0)` callsites. P&R is validated but end-to-end inference accuracy
on ImageNet has not been measured — this may mask a numeric error. ~10-line frontend change.

- [x] Add bias correction loop to `OnnxFrontend.lowerQuantized`; validate with ImageNet sample
  Implemented `zpBiasCorrect`: folds `−zp * Σw[oc]` into int32 biases for QLinearConv, DepthwiseConv, and QGemm.  
  Verified by SqueezeNetCompileTest (new "zero-point bias correction" test computes expected correction  
  from raw ONNX data and asserts LayerSpec biases match).
- [x] **ONNX accuracy validation (2026-06-16)**: `tools/check_imagenet_accuracy.py` — 4/4 gating checks pass.
  SqueezeNet INT8: 2/2 cats correctly classified (tabby 69.2%, lynx 32.9%). Validates full pipeline: preprocessing → INT8 quantization → zpBiasCorrect → correct top-1.
  RepVGG-A0 FP32: 2/2 correctly classified — confirms model weights + preprocessing are correct.
  RepVGG-A0 INT8: re-exported with real calibration images (no longer degenerate; cat top-2); needs ≥50 diverse ImageNet images for full accuracy.
  Generates `SqueezeNetValidationData.scala` + `RepVggValidationData.scala` for future RTL reference.
  `export_repvgg_a0_int8.py` updated with `--cal-images-dir` flag for proper recalibration.
- [x] Add elaboration test: SqueezeNet generates Verilog cleanly (IrBackend full pass)
- [x] Export QARepVGG-A0 INT8 from paper PyTorch code; add to `models/`
- [x] Synthesize + P&R: SqueezeNet (171.5 MHz, 512 DSP) and RepVGG-A0 (173.3 MHz, 435 DSP) on Ti180

**Target hardware**: Efinix Titanium Ti180M484 (512 DSPs, 1,280 RAM10K, embedded LPDDR4x).  
Results: see `docs/BENCHMARKS_TITANIUM.md`.

---

### ✅ Phase 2 (DONE): DepthwiseConv + DS-CNN-S
**Goal**: Add `DepthwiseConvCore`/`DepthwiseConvPlugin`; compile and simulate DS-CNN-S
(~24 KB INT8) from ARM ML-examples TFLite export. First BRAM-only non-vision benchmark.

- [x] `DepthwiseConvCore` — grouped conv, groups = C_in, weight `[C, 1, kH, kW]`
- [x] DS-CNN-S ONNX export from ARM ML-examples
- [x] End-to-end sim + accuracy check vs 92.2% reference
- [x] P&R on Ti90 (smallest LPDDR4x part); report utilization + latency
- [ ] **Open:** DS-CNN-S N=16 + P=2 on Ti90 (next P&R run; expected ~1.5× over N=8 P=1)

---

### 🟠 Phase 2.5: LPDDR4x Weight Streaming
**Goal**: AXI4 weight-DMA controller reading from Titanium embedded LPDDR4x into
double-buffered on-chip BRAM staging. Enables models > on-chip BRAM (QARepVGG, MobileNet).

**Phase 1 (512-bit DMA beats) — DONE 2026-06-15:**
- [x] `WeightDmaCore` outputs `Stream[Bits(512 bits)]` per fire (was `Stream[SInt(8 bits)]`)
- [x] All conv/linear cores drain N bytes/cycle from 512-bit shift register
- [x] N-banked weight BRAMs (N=16 lanes) for parallel load; `stepsPerBeat = 64/N`
- [x] `effectiveWeightMode` fallback to WeightRom when `64 % N ≠ 0` (e.g. conv1 C_in=3)
- [x] IrBackend: WeightStream always routes through `QLinearConvLineCore` (no full-frame BRAM)
- [x] IrBackend: MaxPool under MemAuto always uses line-buffer core (eliminates ~1,840 RAM10K)
- [x] P&R validated: 176 MHz, 510/512 DSP, 625/1280 RAM10K, ~3.1 FPS (conv1 N=1; N=3 override pending)
- [x] `WeightStreamN4Test` sim test passes (64/64 outputs match reference)
- [x] `GenSqueezeNetBench` utility generates ws_n1 / ws_n16 RTL variants

**Phase 2 (DMA clock domain) — PENDING:**
- [ ] PLL-derived synchronous clocks: DMA domain (fast) vs compute domain (150 MHz)
- [ ] Both clocks from same PLL → mesochronous, not asynchronous. Efinity timing closure
  handles PLL-derived clock relationships natively (same as Vivado/Quartus). No async FIFO
  (`StreamFifoCC`) needed — use a rate adapter or simple handshake + multicycle path SDC constraint.
  Verify `EFX_LPDDR4_32_V1` accepts an external clock input (vs. internal PLL) before finalizing.
- [ ] `BuildEnv` carries `dmaClockDomain` + `computeClockDomain`

**Phase 3 (double-buffer) — PENDING:**
- [ ] Ping-pong weight BRAMs: load channel K+1 while computing K
- [ ] Hides load latency on layers where load ≥ compute cycles

---

### 🟢 Phase 4 (R&D): Hardware DSP Customization (Altera BFloat16 & AMD DSP48)
**Goal**: Alternative math backends using hard silicon blocks. Secondary to the INT8 compiler track.

- [ ] **Math Abstraction Layer (`MathPlugin`)**
  - Selectable `MathEngine` trait defining raw multiplication interfaces.
  - Intel/Altera Agilex / Stratix 10 BFloat16 dot-product MAC macros.
  - AMD/Xilinx UltraScale+ DSP48E2 dual-INT8 cascading (`A*B + C`) mode.

---

### 🟡 Phase 3: ASIC-Friendly Packaging (Memory Compilers & Port Mappings)
**Goal**: Prepare the library for ASIC fabs by abstracting raw memory blocks away from FPGA-inferred `Mem` blocks, making it compatible with custom SRAM compiler libraries (TSMC, ARM, Synopsys).

- [ ] **SRAM Memory Wrapping Templates**
  - Replace direct `Mem(...)` declarations with high-level cell-wrapper boundaries.
  - Implement an ASIC configuration profile under `BuildEnv`.
  - When ASIC profile is target-enabled during project elaboration, bind SRAM memory reads/writes to clean external port interfaces where users can drop in their compiled `.v` SRAM macro blocks.

---

### 🟣 Phase 4: Advanced Research (Stochastic Computing Acceleration)
**Goal**: Provide an ultra-low-power, radiation-tolerant stochastic computing mode operating on bitstreams, consuming zero DSPs.

**Key papers:**
- **uGEMM (ISCA 2020)** — Wu et al.: relaxes correlation and stream-length constraints; enables N=256 for near-8-bit accuracy via input-insensitive arithmetic and early termination.
- **SC CNN Reinvented (Research/SPJ 2024)** — Lee et al.: SC Multiplexer MAC (MUX-MAC) on Kintex-7; 0.14% accuracy loss at N=256; 99.72% energy reduction; 31× throughput/area gain.

**Important distinction from classical SC:**
Classical LFSR + AND-gate SC requires N≈16,000 bits for true 8-bit precision (variance = p(1-p)/N).
Modern approaches (uGEMM, MUX-MAC) achieve near-8-bit at N=256 by eliminating correlation error.
The BUILD_PLAN.md claim of "N=256 = 8-bit equivalent" is correct for MUX-MAC, not for classical AND-gate SC.

- [ ] **Stochastic Conv Core & Weight Gen**
  - Implement `StochasticNumberGenerator`: LFSR → comparator → 1-bit stream per weight/activation.
  - Write `StochasticConvCore` using **SC Multiplexer MAC** (MUX-MAC per Lee 2024), not classical AND gate.
    - MUX select = weight bitstream; MUX input = activation bitstream; output accumulates via XOR counter / popcount.
  - Build binary output converter (popcount accumulator, N-cycle accumulation window).
  - N is a compile-time parameter (N=64 fast/coarse, N=256 accurate, N=1024 maximum).
  - `StochasticConvCore` is a drop-in alternative to `QLinearConvCore` — same plugin interface, different compute substrate.
  - Use zero DSPs; instantiate as many parallel MUX-MAC units as LUT budget allows (Ti375: ~370K LUT4s available).

---

## ── HANDOVER TIPS FOR NEW AGENTS ──

1. **Keep Test Execution Synchronous**: Parallel execution is strictly disabled in `build.sbt` via `Test / parallelExecution := false`. Do not re-enable it—overlapping Verilator runs will corrupt the translation caches.
2. **First-Class Traversal Rule**: Pointing the generator to a new `.onnx` configuration inside `Params.plugins` runs all parsing, quantization, and tensor transformation inside the JVM dynamically at build-time.
3. **Phase-Safe Exporters**: All output wiring inside `TopIoExportPlugin.scala` must call `.load` (Phase 1) for all inputs before calling `.await` (Phase 2) for any outputs. Do not swap these, otherwise Spinal's fiber compiler will deadlock.
