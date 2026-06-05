# SpinalNN Future R&D and Verification Roadmap

This roadmap acts as a stable handover and tracking checklist for future development agents and collaborators. It maintains the exact technical context, design patterns, and priorities for the next developmental phases of SpinalNN.

---

## ── CURRENT STATUS & COMPLETED MILESTONES ──

- [x] **Flat-Plugin Architecture Implementation**: Solidified separate stateless `Core` computations and structural `FiberPlugin` negotiation layers.
- [x] **Stage 4 Memory Optimization**: Completed 100% single-port BRAM-friendly `readSync` sequential memory mapping for spatial and dense layers (`QLinearConvCore` and `QLinearLinearCore`). Removed legacy raw asynchronous LUT memory inflation.
- [x] **Integration Testing Harness (`it:test`)**: Implemented `GoldenIntegrationTest` (detects RTL-source drift) and `TopLevelSimIntegrationTest` (streams a 6x6x1 feed simulation with cycle-latency measurement).
- [x] **Native Scala-ONNX Compiler**: Embedded `sbt-protoc` and `ScalaPB` directly into SBT. Parsed the model on-the-fly inside Scala during elaboration.
- [x] **On-The-Fly Post-Training Quantization (PTQ)**: Implemented symmetric INT8 quantizers, real scale factor resolution, bias scaling, and multidimensional matrix transpositions in `OnnxCompiler.compileModel`.

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

### 🔵 Phase 0 (ACTIVE): General ONNX Frontend
**Goal**: Replace the hand-written MNIST translation in `OnnxCompiler` with a real
graph walk → small Scala IR (`Seq[LayerSpec]`) → op-registry backend, keeping the MNIST
output bit-identical so the validation suite stays green. See ARCHITECTURE_DIRECTION.md §9.

- [x] **Backend seam** — `LayerSpec` IR + `IrBackend` op-dispatch registry + symbol-table wiring.
- [x] **Frontend** — `OnnxFrontend` walks the graph generically (op sequence, weights, biases, shapes); float-model activation scales supplied via an explicit `Calibration` (pre-quantized models read scales off nodes).
- [x] **Faithful shapes** — convolutions honor `auto_pad`/`pads` (conv padding added to `QLinearConvCore` via a zero-initialised buffer) and pooling honors real `kernel_shape`/`strides` (general window added to `MaxPoolCore`). MNIST now compiles to the true SAME-conv / 3×3-pool topology, lifting top-1 from **80% → 100% (5/5)** — proving the old miss was the VALID approximation, not quantization noise. (Padded pooling and conv dilations ≠ 1 are still TODO.)

### 🟢 Phase 2 (R&D): Hardware DSP Customization (Altera BFloat16 & AMD DSP48)
**Goal**: Provide alternative math plugins so that physical FPGA synthesis tools can map math operations natively to hard silicon blocks instead of soft logic.

- [ ] **Math Abstraction Layer (`MathPlugin`)**
  - Introduce a selectable trait `MathEngine` defining raw multiplication interfaces.
  - Implement **Intel/Altera Agilex / Stratix 10 BFloat16 mode**: Instantiate Intel native dot-product MAC macros.
  - Implement **AMD/Xilinx UltraScale+ DSP48E2 dual-INT8 mode**: Utilize cascading instructions (`A*B + C`) inside a single physical DSP slice in parallel.

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
