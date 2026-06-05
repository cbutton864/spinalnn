# spinalnn: An FPGA Inference Accelerator

## What This Is

spinalnn is a library for running trained machine learning models directly on FPGA hardware.

You give it a trained model. It generates synthesizable Verilog. Flash that to an FPGA and the model runs in hardware, with no CPU involved in the computation path.

The target use case is edge inference: classifying sensor data in real time on a small, low-power chip. Think voice detection, gesture recognition, anomaly detection in industrial sensors. Anything that needs to make a decision fast with a small power budget.

---

## Target Scope

spinalnn spans the full FPGA size range -- from a tiny Trion T20 running a 1D biometric
model to a large Agilex / UltraScale+ running a vision backbone. The T20 examples in
these docs are a convenient small bring-up target, **not** the design ceiling, and the
project is not vision-only: non-visual models (audio keyword spotting, ECG / IMU
biometrics, anomaly detection) are first-class targets.

The primary input is **pre-quantized** ONNX (the scale factors are read directly off the
model); float models are supported as a secondary path with a little manual calibration.
For where the architecture is headed -- a general ONNX frontend, multi-input graphs, and
a streaming dataflow option -- see [ARCHITECTURE_DIRECTION.md](ARCHITECTURE_DIRECTION.md).

---

## The Problem: Running ML on an FPGA

A trained neural network is usually run on a GPU or a CPU using a software framework like PyTorch. That works well in a data center. It does not work at the edge. GPUs need too much power and cost too much per unit. CPUs are flexible but slow for this kind of math.

An FPGA occupies the middle ground. It is a chip full of programmable logic. You describe a circuit, compile it, and load it onto the chip. The circuit is now hardwired to do exactly the computation you described. No instruction fetching, no memory hierarchy, no operating system. Just pure parallel arithmetic running at 150 million cycles per second or more.

The tradeoff: FPGAs are harder to program than a GPU. That is what this library solves.

---

## How a Neural Network Works in Hardware (Simplified)

A trained CNN has a fixed stack of mathematical operations called layers. Each layer takes in a tensor of numbers (the activations), does some math, and produces a new tensor. The output of one layer is the input to the next.

The three most common operations in a CNN are:

**Convolution.** Slides a small filter (say, 3x3) across an input image or feature map. At each position, it multiplies the filter weights by the input values and sums them up. The output is a transformed feature map that captures patterns at different scales.

**Pooling.** Reduces the spatial size of a feature map by taking the maximum or average value in small windows. A 2x2 max pool on a 24x24 input gives a 12x12 output. This makes downstream layers cheaper.

**Fully connected (Linear).** Multiplies an input vector by a weight matrix to produce an output vector. Used at the end of a CNN to turn a spatial feature map into a class prediction.

In hardware, these are all variations on one operation: multiply two numbers and add the result to a running total. The running total is the accumulator. At the end, you adjust it with a scale factor and clip it to a valid range. That is the entire math.

---

## INT8 Quantization: Why We Use It

A trained network typically stores its weights and activations as 32-bit floating-point numbers. On an FPGA, 32-bit floating-point multiply is expensive -- it takes significant logic and runs slowly.

INT8 quantization converts weights and activations to 8-bit signed integers. The math is simpler, faster, and uses far fewer resources. Two 8-bit multiplies fit in one DSP block on most FPGAs. The tradeoff is a small reduction in accuracy, which is usually acceptable for inference.

The conversion involves two parameters per tensor: a scale factor and a zero point. Together they map the range of INT8 values (-128 to 127) onto the original floating-point range. This mapping is computed during training or calibration and is fixed at inference time.

The formula:
```
real_value = (int8_value - zero_point) * scale
```

In hardware, we never convert back to floating point. Instead, we precompute a combined scale factor (called the requantization multiplier) that maps the INT32 accumulator output directly back to an INT8 output. No floating-point hardware is needed anywhere in the inference path.

---

## The Operator Library: The Building Blocks

spinalnn provides a library of hardware operators. Each operator implements one layer type. Each operator is self-contained, tested in isolation, and composable with any other operator.

The current set:

| Operator | What it does |
|---|---|
| QLinearConv | INT8 2D convolution (the main workhorse) |
| MaxPool | Spatial downsampling via max value |
| ReLU | Element-wise: replace negative values with zero |
| Flatten | Reshape a 3D feature map to a 1D vector |
| QLinearLinear | INT8 fully-connected layer |
| Softmax | Find the highest-confidence class (argmax) |
| InputPlugin | Entry point: receives data from the outside world |
| NetworkOutputPlugin | Exit point: delivers the result to the output port |

These are the Lego bricks. A neural network is just a specific arrangement of these bricks connected in sequence.

---

## How Data Flows Through the Hardware

Data moves between operators as a stream of 8-bit signed integers. The stream carries one value per clock cycle.

The ordering convention is HWC: height outermost, channels innermost. For a 4x4 feature map with 2 channels, the stream delivers:
```
(row 0, col 0, ch 0), (row 0, col 0, ch 1),
(row 0, col 1, ch 0), (row 0, col 1, ch 1),
...
(row 3, col 3, ch 0), (row 3, col 3, ch 1)
```

The stream uses a valid/ready handshake. The producer asserts valid when it has data. The consumer asserts ready when it can accept data. Both must be true for a transfer to happen. This is called backpressure: a slow downstream stage automatically slows down upstream stages.

Most operators work in two phases:

**Receive.** Accept the entire input feature map and store it in on-chip block RAM.

**Compute.** Iterate through the output positions, do the math, and stream the results out.

ReLU is an exception. It is purely combinatorial: each input value is transformed and passed to the output in the same clock cycle. No buffering needed.

---

## How the Hardware Is Organized

Three layers of abstraction. Each one has a single job.

### Layer 1: The Core

The Core is where the actual RTL logic lives. It is a Scala function that generates hardware. You call it with a configuration and a stream of input activations, and it returns a stream of output activations.

The Core does not know anything about the rest of the system. It does not know what is upstream or downstream. It just does math.

Example signature:
```
QLinearConvCore.build(
  config: Config,        // kernel size, quantization params, weights
  activationIn: Stream   // the incoming activation stream
) -> Io(activationOut: Stream)
```

### Layer 2: The Plugin

The Plugin connects a Core into the network. It declares what it consumes (the upstream activation stream) and what it produces (the output activation stream). It calls the Core with the resolved upstream data.

Plugins do not contain any math. They are wiring. The only thing a Plugin does is: wait for its upstream data to be ready, call its Core, and announce that its output is available.

Critically, operator Plugins receive their upstream stream as a constructor argument. This means the same Plugin type can appear multiple times in a network without any naming conflicts. The second Conv layer is just another `QLinearConvPlugin` receiving the first Pool layer's output as its input argument.

### Layer 3: Params

Params is the network topology. It instantiates the plugins in order and connects each one to its upstream.

```scala
val input   = InputPlugin(inputShape)
val conv1   = QLinearConvPlugin(conv1Config, input.activationOut)
val relu1   = ReLUPlugin(conv1Config.outputShape, conv1.activationOut)
val pool1   = MaxPoolPlugin(pool1Config, relu1.activationOut)
val linear1 = QLinearLinearPlugin(linearConfig, pool1.activationOut)
val softmax = SoftmaxPlugin(softmaxConfig, linear1.activationOut)
```

This is the complete wiring diagram for a simple CNN classifier. Six lines. Swap any line for a different operator and the rest of the network is unchanged.

---

## The Build Process: From Trained Model to Hardware

### Step 1: Train a model

Use PyTorch, TensorFlow, or any standard ML framework. Train with INT8-aware quantization. Export to ONNX format, which is a standard interchange format supported by all major frameworks.

```bash
# Example using PyTorch
torch.onnx.export(model, dummy_input, "model.onnx", ...)
```

### Step 2: Parse the model (Python)

The ONNX parser reads the model file, walks the graph of operators, and generates two Scala files:

- `ModelParams.scala` -- the network topology (equivalent to the Params example above, but generated automatically from the ONNX graph)
- `ModelWeights.scala` -- all the weight arrays as Scala byte arrays

```bash
python3 tools/onnx_to_params.py models/my_model.onnx
```

This is the translation step. It reads the ONNX graph edges (which operator feeds which) and generates the Handle references that wire the plugins together.

### Step 3: Compile the Scala

SpinalHDL is a hardware description library written in Scala. The Scala code does not run on the FPGA -- it generates hardware. Running the Scala code elaborates (constructs) the circuit and emits Verilog.

```bash
sbt compile            # type-check the Scala
sbt "runMain spinalnn.GenVerilog"   # generate Verilog
```

The Verilog lands in `rtl/flat/` and `rtl/hierarchical/`.

### Step 4: Synthesize the Verilog

Feed the generated Verilog to your FPGA toolchain (Xilinx Vivado, Intel Quartus, Efinix Efinity, etc.). The tool maps the circuit onto the physical FPGA resources: logic cells, block RAMs, and DSP multiplier blocks.

```bash
# Example with Vivado
vivado -mode batch -source synth.tcl
```

### Step 5: Flash and run

Load the bitstream onto the FPGA. Connect your sensor data to the activation input port and read classification results from the output port.

---

## What You Can Tune

Two knobs matter most.

**macParallelism.** Controls how many multiply-accumulate operations happen per clock cycle in each Conv layer. Setting this to 1 gives the simplest hardware. Setting it to 8 uses 4 DSP blocks and runs 4x faster. Setting it to 16 uses 8 DSP blocks and runs 8x faster.

The constraint: `macParallelism` must divide the number of input channels evenly. For a layer with 8 input channels, valid choices are 1, 2, 4, or 8.

Resource guidance: a Zynq-7020 has 220 DSP blocks. A reasonable starting point is macParallelism = 16 (8 DSP blocks per Conv layer), leaving plenty of DSPs for other logic.

**Flat vs hierarchical Verilog.** The flat build puts all logic in one module. This gives the synthesis tool global visibility and usually produces better timing results. The hierarchical build creates a separate module per operator, which makes waveform debugging easier. Both build from the same source code with one parameter change.

---

## What the Output Looks Like

After running GenVerilog, you get a Verilog file with a clean port interface:

```verilog
module SpinalNNTop (
    input         clk,
    input         reset,
    // Input: one activation per cycle (8-bit signed, valid/ready handshake)
    input         activation_in_valid,
    output        activation_in_ready,
    input  [7:0]  activation_in_data,
    // Output: one value per inference (the argmax class index)
    output        activation_out_valid,
    input         activation_out_ready,
    output [7:0]  activation_out_data
);
```

The interface is intentionally simple. Stream activations in. Read the result out. Anything upstream (sensor interface, preprocessing, DMA) connects to the same two streaming ports. Anything downstream (decision logic, communications, display) reads from the output port.

---

## Summary

The full flow from trained model to running hardware:

```
Train model in PyTorch (or any framework)
    |
Export to ONNX INT8 format
    |
Run onnx_to_params.py -- generates Scala Params and weight arrays
    |
sbt runMain GenVerilog -- SpinalHDL elaborates the circuit, emits Verilog
    |
FPGA synthesis tool -- maps Verilog to BRAM, DSP, and logic cells
    |
Bitstream flashed to FPGA
    |
Sensor data in, classification out
```

The operator library handles the hardware math. The ONNX parser handles the translation from model to hardware description. The build system handles the rest.

What you control: which model you train, how aggressive the quantization is, and how many DSP blocks to dedicate to the accelerator. Everything else is automated.
