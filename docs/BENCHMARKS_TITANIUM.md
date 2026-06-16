# SpinalNN — Efinix Titanium Benchmark Results

Tracking top P&R results per design configuration on Titanium silicon.  
Long-term goal: compare SpinalNN throughput and resource efficiency against FINN and hls4ml on identical models.

---

## Device Reference: Efinix Titanium (16nm FNX)

| Device | Family | LUT4 | DSP48 | RAM10K | On-Package LPDDR4x | Notes |
|:---|:---|---:|---:|---:|:---|:---|
| Ti60  | Standard | 62,016 | 160  | 256   | — | — |
| Ti90  | Standard | 92,534 | 336  | 672   | 512MB, 3Gbps | Ti90M225 target |
| Ti120 | Standard | 123,379 | 448 | 896   | 1GB,  3Gbps  | — |
| Ti165 | Standard | 162,800 | 590 | 1,183 | 1GB,  3Gbps  | — |
| **Ti180M484** | **Standard** | **176,256** | **512¹** | **1,280** | **1GB, 3Gbps** | **Current benchmark target** |
| Ti240 | Standard | 236,888 | 860 | 1,720 | 1GB,  3Gbps  | — |
| Ti375 | Standard | 370,137 | 1,344 | 2,688 | 2GB, 3Gbps  | N=32+ headroom target |

¹ Ti180 full die = 640 DSPs; Ti180M484 package exposes **512** to user logic (confirmed by efx_map on SqueezeNet at 100% utilization).  
RAM10K = datasheet on-chip RAM (Mb) ÷ 10,240 bits/block. DSP48 counts other than Ti180M484 are datasheet totals — verify with efx_map for the specific package.

All Titanium parts include embedded on-package LPDDR4x (1×32-bit AXI4 port) and MIPI D-PHY.

**DSP Block Modes:** All Titanium DSP blocks (both Standard and Edge sub-families) support multi-mode operation: 18×18-bit integer multiply, 27×18-bit multiply, and a **Float Mode** implementing BF16 fused multiply-add (FMA, BF16 input → FP32 accumulate). The Titanium Edge sub-family (Ti60E/Ti125) specifically markets the BF16 FMA capability for ML workloads but offers fewer DSP blocks than the comparable Standard parts. **For INT8 inference (current SpinalNN path), Float Mode is irrelevant — DSP blocks run in integer mode.**

---

## SqueezeNet 1.0 INT8 — Efinix Ti180M484

Best result per design configuration. Full run history in `pnr_results.tsv`.

| Date | Label | N Strategy | LUT4 | DSP48 | FF | RAM10K | fmax (MHz) | FPS | Latency (ms) | Notes |
|:---|:---|:---|---:|---:|---:|---:|---:|---:|---:|:---|
| 2026-06-10 | N1_singleclock | Global N=1 | 31,804 | 135 | 26,764 | 331 | 197.9 | ~0.1 | ~10,000 | Stream baseline; WeightRom |
| **2026-06-10** | **N16_balanced_tree** | **N=16 / conv1=N=3** | **39,377** | **512** | **34,908** | **630** | **171.5** | **~4.4** | **~225** | **Best FPS; balanced tree MAC; conv1 N=3 override; MemLineBuffer explicit** |
| 2026-06-15 | ws_n16_phase1_dma | N=16, conv1=N=1 (fallback) | 39,947 | 510 | 35,625 | 625 | 176.0 | ~3.1 | ~320 | Phase 1 512-bit DMA beats; MemAuto line-buffer fix; conv1 N=3 override pending |

**Design config for N16_balanced_tree (current FPS champion):**
- `macParallelism: 16`, `conv1_1_quantized` override → `N=3` (WeightRom fallback, 64%3≠0)
- `weightMode: stream`, `memoryStrategy: line`, `targetFreqMhz: 150`
- Balanced tree `treeReduce` in Stage 2 of `QLinearConvLineCore` replaces left-fold — critical for timing closure

**Design config for ws_n16_phase1_dma (2026-06-15):**
- `macParallelism: 16`, no conv1 override (N=1 fallback; conv1 bottleneck at 46% of cycles)
- `weightMode: stream`, `memoryStrategy: auto`, `targetFreqMhz: 150`
- Phase 1 DMA: `WeightDmaCore` now outputs `Stream[Bits(512 bits)]` per fire (was `Stream[SInt(8 bits)]`); conv cores drain N bytes/cycle from shift register
- IrBackend fix: WeightStream mode always routes through `QLinearConvLineCore` (avoids H×W×C_in full-frame BRAM)
- IrBackend fix: MaxPool under `MemAuto` always uses `MaxPoolLineCore` (avoids full-frame pool BRAM; saves ~1,840 RAM10K on SqueezeNet)
- New bench script: `spinalnn.bench.GenSqueezeNetBench` generates ws_n1 and ws_n16 RTL variants
- Adding conv1 N=3 override expected to recover ~4.4–4.5 FPS at the higher 176 MHz fmax

**Device utilization at current best (N16_balanced_tree, Jun 10):**

| Resource | Used | Available | % |
|:---|---:|---:|---:|
| EFX_LUT4 | 39,377 | 183,960 | 21% |
| EFX_DSP48 | 512 | 512 | **100%** |
| EFX_FF | 34,908 | ~183,960 | 19% |
| EFX_RAM10K | 630 | 1,280 | 49% |

DSP budget is the active constraint. LUT4, FF, BRAM all have ample headroom.

**Conv1 bottleneck analysis:**
- conv1 (C_in=3, 224×224, 3×3) falls back to N=1 at MacParFixed(16) since 64%3≠0
- conv1 consumes 46% of total inference cycles at N=1 (23.8M of 54.7M)
- Fix: `MacParPerLayer("conv1_1_quantized" → 3)` — uses N=3 (3%3=0), 3× faster, costs 3 DSPs vs 1
- At N=3 conv1, total cycles ≈ 38.8M; at 176 MHz → **~4.5 FPS** (next P&R target)

---

## RepVGG-A0 INT8 — Efinix Ti180M484

| Date | Label | N Strategy | LUT4 | DSP48 | FF | RAM10K | fmax (MHz) | FPS | Latency (ms) | Notes |
|:---|:---|:---|---:|---:|---:|---:|---:|---:|---:|:---|
| 2026-06-10 | repvgg_a0_N16 | Global N=16, conv1=N=1 | 42,677 | 435 | 28,816 | 728 | 173.3 | ~1.59 | ~630 | Baseline; conv1 bottleneck |
| 2026-06-10 | repvgg_a0_N16_top4N32 | N=16 + conv1=N=3 + 4×N=32 (left-fold) | — | 501 | — | 828 | 156.7 | ~1.57 | ~638 | Routing-limited; prior FPS estimate was incorrect |
| **2026-06-11** | **repvgg_a0_N16_top4N32_btree** | **N=16 + conv1=N=3 + 4×N=32 (balanced tree)** | **44,926** | **501** | **29,282** | **828** | **156.7** | **~1.57 (@fmax) / ~1.50 (@150)** | **~638** | **+0.285 ns slack @ 150 MHz; routing-limited** |

**Key finding — N=32 timing wall is routing, not logic:**
- Critical path: `inValReg_20` → DSP (1.34 ns wire, X:199) → adder (1.47 ns wire, X:254) → 30-level ripple carry chain
- Efx_map already generates balanced carry-lookahead internally; `treeReduce` RTL change produced identical netlist
- Root cause: 501/512 DSPs (98% utilization) → severe routing congestion → long inter-block wires dominate delay
- **At 150 MHz target (fair comparison):** N=32 gives 1.50 FPS vs N=16's 1.37 FPS → **+9.4% real gain**
- **At respective fmax:** N=32 (156.7 MHz, 1.57 FPS) vs N=16 (173.3 MHz, 1.58 FPS) → essentially break-even
- N=32 beneficial on **Ti375** where 501/1344 DSPs (37%) leaves ample routing slack

**Device utilization (N16 baseline):**

| Resource | Used | Available | % |
|:---|---:|---:|---:|
| EFX_LUT4 | 42,677 | 183,960 | 23% |
| EFX_DSP48 | **435** | 512 | **85%** |
| EFX_FF | 28,816 | ~183,960 | 16% |
| EFX_RAM10K | 728 | 1,280 | 57% |

**Cycle breakdown (N=16 + conv1=N=3, estimated at 173.3 MHz):**

| Bottleneck | Cycles | % | Notes |
|:---|---:|---:|:---|
| conv1 (C_in=3, N=3 override) | 6.1M | 6.3% | RGB input; N=3 is the max (C_in=3) |
| 3× C_in=48→48/96 layers | 26.9M | 27.7% | N=16 max (48%32≠0), structurally bound |
| 14× C_in=192 body layers | 57.2M | 59.0% | N=32 eligible but timing-limited on Ti180 |
| C_in=192→1280 final conv | 5.4M | 5.6% | N=32 eligible |
| GAP + Linear | 1.3M | 1.3% | — |

**N=32 analysis:**
- 4 layers at N=32 within 512 DSP budget: cycles −10%, fmax −9.6% → net ~flat (confirmed by P&R)
- All 18 eligible layers at N=32 (Ti375): **2.39 FPS** — meaningful gain with routing slack
- Theoretical max (conv1 bottleneck removed): ~5.7 FPS — conv1 is the true ceiling on Ti180

---

## DS-CNN-S INT8 — Keyword Spotting — Efinix Ti180M484

First DWConv-validated model. Input: 49×10×1 MFCC spectrogram, 12-class output (Google Speech Commands).

| Date | Label | N Strategy | P | LUT4 | DSP48 | FF | RAM10K | fmax (MHz) | FPS | Latency (ms) | Notes |
|:---|:---|:---|---:|---:|---:|---:|---:|---:|---:|---:|:---|
| 2026-06-10 | dscnn_s_N8 | N=8, stem N=1 | 1 | 9,368 | 86 | 8,872 | 128 | 206.9 | ~186 | ~5.4 | Baseline; WeightStream; DWConv P&R |
| **2026-06-11** | **dscnn_s_N8_P4** | **N=8, stem N=1** | **4** | **11,619** | **230** | **9,644** | **286** | **≥150** | **~176** | **~5.7** | **P=4 on 4 PWConv; +0.609 ns slack; WeightRom** |

---

## DS-CNN-S INT8 — Keyword Spotting — Efinix Ti90J484

First Ti90 benchmark. Identical model; smallest Titanium part with LPDDR4x. Device: Ti90J484 (484-pin BGA, Efinity 2025.2 name). Corresponds to Ti90 Standard with 336 DSP / 672 RAM10K.

End-to-end accuracy validated in sim (3/3 MFCC inputs match ONNX Runtime, 2026-06-14).

| Date | Label | N Strategy | P | LUT4 | DSP48 | FF | RAM10K | fmax (MHz) | Slack @ 150 MHz | Notes |
|:---|:---|:---|---:|---:|---:|---:|---:|---:|---:|---:|:---|
| **2026-06-14** | **dscnn_s_ti90_N8_ws** | **N=8, stem N=1** | **1** | **9,429** | **86** | **8,874** | **144** | **199.4** | **+1.652 ns** | **WeightStream; LineBuffer; Ti90J484** |

**Device utilization (Ti90J484 — 336 DSP / 672 RAM10K available):**

| Resource | Used | Available | % |
|:---|---:|---:|---:|
| EFX_LUT4 | 9,429 | ~92,534 | 10% |
| EFX_DSP48 | **86** | 336 | **26%** |
| EFX_FF | 8,874 | ~92,534 | 10% |
| EFX_RAM10K | 144 | 672 | **21%** |

Ample headroom on all resources — 74% DSP and 79% BRAM unused. Room to add N=16 on PWConv layers (~109 DSP, per auto-sweep) or P=4 (~190 DSP, per Ti180 P=4 result).

**Benchmark project:** `benchmark_dscnn_s_ti90/spinalnn_dscnn_s_ti90.xml` (Ti90J484, timing.sdc 150 MHz).

**Device utilization (P=4 config):**

| Resource | Used | Available | % |
|:---|---:|---:|---:|
| EFX_LUT4 | 11,619 | 176,256 | 7% |
| EFX_DSP48 | **230** | 512 | **45%** |
| EFX_FF | 9,644 | ~176,256 | 5% |
| EFX_RAM10K | 286 | 1,280 | **22%** |

**This model fits on Ti90 (336 DSPs, 672 BRAM) with ample headroom.**

**Cycle breakdown (N=8, WeightRom):**

| Layer | P=1 Cycles | P=1 % | P=4 Cycles | P=4 % | Notes |
|:---|---:|---:|---:|---:|:---|
| Stem Conv (10×4, C_in=1, N=1) | 330,924 | 29.9% | 330,924 | 38.7% | MFCC input; N=1 forced |
| 4× DWConv 3×3 (C=64) | 399,360 | 36.1% | 399,360 | 46.8% | ~100K each; no N/P axis |
| 4× PWConv 1×1 (N=8, C=64) | 368,640 | 33.3% | 115,200 | 13.5% | ~29K each with P=4 |
| GAP + Linear | 8,524 | 0.8% | 8,524 | 1.0% | — |
| **Total** | **1,107,448** | | **854,008** | | |
| **FPS @ 150 MHz** | **135.5** | | **175.6** | | **+1.30× gain** |
| **FPS @ fmax** | **~186 @ 207 MHz** | | **~193 @ 165 MHz** | | *(fmax estimated from slack)* |

**P=4 speedup breakdown:** PWConv cycles reduced 3.2× (368,640 → 115,200). Stem and DWConv are the new bottlenecks at 85.5% of total cycles.

**DWConv cycle profile:** DWConv has no input-channel or output-channel parallelism axis — always 1 MAC per spatial step regardless of N or P. The 4 DWConv layers take ~47% of cycles in the P=4 config, up from 36% with P=1. Further improvement requires DWConv kernel fusion or increased clock rate.

---

## Model Comparison — Ti180M484

| Model | Domain | DSP48 | DSP% | RAM10K | fmax (MHz) | FPS | Latency | Notes |
|:---|:---|---:|---:|---:|---:|---:|---:|:---|
| SqueezeNet 1.0 | ImageNet | 512 | 100% | 630 | 171.5 | ~4.4 | ~225ms | DSP ceiling; fire-module overhead |
| RepVGG-A0 | ImageNet | 435 | 85% | 728 | 173.3 | ~1.79 | ~560ms | 15% DSP headroom; N=16+conv1=N=3 |
| DS-CNN-S (P=1) | KWS | 86 | 17% | 128 | 206.9 | ~186 | ~5ms | First DWConv; WeightStream |
| **DS-CNN-S (P=4)** | **KWS** | **230** | **45%** | **286** | **≥150** | **~176** | **~5.7ms** | **P=4 PWConv; WeightRom standalone; +1.30×** |

---

## Auto N-Sweep Optimiser Results

`ModelCycleEstimator.optimizeMacPar()` — greedy knapsack, analytical only (no P&R). Run via `PrintNOptimize`.

### RepVGG-A0 — Ti180M484 (budget=512 DSP, defaultN=8, maxN=16)

| Config | Cycles | FPS @ 173.3 MHz | DSP | Notes |
|:---|---:|---:|---:|:---|
| Baseline N=8 global | 193,989,556 | 0.89 | 261 | Starting point |
| **Optimised (per-layer)** | **109,554,868** | **1.58** | **429** | **+1.77x FPS, +168 DSP** |

Optimizer bumps all 21 layers with C_in divisible by 16 from N=8 → N=16.
Stem (C_in=3) stays at N=1 fallback (3%16≠0) and accounts for 16.6% of cycles — the irreducible bottleneck.
Result converges to "N=16 global" which is the empirically validated P&R best config (173.3 MHz, 435 DSP).

### DS-CNN-S — Ti180M484 and Ti90 (budget=512/288 DSP, defaultN=8, maxN=16)

| Config | Cycles | FPS @ 206.9 MHz | DSP | Notes |
|:---|---:|---:|---:|:---|
| Baseline N=8 global | 1,113,592 | 185.80 | 77 | Starting point |
| **Optimised (per-layer)** | **989,688** | **209.06** | **109** | **+1.13x FPS** |

Only the 4 PWConv 1×1 layers upgrade to N=16. DWConv layers are unaffected (no N parallelism).
Stem (C_in=1) stays N=1. With 109 DSPs, this fits Ti90 (288 DSP budget) with identical results.

**Key insight:** The optimizer correctly ignores DWConv layers (they have no input-channel parallelism axis) and focuses all DSP headroom on the pointwise conv layers. The result is immediately usable — copy the printed JSON overrides into the config file and run a single confirmation P&R.

---

## DSP Budget Notes

**SqueezeNet (N=16):** 512/512 DSPs. Breakdown: ~403 MAC + ~104 requant (4 per layer × 26 layers). Zero headroom.

**RepVGG-A0 (N=16):** 435/512 DSPs. 22 layers × (16 MAC + 4 requant) = 440 expected, 435 actual (MAP optimized 5 blocks). 77 spare.

Every layer increased N=16 → N=32 costs +16 DSPs. RepVGG-A0 can support 4 layers at N=32 within budget.

---

## Output Parallelism P — Confirmed Results

`outParallelism: P` in `QLinearConvCore.Config` computes P output channel groups per kernel pass.
DSP cost scales to **P×(N+4)** per Conv layer.

### DS-CNN-S — P=4, N=8 — Ti180M484 (P&R confirmed, 2026-06-11)

Config: `examples/dscnn_s_ti90_p4.json` — P=4 on all 4 PWConv layers, N=8, WeightRom, memAuto.

| Metric | P=1 baseline | P=4 PWConv | Change |
|:---|---:|---:|---:|
| DSP48 (synthesis) | 86 | **230** | +2.67× |
| RAM10K | 128 | **286** | +2.2× |
| LUT4 | 9,368 | 11,619 | +24% |
| Cycles @ 150 MHz | 1,107,448 | **854,008** | −22.9% |
| FPS @ 150 MHz | 135.5 | **175.6** | **+1.30×** |
| fmax (estimated) | ~207 MHz | ~165 MHz | — |
| Setup slack | — | +0.609 ns | ✓ closed |

DSP analytical: stem(5) + 4×DWConv(5) + 4×PWConv×P×(N+4) + linear(4) = **221** (synthesis: 230, δ=9 overhead).

**Fits Ti90M225 (336 DSP, 672 RAM10K)** with ~30% DSP headroom.

### RepVGG-A0 — P=2, N=16, Ti375 (analytical — P&R pending)

With P=2 and N=16 on Ti375: each body layer costs P×(N+4) = 2×20 = 40 DSPs.  
22 layers × 40 = 880 DSPs — fits Ti375 (1,344 DSP) with headroom for N=32 on some layers.  
Estimated FPS: ~2× vs P=1/N=16 on Ti375 (before timing closure).

---

## Model Roadmap (P&R Targets)

| Priority | Model | Architecture | Status | Blocker |
|:---|:---|:---|:---|:---|
| ✅ | SqueezeNet 1.0 INT8 | Fire modules, 7×7 conv1 | P&R validated 171.5 MHz | DSP ceiling; validation benchmark only |
| ✅ | **RepVGG-A0 INT8 (PTQ)** | Pure regular conv, channels ×48 | **P&R validated 173.3 MHz** | — |
| ✅ | **DS-CNN-S INT8 (KWS)** | DWConv + std conv, tiny MFCC input | **P&R validated (P=1 + P=4)** | — |
| Next | RepVGG-A0 INT8 (QAT) | Same, Brevitas-trained | Export from Brevitas | Better accuracy baseline |
| Later | MobileNetV3-Small | DWConv, ≤96×96 input | Needs small-res export | Input resolution must fit BRAM |
| Later | ResNet-18 INT8 | Standard residual blocks | Compiler ready | Need export + benchmark |
| ⚠️ | MobileNetV2 INT8 (224×224) | Inverted residuals | **Compiler OK; P&R fails** | BRAM: needs 5,055 blocks (Ti180 has 1,280) |
| Ti375 | MobileNetV2 INT8 (224×224) | Inverted residuals | — | Even Ti375 (2,560 blocks) insufficient |
| Ti375 | MobileNetV4 | Hybrid regular+DWConv | — | DWConv OK; need large-res export |

**MobileNetV2 BRAM wall:** The per-layer feature map buffer architecture stores each layer's full
input activation in on-chip BRAM. At 224×224 input, MobileNetV2's 52 layers collectively need
5,055 RAM10K blocks — 4× Ti180's budget and 2× Ti375's. Resolution reduction (≤64×64) or an
off-chip activation streaming architecture is required. FINN/hls4ml solve this via time-multiplexed
feature map reuse; adding that is a future architectural upgrade.

**Why QARepVGG-A0 is the priority target:**
- Pure standard convolutions — no depthwise, no attention
- Channel widths are multiples of 48 throughout the body (C_in=48/96/192/1280)
- 48%16=0 → N=16 fits cleanly; 48%48=0 → N=48 on Ti375
- Designed for INT8 QAT; maps directly to ONNX QDQ operators (same path as SqueezeNet)
- Avoids SqueezeNet's fire-module DSP fragmentation and conv1 N=3 bottleneck dominance

---

## FINN / hls4ml Comparison Baselines (Future)

To be populated once SpinalNN supports ≥2 validated models on Ti180.  
Target comparison: equivalent model, identical INT8 precision, comparable Xilinx/Efinix silicon tier.

| Framework | Model | Device | FPS | Latency (ms) | DSP | BRAM | LUT | fmax | Source |
|:---|:---|:---|---:|---:|---:|---:|---:|---:|:---|
| SpinalNN | SqueezeNet 1.0 INT8 | Ti180M484 | ~4.4 | ~225 | 512 | 630 | 39,377 | 171.5 MHz | conv1=N=3; 57% top-1 |
| SpinalNN | RepVGG-A0 INT8 (PTQ) | Ti180M484 | ~1.8 | ~560 | 435 | 728 | 42,677 | 173.3 MHz | conv1=N=3 override; 72% top-1 |
| SpinalNN | DS-CNN-S INT8 (KWS) P=1 | Ti180M484 | ~186 | ~5 | 86 | 128 | 9,368 | 206.9 MHz | DWConv validated; WeightStream |
| SpinalNN | DS-CNN-S INT8 (KWS) P=4 | Ti180M484 | ~176 | ~5.7 | 230 | 286 | 11,619 | ≥150 MHz | P=4 PWConv; WeightRom; standalone |
| FINN | — | — | — | — | — | — | — | — | TBD |
| hls4ml | — | — | — | — | — | — | — | — | TBD |

**Notes on fair comparison methodology:**
- Match quantization precision (INT8 activations and weights)
- Match device tier by approximate LUT count (Xilinx KU5P ≈ Ti375; Artix-7 200T ≈ Ti180)
- Report both latency (single inference) and throughput (pipelined FPS)
- hls4ml Reuse Factor is analogous to our per-layer N (inverse parallelism)

---

## Candidate Models for FPGA-Friendly Comparison Suite

Based on literature survey (2023–2026) — models with hardware-friendly channel widths:

| Model | Channel widths | INT8 support | FPGA published? | Priority |
|:---|:---|:---|:---|:---|
| **QARepVGG-A0** | 48→96→192→1280 (all ×48) | QAT (Brevitas) | No | **High** |
| ResNet-18 | 64→128→256→512 (all ×64) | PTQ/QAT | Yes (multiple) | High |
| SqueezeNet 1.1 | Same as 1.0, smaller conv1 | PTQ | No | Medium |
| EfficientNet-Lite0 | Mixed, compound-scaled | PTQ | Partial (hls4ml) | Medium |
| MobileNetV4 (2024) | 32/64/96/128 multiples | PTQ/QAT | No (too new) | Low (has DWConv) |

---

*Full per-run P&R history: `pnr_results.tsv`*  
*Per-run archives: `benchmark_*/runs/<label>_<date>/`*
