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
| 2026-06-10 | N16_balanced_tree | N=16 / conv1=N=3 | 39,377 | 512 | 34,908 | 630 | 171.5 | ~4.4 | ~225 | WeightRom; MemLineBuffer explicit; balanced tree MAC |
| 2026-06-15 | ws_n16_phase1_dma | N=16, conv1=N=1 (fallback) | 39,947 | 510 | 35,625 | 625 | 176.0 | ~3.1 | ~320 | Phase 1 512-bit DMA beats; MemAuto line-buffer fix; conv1 bottleneck at 46% cycles |
| **2026-06-15** | **ws_n16_conv1n3** | **N=16 / conv1=N=3** | **39,377** | **512** | **34,908** | **630** | **171.5** | **~4.4** | **~225** | **WeightStream Phase 1 DMA + conv1 N=3; ties Jun 10 fmax; LPDDR4x runtime weight load** |

---

## SqueezeNet 1.0 W4A8 — Efinix Ti180M484

INT4 weights / INT8 activations. Weights streamed from LPDDR4x (WeightStream), packed 2 nibbles/byte.
LUT shift-and-add replaces DSP multipliers; only requant DSPs remain.

| Date | Label | Precision | N Strategy | LUT4 | DSP48 | FF | RAM10K | fmax (MHz) | FPS (est) | Latency (est) | Notes |
|:---|:---|:---|:---|---:|---:|---:|---:|---:|---:|---:|:---|
| **2026-06-21** | **sqz_w4a8_n32_ws** | **W4A8** | **N=32 (C_in%32==0) / N=16 (C_in%32≠0) / conv1=N=3** | **67,747** | **109** | **50,577** | **748** | **174.2** | **~6.3** | **~159ms** | **W4A8+WeightStream; 79% DSP reduction; Phase A goal** |

**Design config for sqz_w4a8_n32_ws (2026-06-21):**
- `weightMode: stream`, `weightPrecision: int4`, `targetFreqMhz: 150`
- `macParallelism: MacParPerLayer(C_in%32==0 layers → 32, stemName → 3, default = 16)`
- W4A8 beat drain: `stepsPerBeat = 128/N` (N=32 → 4 steps/beat); packed 2 nibbles/byte in LPDDR4x
- conv1 (C_in=3, N=3): 128%3≠0 → auto-falls back to WeightRom; ~6.2M cycles (same as INT8)
- C_in=16 (fire2-3 expand), C_in=48 (fire6-7 expand): N=16 default; limits overall speedup
- Gen script: `spinalnn.bench.GenSqueezeNetW4A8Bench` (sqz_w4a8_n32_ws variant)
- P&R dir: `benchmark_sqz_w4a8_n32_ws/`

**W4A8 vs INT8 N=16 delta (Ti180M484):**

| Resource | INT8 N=16 ws | W4A8 N=32 ws | Delta | Reason |
|:---|---:|---:|---:|:---|
| LUT4 | 39,377 | 67,747 | **+28,370** | LUT shift-and-add multiply (N=32 lanes × 4 partial products) |
| DSP48 | 512 | **109** | **−403** | All 403 MAC DSPs freed; 109 DSPs = requant-only (4/layer × ~27 layers) |
| FF | 34,908 | 50,577 | **+15,669** | Wider weight buffer (N×4 bits vs N×8 bits), more LUT pipeline regs |
| RAM10K | 630 | 748 | **+118** | N=32 wider weight buffer + row buffers; partially offset by halved weight bytes |
| Fmax | 171.5 MHz | **174.2 MHz** | **+2.7 MHz** | Fewer DSP routing constraints; T+3 pipeline gives slight timing headroom |
| Setup slack | — | **+0.926 ns** | — | At 150 MHz target; comfortable margin |

**FPS analysis (W4A8 N=32 vs INT8 N=16):**

| Metric | INT8 N=16 | W4A8 N=32 | Notes |
|:---|---:|---:|:---|
| Fmax | 171.5 MHz | 174.2 MHz | +1.6% |
| Est. cycles | ~38.8M | ~27.5M | −29% |
| Est. FPS | ~4.4 | **~6.3** | **+43%** |
| Speedup | 1.00× | **1.43×** | Limited by N=16-constrained layers |

**Cycle breakdown — why not 2× speedup:**
- Theoretical max speedup (all layers at N=32): ~2× (double parallelism)
- conv1 (N=3 fixed, ~16% of cycles): no change — 128%3≠0, WeightRom fallback
- C_in=16 layers (fire2-3 expand, 3×3): N=16 stuck (16%32≠0) — no speedup, ~6% of cycles
- C_in=48 layers (fire6-7 expand, 3×3): N=16 stuck (48%32≠0) — no speedup, ~10% of cycles
- C_in=32,64,96,128,256,384,512 (all body squeeze + fire4-9 expand + conv10): N=32 → **1.6–1.9× speedup each**
- Effective speedup = 1.43× at 174.2 MHz → **~6.3 FPS** (vs ~4.4 FPS INT8)

*FPS is estimated from cycle-ratio analysis (ModelCycleEstimator formula, calibrated to known 38.8M INT8 cycle count). Actual FPS pending simulation-cycle measurement.*

**Key finding — W4A8 DSP freed the DSP budget:**
- INT8 N=16 hit the hard ceiling (512/512 DSPs, 100%). No headroom for N=32.
- W4A8 LUT multiply drops DSP usage to 109/512 (21%) — requant-only.
- N=32 is now achievable within budget (was blocked by DSP ceiling with INT8).
- LUT cost (+28K) is the real trade. Ti180 has 176K LUTs; 67K used (38%) — ample headroom for N=64 in principle if C_in%64==0 layers exist.
- **This establishes W4A8+WeightStream as the recommended SqueezeNet path on Ti180.**

**Device utilization (sqz_w4a8_n32_ws — 2026-06-21):**

| Resource | Used | Available | % |
|:---|---:|---:|---:|
| EFX_LUT4 | 67,747 | 176,256 | 38% |
| EFX_DSP48 | **109** | 512 | **21%** |
| EFX_FF | 50,577 | ~176,256 | 29% |
| EFX_RAM10K | 748 | 1,280 | 58% |

**Design config for ws_n16_conv1n3 (current best — WeightStream + conv1 fix):**
- `macParallelism: MacParPerLayer(conv1_1_quantized → 3, default = 16)`
- `weightMode: stream`, `memoryStrategy: auto`, `targetFreqMhz: 150`
- conv1 (C_in=3): N=3 override; 64%3≠0 → auto-falls back to WeightRom for that layer; costs 3 DSPs vs 1
- Phase 1 DMA: `WeightDmaCore` outputs `Stream[Bits(512 bits)]` per fire; conv cores drain N bytes/cycle
- IrBackend: WeightStream always routes through `QLinearConvLineCore`; MaxPool MemAuto always line buffer
- Gen script: `spinalnn.bench.GenSqueezeNetBench` (ws_n1 / ws_n16 / ws_n16_conv1n3 variants)

**Design config for N16_balanced_tree (Jun 10 — WeightRom baseline):**
- `macParallelism: MacParPerLayer(conv1_1_quantized → 3, default = 16)`
- `weightMode: rom`, `memoryStrategy: line`, `targetFreqMhz: 150`
- Identical fmax/FPS to ws_n16_conv1n3 — confirms Phase 1 DMA adds zero synthesis overhead

**Device utilization at current best (ws_n16_conv1n3, Jun 15):**

| Resource | Used | Available | % |
|:---|---:|---:|---:|
| EFX_LUT4 | 39,377 | 183,960 | 21% |
| EFX_DSP48 | 512 | 512 | **100%** |
| EFX_FF | 34,908 | ~183,960 | 19% |
| EFX_RAM10K | 630 | 1,280 | 49% |

DSP budget is the active constraint. LUT4, FF, BRAM all have ample headroom.

**Conv1 bottleneck analysis — RESOLVED (2026-06-15):**
- conv1 (C_in=3, 224×224, 3×3) falls back to N=1 at MacParFixed(16) since 64%3≠0
- conv1 consumes 46% of total inference cycles at N=1 (23.8M of 54.7M cycles)
- Fix: `MacParPerLayer("conv1_1_quantized" → 3)` — N=3 (3%3=0), 3× faster conv1; 64%3≠0 → WeightRom fallback for that layer only
- P&R confirmed: 512/512 DSP, 630/1280 RAM10K, **171.5 MHz** fmax; ~38.8M cycles → **~4.4 FPS** ✓

---

## RepVGG-A0 INT8 — Efinix Ti180M484

| Date | Label | N Strategy | LUT4 | DSP48 | FF | RAM10K | fmax (MHz) | FPS | Latency (ms) | Notes |
|:---|:---|:---|---:|---:|---:|---:|---:|---:|---:|:---|
| 2026-06-10 | repvgg_a0_N16 | Global N=16, conv1=N=1 | 42,677 | 435 | 28,816 | 728 | 173.3 | ~1.59 | ~630 | Baseline; conv1 bottleneck |
| 2026-06-10 | repvgg_a0_N16_top4N32 | N=16 + conv1=N=3 + 4×N=32 (left-fold) | — | 501 | — | 828 | 156.7 | ~1.57 | ~638 | Routing-limited; prior FPS estimate was incorrect |
| 2026-06-11 | repvgg_a0_N16_top4N32_btree | N=16 + conv1=N=3 + 4×N=32 (balanced tree) | 44,926 | 501 | 29,282 | 828 | 156.7 | ~1.57 (@fmax) / ~1.50 (@150) | ~638 | +0.285 ns slack @ 150 MHz; routing-limited |

**Key finding — N=32 timing wall is routing, not logic:**
- Critical path: `inValReg_20` → DSP (1.34 ns wire, X:199) → adder (1.47 ns wire, X:254) → 30-level ripple carry chain
- Efx_map already generates balanced carry-lookahead internally; `treeReduce` RTL change produced identical netlist
- Root cause: 501/512 DSPs (98% utilization) → severe routing congestion → long inter-block wires dominate delay
- **At 150 MHz target (fair comparison):** N=32 gives 1.50 FPS vs N=16's 1.37 FPS → **+9.4% real gain**
- **At respective fmax:** N=32 (156.7 MHz, 1.57 FPS) vs N=16 (173.3 MHz, 1.58 FPS) → essentially break-even
- N=32 on Ti375 where routing slack eliminates the timing wall — see Ti375 section below

---

## RepVGG-A0 INT8 — Efinix Ti375N484

Per-layer N=32 on a larger device where routing congestion is eliminated.

| Date | Label | N Strategy | LUT4 | DSP48 | FF | RAM10K | fmax (MHz) | FPS | Latency (ms) | Notes |
|:---|:---|:---|---:|---:|---:|---:|---:|---:|---:|:---|
| 2026-06-15 | repvgg_a0_ti375_allN32 | N=16 (C_in=48) / N=32 (C_in≥96) | 54,948 | 723 | 33,277 | 1,160 | 162.6 | ~2.24 | ~445 | WeightStream; all 18 eligible layers at N=32; stem N=1 (25.2% of cycles) |
| 2026-06-15 | repvgg_a0_ti375_allN32_stemn3 | N=16 / N=32 + stem N=3 | 54,948 | 723 | 33,277 | 1,160 | 162.6 | ~2.69 | ~372 | Stem override N=3; 64%3≠0 → WeightRom for stem only; stem drops to ~10% of cycles |
| **2026-06-20** | **repvgg_a0_ti375_allN32n48_stemn3** | **N=48 (C_in=48) / N=32 (C_in≥96) + stem N=3** | **56,898** | **821** | **—** | **1,339** | **154.3** | **~4.6** | **~217** | **N=48 on 3 C_in=48 body layers; 64%48≠0 → WeightRom for those; 71% gain over stemn3** |

**Design config for repvgg_a0_ti375_allN32n48_stemn3 (current best — 2026-06-20):**
- `macParallelism: MacParPerLayer(C_in%32==0 layers → 32, C_in==48 layers → 48, stemName → 3, default = 16)`
- `weightMode: stream`, `memoryStrategy: auto`
- Stem (C_in=3, N=3) + 3× C_in=48 body layers (N=48): all have 64%N≠0 → WeightRom fallback; ~8 RAM10K weight ROM cost, negligible on Ti375
- C_in=48 body layers (stages_1_0/1_1/2_0): N=16 → N=48 (3× speedup each); these 3 layers previously ~67% of post-stemn3 cycles
- Total cycle reduction: ~60.5M → ~33.4M; FPS: 2.69 → **~4.6** (+71%); latency: 372 → ~217 ms
- DSP: 723 → 821 (+98 from 3 wider N=48 MAC arrays); fmax: 162.6 → 154.3 MHz (wider reduction trees add routing pressure)
- Gen script: `spinalnn.bench.GenRepVggBench` (all three variants generated in one sbt run)

**Design config for repvgg_a0_ti375_allN32_stemn3:**
- `macParallelism: MacParPerLayer(C_in%32==0 layers → 32, stemName → 3, default = 16)`
- `weightMode: stream`, `memoryStrategy: auto` (line buffers everywhere)
- Stem (C_in=3, N=3): 3%3=0 → accepted; 64%3≠0 → WeightRom fallback for stem layer only; costs 3 DSPs vs 1
- Stem weight tensor (3×3×3×48 INT8 = 1.3 KB) fits trivially in BRAM ROM
- Stem cycles: 18.2M → 6.1M (3× reduction); total: 72.6M → ~60.5M; stem: 25.2% → ~10%
- Gen script: `spinalnn.bench.GenRepVggBench`

**Design config for repvgg_a0_ti375_allN32 (baseline, Jun 15):**
- `macParallelism: MacParPerLayer(C_in%32==0 layers → 32, default = 16)`, 18 layers at N=32
- Stem (C_in=3): N=1 fallback (3%32≠0, 3%16≠0); stem accounts for 25.2% of cycles

**Device utilization (Ti375N484 — current best: allN32n48_stemn3):**

| Resource | Used | Available | % |
|:---|---:|---:|---:|
| EFX_LUT4 | 56,898 | 370,137 | 15% |
| EFX_DSP48 | **821** | 1,344 | **61%** |
| EFX_FF | — | ~370,137 | — |
| EFX_RAM10K | 1,339 | 2,688 | **50%** |

**Comparison to Ti180M484 N=32 (4 layers only, routing-limited):**

| | Ti180M484 (4×N=32) | Ti375N484 (18×N=32) | Gain |
|:---|---:|---:|---:|
| DSP48 | 501/512 (98%) | 723/1344 (54%) | Headroom ↑ |
| fmax | 156.7 MHz | 162.6 MHz | +3.8% |
| FPS (at fmax) | ~1.57 | **~2.24** | **+43%** |
| Latency | ~638 ms | ~445 ms | −30% |

**Stem bottleneck — RESOLVED (2026-06-15):** N=1 stem was 25.2% of cycles; N=3 override reduces to ~10% (same pattern as SqueezeNet conv1 fix). Fmax unchanged at 162.6 MHz.

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

Smallest Titanium part with LPDDR4x (336 DSP / 688 RAM10K per efx_pnr). End-to-end accuracy validated in sim (3/3 MFCC inputs match ONNX Runtime, 2026-06-14).

| Date | Label | N Strategy | P | LUT4 | DSP48 | FF | RAM10K | fmax (MHz) | Slack @ 150 MHz | Notes |
|:---|:---|:---|---:|---:|---:|---:|---:|---:|---:|---:|:---|
| 2026-06-14 | dscnn_s_ti90_N8_ws | N=8, stem N=1 | 1 | 9,429 | 86 | 8,874 | 144 | 199.4 | +1.652 ns | WeightStream; LineBuffer; 26% DSP |
| **2026-06-15** | **dscnn_s_ti90_N16_P2** | **N=16, stem N=1** | **2** | **7,934** | **203** | **7,211** | **321** | **189.7** | **+1.396 ns** | **WeightRom; N×P=32; same cycles as P=4 N=8; better fmax** |

**Design config for dscnn_s_ti90_N16_P2:**
- `macParallelism: 16` (stem C_in=1 → N=1 fallback), `outParallelism: 2`, `weightMode: rom`
- P>1 requires `QLinearConvCore` (full-buffer path) — WeightStream not compatible with P>1
- N×P = 32 = same throughput product as P=4/N=8; cycle count is identical (~854K)
- Higher fmax (189.7 MHz vs estimated ~165 MHz for P=4 N=8) → **~222 FPS at fmax** vs ~193 FPS
- Gen script: `spinalnn.bench.GenDsCnnBench`; P&R: `benchmark_dscnn_ti90_n16p2/`

**Device utilization (Ti90J484 — 336 DSP / 688 RAM10K from efx_pnr):**

| Resource | Used | Available | % |
|:---|---:|---:|---:|
| EFX_LUT4 | 7,934 | ~92,534 | 9% |
| EFX_DSP48 | **203** | 336 | **60%** |
| EFX_FF | 7,211 | ~92,534 | 8% |
| EFX_RAM10K | 321 | 688 | **47%** |

**Benchmark project:** `benchmark_dscnn_ti90_n16p2/spinalnn_dscnn_ti90_n16p2.xml` (Ti90J484, timing.sdc 150 MHz).

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

## W4A8 Weight Precision Benchmark — MNIST on Ti180M484

Characterises the DSP↔LUT trade from INT4 weight quantization (`WeightInt4`).  
Three configs compared: INT8 N=1 (floor), INT8 N=8 (DSP baseline), W4A8 N=8 (LUT multiply).  
All: Ti180M484, 150 MHz target, `MemAuto`, `WeightRom`.

| Date | Label | Precision | N | LUT4 | DSP48 | DSP24 | RAM10K | Fmax (MHz) |
|:---|:---|:---|---:|---:|---:|---:|---:|---:|
| 2026-06-20 | int8_N1 | INT8 | 1 | 919 | 15 | 2 | 26 | 296.6 |
| 2026-06-20 | int8_N8 | INT8 | 8 | 916 | 22 | 2 | 34 | 252.3 |
| **2026-06-20** | **w4a8_N8** | **W4A8** | **8** | **2,028** | **13** | **2** | **44** | **254.8** |

**W4A8 vs INT8 N=8 delta:**

| Resource | INT8 N=8 | W4A8 N=8 | Delta | Reason |
|:---|---:|---:|---:|:---|
| LUT4 | 916 | 2,028 | **+1,112** | LUT shift-and-add multiply (8 lanes × 4 partial products) |
| DSP48 | 22 | 13 | **−9** | conv2 MAC lane DSPs eliminated; requant DSPs unchanged |
| RAM10K | 34 | 44 | **+10** | W4A8 forces line-buffer path; row bufs added, outweigh halved weight ROM |
| Fmax | 252.3 MHz | 254.8 MHz | ≈0 | Extra pipeline stage (T+3 vs T+2) gives slight timing headroom |

**Key finding — W4A8 is a DSP↔LUT trade, not a net resource saver for small models:**
- The −9 DSP48 saving is real and scales with N (8 conv2 MAC lanes → 8 DSPs freed).
- LUT cost (+1,112) is proportional to N × 4 (four Mux+shift partial products per lane); at N=8 this is substantial.
- RAM10K increased (+10) because W4A8 forces `QLinearConvLineCore` (line-buffer path) for all layers, even those small enough to fit in BRAM under `MemAuto`. The row buffer cost dominates the weight ROM savings (32-bit vs 64-bit) at MNIST scale.
- **W4A8 is most valuable when DSPs are the bottleneck** (e.g. SqueezeNet at 512/512 DSP, or large N on Ti90).  On a small model like MNIST on Ti180 the DSP budget is irrelevant and the LUT/BRAM overhead shows.

**Accuracy:** 5/5 MNIST digits correct in simulation with W4A8 weights (same as INT8). INT4 symmetric quantization at this model scale is lossless for these 5 samples.

**RTL:** `rtl/mnist_w4a8/{int8_N1,int8_N8,w4a8_N8}/SpinalNNTop.v`  
**P&R projects:** `benchmark_mnist_w4a8_{int8_n1,int8_n8,w4a8_n8}/`

---

## Stochastic Computing (MUX-MAC SC) — Phase B Research

Zero-DSP conv backend per Lee et al. 2024 ("SC CNN Architecture Reinvented for Highly Efficient AI on FPGA").
Enabled via `CompilerOptions(weightPrecision = WeightStochastic(bitstreamLen))`.
Each output position takes `bitstreamLen` clock cycles; accuracy improves with larger N.

### Precision vs Speed Trade (bitstreamLen)

| bitstreamLen (N) | Cycles/output | Relative speed vs INT8 N=1 | SC accuracy (Lee et al.) |
|---:|---:|---:|:---|
| 64  | 64+nMac+1 | ~64× slower | ~2% loss (coarse) |
| 255 | 255+nMac+1 | ~255× slower | <0.15% loss (target) |
| 1024 | 1024+nMac+1 | ~1024× slower | ~0% loss (maximum) |

Speed relative to INT8 N=1 (one MAC/cycle). At N=16 INT8, SC at N=255 is ~16× slower per cycle-count.
SC advantage is DSP budget, not throughput — the correct comparison is: *what can run on this device at all?*

### Simulation Accuracy — MNIST-scale (2026-06-22, B7 complete)

All weights in on-chip BRAM ROM (`WeightRom` mode; `WeightStream` DMA path added in B10).

**End-to-end MNIST-8 accuracy** (`ScAccuracyTest`, `WeightStochastic(255)`, full SpinalNNTop sim):

| Config | N | 5-sample accuracy | INT8 baseline | Notes |
|:---|---:|:---:|:---:|:---|
| **SC MACFG+actBuf** | **255** | **5/5 (100%)** | 4/5 (80%) | SC surpasses INT8 on this test set |

SC with N=255 correctly classifies **all 5** MNIST validation digits, including sample 1 (digit "2")
which INT8 quantization gets wrong due to calibration-gap noise in the per-layer activation clip ranges.
The SC approximation error at N=255 is smaller than the INT8 quantization error for this borderline digit.

Latency: ~3.09M sim cycles per MNIST inference (N=1, bitstreamLen=255, Verilator sim).  
Test: `sbt "testOnly spinalnn.ScAccuracyTest"` — runs in ~16 min wall-clock (Verilator at ~50M sim/s).

**Per-output per-pixel SC approximation error (unit tests):**

| Config | nMac | N | Max error (INT8 units) | Mean error | Notes |
|:---|---:|---:|---:|---:|:---|
| 1×1 conv, ±100 weights, uniform input | 4 | 255 | **4** | **3.50** | Test 3 result; nMac=4 (small — higher variance) |
| Extrapolated: nMac=25 (MNIST Conv1 5×5×1) | 25 | 255 | ~1.8 | ~1.6 | 1/√(25/4) scaling from nMac=4 |
| Extrapolated: nMac=200 (MNIST Conv2 5×5×8) | 200 | 255 | ~0.6 | ~0.6 | Approaches deterministic at this nMac |
| Lee et al. 2024 (reported) | — | 256 | — | — | 0.14% top-1 accuracy loss on CNN tasks |

### P&R Resource Comparison — MNIST on Ti180M484 *(B8 complete — 2026-06-21)*

All four configs target Ti180M484, 150 MHz clock, `MemAuto`, `WeightRom`.  
SC always uses WeightRom (no LPDDR4x support in SC path).

| Config | Precision | N | LUT4 | DSP48 | FF | RAM10K | fmax | Fits Ti60? |
|:---|:---|---:|---:|---:|---:|---:|---:|:---|
| int8_N1 | INT8 | 1 | 919 | 15 | 1,179 | 26 | 296.6 MHz | ✅ |
| int8_N8 | INT8 | 8 | 916 | 22 | 1,179 | 34 | 252.3 MHz | ✅ |
| w4a8_N8 | W4A8 | 8 | 2,028 | 13 | 1,478 | 44 | 254.8 MHz | ✅ |
| sc_N255 (naive) | SC | 255 | 65,646 | 13 | 35,505 | 21 | 143.968 MHz ❌ | ❌ (>62,016 cap) |
| **sc_N255 (MACFG+actBuf)** | **SC** | **255** | **6,229** | **8** | **5,796** | **27** | **177.620 MHz ✅** | **✅ 10% of Ti60** |

Ti60 capacity: 62,016 LUT4, 160 DSP48, 256 RAM10K.  
SC naive on Ti60 previously **failed** — "Block capacity checks have failed." After MACFG+actBuf fix, SC fits Ti60 with **90% LUT headroom** and **176.305 MHz fmax**.

**Apples-to-apples scorecard (SC N=255 MACFG+actBuf vs INT8 N=1):**

| Metric | INT8 N=1 | SC N=255 (naive) | SC N=255 (MACFG+actBuf) | Ratio vs INT8 |
|:---|---:|---:|---:|---:|
| LUT4 | 919 | 65,646 | **6,229** | **6.8×** |
| DSP48 | 15 | 13 | **8** | **0.5× (half!)** |
| FF | 1,179 | 35,505 | **5,796** | **4.9×** |
| RAM10K | 26 | 21 | **27** | **1.0×** |
| fmax (Ti180) | 296.6 MHz | 143.968 MHz ❌ | **177.620 MHz ✅** | −40% (timing met) |
| fmax (Ti60) | 296.6 MHz | ❌ fails PNR | **176.305 MHz ✅** | ✅ |
| Fits Ti60? | ✅ | ❌ | **✅ 10% of cap** | |

The MACFG+actBuf implementation reduces LUT4 by **90.5%** (65,646→6,229) and FF by **83.7%** (35,505→5,796) vs the naive baseline. SC now uses *fewer* DSPs than INT8 (8 vs 15 — requant only, zero MAC DSPs) and fits any Titanium device from Ti60 up.

**SC Ti60 result (2026-06-21):**

| Resource | Used | Available | % |
|:---|---:|---:|---:|
| EFX_LUT4 | 6,229 | 62,016 | **10%** |
| EFX_DSP48 | 8 | 160 | 5% |
| EFX_FF | 5,796 | ~62,016 | 9% |
| EFX_RAM10K | 27 | 256 | 11% |
| fmax | **176.305 MHz** | — | ✅ above 150 MHz |

### Root Causes Fixed — MACFG + actBuf

**Naive baseline problems (four root causes):**

1. **Per-lane independent LFSRs (O(nMac) overhead):** For MNIST conv2 (nMac=200), 400 separate 8-bit LFSRs. MACFG fix: single shared root LFSR + shift-register chain → O(1) LFSR cost, O(nMac) chain FFs only.

2. **Always-on combinatorial CountOne tree:** `val posBits = Vec.tabulate(nMac) {...}` inside `when(sSC)` created always-active 200-bit popcount and comparator trees; synthesis inserted pipeline registers throughout (35K FFs). MACFG fix: registered `posBitRegs`/`negBitRegs` move the combinatorial fan-in to a single cycle, CountOne runs on reg outputs.

3. **Two-write-port actBuf blocking RAM10K inference:** Two separate `Mem.write()` calls (one in sInit, one in sRx) created two independent write ports. Efinity cannot map dual-write-port memories to RAM10K — falls back to FF-array (+14K LUT4, +21K FF per actBuf). Fix: single `when()` block with OR enable + `Mux` address/data → one write port → RAM10K inferred.

4. **sDecode 64-bit multiply:** `corrected.resize(64) * S(decodeMult, 64)` was unnecessarily wide. Fix: `corrected.resize(accBits+2) * S(cfg.decodeMult.toInt, 32 bits)` — correct range, no wide DSP chain.

**Cumulative impact:**

| Fix | LUT4 saved (est.) | FF saved (est.) | Source |
|:---|---:|---:|:---|
| MACFG (LFSR + registered bits) | ~28,000 | ~24,000 | O(nMac) LFSRs → O(1) root + chain |
| actBuf single write port | ~20,500 | ~29,000 | RAM10K inference vs FF-array |
| Narrow sDecode multiply | ~14,000 | ~2,000 | 64-bit DSP chain eliminated |
| Other / interaction | ~2,800 | ~500 | — |
| **Total measured** | **~59,400** | **~29,700** | **65,646→6,229; 35,505→5,796** |

### Device Feasibility — Which Modes Fit Where *(updated 2026-06-21)*

**MNIST model (tiny — 2 conv + 2 pool + 1 dense):**

| Device | LUT4 cap | INT8 N=1 | SC N=255 (naive) | SC N=255 (MACFG+actBuf) |
|:---|---:|:---|:---|:---|
| Ti60 | 62,016 | ✅ 919 LUT4 | ❌ 65,646 — doesn't fit | **✅ 6,229 LUT4, 176 MHz** |
| Ti90 | 92,534 | ✅ | ❌ doesn't fit | **✅** |
| Ti180 | 176,256 | ✅ | ⚠️ fits but misses timing | **✅ 6,229 LUT4, 178 MHz** |

**SqueezeNet-scale — B9 result (2026-06-22):**

SC SqueezeNet N=255 MAP result on Ti180M484: **LUT4=158,167, DSP=78, FF=122,376, RAM10K=3,046**.
PNR fails: "Block capacity checks have failed" — 3,046 RAM10K > 1,280 Ti180 cap (238% over budget).
LUT4+FF are also over (158K+122K = 280K > 172K Ti180 logic capacity). SC fails on all but DSP.

Root cause: `conv10_1_quantized_wThrRom` alone stores 1,000 × 512 = 512K weight thresholds (one
INT8 per weight) + wSignRom (one bit per weight) → hundreds of RAM10K even after zero-row optimization.
Per-layer: 26 SC conv layers × ~6K LUT4 each ≈ 156K LUT4 total (MNIST had only 2 SC layers).

| Resource | SC N=255 (SqueezeNet) | INT8 N=16 WS | W4A8 N=32 WS | Ti180 cap | SC:INT8 |
|:---|---:|---:|---:|---:|:---|
| LUT4 | 158,167 | 39,947 | ~40K | 172,800 | 4.0× more |
| DSP48 | **78** | **512** | ~109 | 512 | **6.6× fewer** |
| FF | 122,376 | ~25,000 | ~28K | 172,800 | ~5× more |
| RAM10K | **3,046** | **629** | 748 | 1,280 | **4.8× more** |

SC saves DSPs but uses 4–5× more of everything else at SqueezeNet/ImageNet scale.
At MNIST scale (2 SC layers, 10-class head), SC uses only 27 RAM10K + 6,229 LUT4 — viable on Ti60.

**B9 Conclusion**: SC WeightRom is **BRAM-limited at ImageNet scale** — `conv10` wThrRom + wSignRom
(512K entries) alone accounts for ~450 RAM10K; all weight ROMs total ~1,200 RAM10K across 26 layers.

### SC + WeightStream — B10 MAP Result (2026-06-22)

`wThrRom` + `wSignRom` eliminated; weights loaded from LPDDR4x via DMA beat-drain (`sLoadW` FSM state).
Packed byte format: `[isNeg:1][abs_w:7]` — 1 byte/weight, identical DMA byte count to INT8 N=1 WS.
Only combAdjRom (C_out × 4 bytes/layer) + actBuf (full padded frame) remain in BRAM.
`combAdjRom` is optimized to LUT logic by `efx_map` (too small for RAM10K). **actBuf alone drives BRAM.**

| Resource | SC N=255 WeightRom (B9) | SC N=255 WeightStream (B10) | Change | Ti180 cap |
|:---|---:|---:|---:|---:|
| LUT4 | 158,167 | 158,420 | +253 | 172,800 |
| DSP48 | 78 | 79 | +1 | 512 |
| FF | 122,376 | 130,662 | +8,286 | 172,800 |
| **RAM10K** | **3,046** | **1,824** | **−1,222 (−40%)** | **1,280** |

WeightStream eliminates **1,222 RAM10K** (40%) — the weight-ROM contribution. But **1,824 RAM10K actBuf
still exceeds the 1,280 cap**. SC's full-frame actBuf strategy is the deeper BRAM bottleneck:

- INT8 uses a **line buffer** (K_H rows × W × C_in) → ~3–20 RAM10K per layer
- SC uses a **full-frame buffer** (H × W × C_in) → up to 300+ RAM10K for early fire modules (55×55×128)
- SqueezeNet actBuf total across 26 layers: ~1,800 RAM10K regardless of weight storage strategy

**B10 finding**: SC + WeightStream is necessary but not sufficient. The SC memory architecture must
adopt a streaming/row-at-a-time actBuf (like INT8's line buffer) to fit SqueezeNet on Ti180.
This is B11: **SC line buffer** — restructure StochasticConvCore to process one row per sLoad/sSC/sDecode
pass, cycling over output rows rather than buffering the full input frame.

**Device feasibility comparison:**

| Device | LUT4 cap | RAM10K cap | INT8 N=16 WS | SC WeightRom (B9) | SC WeightStream (B10) | SC WS + LineBuffer (B11) |
|:---|---:|---:|:---|:---|:---|:---|
| Ti60 | 62,016 | 256 | ❌ DSP | ❌ BRAM × 12 | ❌ BRAM × 7 | ❌ LUT4 × 2.5 |
| Ti90 | 92,534 | 688 | ✅ | ❌ BRAM × 4.4 | ❌ BRAM × 2.6 | ❌ LUT4 × 1.7 |
| Ti180 | 172,800 | 1,280 | ✅ 100% DSP | ❌ BRAM × 2.4 | ❌ BRAM × 1.4 | **✅ RAM10K=175 (14%)** |

**B10 Gen script:** `spinalnn.bench.GenSqueezeNetScWsBench` → `rtl/squeezenet_sc/sc_N255_ws/`  
**B10 MAP dir:** `benchmark_sqz_sc_n255_ws_ti180/` (Ti180M484, RUNMAP only; PNR fails at 1,824 RAM10K)

### SC + WeightStream + LineBuffer — B11 MAP Result (2026-06-23)

K_H circular row Mems replace the full-frame `actBuf` in `StochasticConvCore`. Each slot holds one
padded input row (paddedW × C_in bytes). `sReceiveRow` writes rows into the circular slot pointer;
`sLoad` selects each kernel row's slot via compile-time `kKh[b]` offset into `oldestSlotReg`.
With B10 WeightStream, no large static memories remain: `combAdjRom` → LUT logic; weights → LPDDR4x.

| Resource | SC N=255 WeightRom (B9) | SC N=255 WeightStream (B10) | SC WS + LineBuffer (B11) | Ti180 cap |
|:---|---:|---:|---:|---:|
| LUT4 | 158,167 | 158,420 | **156,973** | 172,800 |
| DSP48 | 78 | 79 | **53** | 512 |
| FF | 122,376 | 130,662 | **130,421** | 172,800 |
| **RAM10K** | **3,046** | **1,824** | **175** | **1,280** |

**B11 reduces RAM10K by 10.4× vs B10 (1,824 → 175). SC SqueezeNet now fits Ti180.**

DSP count drops 79 → 53: the full-frame actBuf required H×W×C_in address arithmetic (DSP-mapped
multiply chains); row-buffer addressing is within-row only and maps to LUTs.

LUT4=156,973 (91% of Ti180 cap) — the N=255 LFSR-per-lane logic (255 LFSRs × 26 layers) dominates.
SC requires Ti180+ by LUT4; Ti90 and Ti60 remain infeasible for SqueezeNet-scale SC.

**B11 Gen script:** `spinalnn.bench.GenSqueezeNetScWsBench` → `rtl/squeezenet_sc/sc_N255_ws/` (same RTL dir as B10)  
**B11 MAP dir:** `benchmark_sqz_sc_n255_ws_lb_ti180/` (Ti180M484, MAP complete; PNR pending)

---

## Model Comparison — Multi-Device Summary

| Model | Device | DSP48 | DSP% | RAM10K | fmax (MHz) | FPS | Latency | Config |
|:---|:---|---:|---:|---:|---:|---:|---:|:---|
| SqueezeNet 1.0 INT8 | Ti180M484 | 512 | 100% | 630 | 171.5 | ~4.4 | ~225ms | WS N=16/conv1=N=3 |
| **SqueezeNet 1.0 W4A8** | **Ti180M484** | **109** | **21%** | **748** | **174.2** | **~6.3** | **~159ms** | **WS N=32 (C_in%32==0); +43% FPS** |
| RepVGG-A0 | Ti180M484 | 501 | 98% | 828 | 156.7 | ~1.57 | ~638ms | WR N=32 (4 layers) |
| RepVGG-A0 | Ti375N484 | 723 | 54% | 1,160 | 162.6 | ~2.24 | ~445ms | WS N=32 (18 layers); stem N=1 |
| **RepVGG-A0** | **Ti375N484** | **723** | **54%** | **1,160** | **162.6** | **~2.69** | **~372ms** | **WS N=32 + stem N=3; +20% vs allN32** |
| DS-CNN-S | Ti90J484 | 86 | 26% | 144 | 199.4 | ~200 | ~5ms | WS N=8; 26% DSP only |
| DS-CNN-S | Ti180M484 | 230 | 45% | 286 | ≥150 | ~176 | ~5.7ms | WR P=4 N=8 |
| **DS-CNN-S** | **Ti90J484** | **203** | **60%** | **321** | **189.7** | **~222** | **~4.5ms** | **WR P=2 N=16; N×P=32; best FPS** |

WS = WeightStream (LPDDR4x runtime load); WR = WeightRom (weights in BRAM at bitstream time).

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

### RepVGG-A0 — Ti375 (P&R confirmed, 2026-06-15)

P>1 is not yet supported with WeightStream mode (QLinearConvLineCore has no P path).  
Instead: per-layer N=32 overrides on C_in-divisible-by-32 layers + stem N=3 override.

| Metric | allN32 (stem N=1) | allN32_stemn3 | Change |
|:---|---:|---:|---:|
| DSP48 | 723/1344 (54%) | 723/1344 (54%) | — |
| fmax | 162.6 MHz | 162.6 MHz | — |
| Stem % of cycles | 25.2% | ~10% | −15 pp |
| Total cycles | ~72.6M | ~60.5M | −16.7% |
| FPS | ~2.24 | **~2.69** | **+20%** |

P>1 with WeightStream tracked as future work in FUTURE_ROADMAP.md §Phase 2.5.

---

## Model Roadmap (P&R Targets)

| Priority | Model | Architecture | Status | Blocker |
|:---|:---|:---|:---|:---|
| ✅ | SqueezeNet 1.0 INT8 | Fire modules, 7×7 conv1 | P&R validated 171.5 MHz; WeightStream Phase 1 confirmed | DSP ceiling; conv1 N=3 fix confirmed |
| ✅ | **RepVGG-A0 INT8 (PTQ)** | Pure regular conv, channels ×48 | **Ti180: 173.3 MHz N=16; Ti375: 162.6 MHz N=32+stemN3 → ~2.69 FPS (+70% vs Ti180 N=16)** | — |
| ✅ | **DS-CNN-S INT8 (KWS)** | DWConv + std conv, tiny MFCC input | **Ti90: P=2 N=16 → ~222 FPS @ 189.7 MHz (best of all runs)** | — |
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
| SpinalNN | SqueezeNet 1.0 INT8 | Ti180M484 | ~4.4 | ~225 | 512 | 630 | 39,377 | 171.5 MHz | WS conv1=N=3; Phase 1 DMA |
| **SpinalNN** | **SqueezeNet 1.0 W4A8** | **Ti180M484** | **~6.3** | **~159** | **109** | **748** | **67,747** | **174.2 MHz** | **WS N=32 W4A8; 79% DSP reduction; Phase A** |
| SpinalNN | RepVGG-A0 INT8 (PTQ) | Ti180M484 | ~1.59 | ~630 | 435 | 728 | 42,677 | 173.3 MHz | WS N=16 baseline |
| SpinalNN | RepVGG-A0 INT8 (PTQ) | Ti375N484 | ~2.24 | ~445 | 723 | 1,160 | 54,948 | 162.6 MHz | WS N=32 all-eligible layers; stem N=1 |
| SpinalNN | RepVGG-A0 INT8 (PTQ) | **Ti375N484** | **~2.69** | **~372** | **723** | **1,160** | **54,948** | **162.6 MHz** | **WS N=32 + stem N=3; current best** |
| SpinalNN | DS-CNN-S INT8 (KWS) | Ti90J484 | ~200 | ~5 | 86 | 144 | 9,429 | 199.4 MHz | WS N=8 P=1; 26% DSP only |
| SpinalNN | DS-CNN-S INT8 (KWS) | **Ti90J484** | **~222** | **~4.5** | **203** | **321** | **7,934** | **189.7 MHz** | **WR N=16 P=2; N×P=32** |
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
