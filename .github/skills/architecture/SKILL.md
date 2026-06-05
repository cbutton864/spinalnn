---
name: architecture
description: 'Core/Plugin/Trait pattern for spinalnn inference operators. Use when writing a new operator, adding a stage boundary, or debugging elaboration.'
argument-hint: 'new operator, trait boundary, two-phase rule, handle deadlock'
user-invocable: true
---

# spinalnn Architecture Pattern

Every inference operator has exactly three parts: a Core, a Plugin, and a trait.
RTL lives in Cores. Wiring lives in Plugins. Stage boundaries are traits.

---

## Core Pattern

Stateless `object`. `build()` accepts elaboration-time config and runtime signals.
Returns `case class Io` (never a Bundle). All registers inside `PrefixArea`.

```scala
object MaxPoolCore {
  case class Config(periphName: String, inputShape: TensorShape, outputShape: TensorShape)
  case class Io(activationOut: Stream[Activation])

  def build(cfg: Config, activationIn: Stream[Activation] = null): Io = {
    require(activationIn != null, "activationIn is required")
    val logic = new PrefixArea(cfg.periphName) {
      // Mem, Reg, FSM, combinational logic here
    }
    Io(activationOut = logic.activationOut)
  }
}
```

Rules:
- `object`, not `class`
- `case class Io`, not `Bundle`
- All `Reg` and `Mem` inside `PrefixArea(periphName)` for flat Verilog naming
- `require()` guards before any hardware is created
- No `Component` instantiation inside `build()`

---

## Plugin Pattern

`case class` extending `FiberPlugin`. Handles declared outside `during build`.
All RTL calls inside `during build new Area`.

```scala
case class MaxPoolPlugin(cfg: MaxPoolCore.Config, buildEnv: BuildEnv = BuildEnv())
    extends FiberPlugin with ActivationSource {

  val activationOut: Handle[Stream[Activation]] = Handle()
  val outputShape:   TensorShape                = cfg.outputShape

  val logic = during build new Area {
    val upstream = host[ActivationSource].activationOut.await
    val core     = MaxPoolCore.build(cfg, upstream)
    activationOut.load(core.activationOut)
  }
}
```

Rules:
- Only Handle declarations outside `during build`
- No `Reg`, `when`, or signal assignments outside `during build`
- Consume upstream via `host[SomeTrait].handle.await`
- Publish result via `handle.load()`

---

## Stage Boundary Traits

Decouple producers from consumers. Downstream operators consume traits, not concrete types.

```scala
trait ActivationSource {
  val activationOut: Handle[Stream[Activation]]
  val outputShape:   TensorShape   // elaboration-time, no Handle needed
}

trait NetworkOutput {              // only the final layer implements this
  val networkOut:  Handle[Stream[Activation]]
  val outputShape: TensorShape
}
```

Swap any layer by changing one line in `Params` -- nothing downstream changes.

---

## Two-Phase Rule (TopIoExportPlugin)

Phase 1: load all inputs. Phase 2: await all outputs. Never mix the order.

```scala
// Phase 1: load inputs (non-blocking)
Try(host[InputPlugin]).toOption.foreach { p =>
  p.activationIn.load(top.io.activationIn.toStream)
}

// Phase 2: await outputs (blocking)
Try(host[NetworkOutput]).toOption match {
  case Some(out) => top.io.activationOut << out.networkOut.await
  case None      => top.io.activationOut.valid := False
                    top.io.activationOut.payload.value := 0
}
```

Calling `.await` before all `.load` calls completes causes a Fiber deadlock.
The error message says timeout, not deadlock.

---

## Scope & Direction

Read these before proposing structural changes. Full rationale + phased roadmap:
[docs/ARCHITECTURE_DIRECTION.md](../../../docs/ARCHITECTURE_DIRECTION.md).

- **Not tied to the Efinix T20.** T20 is a convenient small bring-up target, not the
  ceiling. spinalnn targets the full FPGA size range. Do not assume an ML-on-T20 goal
  or a vision-only / MNIST-only scope.
- **Primary input is pre-quantized ONNX.** QOperator nodes (e.g. QLinearConv) carry
  `x_scale` / `w_scale` / `y_scale` inline — read them directly, no calibration. Float
  ONNX + manual calibration is the secondary path.
- **This Core/Plugin/Trait pattern is the operator plugin system.** The ONNX compiler's
  job is to *generate* the same wiring you write by hand in `Params`. Grow capability by
  adding operators, not by rewriting.
- **Generalization seam:** ONNX -> graph walk -> small Scala IR (`Seq[LayerSpec]`, one
  case class per op) -> op-registry dispatch (`Map[opType, LayerSpec => FiberPlugin]`).
  Granularity belongs in the compiler, not in fragmenting Cores. Core = one ONNX op.
- **DAGs need multi-input plugins:** extend the upstream constructor arg to
  `Seq[Handle[Stream[Activation]]]` for Concat / Add / skip connections.
- **Dataflow schedule** (store-then-compute vs line-buffer streaming) is a per-stage
  axis, like `BuildEnv` flat/hierarchical. Stream conv/pool; buffer FC/reductions.
