# spinalnn Architecture Direction

Forward-looking design direction for growing spinalnn from a single hand-written
MNIST translation into a general compiler for pre-quantized models across the full
FPGA size range. Read this before proposing structural changes to the compiler,
the operator library, or the dataflow.

This is a direction document, not a spec. It states the principles and the order
of work. Each phase is independently useful and keeps the existing tests green.

---

## 1. Scope (read this first)

- **Primary hardware target: Efinix Titanium (FNX).** Ti90 through Ti375 are the
  reference parts — 16 nm, embedded LPDDR4x on-package (1 × 32-bit channel, up to
  2 Gb / 3,000 Mbps), 336–1,344 DSP blocks, 860 KB–3.4 MB on-chip BRAM, AXI4
  interface to the LPDDR controller. Trion T20 / Topaz Tz50 remain valid bring-up
  and benchmark reference points. Larger parts (Xilinx UltraScale+, Intel Agilex)
  are long-term stretch targets, not the current focus.
- **Embedded LPDDR4x changes the memory story.** On-package latency (~10–20 ns vs
  40–80 ns off-chip) and a wide internal bus mean weight-streaming overhead is
  negligible when double-buffered. This unlocks models whose weights exceed on-chip
  BRAM without board-level DDR routing complexity. All Titanium parts from Ti90 up
  carry this interface; no external DDR chip is required.
- **Primary input is pre-quantized ONNX (QOperator).** A QLinearConv node carries
  `x_scale`, `x_zero_point`, `w_scale`, `w_zero_point`, `y_scale`, `y_zero_point`
  inline. Read them directly — no calibration, no guessing. This is the clean path
  and the main intent.
- **Float ONNX + manual calibration is the secondary path.** The current
  quantize-on-the-fly logic in `OnnxCompiler` stays as a convenience for float models;
  it is not the primary route.
- **Goal:** compile a curated set of publicly available pre-quantized models — from
  tiny BRAM-only 1D models (KWS, biometrics) up to LPDDR4x-enabled vision backbones
  (SqueezeNet, MobileNetV2, QARepVGG). Benchmark each against the competitor landscape
  in §model-targets. "Reasonable" is bounded by the fit knobs in §6 and the operator
  set in §8, not by any one chip or domain.

---

## 2. The design pattern is already the right foundation

The Core / Plugin / Trait pattern **is** an operator plugin system. Each ONNX op maps
to exactly one operator (a stateless `Core`, a `FiberPlugin`, and a stage-boundary
trait). The library grows by *adding operators*, never by rewriting.

The key reframing: **the compiler's job is to generate the exact wiring you already
write by hand in `Params`.** Your hand-written topology is the compilation *target*.
Today `OnnxCompiler.compileModel` hard-codes that wiring for MNIST; the direction is
to *generate* it from the graph. The pattern does not change — it becomes the thing
the compiler emits.

Because elaboration is just Scala running at build time, the whole frontend (graph
walk, shape inference, quant resolution, op dispatch) is plain Scala metaprogramming.
It resolves entirely before any hardware exists and leaves zero runtime cost in the
generated RTL. That is the SpinalHDL strength to lean on — not a new framework.

---

## 3. Three independent gaps (name them so we stop conflating them)

| Gap | What it is | Status |
|---|---|---|
| **A — Frontend** | `OnnxCompiler` is a hard-coded MNIST translator: no graph walk, no op dispatch, no shape inference, guessed activation scales. | The real blocker to "more models". |
| **B — Operator coverage** | The op set is small (Conv, Pool, ReLU, Flatten, Linear, Softmax). Each model family needs a few new ops. | Additive, low-risk, pattern-friendly. |
| **C — Dataflow schedule** | Fixed store-then-compute (whole frame to BRAM, then compute). | The scaling ceiling for large inputs. |

These are orthogonal. Solve them in order. Each one is useful on its own.

---

## 4. The seam: a tiny IR + an op registry

This is the answer to "should we go more granular?" — **yes, but the granularity goes
in the compiler, not in the hardware.**

```
ONNX file
   │  parse (ScalaPB, already in place)
   ▼
graph walk (topological — ONNX nodes are already topo-ordered)
   │  shape inference (HWC) + quant resolution per node
   ▼
small Scala IR:  Seq[LayerSpec]      // one case class per op, fully resolved
   │  backend dispatch
   ▼
op registry:  Map[opType, LayerSpec => FiberPlugin]
   │  symbol table:  Map[tensorName, producing plugin's Handle]
   ▼
the same plugin wiring you write by hand in Params today
```

- **`LayerSpec`** is plain Scala case classes — `LayerSpec.Conv`, `LayerSpec.Pool`,
  `LayerSpec.Concat`, … — each carrying its resolved `TensorShape`, `QuantParams` /
  `RequantScale`, and (for weight layers) the quantized weight/bias arrays. It is a
  thin, testable description of the network. It is *not* a new hardware abstraction.
- **The op registry** is the single extension point. Supporting a new model family =
  add the op(s) to the registry. Nothing else in the compiler changes.
- **The symbol table** maps each ONNX tensor name to the plugin that produces it, so a
  node wires to its named inputs. This is exactly the `host[...]` / constructor-arg
  wiring from the existing pattern, generated instead of typed.
- **Pre-quantized path** reads scales straight off the nodes. **Float path** keeps the
  current `quantizeSymmetric` + manual clip ranges as a clearly secondary fallback.

**Do not fragment the Cores into micro-ops.** One `Core` = one ONNX op is the right
grain. The IR adds granularity to the *description*, which is where it belongs.

---

## 5. The one structural upgrade the chain needs: multi-input wiring

Today every operator plugin takes exactly **one** upstream `Handle` as a constructor
argument, so only strictly linear chains are expressible. Real graphs are DAGs —
they have fan-in (Concat, residual `Add`, multi-head outputs, skip connections).

The fix is a small, natural extension of the existing pattern: let a plugin accept
`Seq[Handle[Stream[Activation]]]` instead of a single handle. A `ConcatPlugin` takes
two upstream handles; an `AddPlugin` takes two and sums element-wise. This is the
single most important structural change, and it is modest — it reuses the
constructor-arg convention rather than replacing it.

This unlocks SqueezeNet (Concat), ResNet (residual Add), and YOLO (multi-head).

**Status (Phase 1, in progress).** Both fan-in and fan-out are proven at the
Core/Plugin level:
- **Fan-in** — `ConcatCore` (a stateless streaming channel-wise mux over
  `Seq[Stream[Activation]]`, HWC order, full throughput, no buffering) plus
  `ConcatPlugin` (the first plugin to take `Seq[Handle[Stream[Activation]]]`),
  unit-tested 4/4.
- **Fan-out** — `StreamForkCore` (replicate one stream to N branches; default async
  variant holds each element via per-output `linkEnable` tokens until every branch
  consumes it, so branches may run at different rates) plus `StreamForkPlugin` (the
  first plugin to *publish* `Seq[Handle[Stream[Activation]]]`), unit-tested 4/4
  including random independent back-pressure and the lock-step synchronous variant.

Both use `StreamDriver`/`StreamMonitor` — the idiomatic tools for same-cycle
streaming pass-throughs. With fan-in + fan-out in hand, a SqueezeNet fire module is
fully expressible (squeeze → fork → two expand convs → concat). What remains to run
`squeezenet1.0-12-int8` end-to-end is leaf operators and frontend wiring, not
structure: `GlobalAveragePool`, the QOperator pre-quant scale-read path, and
`LayerSpec.Concat` + the multi-input `IrBackend` case.

---

## 6. Fit knobs: one model, many FPGAs

The "not pigeonholed" story is a small set of orthogonal knobs. The *same* compiled
network targets a tiny chip or a large one by turning these, without re-authoring it.

| Knob | Axis | Effect | State |
|---|---|---|---|
| `macParallelism` | spatial | N parallel MACs per Conv (N DSPs) | implemented; shipped configs use N=1 |
| dataflow schedule | temporal | store-then-compute vs line-buffer streaming (§7) | store-then-compute only today |
| folding (PE / SIMD) | spatial × temporal | trade DSPs for cycles, FINN-style | future |
| `BuildEnv` hierarchy | packaging | flat vs hierarchical Verilog | implemented |

Small fit: `macParallelism = 1`, buffered, flat → MNIST/biometric on a T20.
Large fit: high fold, streaming → a vision backbone on an Agilex. One source, two fits.

---

## 7. Dataflow-schedule axis (store-then-compute vs streaming)

These are two *schedules* for the same math. They are orthogonal to the spatial
parallelism in §6 — you can be parallel on either schedule.

**Store-then-compute (today).** Receive the whole feature map into BRAM, then iterate
output positions. Grain of truth: BRAM gives single-cycle random access, which feeds a
wide MAC array cleanly per layer. Genuinely good for:
- FC / GlobalAveragePool / Softmax and other reductions (need the whole vector anyway),
- single-shot latency and prototyping / resource-probing (the MNIST-on-T20 use case),
- the DRAM-tiling endgame for very large models.
Ceiling: buffers are `O(H·W·C)` (a 416×416 input is ~520 KB — far past a T20's on-chip
RAM), and the RECEIVE and COMPUTE phases do not overlap.

**Line-buffer streaming.** Keep only `O(k·W·C)` line buffers and compute as data flows.
Captures more FPGA strength: cross-layer pipelining keeps every stage near 100% duty,
and storage drops by a factor of `H/k`. This is the *same* sliding-window primitive as
the `fusion-pipeline` and `efinix_t20_mipi` camera/thermal cores in this multi-root
workspace — a streaming NN shares that substrate.

**Direction:** make the schedule a **per-stage** configuration, the same way `BuildEnv`
toggles flat vs hierarchical. Default: stream conv/pool, buffer FC/reductions.

---

## 8. Model targets and operator roadmap (priority order)

Models are ordered by operator complexity and hardware requirements, not by size alone.
Every model listed has a publicly available INT8 ONNX file or a clear export path from
public code. Operator gaps are additive — each tier reuses all operators from the tier
above it.

### Tier 1 — Existing operators, BRAM-only (Ti90+, no DDR streaming needed)

| Model | Source | Params (INT8) | Task | Accuracy | Operators needed |
|---|---|---|---|---|---|
| **SqueezeNet 1.0 int8** | `onnxmodelzoo/squeezenet1.0-12-int8` (HuggingFace) — *already in `models/`* | ~1.2 MB | ImageNet top-1 | 57.5% | QLinearConv, MaxPool, Concat, GlobalAvgPool, Softmax — **all implemented** |
| **QARepVGG-A0 int8** | Export from [QARepVGG paper code](https://arxiv.org/abs/2212.01593) (PyTorch → ONNX) | ~8 MB | ImageNet top-1 | 70.4% INT8 (vs 72.2% FP32, < 2% drop) | Conv (3×3 only), ReLU, GlobalAvgPool, Linear — **all implemented** |

SqueezeNet is already on disk and needs only the asymmetric-input bias correction to
elaborate correctly (§12). QARepVGG-A0 after reparameterization is a pure 3×3 conv
chain with ReLU — zero new operators, high accuracy, excellent quantization behavior
(quantization-aware training was the design goal). These are the two immediate targets.

### Tier 2 — DepthwiseConv operator, BRAM-only or LPDDR4x (Ti90+)

| Model | Source | Params (INT8) | Task | Accuracy | New operators |
|---|---|---|---|---|---|
| **DS-CNN-S** (KWS) | ARM ML-examples GitHub (TFLite → ONNX export) | ~24 KB | Google Speech Commands 12-class | 92.2% | `DepthwiseConv` (grouped conv, groups = C_in) |
| **MobileNetV1 int8** | `onnxmodelzoo/mobilenetv2-7` INT8 variant via Intel Neural Compressor | ~4 MB | ImageNet top-1 | ~70.9% | `DepthwiseConv` |

DS-CNN-S is the smallest useful real model — 24 KB fits in any Titanium part's BRAM
with room to spare, making it the first fully BRAM-only, no-DDR benchmark. It also
breaks the vision-only framing immediately.

### Tier 3 — Add (residual), LPDDR4x weight streaming (Ti90+)

| Model | Source | Params (INT8) | Task | Accuracy | New operators |
|---|---|---|---|---|---|
| **MobileNetV2 int8** | `qualcomm/MobileNet-v2-Quantized` (HuggingFace) | ~3.4 MB | ImageNet top-1 | 71.8% | `DepthwiseConv` + `Add` (elementwise residual) + `ReLU6` |
| **ResNet-18 int8** | ONNX model zoo / Intel NC | ~11 MB | ImageNet top-1 | 69.7% | `Add` (residual skip connections) |

`Add` is the second fan-in op after `Concat` — it reuses the `Seq[Handle]` multi-input
wiring already proven in `ConcatPlugin`.

### Tier 4 — Streaming dataflow + LPDDR4x weight streaming (Ti180+, north star)

| Model | Source | Params (INT8) | Task | Notes |
|---|---|---|---|---|
| **EfficientNet-Lite4 int8** | `onnxmodelzoo/efficientnet-lite4-11-int8` (HuggingFace) | ~13 MB | ImageNet top-1 80.4% | Needs DepthwiseConv + `Squeeze-Excite` (Mul + Sigmoid) |
| **YOLO-NAS nano int8** | Deci AI / SuperGradients (PyTorch → ONNX) | ~20 MB | COCO object detection | Needs `Resize`/`Upsample`; NMS stays off-chip on host |

### Operator gap summary

| Operator | Unlocks | Status |
|---|---|---|
| `DepthwiseConv` (grouped conv, groups = C_in) | DS-CNN-S, MobileNetV1/V2 | **Next to implement** |
| `Add` (elementwise, two upstream Handles) | MobileNetV2, ResNet, RepVGG training graphs | After DepthwiseConv |
| `ReLU6` (clamp at 6) | MobileNetV2 | Trivial ReLU variant |
| `Sigmoid` / `HardSigmoid` | EfficientNet SE blocks | LUT activation |
| `Resize` / `Upsample` (nearest) | YOLO necks | Phase 4 |

Biometrics and other 1D signal models are called out first deliberately: they are the
most useful *and* the easiest, and they break the "vision-only / MNIST-only" framing
immediately.

---

## 9. Phased roadmap (incremental — every phase ships something)

- **Phase 0 — Frontend refactor.** ✅ **DONE.** `OnnxFrontend` + `LayerSpec` IR +
  `IrBackend` op-registry. MNIST output bit-identical; validation suite green.

- **Phase 1 — DAG operators + quant generality.**
  *Structural work done:* `ConcatCore`/`ConcatPlugin` (4/4), `StreamForkCore`/
  `StreamForkPlugin` (4/4), `GlobalAveragePoolCore`/`GlobalAveragePoolPlugin` (5/5),
  per-channel requant in `QLinearConvCore` (3/3), `lowerQuantized` frontend for
  QOperator graphs (SqueezeNet structural tests 4/4).
  *Remaining:* asymmetric-input bias correction (`−z_x·Σw` folded into biases at
  elaboration time) → then SqueezeNet elaborates end-to-end, Verilog generation test.

- **Phase 1.5 — First Tier-1 hardware benchmarks (Titanium target).**
  Synthesize and P&R SqueezeNet on Tz50 (timing/area reference) and Ti180 (embedded
  LPDDR4x target). Export QARepVGG-A0 INT8 from paper code; compile and P&R.
  These produce the first real benchmark numbers for models beyond MNIST.

- **Phase 2 — DepthwiseConv + Tier-2 models.**
  Add `DepthwiseConv` Core/Plugin (grouped conv, groups = C_in). Compile DS-CNN-S
  (KWS) from ARM ML-examples TFLite export; run end-to-end in simulation. First fully
  BRAM-only non-vision benchmark, fits any Titanium part.

- **Phase 2.5 — LPDDR4x weight streaming.**
  Add weight-DMA controller: AXI4 master, sequential burst reads from embedded LPDDR4x
  into on-chip staging BRAM (double-buffered). Enables any model whose weights exceed
  on-chip BRAM. Target Titanium Ti90+ (embedded LPDDR4x on-package, no external DDR).

- **Phase 3 — Add (residual) + streaming dataflow.**
  Elementwise `Add` plugin (second fan-in op, reuses `Seq[Handle]` wiring). Then
  per-stage line-buffer schedule for conv/pool — drops activation BRAM from `O(H·W·C)`
  to `O(k·W·C)`. Unlocks MobileNetV2, ResNet, 224×224 inputs without activation LPDDR.

- **Phase 4 — Folding + detector-class models.**
  FINN-style PE/SIMD folding; `Resize`/`Upsample`; YOLO-NAS nano on Ti180+. NMS off-chip.

---

## 10. What we deliberately do not do

- **No Core fragmentation into micro-ops.** Core = one ONNX op is the grain.
- **No on-chip NMS or control-heavy post-processing.** The host does it.
- **No floating-point in the RTL.** Quantize at elaboration; integer-only datapath.
- **No big-bang rewrite.** Every phase keeps the tests green and the pattern intact.

---

## 11. Phase 0 status + the faithfulness gap (important)

**Done (this iteration):** the frontend/backend seam is in place. `OnnxCompiler.compileModel`
now delegates to `OnnxFrontend.lower` (graph walk → `Seq[LayerSpec]`) and `IrBackend.build`
(IR → plugins via op-dispatch registry + symbol table). MNIST output is bit-identical;
the validation/logit tests stay green. Adding an operator is now: one `LayerSpec` case +
one `IrBackend` case (+ a frontend dispatch case).

**Known faithfulness gap — now CLOSED (conv padding + general pooling).** The MNIST-8
ONNX graph uses `auto_pad=SAME_UPPER` convolutions (spatial size preserved: 28→28→14→14)
and a 3×3 / stride-3 final MaxPool. The compiler *originally* modeled these as **VALID**
convolutions (28→24→12→8) with 2×2 / stride-2 pools — a hand-tuned approximation, not a
faithful translation. That approximation is what produced the long-standing 80% MNIST
result.

Both operators were upgraded so the frontend can now translate the graph faithfully:
- **Conv padding** (`auto_pad` SAME_UPPER/SAME_LOWER/VALID + explicit `pads`) in
  `QLinearConvCore`. Realized by storing the incoming feature map into the interior of a
  zero-initialised buffer (symmetric quant → zeroPoint 0 → padded taps contribute 0), then
  running the existing VALID compute walk over the padded buffer. The MAC pipeline is byte
  -for-byte unchanged — only RECEIVE addressing and buffer sizing changed.
- **General MaxPool** kernel/stride (`QLinearConvCore`'s 2×2-only window replaced by a
  counter-driven `poolH×poolW`/stride window using the ONNX floor output formula). The
  default 2×2/stride-2 schedule reduces to the original cycle-for-cycle behavior.

**Measured result:** with the faithful topology (SAME convs, real 2×2 then 3×3/stride-3
pools), MNIST top-1 went from **80% (4/5) → 100% (5/5)**, and the dequantized HW logits now
track the ONNX-Runtime gold floats almost exactly. This confirms the earlier root-cause
analysis: the miss was the VALID approximation distorting feature maps, **not** irreducible
quantization noise. Pre-quantized graphs that rely on SAME padding can now elaborate
faithfully. (Padded *pooling* and conv `dilations` ≠ 1 remain unsupported — add when a
model needs them.)

---

## 12. Quantization-generality axis (the real lever for cutting-edge models)

Structurally we are in good shape: `Concat` (fan-in), `StreamFork` (fan-out), and
`GlobalAveragePool` give us the vocabulary for DAGs. The next frontier is **not** a pile
of exotic operators — it is **quantization fidelity**. Today every Core bakes in three
assumptions: *symmetric* INT8, *zero-point = 0*, and *one scale per layer (per-tensor)*.
Modern quantized models break all three.

**Measured ground truth — `squeezenet1.0-12-int8.onnx` (the only real pre-quantized model
on disk).** Inspecting the graph (26 `QLinearConv`, 8 `Concat`, 3 `MaxPool`, 1
`QLinearGlobalAveragePool`, 1 `Softmax`; Q/DQ pairs appear *only* around the Concats,
because the two expand branches carry different scales) shows it needs the full
quant-generality stack at once:

1. **uint8 activations.** Activation tensors are UINT8 `[0,255]` (zero-point 0 post-ReLU),
   but our `Activation` is `SInt(8)` `[-128,127]`. A uint8 200 simply does not fit. Options:
   widen the stream element, or remap uint8→int8 (subtract 128) at the QuantizeLinear
   boundaries and carry the offset in the requant. **Real impedance mismatch, not cosmetic.**
2. **Asymmetric input zero-point.** `data_0_zero_point = 115`. With *symmetric weights*
   (`z_w = 0`) the cross-term collapses: `(x−z_x)(w) = xw − z_x·w`, so the `−z_x·Σw`
   correction folds into the per-output-channel bias at elaboration time. The datapath
   already subtracts zero-point; the **frontend must compute the bias correction.**
3. **Per-channel weight scales.** *All 26* conv weight tensors carry a **per-output-channel**
   scale vector (e.g. conv1 `w_scale` is shape `[64]`). This is the single biggest INT8
   accuracy lever and is now the default in PyTorch FX / TensorRT / ONNX QDQ exports.
   `RequantScale` is currently one `(multiplier, shift)` per layer; this becomes a **vector
   indexed by output channel**, and the Conv/Linear requant FSM reads the per-channel entry.
4. **Q/DQ folding.** SqueezeNet is *QOperator* form, but most modern exports are *QDQ*
   (a float graph sprinkled with QuantizeLinear/DequantizeLinear). We must fold Q/DQ around
   Concat anyway, so a general Q/DQ folder pays off immediately for both forms.

**Implication.** Finishing SqueezeNet end-to-end *is* the cutting-edge-quant work in
miniature — uint8 + asymmetric input + per-channel requant land together. That reframes the
"is SqueezeNet a gentle first model?" question: it is not. Two honest paths:
- **(a) Land quant-generality on SqueezeNet directly** — highest payoff, but couples the
  DAG-wiring proof to three quant changes at once.
- **(b) Decouple:** first prove the DAG wiring (Concat/Fork/GAP in a real `Params` profile)
  on a **symmetric-int8, per-tensor** graph (e.g. a re-exported CIFAR/RepVGG-S or a
  synthetic fire module), then add uint8 + per-channel as an isolated quant milestone.

**Target models, honestly ranked for this axis:**

| Target | Quant reality | Verdict |
|---|---|---|
| **QARepVGG-S** | reparam → linear `3×3 conv → ReLU` chain; quant-aware so per-channel int8 behaves | **Near-ideal first real backbone** once per-channel requant exists. Vanilla RepVGG quantizes badly — use the QA variant. |
| **MobileNet / EfficientNet-lite int8** | depthwise/grouped conv + per-channel + uint8 | High edge ROI; needs a depthwise Core (a *cheaper* conv: no cross-channel accumulate). |
| **ResNet-18 int8** | residual `Add` (two different input scales → requant), per-channel | Establishes skip connections; `Add` is the next fan-in op after Concat. |
| **YOLO-NAS** | quant-friendly by design, but detector: FPN/PAN neck (heavy concat/upsample/multi-scale), `Resize`/`Upsample`, ~12M params, NMS | **Phase-4 north star.** Too big for on-chip ROM (needs weight streaming, §7) and needs `Upsample` we lack; NMS stays off-chip. |

**Sequencing (folds into the §9 roadmap, doesn't replace it):**
1. QOperator scale-read frontend, **designed for zero-point + per-channel from the start**
   (even where a model only exercises a subset).
2. **Per-channel requant** in Conv/Linear (vector `RequantScale`) — the accuracy unlock.
3. uint8 activation handling + asymmetric-input bias correction + Q/DQ folding.
4. **Elementwise `Add`** (residual) → ResNet / RepVGG training graphs.
5. **Depthwise/grouped conv** + nearest **`Upsample`** → MobileNet/EfficientNet-lite and
   detector necks.
6. **Weight streaming (off-chip) + line-buffer dataflow (§7) + tiling** → the gate to
   detector-class models. *This is the memory ceiling, separate from operator coverage:
   small backbones (RepVGG-A0, MobileNet, SqueezeNet) fit with on-chip weights; YOLO-class
   does not.*

The throughline: the structural vocabulary is largely built. The remaining distance to
"cutting-edge" is **quant fidelity first, memory scale second** — not operator sprawl.
