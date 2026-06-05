---
name: operators
description: 'How to add a new inference operator (Core + Plugin + trait) to the spinalnn library.'
argument-hint: 'new conv variant, add relu, add linear layer, new pool type'
user-invocable: true
---

# Adding a New Operator

Follow this order. Validate each step before the next.

---

## Step 1: Write the Core

File: `src/main/scala/spinalnn/ops/{category}/{Name}Core.scala`

```scala
package spinalnn.ops.{category}

import spinal.core._
import spinal.lib._
import spinalnn.types._
import spinalnn.util.PrefixArea

object {Name}Core {

  case class Config(
    periphName:  String,
    inputShape:  TensorShape,
    outputShape: TensorShape
    // add operator-specific parameters here
  )

  case class Io(activationOut: Stream[Activation])

  def build(cfg: Config, activationIn: Stream[Activation] = null): Io = {
    require(activationIn != null, "activationIn is required")

    val logic = new PrefixArea(cfg.periphName) {
      // FSM, Mem, registers here
      // Streaming convention: HWC order (rows outermost, channels innermost)
      // Use store-then-compute for v0.1: RECEIVE -> COMPUTE -> back to RECEIVE
    }

    Io(activationOut = logic.activationOut)
  }
}
```

## Step 2: Write the Plugin

File: `src/main/scala/spinalnn/ops/{category}/{Name}Plugin.scala`

```scala
package spinalnn.ops.{category}

import spinal.core._
import spinal.core.fiber._
import spinal.lib._
import spinal.lib.misc.plugin._
import spinalnn._
import spinalnn.types._
import spinalnn.util._

case class {Name}Plugin(cfg: {Name}Core.Config, buildEnv: BuildEnv = BuildEnv())
    extends FiberPlugin with ActivationSource {

  val activationOut: Handle[Stream[Activation]] = Handle()
  val outputShape:   TensorShape                = cfg.outputShape

  val logic = during build new Area {
    val upstream = host[ActivationSource].activationOut.await
    val core     = {Name}Core.build(cfg, upstream)
    activationOut.load(core.activationOut)
  }
}
```

If the operator is the final layer, extend `NetworkOutput` instead of `ActivationSource`.

## Step 3: Write the Test Harness

File: `src/test/scala/spinalnn/testhelpers/{Name}Harness.scala`

```scala
class {Name}Harness(cfg: {Name}Core.Config) extends Component {
  val io = new Bundle {
    val activationIn  = slave(Stream(Activation()))
    val activationOut = master(Stream(Activation()))
  }
  val core = {Name}Core.build(cfg, io.activationIn)
  io.activationOut << core.activationOut
}
```

## Step 4: Write the Unit Test

File: `src/test/scala/spinalnn/ops/{Name}CoreTest.scala`

Test at minimum:
- Correct output count (outputShape.size elements)
- Known input/output pair for at least one configuration
- Reset and back-to-back inference behavior

## Step 5: Add to Params

```scala
def plugins: Seq[FiberPlugin] = Seq(
  InputPlugin(inputShape, buildEnv),
  // ... existing layers ...
  {Name}Plugin(cfg, buildEnv),
  TopIoExportPlugin()
)
```

## Step 6: Update ElaborationTest

Add a test case that elaborates the design with the new operator in the plugin list.

---

## Streaming Convention

All streams use HWC order:
```
(row0, col0, ch0), (row0, col0, ch1), ..., (row0, col1, ch0), ...
```

Producer sends `rows * cols * channels` activations.
Downstream stalls the producer by deasserting `ready`.
The Core must handle stall correctly in the EMIT state.
