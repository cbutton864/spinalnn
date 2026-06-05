# spinalnn Architecture Direction

Forward-looking design direction for growing spinalnn from a single hand-written
MNIST translation into a general compiler for pre-quantized models across the full
FPGA size range. Read this before proposing structural changes to the compiler,
the operator library, or the dataflow.

This is a direction document, not a spec. It states the principles and the order
of work. Each phase is independently useful and keeps the existing tests green.

---

## 1. Scope (read this first)

- **Not tied to the Efinix T20.** The T20 is a convenient small bring-up target,
  not the design ceiling. spinalnn targets the whole range — from a tiny Trion
  running a 1D biometric model, to a large Agilex / UltraScale+ running a vision
  backbone. Treat any T20-specific number in the docs as one data point, not the goal.
- **Primary input is pre-quantized ONNX (QOperator).** A QLinearConv node carries
  `x_scale`, `x_zero_point`, `w_scale`, `w_zero_point`, `y_scale`, `y_zero_point`
  inline. Read them directly — no calibration, no guessing. This is the clean path
  and the main intent.
- **Float ONNX + manual calibration is the secondary path.** The current
  quantize-on-the-fly logic in `OnnxCompiler` stays as a convenience for float models;
  it is not the primary route.
- **Goal:** compile as many *reasonable* pre-quantized models as practical — vision
  (MNIST → SqueezeNet → YOLO-class) and non-visual (audio keyword spotting, ECG / IMU
  biometrics, anomaly detection). "Reasonable" is bounded by the fit knobs in §6, not
  by any one chip.

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

## 8. Model families → operators needed (priority order)

| Family | New operators needed | Why this order |
|---|---|---|
| **Non-visual 1D** (KWS, ECG, IMU biometrics) | Conv1D (degenerate 2D: `cols=1`), small GRU/TCN cell, `Add` | **Highest near-term ROI.** Tiny, fits every FPGA, real edge use, mostly reuses existing Cores. |
| **SqueezeNet int8** (the only real pre-quantized model on disk) | `Concat`, `GlobalAveragePool`, 1×1 conv (a Conv special case) | Proves DAG wiring (§5) + the frontend (§4) on a non-toy graph. |
| **ResNet-class** | residual `Add`, BN-folded conv, strided conv | Establishes skip connections and deeper graphs. |
| **YOLO-class** | `Sigmoid`/`SiLU` (LUT activation), `Resize`/`Upsample`, multi-output heads | Needs the streaming schedule (§7) to fit; **NMS stays off-chip on the host** — standard practice. |

Biometrics and other 1D signal models are called out first deliberately: they are the
most useful *and* the easiest, and they break the "vision-only / MNIST-only" framing
immediately.

---

## 9. Phased roadmap (incremental — every phase ships something)

- **Phase 0 — Frontend refactor (no hardware change).** Split `OnnxCompiler` into
  frontend (graph walk → `LayerSpec` IR, with shape inference and quant resolution) and
  backend (IR → plugins via the op registry). Add the pre-quantized scale-reading path.
  Output stays bit-identical to today's MNIST so `GoldenIntegrationTest` and the
  validation suite stay green. This de-risks everything after it.
- **Phase 1 — Fan-in + SqueezeNet.** Add `Seq[Handle]` multi-input wiring; add `Concat`
  and `GlobalAveragePool`; run `squeezenet1.0-12-int8` end-to-end.
  *(In progress: fan-in `ConcatCore`/`ConcatPlugin` and fan-out
  `StreamForkCore`/`StreamForkPlugin` done + tested 4/4 each; still need
  `GlobalAveragePool`, the QOperator pre-quant scale-read path, and `LayerSpec.Concat`
  + multi-input backend wiring.)*
- **Phase 2 — Non-visual 1D.** Add Conv1D and a small recurrent/TCN cell; ship a keyword-
  spotting or biometric example.
- **Phase 3 — Streaming schedule.** Introduce the per-stage line-buffer dataflow for
  conv/pool; reductions stay buffered.
- **Phase 4 — Folding + big models.** FINN-style PE/SIMD folding for YOLO/ResNet-class;
  NMS off-chip.

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
