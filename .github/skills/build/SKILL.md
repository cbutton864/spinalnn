---
name: build
description: 'sbt commands for compiling, testing, and generating Verilog for spinalnn.'
argument-hint: 'compile, test, generate verilog, run single test'
user-invocable: true
---

# Build Commands

## Compile

Validates Scala syntax and SpinalHDL types. No RTL generated.

```bash
sbt compile
```

## Run All Tests

Elaboration smoke test plus all operator unit simulations.
Parallel execution is disabled -- Verilator builds conflict on shared cache paths.

```bash
sbt test
```

## Run One Test

```bash
sbt "testOnly spinalnn.MaxPoolCoreTest"
sbt "testOnly spinalnn.QLinearConvCoreTest"
sbt "testOnly spinalnn.ElaborationTest"
```

## Generate Verilog

Writes flat and hierarchical outputs to `rtl/`.

```bash
sbt "runMain spinalnn.GenVerilog"
```

## Run ONNX Parser

Reads a quantized ONNX model, emits `Params.scala` and weight arrays to `src/main/scala/spinalnn/generated/`.

```bash
.venv/bin/python3 tools/onnx_to_params.py models/squeezenet1.0-12-int8.onnx
```

Regenerate Verilog after parsing:

```bash
sbt compile && sbt "runMain spinalnn.GenVerilog"
```
