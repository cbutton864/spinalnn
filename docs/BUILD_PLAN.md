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
- [ ] Long-term: parameterise `Activation(bits)` and thread through `QuantParams` when a second precision (INT4, BFloat16, stochastic) is actually needed -- interface change, defer until then

### Stage 5: Model Integration
*ONNX parser automates topology and weight generation from any quantized model.*

- [x] ONNX parser -- implemented in-JVM as `compiler/OnnxCompiler.scala` (ScalaPB), compiled live during elaboration via `Params.onnx`. Reads INT8 ONNX, applies symmetric PTQ, transposes weights, and emits the concrete plugin graph. (Supersedes the originally-planned standalone `tools/onnx_to_params.py`.)
- [x] General frontend/backend seam -- `OnnxCompiler` now delegates to `OnnxFrontend` (graph walk -> `LayerSpec` IR, with shape inference + quant resolution) and `IrBackend` (IR -> plugins via an op-dispatch registry + symbol table). Adding an operator = one `LayerSpec` case + one backend case. See [ARCHITECTURE_DIRECTION.md](ARCHITECTURE_DIRECTION.md).
- [x] Faithful shapes -- convolutions honor `auto_pad`/`pads` (conv padding added to `QLinearConvCore` via a zero-initialised input buffer) and pooling honors real `kernel_shape`/`strides` (general window in `MaxPoolCore`). MNIST now compiles to the true SAME-conv / 3x3-pool topology; top-1 rose from 80% to 100% (5/5). (Padded pooling and conv dilations != 1 remain TODO.)
- [ ] SqueezeNet INT8 elaborates cleanly from generated Params
- [ ] Add GlobalAvgPool, Concat stub operators to support SqueezeNet topology

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
