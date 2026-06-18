# TinyML Reference — Relevance to SpinalNN

SpinalNN occupies a genuine gap: ONNX INT8 → parameterized SpinalHDL with WeightRom/WeightStream
and per-layer MAC parallelism. No direct open-source equivalent exists.

---

## Key Concepts

### Defining Constraints
- **MCU class**: <1 mW, 128–512 KB SRAM, <1 MB weight storage. Peak *SRAM* (not parameter count) is the bottleneck.
- **FPGA class (our target)**: 1–10 W, BRAM for weights + LPDDR4x for overflow. Bandwidth-bound when streaming weights from DRAM.
- **Latency vs throughput**: FINN-style dataflow targets throughput (pipeline always full); hls4ml targets ultra-low latency (5 µs for small CNNs). SpinalNN is currently store-and-compute (latency per inference).

### Dominant Architectures and Their Hardware Implications
| Architecture | Key Op | Hardware Challenge |
|---|---|---|
| MobileNetV1/V2 | DWConv + PWConv | DWConv under-utilizes output-parallel MAC arrays (1 out-ch/in-ch group) |
| MobileNetV2 | Inverted residual + Add | Skip tensor must be double-buffered; Add requires FIFO on skip path |
| SqueezeNet | Fire module (1×1 squeeze + parallel expand + Concat) | Two activation streams must coexist; StreamFork + Concat topology |
| EfficientNet-Lite | ReLU6 replaces Swish, no squeeze-and-excite | Explicitly hardware-simplified |
| MCUNet/V2 | Patch-based tiled inference | Processes spatial tiles through multiple layers; avoids materializing full H×W×C |

### Quantization
- **INT8 is the production standard** (TFLite, ONNX Runtime, TVM, FINN, hls4ml, Vitis AI). <1% accuracy loss with PTQ on most CNNs.
- **INT4** active in research/LLMs; TFLite Micro added INT4 kernel support ~2024. Not yet a priority for SpinalNN.
- **Mixed precision**: sensitive layers (first conv, classifier head) at INT8/INT16; middle layers at INT4. Hard to encode cleanly in vanilla ONNX; QONNX (FINN) extends ONNX with explicit Quant nodes.
- **ONNX QDQ format** (quantize-dequantize nodes) is the lingua franca for quantized model exchange. Our ONNX input follows this standard.

### Store-and-Compute vs Streaming Dataflow
| Mode | Description | When to Use |
|---|---|---|
| **Store-and-compute** (current SpinalNN) | Each layer buffers all input in BRAM/LPDDR4x, then computes full output before passing downstream | Simple, correct for any topology. Latency = sum of all layer times |
| **Streaming dataflow** (FINN) | Each layer is a concurrent pipeline stage; activations flow as a stream through all stages | Maximum throughput once pipeline is full. Requires entire network on-chip |
| **Tiled/patch-based** (MCUNetV2, StreamNet++) | Process spatial tiles through multiple layers; avoids materializing full H×W×C tensors | Reduces peak activation memory 4–8×; enables larger models on-chip |

### Weight Storage Hierarchy
| Mode | Storage | When to Use |
|---|---|---|
| **WeightRom** (BRAM) | Weights in BRAM, single-cycle read | Small models (MNIST, tiny SqueezeNet); total weights fit in BRAM budget |
| **WeightStream** (LPDDR4x) | Weights DMA'd from LPDDR4x before each output channel | Large models; BRAM budget exceeded. Bandwidth-bound |

### Accumulator Width (A2Q)
INT8 × INT8 = INT16 intermediate; accumulating K products requires log₂(K) additional bits.
- 512 input channels × 3×3 kernel = 4,608 MACs → needs ~25-bit accumulator before requantization.
- SpinalNN `accumReg` is `SInt(32 bits)` — covers all realistic cases.
- Reference: *A2Q: Accumulator-Aware Quantization with Guaranteed Overflow Avoidance* (2023).

### Residual Add / Concat — Stream Buffering
The skip path in a residual block arrives before the conv branch. Both AddCore and StreamFork
require simultaneous handshake → classic deadlock. Fix: FIFO of depth `inputShape.size` on
the fork output going to Add. This is the "double-buffer skip tensor" approach from the literature.
SpinalNN implements this in `AddPlugin` via `queueDepthA`/`queueDepthB`.

### Depthwise Convolution Under-utilization
A MAC array designed for PWConv parallelism (N=8 output channels in parallel) will have
N−1 out of N PEs idle during DWConv (1 output channel per input channel group).
Solutions in the literature: separate DWConv engine, SharePE, or dynamic A/M reconfiguration.
**Action**: when targeting MobileNetV2, verify DWConv utilization is acceptable or add a
reconfigurable accumulation path.

---

## Toolchain Landscape

| Tool | Approach | Relevant to SpinalNN |
|---|---|---|
| **hls4ml** | ONNX/Keras → HLS C++ for Xilinx/Intel; Reuse Factor = our per-layer N | Closest analogue; outputs HLS not SpinalHDL; Xilinx-only |
| **FINN** | QONNX → streaming dataflow RTL; entire net on-chip | Handles residual/Concat but requires low-bit quant for full on-chip; AMD-only |
| **Vitis AI** | Fixed DPU architecture; INT8 ONNX in | Xilinx-only; performance reference |
| **Apache TVM** | Graph IR → auto-tiled code; QNN dialect for INT8 ONNX | Best reference for memory planning and requantization arithmetic |
| **TFLM** | MCU runtime; pre-compiled CMSIS-NN kernels | Defines INT8 operator semantics our ONNX inputs follow |
| **IREE / ExecuTorch** | MLIR / torch.export edge runtimes | Maturing; not directly applicable |

---

## Open Problems Relevant to SpinalNN

1. **Layer fusion across LPDDR4x** — store-and-compute writes/reads each layer through LPDDR4x.
   Fusing consecutive elementwise ops (Add → ReLU6 → Conv) eliminates one round-trip.
   Literature shows >20% bandwidth reduction on EfficientNet-scale models.

2. **Tiled/streaming compute mode** — process spatial tiles through multiple layers without
   writing to LPDDR4x between them. Reduces latency-to-first-output and LPDDR4x bandwidth.
   Not required for correctness but meaningful for throughput on large spatial feature maps.

3. **BRAM shape matching** — weight tensor shapes rarely match BRAM primitive widths (Efinix
   embedded BRAM). Padding wastes capacity. Worth auditing when BRAM budget is tight.

4. **Structured pruning integration** — whole-channel pruning is hardware-friendly (disabled
   MAC column = lower effective N for that layer). A 2025 paper shows 77–94% model size
   reduction with negligible accuracy loss via pruning + INT8 QAT.

---

## Key Papers

| Paper | Why Relevant |
|---|---|
| **MCUNetV2** (NeurIPS 2021) — Lin et al., MIT | Patch-based inference; reduces peak activation RAM 4–8×; tiling strategy reference |
| **StreamNet++** (ACM TECS 2024) — memory-efficient streaming CNN inference | Tile-by-tile streaming through layers; avoids materializing full feature maps; complements store-and-compute |
| **A2Q: Accumulator-Aware Quantization** (ICLR 2024) — Colbert et al. | Formal treatment of accumulator overflow in quantized hardware; directly applicable to SpinalNN MAC width sizing |
| **FINN-R** (ACM TOCS 2019) — Blott et al., AMD/Xilinx | Streaming dataflow FPGA inference; SIMD×FOLD parallelism model; reference for on-chip weight layout |
| **hls4ml** (JINST 2021 + ongoing) — Duarte et al., CERN/Fermilab | Reuse Factor = per-layer N; fixed-point MAC pipeline; latency-mode vs resource-mode trade-off |
| **Algorithm-Hardware Co-design for DW-Sep CNNs** (ACM TODAES 2024) | DWConv under-utilization; SharePE designs; directly relevant to MobileNetV2 support |
| **ONNX-to-Hardware Design Flow** (SAMOS 2024) | Direct ONNX → RTL/HLS academic flow; closest analogue to SpinalNN's compiler architecture |
| **Dataflow & Tiling Strategies Survey** (arXiv 2505.08992, 2025) | Comprehensive survey of FPGA CNN accelerator dataflow choices; good orientation document |
| **uGEMM: Unary Computing Architecture for GEMM** (ISCA 2020) — Wu et al. | Relaxes the two hard constraints of classical SC (low correlation + long stream length) using input-insensitive arithmetic units. Enables early termination: N=64 for coarse, N=256 for fine precision. Key enabler for StochasticConvCore — classical LFSR+AND needs N≈16K for 8-bit; uGEMM-style gets there at N≈256. |
| **SC CNN Architecture Reinvented for Highly Efficient AI on FPGA** (Research/SPJ 2024) — Lee et al., Kintex-7 | Introduces SC Multiplexer MAC (MUX-MAC) replacing classical AND gate. Achieves 0.14% accuracy loss vs. binary INT8 at N=256. Results: 99.72% energy reduction, 31× throughput/area vs. conventional hardware, >2× logic density, >6× fewer broadcast wires. Primary implementation reference for StochasticConvCore. |
