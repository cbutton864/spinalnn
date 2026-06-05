# Project Guidelines: spinalnn

SpinalHDL plugin-based INT8 inference accelerator library.
Maps quantized ONNX models to synthesizable Verilog via a composable operator plugin library.

---

## Quick Reference

| Task | Command |
|---|---|
| Compile | `sbt compile` |
| Test | `sbt test` |
| Single test | `sbt "testOnly spinalnn.MaxPoolCoreTest"` |
| Generate Verilog | `sbt "runMain spinalnn.GenVerilog"` |
| Run ONNX parser | `.venv/bin/python3 tools/onnx_to_params.py <model.onnx>` |

---

## Architecture

Three-layer pattern. Every inference operator has a Core, a Plugin, and a trait.

**Core:** pure RTL. Stateless `object`. `build()` returns `case class Io`. No Bundles, no Components.
All registers inside `PrefixArea(periphName)` for deterministic flat Verilog naming.

**Plugin:** wiring only. `case class` extending `FiberPlugin`. Handles declared outside `during build`.
All RTL calls inside `during build new Area`. Consumes upstream via `host[Trait].handle.await`.

**Trait:** stage boundary contract. Downstream consumes the trait, not the concrete plugin.
Swapping a layer means one line change in `Params` -- nothing else changes.

---

## Key Rules

1. No RTL outside `during build`. No `Reg`, `when`, or signal assignments in the plugin class body.
2. `TopIoExportPlugin` runs in two phases. All `.load()` calls before any `.await()` calls. Violating this causes a Fiber deadlock -- the error says timeout, not deadlock.
3. Cores return `case class Io`, never `Bundle`.
4. Every `Reg` and `Mem` inside a `PrefixArea(periphName)` block.
5. `Params.plugins` is a `def`, not a `val`. Fresh instances on every elaboration call.
6. `Test / parallelExecution := false` must stay false. Verilator cache conflicts.

---

## Streaming Convention

Data flows between layers as `Stream[Activation]` in HWC order:
```
(row0, col0, ch0), (row0, col0, ch1), ..., (row0, col1, ch0), ...
```

Producer sends `rows * cols * channels` INT8 activations.
Downstream stalls by deasserting `ready`. Cores must handle backpressure in the EMIT state.

---

## Quantization

All operators use INT8 symmetric quantization.
Scale factors are pre-computed at elaboration time as `RequantScale(multiplier: Long, shift: Int)`.
Hardware computes: `output = clamp((acc * multiplier) >> shift + zp_out, -128, 127)`.
The Python ONNX parser (`tools/onnx_to_params.py`) handles scale computation automatically.

---

## Docs

- [docs/BUILD_PLAN.md](docs/BUILD_PLAN.md) -- phased build plan and operator priority
- [docs/PATTERN_GUIDE.md](docs/PATTERN_GUIDE.md) -- human-readable architecture overview
