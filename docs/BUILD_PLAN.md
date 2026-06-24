# spinalnn Build Plan

SpinalHDL plugin-based INT8 inference accelerator.
One operator per Core + Plugin. Composed in Params. Generated from ONNX.

---

## Development Checklist

### Stage 1: Infrastructure
*Project compiles. Types, traits, and wiring conventions established.*

- [x] Project scaffold (build.sbt, types, traits, BuildHelper)
- [x] InputPlugin, NetworkOutputPlugin, TopIoExportPlugin
- [x] ElaborationTest smoke test passes

### Stage 2: Spatial Processing
*CNN spatial operators working and tested in isolation.*

- [x] MaxPoolCore + MaxPoolPlugin + tests
- [x] QLinearConvCore + QLinearConvPlugin + tests
- [x] Two-layer integration (Conv -> Pool in Params, Verilog generation)

### Stage 3: Classifier Stack
*Full inference pipeline complete. MNIST runs end to end in simulation.*

- [x] ReLUCore + ReLUPlugin + tests
- [x] FlattenPlugin (shape accounting, no RTL) + ElaborationTest
- [x] QLinearLinearCore + QLinearLinearPlugin + tests
- [x] SoftmaxCore (argmax) + SoftmaxPlugin + tests
- [x] Update Params and ElaborationTest for full MNIST topology

### Stage 4: FPGA Optimization
*Production-grade BRAM inference and parameterized parallelism. Ready for real hardware.*

- [x] readSync migration -- Conv, Linear, and Pool BRAMs infer as Block RAM not LUT RAM
- [x] macParallelism -- Conv Config parameter, N parallel MACs (N-banked input/weight buffers), pipelined BRAM reads (functional coverage in `QLinearConvParallelTest`)
- [x] Verify synthesis report shows BRAM primitives -- Efinity P&R maps RAM5K + 18x18 hard multipliers (see [BENCHMARKS_TOPAZ.md](BENCHMARKS_TOPAZ.md)). Note: shipped MNIST/ONNX profiles run macParallelism = 1; DSP scaling at N>1 is verified in sim but not yet pushed through P&R.

### Stage 4.5: Precision Standardisation
*All bit-width constants derive from one place. Future precision changes are one-line edits.*

- [x] Add `ActivationDType` config object to `TensorTypes.scala` (bits, minVal, maxVal, adjBits)
- [x] Eliminate hardcoded `8 bits`, `-128`, `127`, `9 bits` across all Cores
- [x] **W4A8 (INT4 weights, INT8 activations)** — `weightPrecision: WeightInt4` flag in `CompilerOptions`; symmetric PTQ (`scale = max|w|/7`, ZP=0) applied in `OnnxFrontend.lower()`; weights packed 2-per-nibble in `QLinearConvLineCore` weight ROM (32-bit word for N=8 vs 64-bit for INT8); LUT shift-and-add multiply replaces DSP inference (Stage 1.5 computes N per-lane Mux+shift products → 32-bit `lutProdRegs`; Stage 2 treeReduce; Stage 3 accumulate — T+3 total vs T+2 for INT8). IrBackend forces `QLinearConvLineCore` (line-buffer path) whenever `weightBits==4`, regardless of BRAM budget. MNIST-8 accuracy: 5/5 (100%) in simulation with W4A8 weights. P&R (Ti180M484, 150 MHz target): vs INT8 N=8 baseline → **−9 DSP48** (22→13), **+1,112 LUT4** (916→2,028), +10 RAM10K (line-buffer row bufs outweigh halved weight ROM on this small model); Fmax unchanged at ≈254 MHz. W4A8 is a DSP↔LUT trade: most valuable when DSPs are the bottleneck on larger models. RTL and P&R projects in `rtl/mnist_w4a8/` and `benchmark_mnist_w4a8_*/`. See BENCHMARKS_TITANIUM.md §W4A8.
  - `lowerQuantized()` W4A8 path: **DONE** — `requantizeInt8ToInt4()` in `OnnxCompiler`; dequant+INT4 requant of embedded INT8 weight bytes; validated via SqueezeNet W4A8 bench.
  - **W4A8 + WeightStream: DONE (2026-06-20)** — Nibble packing in IrBackend (2 weights/byte in DMA descriptor); `effectiveWeightMode` allows W4A8 WeightStream when 128%N==0; `QLinearConvLineCore` drain logic uses N×4-bit steps (vs N×8 for INT8), `stepsPerBeat=512/(N×weightBits)`; 2 new sim tests pass (VALID + SAME+consecutive inferences). Full suite: 129/129. P&R benchmark pending (SqueezeNet W4A8 N=32 WeightStream on Ti180 — see FUTURE_ROADMAP.md §Phase A).
- [ ] Long-term: parameterise `Activation(bits)` and thread through `QuantParams` when a second precision (INT4, BFloat16, stochastic) is actually needed -- interface change, defer until then
- [x] **StochasticConvCore** *(Phase B research — sim complete 2026-06-21)*  
  MUX-MAC SC architecture per Lee et al. 2024; `bitstreamLen=255` default; zero DSP cost; pure LUT fabric.
  `WeightStochastic(bitstreamLen)` added to `WeightPrecision` in `CompilerOptions`; `StochasticConvPlugin`
  wires into `IrBackend` Conv dispatch. Sim accuracy: max error ±4 INT8 units at N=255, nMac=4
  (132/132 tests pass). P&R benchmark (B6) and end-to-end MNIST accuracy (B7) pending — see FUTURE_ROADMAP.md §Phase B.

### Stage 5: Model Integration
*ONNX parser automates topology and weight generation from any quantized model.*

- [x] ONNX parser -- implemented in-JVM as `compiler/OnnxCompiler.scala` (ScalaPB), compiled live during elaboration via `Params.onnx`. Reads INT8 ONNX, applies symmetric PTQ, transposes weights, and emits the concrete plugin graph. (Supersedes the originally-planned standalone `tools/onnx_to_params.py`.)
- [x] General frontend/backend seam -- `OnnxCompiler` now delegates to `OnnxFrontend` (graph walk -> `LayerSpec` IR, with shape inference + quant resolution) and `IrBackend` (IR -> plugins via an op-dispatch registry + symbol table). Adding an operator = one `LayerSpec` case + one backend case. See [ARCHITECTURE_DIRECTION.md](ARCHITECTURE_DIRECTION.md).
- [x] Faithful shapes -- convolutions honor `auto_pad`/`pads` (conv padding added to `QLinearConvCore` via a zero-initialised input buffer) and pooling honors real `kernel_shape`/`strides` (general window in `MaxPoolCore`). MNIST now compiles to the true SAME-conv / 3x3-pop topology; top-1 rose from 80% to 100% (5/5). (Padded pooling and conv dilations != 1 remain TODO.)
- [x] DAG operators -- `ConcatCore`/`ConcatPlugin` (fan-in, 4/4 tests), `StreamForkCore`/`StreamForkPlugin` (fan-out, 4/4 tests), `GlobalAveragePoolCore`/`GlobalAveragePoolPlugin` (5/5 tests). Fan-in + fan-out fully proven; fire-module topology expressible.
- [x] Per-channel requant -- `QLinearConvCore` accepts `weightScales: Option[Array[Float]]`; per-output-channel requant ROMs + variable barrel shifter; per-tensor fallback byte-identical to before (3/3 tests). `lowerQuantized` in `OnnxFrontend` reads per-channel weight scales from QOperator nodes.
- [x] QOperator frontend (`lowerQuantized`) -- reads scales/zero-points directly off QLinearConv nodes; Q/DQ alias folding; per-Concat output-quant override; SqueezeNet structural IR tests pass (4/4).
- [ ] **NEXT: Asymmetric-input bias correction** -- add `−z_x · Σw[oc]` fold into biases inside `lowerQuantized` (elaboration-time, no RTL change). Unblocks SqueezeNet end-to-end Verilog generation.
- [ ] SqueezeNet INT8 elaborates cleanly -- Verilog generation test (no sim; 224x224x3 is billions of cycles)

### Stage 5.5: Operator Expansion + Tier-2 Models
*DepthwiseConv and Add unlock the next two model tiers. Hardware target: Efinix Titanium.*

- [ ] `DepthwiseConvCore` + `DepthwiseConvPlugin` -- grouped conv with groups = C_in. Weight shape `[C, 1, kH, kW]`. Reuses QLinearConvCore FSM structure; no cross-channel accumulation. Unlocks DS-CNN-S and MobileNetV1.
- [ ] DS-CNN-S (KWS) end-to-end -- export INT8 ONNX from ARM ML-examples TFLite; compile + simulate; report latency on Ti90 class hardware. First non-vision, BRAM-only benchmark.
- [ ] QARepVGG-A0 INT8 -- export from QARepVGG paper PyTorch code; no new operators needed (pure 3x3 conv chain). Compile + P&R on Ti180; report ImageNet accuracy vs latency vs resource cost.
- [ ] `Add` (elementwise, two upstream Handles) -- second fan-in op, reuses `Seq[Handle]` pattern from ConcatPlugin. Unlocks MobileNetV2 and residual skip connections.
- [ ] MobileNetV2 INT8 -- `qualcomm/MobileNet-v2-Quantized` (HuggingFace); needs DepthwiseConv + Add + ReLU6. P&R on Ti180 with LPDDR4x weight streaming.

### Stage 6: LPDDR4x Weight Streaming
*Enables any model whose weights exceed on-chip BRAM. Target: Efinix Titanium Ti90+.*

- [ ] Weight-DMA controller -- AXI4 master; sequential burst reads from embedded LPDDR4x into double-buffered on-chip staging BRAM. Layer-boundary trigger from FSM.
- [ ] Weight-loading mode in `QLinearConvCore` -- accept weights from BRAM staging buffer instead of ROM init. Controlled by `BuildEnv` flag.
- [ ] SqueezeNet on Ti180 with LPDDR4x -- end-to-end compile + P&R with weight streaming. Benchmark vs Coral/Hailo/DPU from `BENCHMARKS_TOPAZ.md`.

### Stage 6: Validation
*End-to-end inference verified correct against reference runtime.*

- [x] Run inference on known input through generated hardware -- `OnnxInferenceValidationTest` streams 5 MNIST digits, top-1 argmax matches gold on **5/5 (100%)** after the faithful-shape upgrade (was 4/5 under the old VALID approximation).
- [x] Root cause of the former 1/5 miss identified and fixed -- `OnnxLogitInspectionTest` showed the distortion was upstream feature-map error from the VALID-padding approximation, not clip-range saturation or irreducible rounding. Compiling the true SAME-conv / 3x3-pool topology lifted agreement to 5/5, and the dequantized HW logits now track the ONNX-Runtime gold floats closely.
- [ ] Bit-exact match against an INT8 software reference (deterministic) -- next validation step now that the topology is faithful.

---

## Goal

```
Trained model (ONNX INT8)
        |
  tools/onnx_to_params.py
        |
  Params.scala       layer graph + quantization params + weight arrays
        |
  SpinalHDL plugins  one plugin per ONNX operator node
        |
  Synthesizable Verilog  flat or hierarchical
```

---

## Operator Reference

One Core + one Plugin per operator. No operator bundles multiple concerns.
Operator-to-operator connections use direct Handle constructor injection in Params.
Traits are used only for the two unique boundaries (InferenceInput, NetworkOutput).

### Done

| Operator | Notes |
|---|---|
| `InputPlugin` | Entry point, top-level IO to stream |
| `NetworkOutputPlugin` | Terminal marker, drives output pads |
| `MaxPool` | General poolH x poolW window, arbitrary stride (ONNX floor formula), store-then-compute FSM, readSync (BRAM-inferred) |
| `QLinearConv` | 10-state FSM, N-banked MAC, INT8 zero-point + split requantize, `auto_pad`/`pads` via zero-initialised buffer, readSync (BRAM-inferred) |
| `ReLU` | Pass-through clamp: value < 0 -> 0. Single-cycle, no buffer |
| `Flatten` | Zero RTL. Republishes same stream with shape TensorShape(1, 1, H*W*C) |
| `QLinearLinear` | Same FSM as Conv without spatial indices, readSync (BRAM-inferred) |
| `Softmax` | Argmax (top-1 winning logit index). Full softmax optional later |

### Remaining (extended operators for SqueezeNet)

| Operator | Notes |
|---|---|
| `GlobalAvgPool` | Accumulate all spatial positions per channel, divide, emit C values |
| `Concat` | Merge two upstream streams channel-wise. Requires two upstream Handles |
| `DepthwiseConv` | Per-channel spatial conv. Weight shape: [C, 1, kH, kW] |
| `BatchNorm` | Fuse into preceding Conv weights at export time (standard practice) |

---

## Architecture: readSync + Parallel MAC

These two changes are internal to QLinearConvCore. The Plugin, Params, and streaming
interface are unchanged.

### readSync (BRAM inference)

`readAsync` forces LUT RAM. For weight tables above ~256 bits this wastes fabric.
`readSync` allows the synthesis tool to infer Block RAM (BRAM) properly.

The ITER state gains one address-issue sub-cycle before the MAC cycle:

```
ITER sub-cycle 0:  issue inIdx and wIdx to BRAM ports
ITER sub-cycle 1:  receive inVal and wVal, compute MAC, advance indices
```

Total MAC count is unchanged. One extra cycle of pipeline latency per ITER pass.

### macParallelism (parallel MAC units)

One new field in `QLinearConvCore.Config` with default 1. All existing tests pass unchanged.

```scala
macParallelism: Int = 1   // set to N to use N MAC units per cycle
```

When N > 1:
- Input BRAM port: N * 8 bits wide (reads N activations per cycle)
- Weight BRAM port: N * 8 bits wide (reads N weights per cycle)
- ITER cycles per output: ceil(kH * kW * C_in / N) + 2

Constraint: `macParallelism` must divide `C_in` evenly. The natural boundary is `C_in`.

Resource guidance:

| macParallelism | Throughput | BRAM port | DSP blocks |
|---|---|---|---|
| 1 | baseline | 8 bits | 1 |
| 8 | 8x | 64 bits | 4 |
| 16 | 16x | 128 bits | 8 |
| 32 | 32x | 256 bits | 16 |

Zynq-7020 has 220 DSP blocks. A reasonable starting point is macParallelism = 16
(8 DSPs, 16x throughput, fits easily alongside other fabric logic).

---

## Future Arithmetic Backends

The `Activation` bundle uses a named `value` field so the internal representation
can change without touching the streaming interface or any Plugin code.
New backends are new Core variants only.

| Backend | Representation | Multiply cost |
|---|---|---|
| INT8 (current) | `SInt(8 bits)` | 1 cycle |
| INT4 | `SInt(4 bits)` packed | 1 cycle |
| BFloat16 | `Bits(16 bits)` | 1-2 cycles |
| Stochastic | `Bits(N bits)` bitstream | N cycles |

Stochastic: multiplication is a single AND gate. Precision scales with bitstream
length N. N=256 gives 8-bit equivalent accuracy at 256 cycles per computation.
N is a Params-level knob -- trade latency for accuracy.

Do not hardcode one-element-per-cycle throughput assumptions in operator designs.

---

## Key Types

```scala
case class Activation() extends Bundle { val value = SInt(8 bits) }
case class TensorShape(rows: Int, cols: Int, channels: Int)
case class QuantParams(scale: Float, zeroPoint: Int)
case class RequantScale(multiplier: Long, shift: Int)
// Hardware: output = clamp((acc * multiplier) >> shift + zp_out, -128, 127)
```

---

## Streaming Convention

HWC order -- height outermost, channel innermost:
```
(row0, col0, ch0), (row0, col0, ch1), ..., (row0, col1, ch0), ...
```

Producer sends `rows * cols * channels` elements with valid/ready backpressure.
Cores handle stall in the EMIT state by holding valid until downstream asserts ready.
