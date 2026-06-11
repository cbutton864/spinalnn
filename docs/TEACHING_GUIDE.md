# spinalnn — A Teaching Guide

*How a neural network becomes a chip.*

This guide is for people who are comfortable reading code but **don't** have a deep
background in neural networks **or** in hardware design. By the end you'll understand:

1. What a neural network actually *is*, in the only terms hardware cares about.
2. What our compiler reads out of a trained model file.
3. How that becomes a Verilog circuit you could put on an FPGA.
4. What every "Core" in this project does, and which knobs (parameters) it exposes.

There is no prior knowledge assumed. Terms are defined the first time they appear.

---

## Part 1 — The 10-minute neural network

### 1.1 A neural network is just a pipeline of array math

Forget brains and neurons for a moment. For our purposes a neural network is a
**fixed sequence of arithmetic steps** applied to an array of numbers.

You feed in an array (for an image: width × height × colour-channels of pixel
values). It flows through a chain of stages. Each stage does some multiply-and-add
math and hands its result to the next stage. The last stage produces the answer —
for a classifier, "which of N categories is this?"

```
 image ──▶ [stage] ──▶ [stage] ──▶ [stage] ──▶ ... ──▶ "it's a 7"
```

The "intelligence" lives entirely in the **numbers inside each stage** (called
*weights*), which were found during *training*. **Training is not our problem.**
We receive an already-trained model and only do *inference* — running the fixed
math forward to get an answer. We never learn or adjust weights.

### 1.2 The handful of stage types that matter

Real models are built from a small vocabulary of stage types. This project
implements the important ones:

| Stage type | What it does, in one sentence |
|---|---|
| **Convolution (Conv)** | Slides a small grid of weights over the image and computes a weighted sum at each position. This is the workhorse of vision models. |
| **ReLU** | "If a number is negative, make it zero." A cheap non-linearity that lets the network represent complex functions. |
| **Max Pool** | Shrinks the image by keeping only the largest value in each little patch. Reduces data and adds tolerance to small shifts. |
| **Global Average Pool** | Collapses each channel's whole image plane down to a single average number. Common just before the final classifier. |
| **Fully-Connected (Linear)** | Every input number influences every output number via a weight. Often the final "decision" layer. |
| **Concat** | Glues several streams together side-by-side into one wider stream. |
| **Softmax / Argmax** | Turns the final scores into "the winner is category k." |

A real network is these stages wired in a particular order with particular sizes.
That **wiring + sizes + weights** is exactly what a model file stores, and exactly
what our compiler reads.

### 1.3 Convolution, the one worth understanding

Convolution is the only stage that's genuinely worth a picture. A **kernel** is a
small grid of weights, say 3×3. You place it over the top-left 3×3 patch of the
image, multiply each weight by the pixel underneath it, and add up the 9 products.
That single sum is one output number. Then you slide the kernel one step right and
repeat, sweeping across and down the whole image.

```
 kernel (3×3 weights)        image patch              one output number
   w0 w1 w2                   p0 p1 p2
   w3 w4 w5      applied to   p3 p4 p5   =   w0·p0 + w1·p1 + ... + w8·p8
   w6 w7 w8                   p6 p7 p8
```

That repeated **multiply-then-add** is the single most common operation in the
whole network. Everything in the hardware is built to do it efficiently. The
operation has a name worth knowing: **MAC** — *multiply-accumulate*.

Two details that show up everywhere:

- **Channels.** Images have depth (e.g. 3 for red/green/blue; later stages have
  dozens or hundreds of channels). A convolution sums across *all* input channels
  for each output. So a real MAC count is `kernelH × kernelW × inputChannels` per
  output number, repeated for every output position and every output channel.
- **Padding.** To keep the output the same size as the input, you pretend there's
  a border of zeros around the image so the kernel can hang off the edge. This is
  called *zero padding*, and it matters for getting the exact same numbers a
  framework like PyTorch would produce.

### 1.4 Quantization — why this project uses whole numbers

Trained models normally use *floating-point* numbers (decimals like `0.0273`).
Floating-point hardware is big and power-hungry. So before deployment, models are
often **quantized**: every number is rescaled and rounded to an 8-bit integer in
the range −128…127. This is the single most important idea for understanding our
hardware, so here it is precisely.

Each real value is represented as:

$$ \text{real} = \text{scale} \times (q - \text{zeroPoint}) $$

- `q` is the stored 8-bit integer (what flows through the wires).
- `scale` is a fixed decimal (chosen during quantization) that says "how much real
  value does one integer step represent."
- `zeroPoint` is the integer that represents real-value zero.

So an 8-bit number `q` plus its `scale` and `zeroPoint` *is* a real number, just
encoded compactly. **The hardware moves `q` around as plain integers; the `scale`
and `zeroPoint` are baked in at build time as constants.** There is no
floating-point arithmetic anywhere in the generated circuit.

#### Requantization (the one tricky bit)

When a convolution multiplies two 8-bit integers and sums hundreds of them, the
result is a big 32-bit integer in some intermediate scale. The next stage expects a
fresh 8-bit number. Converting back down is called **requantization**, and
mathematically it's a multiply by a fixed fraction followed by a clamp to
−128…127.

We never divide in hardware (dividers are expensive). Instead that fixed fraction
$M = \frac{\text{scaleIn} \times \text{scaleWeights}}{\text{scaleOut}}$ is
pre-computed at build time and encoded as **an integer multiplier and a bit-shift**:

$$ \text{output} = \text{clamp}\Big( (\text{acc} \times \text{multiplier}) \gg \text{shift} + \text{zeroPoint}_{out},\ -128,\ 127 \Big) $$

You'll see this exact pattern — `multiplier`, `>> shift`, `+ zeroPoint`, `clamp` —
in several Cores. In code it's the [`RequantScale`](../src/main/scala/spinalnn/types/TensorTypes.scala)
type, which turns a floating-point `scale` into the `(multiplier, shift)` integer pair.

That's the entire theory you need. Everything below is engineering.

---

## Part 2 — What the compiler reads, and what it builds

### 2.1 The big picture: a model file in, a circuit out

We start from an **ONNX file** — a standard, portable format that stores a trained
model as a *graph*: a list of operation nodes (Conv, Relu, MaxPool, …) plus the
*initializers* (the weight arrays and quantization constants). Our compiler walks
that graph and emits **Verilog**, the text language that describes a digital
circuit, which a chip vendor's tools turn into an actual FPGA configuration.

The journey has a deliberately clean shape, with a narrow "waist" in the middle:

```
 ONNX file
    │   (read the graph: ops, weights, scales, shapes)
    ▼
 OnnxFrontend ─────────────▶  Seq[LayerSpec]     ◀── the "waist": a plain,
    │                          (the IR)               hardware-agnostic recipe
    ▼
 IrBackend ────────────────▶  Seq[FiberPlugin]   ◀── one plugin per layer, wired up
    │
    ▼
 SpinalHDL elaboration ────▶  Verilog (.v)        ◀── the actual circuit
```

The middle representation is a `Seq[LayerSpec]` — literally a list of small Scala
case classes, one per layer, with all the math already resolved (shapes computed,
weights laid out, scales chosen). It's called an **IR** (intermediate
representation). Splitting the work at this waist is the key design choice: the
*frontend* only knows about ONNX, the *backend* only knows about hardware, and they
agree on this one simple list. Adding a new model format means writing a new
frontend; adding a new operator means adding one case class and one backend case.

### 2.2 Step 1 — the frontend extracts a recipe

[`OnnxFrontend`](../src/main/scala/spinalnn/compiler/OnnxFrontend.scala) reads the
graph and, for each operation, pulls out everything the hardware will need and
records it as a `LayerSpec`. Concretely, for a convolution it extracts:

- the **kernel size**, **stride** (step size), and **padding**;
- the **weight array**, converted from ONNX's memory layout to the one our hardware
  reads fastest, and kept as raw 8-bit integers;
- the **bias** (a constant added to each output channel);
- the **quantization scales and zero-points** for input, weights, and output;
- the **input and output shapes** (it computes the output shape from the input
  shape and kernel/stride/padding, exactly as the framework would).

It does the analogous extraction for every supported op. The output is the
`Seq[LayerSpec]` recipe — no hardware yet, just fully-resolved facts.

There are **two frontend paths**, because there are two kinds of model file:

- **Float models** (e.g. our MNIST digit model) store decimal weights and *don't*
  record activation scales. The frontend quantizes the weights itself and uses a
  supplied **calibration** for the activation scales. `lower(...)` handles this.
- **Pre-quantized models** (e.g. SqueezeNet) already store 8-bit weights and carry
  every scale and zero-point on the nodes. The frontend reads them directly — no
  guessing. `lowerQuantized(...)` handles this, and `isQuantized(...)` picks the
  path automatically.

`lowerQuantized` also handles two real-world wrinkles found in pre-quantized
models, and it's worth knowing they exist:

- **uint8 → int8 remap.** Some models store activations as *unsigned* bytes
  (0…255) instead of signed (−128…127). Rather than build different hardware, the
  frontend just subtracts 128 from the zero-point. The real value is unchanged, and
  our standard signed-int8 datapath works as-is.
- **Per-channel weight scales.** Modern exports give each output channel its *own*
  weight scale (more accurate). The frontend reads the whole vector and threads it
  through, and the convolution Core knows how to use a different requant constant
  per channel.

### 2.3 Step 2 — the backend turns the recipe into wired-up blocks

[`IrBackend`](../src/main/scala/spinalnn/compiler/IrBackend.scala) walks the
`Seq[LayerSpec]` and, for each entry, instantiates the matching **plugin** (the
hardware block for that op) and connects it to the block that produces its input.
It keeps a small symbol table mapping each layer's name to its output wire, so each
new block can look up where its data comes from.

It also does two clever bits of pure wiring automatically:

- **Fan-in (Concat):** when an op consumes several inputs, the backend hands the
  block the list of upstream wires.
- **Fan-out (StreamFork):** when one block's output feeds *two or more* consumers
  (common in modern networks — one stage's result branches into several), the
  backend detects it and inserts a **StreamFork** block that duplicates the stream,
  giving each consumer its own copy. You don't write this by hand; it's derived
  from the recipe.

The result is a `Seq[FiberPlugin]` — the complete set of hardware blocks plus their
connections.

### 2.4 Step 3 — SpinalHDL elaborates it into Verilog

This project is written in **SpinalHDL**, a hardware-description library embedded in
the Scala language. You write Scala that, when run, *builds* a description of a
circuit, which SpinalHDL then prints as Verilog. Scala is the "factory"; Verilog is
the "product."

The factory has a few recurring patterns. Understanding these four makes the rest of
the codebase readable:

#### Core / Plugin / Trait — the three-layer pattern

Every operator is split into three pieces with strict roles:

- **Core** (e.g. [`QLinearConvCore`](../src/main/scala/spinalnn/ops/conv/QLinearConvCore.scala)):
  the actual circuit logic — registers, memories, the math, the state machine. It's
  a stateless Scala `object` with a `build(config, inputStream)` method that returns
  the output wire. **All the hardware lives here.** A Core knows nothing about how
  it's wired into the larger graph.
- **Plugin** (e.g. [`QLinearConvPlugin`](../src/main/scala/spinalnn/ops/conv/QLinearConvPlugin.scala)):
  pure wiring glue. It receives an upstream connection, calls the Core's `build`,
  and publishes the Core's output. It contains **no math** — its only job is to
  connect blocks together.
- **Trait** (e.g. `ActivationSource` in [`InferenceTraits`](../src/main/scala/spinalnn/InferenceTraits.scala)):
  a tiny contract ("I produce an activation stream") that lets the wiring layer
  refer to a stage by what it *is* rather than by its concrete type.

The payoff: the math (Core) is tested in isolation, the wiring (Plugin) is trivial,
and swapping one stage for another is a one-line change.

#### Streams — how data flows between blocks

Blocks pass data as a **Stream**: a bundle of `valid` (the sender has data),
`ready` (the receiver can take it), and the `payload` (an 8-bit `Activation`). A
value transfers only on a cycle where both `valid` and `ready` are high. This
**back-pressure** means a slow block automatically stalls the blocks feeding it — no
data is ever lost, and you don't hand-manage timing between stages. Data always
flows in **HWC order**: for each spatial position, all channels in turn, then the
next position.

#### PrefixArea — readable generated Verilog

Every register and memory inside a Core is wrapped in a
[`PrefixArea`](../src/main/scala/spinalnn/util/BuildHelper.scala) named after the
layer. That's why a signal in the generated Verilog is called `conv1_accumReg`
rather than an anonymous `reg_4847`. It makes the output circuit traceable back to
the source. This is a project rule: **all `Reg` and `Mem` go inside a `PrefixArea`.**

#### BuildEnv — flat vs. hierarchical Verilog

A single [`BuildEnv`](../src/main/scala/spinalnn/util/BuildHelper.scala) setting
chooses whether each Core becomes its own Verilog module (*hierarchical*, easier to
read and floorplan) or is inlined into one big flat file (*flat*, sometimes better
for the synthesis tools). The same Scala produces both — see
[`GenVerilog`](../src/main/scala/spinalnn/GenVerilog.scala), which emits `rtl/flat/`
and `rtl/hierarchical/` from the identical design.

### 2.5 Where the whole thing is assembled

[`Params`](../src/main/scala/spinalnn/Params.scala) is the catalog of "which network
do I build." For example, `OnnxProfile` compiles `models/mnist-8.onnx` through the
chain above; the hand-written `MnistProfile`/`SmallProfile` wire plugins directly
(useful for tests). [`SpinalNNTop`](../src/main/scala/spinalnn/Top.scala) is the
chip's outer shell: it declares the input/output pads and hosts the plugins.
[`TopIoExportPlugin`](../src/main/scala/spinalnn/TopIoExportPlugin.scala) connects
the first block to the input pads and the last block to the output pads.

> **One wiring rule worth calling out: the two-phase discipline.** The wiring hub
> first does *all* its "load an input" connections, and only then does *all* its
> "read an output" connections. The hardware-build system (Fiber) resolves
> connections lazily, and reading an output before every input is connected can
> deadlock elaboration. So: **all loads first, all reads second.**

---

## Part 3 — The Cores, one by one

Each Core is the hardware for one operator. For every Core below: what it computes,
how the circuit does it, and **what's parametric** — the knobs in its `Config` that
let the *same* Scala generate differently-sized hardware for different models.

A recurring shape in the heavier Cores is a small **state machine** (FSM): the
circuit steps through named phases — typically *receive the input*, *do the math*,
*emit the output* — one clock cycle at a time. Memories are read with a one-cycle
delay (a "registered read"), which is friendly to the FPGA's built-in block-RAM, so
several phases are just "wait for the memory to answer."

---

### 3.1 QLinearConvCore — the convolution engine

**File:** [QLinearConvCore.scala](../src/main/scala/spinalnn/ops/conv/QLinearConvCore.scala)
· **Computes:** an 8-bit quantized 2-D convolution (the sliding-kernel math from §1.3),
plus bias and requantization back to 8-bit.

**How the circuit works.** The incoming feature map is written into an on-chip
**input buffer** (block-RAM). The weights live in a **weight ROM** initialised at
build time. A state machine then, for each output position and output channel:

1. **Load bias** — seed the 32-bit accumulator with this channel's bias constant.
2. **Compute** — a pipelined **MAC** loop sweeps the kernel window: read one input
   and one weight per cycle, subtract their zero-points, multiply, and add into the
   accumulator. This repeats `kernelH × kernelW × inputChannels` times.
3. **Requantize** — take the big 32-bit accumulator down to 8 bits using the
   `multiplier`/`shift`/`clamp` recipe from §1.4. (The 32-bit × 32-bit multiply is
   itself split into four 16-bit pieces across several cycles so it fits the FPGA's
   small multipliers and stays fast.)
4. **Emit** — push the 8-bit result onto the output stream, advance to the next
   position.

**Padding** is handled elegantly: if the layer needs a zero border, the input buffer
is made slightly larger and pre-filled with zeros, and the real data is written into
the interior. The MAC loop then runs an ordinary border-free convolution over the
padded buffer — which is mathematically identical to a padded convolution, with zero
special-case logic in the hot loop.

**What's parametric (its `Config`):**

| Knob | Effect |
|---|---|
| `inputShape`, `outputShape` | Sizes of the buffers, counters, and address math. |
| `kernelH`, `kernelW` | Size of the sliding window → length of the MAC loop. |
| `strideH`, `strideW` | How far the window jumps each step → output size. |
| `padTop/Bottom/Left/Right` | Size of the zero border baked into the input buffer. |
| `weights`, `biases` | The trained constants, loaded into ROMs at build time. |
| `inputQuant`, `weightQuant`, `outputQuant` | The scales/zero-points → the requant constants and the zero-point subtractions. |
| `weightScales` *(optional)* | If present, **per-channel** requant: one multiplier/shift per output channel, stored in a small ROM and indexed as outputs are produced. If absent, a single per-tensor constant is used and the generated circuit is byte-for-byte the simpler version. |
| `macParallelism` | How many input channels are multiplied **in parallel** each cycle (banked memories). Higher = faster but more hardware. The headline speed/area dial. |

> This is the most complex Core; the others are much simpler. If you understand
> *receive → MAC → requantize → emit*, you understand the heart of the accelerator.

---

### 3.2 QLinearLinearCore — the fully-connected layer

**File:** [QLinearLinearCore.scala](../src/main/scala/spinalnn/ops/linear/QLinearLinearCore.scala)
· **Computes:** a fully-connected layer — every output neuron is a weighted sum of
*all* input neurons, plus bias, requantized to 8-bit.

It's essentially a convolution with the spatial dimensions removed: same
*receive → load bias → multiply-accumulate → requantize → emit* state machine, but
indexed only by input-neuron and output-neuron rather than by image position. Often
the final "decision" layer that turns features into per-class scores.

**What's parametric:** `inNeurons`, `outNeurons` (the layer's shape → buffer and ROM
sizes), `weights` and `biases` (trained constants), and the three `QuantParams`
(scales/zero-points → requant constants).

---

### 3.3 MaxPoolCore — spatial down-sampling

**File:** [MaxPoolCore.scala](../src/main/scala/spinalnn/ops/pool/MaxPoolCore.scala)
· **Computes:** slides a window over the image and outputs the **maximum** value in
each window — shrinking the image and adding tolerance to small shifts.

The frame is buffered, then a state machine, for each output position, reads the
window's taps one per cycle through block-RAM and folds them into a running maximum,
emitting one value per window. The common 2×2 window with stride 2 reduces to a
tidy fixed schedule; arbitrary window and stride sizes are supported by the same
phased loop.

**What's parametric:** `inputShape`, `outputShape`, `poolH`/`poolW` (window size),
`strideH`/`strideW` (step). Channels pass through unchanged; the output spatial size
follows the standard floor formula.

---

### 3.4 GlobalAveragePoolCore — collapse each channel to one number

**File:** [GlobalAveragePoolCore.scala](../src/main/scala/spinalnn/ops/pool/GlobalAveragePoolCore.scala)
· **Computes:** for each channel, the **average** of its entire image plane, giving a
1×1×C result. Common right before the final classifier.

The interesting engineering here is **memory**. Because data arrives channel-by-channel
interleaved over the whole frame, naively you'd buffer the entire (possibly large)
input. Instead this Core keeps only a tiny **accumulator RAM with one 32-bit running
sum per channel** (a few kilobytes even for 1000 channels) and adds each value into
its channel's slot as it streams by. When the frame ends, it sweeps the
accumulators, applies requant, and emits.

Two nice touches: the **divide-by-area** that averaging needs is folded into the
requant multiplier at build time (so there's *no hardware divider* — see
`RequantScale.forAverage`), and a small registered forwarding path makes the
single-channel edge case correct without a timing hazard.

**What's parametric:** `inputShape` (sets the accumulator depth and the area used in
the averaging constant), `outputShape` (must be 1×1×channels), and `inputQuant` /
`outputQuant` (→ the combined average-and-requant constant).

---

### 3.5 ReLUCore — the cheap non-linearity

**File:** [ReLUCore.scala](../src/main/scala/spinalnn/ops/activation/ReLUCore.scala)
· **Computes:** `output = max(0, input)` on every element.

This is the simplest Core in the project: **no buffer, no memory, no state machine.**
Each element is transformed by a single comparator and passed straight through in the
same cycle, with `valid`/`ready` wired directly across so back-pressure is
transparent. A good example of "not every operator needs heavy machinery."

**What's parametric:** essentially nothing but a `periphName` for naming. (A leaky-ReLU
slope is noted as a future extension.)

---

### 3.6 SoftmaxCore — pick the winner

**File:** [SoftmaxCore.scala](../src/main/scala/spinalnn/ops/activation/SoftmaxCore.scala)
· **Computes:** **argmax** — the *index* of the largest score. For a classifier, that
index *is* the predicted class.

It streams in the N class scores tracking a running maximum and its index, then emits
the winning index. (This is the top-1 answer; producing full probability values would
be a future extension, but argmax is all you need to know which class won.)

**What's parametric:** `numClasses` (how many scores to compare; sets the counter and
index width).

---

### 3.7 ConcatCore — glue streams side-by-side (fan-in)

**File:** [ConcatCore.scala](../src/main/scala/spinalnn/ops/concat/ConcatCore.scala)
· **Computes:** channel-wise concatenation — stack several same-sized feature maps
into one with the channels of all inputs combined.

Because data is in HWC order (channels innermost), this is a pure **multiplexer**: at
each spatial position, forward all of input 0's channels, then all of input 1's, and
so on, then move to the next position. **No buffering, full throughput.** It's the
first *multi-input* operator and is what lets the network branch and rejoin.

**What's parametric:** `inputShapes` — the list of input feature-map shapes. All must
share spatial size; the output channel count is their sum. The number of inputs is
simply the length of that list.

---

### 3.8 StreamForkCore — duplicate a stream (fan-out)

**File:** [StreamForkCore.scala](../src/main/scala/spinalnn/ops/fork/StreamForkCore.scala)
· **Computes:** the mirror image of Concat — copy **one** input stream to **N**
identical outputs, so one producer can feed several branches.

The careful part is back-pressure: in the default *asynchronous* mode each output has
its own `ready`, and an input element is held until **every** output has accepted it
(tracked by a small per-output "token"). Branches may therefore run at different
speeds with no data lost or duplicated. A lower-area *synchronous* mode fires all
outputs together when every consumer is ready in lock-step.

**What's parametric:** `shape` (the stream's feature-map shape), `numOutputs` (how many
copies), and `synchronous` (the safe async default vs. the lock-step variant). The
backend inserts this Core automatically wherever the recipe shows a stage feeding two
or more consumers.

---

### 3.9 The "zero-RTL" helpers — Input, Flatten, Output

A few stages are bookkeeping rather than computation and generate essentially no logic:

- **InputPlugin** ([file](../src/main/scala/spinalnn/ops/input/InputPlugin.scala)) —
  the entry point; hands the incoming activation stream to the first real stage.
- **FlattenPlugin** ([file](../src/main/scala/spinalnn/ops/linear/FlattenPlugin.scala)) —
  reinterprets an H×W×C feature map as one long 1×1×(H·W·C) vector before a
  fully-connected layer. The bytes are already in the right order, so it's just a
  relabelling of the shape — no hardware.
- **NetworkOutputPlugin** ([file](../src/main/scala/spinalnn/ops/output/NetworkOutputPlugin.scala)) —
  the terminal marker; routes the final stage's stream to the chip's output pads.

These exist so the graph has clean, named start and end points and so a flatten is
explicit in the IR — they cost no gates.

---

## Part 4 — Putting it together: a worked mental model

To see the whole stack in one glance, follow the MNIST digit classifier
(`Params.onnx`) from file to circuit:

1. **The file** `models/mnist-8.onnx` stores: an input shape of 28×28×1, a couple of
   convolutions with their weights, ReLUs, max-pools, a flatten, a fully-connected
   layer to 10 scores, and a softmax.
2. **The frontend** walks that graph and produces a `Seq[LayerSpec]`: `Input →
   Conv → Relu → MaxPool → Conv → Relu → MaxPool → Flatten → Linear → Softmax →
   Output`, each entry carrying its resolved shapes, weights, and quantization
   constants.
3. **The backend** instantiates a plugin per entry and chains them: each block's
   output stream becomes the next block's input. (For this linear model there's no
   branching, so no StreamForks are inserted; a model like SqueezeNet would get them
   automatically where stages branch and rejoin.)
4. **SpinalHDL elaboration** runs all that Scala and prints Verilog — one
   `SpinalNNTop` with an input pad, an output pad, and the chain of Cores inside,
   every register named like `conv1_accumReg` thanks to `PrefixArea`.
5. **An 8-bit image** clocked into the input pad flows stage to stage — convolve,
   rectify, pool, convolve, …, score, argmax — and the predicted digit appears at
   the output pad. Streams and back-pressure keep every stage in step automatically.

The same machinery, pointed at a richer pre-quantized model, picks up per-channel
scales, uint8 remapping, fan-in/fan-out, and global average pooling — all already
implemented in the Cores above, all selected automatically by the compiler from
what it reads in the file.

---

## Where to look next

| You want to understand… | Read… |
|---|---|
| The architecture rules and rationale in depth | [docs/ARCHITECTURE_DIRECTION.md](ARCHITECTURE_DIRECTION.md), [docs/OVERVIEW.md](OVERVIEW.md) |
| How to add a brand-new operator | the `operators` skill under `.github/skills/operators/` |
| How a Core is unit-tested | any `*CoreTest.scala` under `src/test/scala/spinalnn/ops/` |
| The exact build/test/generate commands | [docs/BUILD_PLAN.md](BUILD_PLAN.md) and the `build` skill |
| The numeric types and requant math | [TensorTypes.scala](../src/main/scala/spinalnn/types/TensorTypes.scala) |

**Build / test / generate, in three commands:**

```
sbt compile                          # type-check the Scala
sbt test                             # run all Core simulations
sbt "runMain spinalnn.GenVerilog"    # write rtl/flat/ and rtl/hierarchical/
```
