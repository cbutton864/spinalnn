# SpinalNN Future R&D and Verification Roadmap

This roadmap acts as a stable handover and tracking checklist for future development agents and collaborators. It maintains the exact technical context, design patterns, and priorities for the next developmental phases of SpinalNN.

---

## ── NEAR-TERM SPRINT (June 2026) ──

Five concrete steps agreed as the immediate execution path. Do these in order.

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

### 🔵 Phase 1 (LARGELY DONE): SqueezeNet end-to-end + Titanium benchmarks

**Open item — asymmetric-input bias correction:**
`lowerQuantized` must fold `−z_x · Σw[oc]` into each conv's biases at elaboration time.
SqueezeNet input zero-point = 115; zero points are currently hardcoded to 0 in several
`QuantParams(inScale, 0)` callsites. P&R is validated but end-to-end inference accuracy
on ImageNet has not been measured — this may mask a numeric error. ~10-line frontend change.

- [x] Add bias correction loop to `OnnxFrontend.lowerQuantized`; validate with ImageNet sample
  Implemented `zpBiasCorrect`: folds `−zp * Σw[oc]` into int32 biases for QLinearConv, DepthwiseConv, and QGemm.  
  Verified by SqueezeNetCompileTest (new "zero-point bias correction" test computes expected correction  
  from raw ONNX data and asserts LayerSpec biases match). Full ImageNet accuracy requires a live inference run.
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
- [ ] `StreamFifoCC` bridge between domains in `WeightDmaPlugin`
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
**Goal**: Provide an ultra-low-power, radiation-tolerant stochastic computing mode where multiplications are simplified to single **AND gates**.

- [ ] **Stochastic Conv Core & Weight Gen**
  - Implement Linear Feedback Shift Registers (LFSRs) to convert standard 8-bit weights and inputs into pseudo-random bit rates (probabilistic bitstreams).
  - Write `StochasticConvCore` where high-density INT8 multipliers are replaced with parallel logical AND array structures.
  - Build stochastic-to-binary converters (pop-count accumulators) to feed downstream logic correctly.

---

## ── HANDOVER TIPS FOR NEW AGENTS ──

1. **Keep Test Execution Synchronous**: Parallel execution is strictly disabled in `build.sbt` via `Test / parallelExecution := false`. Do not re-enable it—overlapping Verilator runs will corrupt the translation caches.
2. **First-Class Traversal Rule**: Pointing the generator to a new `.onnx` configuration inside `Params.plugins` runs all parsing, quantization, and tensor transformation inside the JVM dynamically at build-time.
3. **Phase-Safe Exporters**: All output wiring inside `TopIoExportPlugin.scala` must call `.load` (Phase 1) for all inputs before calling `.await` (Phase 2) for any outputs. Do not swap these, otherwise Spinal's fiber compiler will deadlock.
