"""
sim_mnist_int8.py — Software simulation of SpinalNN's INT8 MNIST inference.

Implements the SAME quantization scheme the hardware uses:
  - Input scale: 1/127
  - Conv1 out scale: 4/127
  - Conv2 out scale: 8/127
  - FC out scale: 16/127
  - Symmetric weights (zero-point = 0 for weights)
  - Requantization using floating-point multiply+round (simulates hardware requant)

Runs all 5 test samples from OnnxValidationData and reports:
  (a) Does the software INT8 sim produce correct answers? (= hardware should too)
  (b) Or does software INT8 also fail? (= it's a calibration issue, not hardware bug)
"""

import numpy as np
import struct
import onnx
from onnx import numpy_helper

MODEL_PATH = "models/mnist-8.onnx"

# ── Same calibration as MnistCalibration in OnnxFrontend.scala ────────────────
INPUT_SCALE  = 1.0 / 127.0
CONV1_SCALE  = 4.0 / 127.0
CONV2_SCALE  = 8.0 / 127.0
FC_SCALE     = 16.0 / 127.0

# ── Load ONNX model and extract weights ───────────────────────────────────────
model  = onnx.load(MODEL_PATH)
graph  = model.graph
inits  = {t.name: t for t in graph.initializer}

def get_float_array(name):
    t = inits[name]
    return numpy_helper.to_array(t).astype(np.float32)

# Print model topology
print("=== MNIST-8 ONNX Model Topology ===")
for i, n in enumerate(graph.node):
    inputs  = list(n.input)
    outputs = list(n.output)
    attrs   = {a.name: a for a in n.attribute}
    print(f"Node {i}: {n.op_type} ({n.name})")
    print(f"  in={inputs}, out={outputs}")
    for k, a in attrs.items():
        v = list(a.ints) or a.f or a.i or a.s
        print(f"  {k}={v}")
print()

# ── Extract weights from the graph ────────────────────────────────────────────
# Identify conv1, conv2 weight/bias initializers and the FC weight from the ONNX graph.
# We iterate nodes as OnnxFrontend does.

weight_nodes = []
for n in graph.node:
    if n.op_type == "Conv":
        wname = n.input[1]
        # Resolve through any Reshape
        bname = None
        # Check for bias Add after this conv
        out = n.output[0]
        for m in graph.node:
            if m.op_type == "Add" and out in m.input:
                bias_in = [x for x in m.input if x != out and x in inits]
                if bias_in:
                    bname = bias_in[0]
        weight_nodes.append(("Conv", wname, bname))
    elif n.op_type == "MatMul":
        wname = n.input[1]
        # The weight might be a reshaped initializer
        out = n.output[0]
        bname = None
        for m in graph.node:
            if m.op_type == "Add" and out in m.input:
                bias_in = [x for x in m.input if x != out and x in inits]
                if bias_in:
                    bname = bias_in[0]
        weight_nodes.append(("MatMul", wname, bname))

print(f"Found weight nodes: {[(t, w, b) for t,w,b in weight_nodes]}")
print()

# Resolve a weight name through Reshape
def resolve_weight(name):
    for n in graph.node:
        if name in n.output:
            if n.op_type == "Reshape":
                return resolve_weight(n.input[0])
    return name

# ── Quantize weights symmetrically (same as OnnxCompiler.quantizeSymmetric) ──
def quantize_symmetric(floats):
    max_abs = np.max(np.abs(floats))
    if max_abs == 0:
        scale = 1.0
    else:
        scale = max_abs / 127.0
    q = np.clip(np.round(floats / scale), -128, 127).astype(np.int8)
    return scale, q

# ── INT8 convolution (reference implementation matching hardware) ──────────────
def conv2d_int8_same(x_q, w_q, b_q32, in_scale, w_scale, out_scale,
                     kH, kW, sH, sW, padT, padB, padL, padR):
    """
    x_q:     [H, W, C_in] int8
    w_q:     [C_out, C_in, kH, kW] int8  (ONNX OIHW order)
    b_q32:   [C_out] int32
    Returns: [outH, outW, C_out] int8
    """
    H, W, C_in = x_q.shape
    C_out       = w_q.shape[0]
    # Pad
    x_pad = np.pad(x_q.astype(np.int32),
                   [(padT, padB), (padL, padR), (0, 0)], mode='constant')
    outH = (H + padT + padB - kH) // sH + 1
    outW = (W + padL + padR - kW) // sW + 1
    out  = np.zeros((outH, outW, C_out), dtype=np.float64)
    for oh in range(outH):
        for ow in range(outW):
            ih, iw = oh * sH, ow * sW
            patch = x_pad[ih:ih+kH, iw:iw+kW, :]  # [kH, kW, C_in]
            for oc in range(C_out):
                # w_q[oc]: [C_in, kH, kW]
                wslice = w_q[oc]  # [C_in, kH, kW]
                acc = int(np.sum(wslice.astype(np.int32) *
                                 patch.transpose(2,0,1).astype(np.int32))) + int(b_q32[oc])
                # Requantize: y_q = round(acc * in_scale * w_scale / out_scale)
                y_float = acc * in_scale * w_scale / out_scale
                y_q = int(np.clip(np.round(y_float), -128, 127))
                out[oh, ow, oc] = y_q
    return out.astype(np.int8)

def maxpool2d(x, kH, kW, sH, sW):
    """x: [H, W, C], returns [outH, outW, C] int8 max pool"""
    H, W, C = x.shape
    outH = (H - kH) // sH + 1
    outW = (W - kW) // sW + 1
    out  = np.full((outH, outW, C), -128, dtype=np.int8)
    for oh in range(outH):
        for ow in range(outW):
            ih, iw = oh * sH, ow * sW
            patch = x[ih:ih+kH, iw:iw+kW, :]
            out[oh, ow, :] = np.max(patch.reshape(-1, C), axis=0)
    return out

def relu_int8(x):
    return np.clip(x, 0, 127).astype(np.int8)

def linear_int8(x_flat, w_q, b_q32, in_scale, w_scale, out_scale):
    """
    x_flat: [M] int8 (already in HWC order)
    w_q:    [O, M] int8
    """
    O = w_q.shape[0]
    out = np.zeros(O, dtype=np.int8)
    for o in range(O):
        acc = int(np.sum(w_q[o].astype(np.int32) * x_flat.astype(np.int32))) + int(b_q32[o])
        y_float = acc * in_scale * w_scale / out_scale
        out[o] = int(np.clip(np.round(y_float), -128, 127))
    return out

# ── Load actual weights from the ONNX model ────────────────────────────────────
# Conv1: Parameter5 (shape [8, 1, 5, 5])
# Conv2: Parameter87 (shape [16, 8, 5, 5])
# FC:    Parameter193 (shape [16, 4, 4, 10])

# Resolve actual initializer names
conv_nodes  = [(n, n.input[1]) for n in graph.node if n.op_type == "Conv"]
matmul_nodes = [(n, n.input[1]) for n in graph.node if n.op_type == "MatMul"]

print("Conv weight refs:", [x[1] for x in conv_nodes])
print("MatMul weight refs:", [x[1] for x in matmul_nodes])

conv1_wname = resolve_weight(conv_nodes[0][1])
conv2_wname = resolve_weight(conv_nodes[1][1])
fc_wname    = resolve_weight(matmul_nodes[0][1])

print(f"Resolved: conv1={conv1_wname}, conv2={conv2_wname}, fc={fc_wname}")

conv1_w_f = get_float_array(conv1_wname)  # [8, 1, 5, 5]
conv2_w_f = get_float_array(conv2_wname)  # [16, 8, 5, 5]
fc_w_f    = get_float_array(fc_wname)     # [16, 4, 4, 10]

print(f"conv1_w shape: {conv1_w_f.reshape(-1, 5*5).shape}  reshape: {conv1_w_f.shape}")
print(f"conv2_w shape: {conv2_w_f.shape}")
print(f"fc_w shape:    {fc_w_f.shape}")

# Quantize
w1_scale, conv1_w_q = quantize_symmetric(conv1_w_f)
w2_scale, conv2_w_q = quantize_symmetric(conv2_w_f)

# FC weight: [16, 4, 4, 10] in CNTK's format — this is [C_in, H, W, O]
# After reshape to [256, 10], row-major: element [c,h,w,o] at c*160 + h*40 + w*10 + o
# We need [O, C_in_hwc_flattened] for int8 matrix multiply in HWC order.
#
# `transposeLinearWeights` in SpinalNN puts weights as [O, H*W*C]:
#   transposed[o * 256 + h*W*C + w*C + ch] = onnxWeights[(ch*H*W + h*W + w)*O + o]
# where onnxWeights = fc_w_f flattened = fc_w_f[c,h,w,o] at c*160+h*40+w*10+o
#
# For our Python simulation we need w_q in [O, H*W*C_in_HWC] order.
# That means for output o and HWC position (h,w,ch), the weight is fc_w_f[ch, h, w, o].

fc_w_f_flat   = fc_w_f.flatten()           # [16*4*4*10] in C,H,W,O order
wfc_scale, fc_w_q_flat = quantize_symmetric(fc_w_f_flat)
# Reshape to [C=16, H=4, W=4, O=10]
fc_w_q_chwo = fc_w_q_flat.reshape(16, 4, 4, 10)
# Reorder to [O, H*W*C] in HWC order (h outer, c inner)
# For hardware: hw_input[h*W*C + w*C + c] = pool2_out[h, w, c]
# weight[o, h*W*C + w*C + c] = fc_w_q_chwo[c, h, w, o]
O, H, W_fc, C = 10, 4, 4, 16
fc_w_q_hwc = np.zeros((O, H * W_fc * C), dtype=np.int8)
for o in range(O):
    for h in range(H):
        for w in range(W_fc):
            for c in range(C):
                hwc_idx = h * W_fc * C + w * C + c
                fc_w_q_hwc[o, hwc_idx] = fc_w_q_chwo[c, h, w, o]

print(f"\nWeight scales: conv1={w1_scale:.6f}, conv2={w2_scale:.6f}, fc={wfc_scale:.6f}")
print(f"Effective scales: conv1 in*w/out = {INPUT_SCALE*w1_scale/CONV1_SCALE:.6f}")
print(f"                  conv2 in*w/out = {CONV1_SCALE*w2_scale/CONV2_SCALE:.6f}")
print(f"                  fc   in*w/out = {CONV2_SCALE*wfc_scale/FC_SCALE:.6f}")

# Extract biases (already quantized as INT32 for the float model)
def get_bias_after(node_out):
    """Find Add node after this output and return the bias initializer."""
    for n in graph.node:
        if n.op_type == "Add" and node_out in n.input:
            bias_names = [x for x in n.input if x != node_out and x in inits]
            if bias_names:
                b_f = get_float_array(bias_names[0])
                return b_f
    return None

conv1_out = conv_nodes[0][0].output[0]
conv2_out = conv_nodes[1][0].output[0]
fc_out    = matmul_nodes[0][0].output[0]

b1_f = get_bias_after(conv1_out)
b2_f = get_bias_after(conv2_out)
bf_f = get_bias_after(fc_out)

# Scale biases to int32: b_q = round(b_float / (in_scale * w_scale))
b1_q = np.round(b1_f.flatten() / (INPUT_SCALE * w1_scale)).astype(np.int32) if b1_f is not None else np.zeros(8, np.int32)
b2_q = np.round(b2_f.flatten() / (CONV1_SCALE * w2_scale)).astype(np.int32) if b2_f is not None else np.zeros(16, np.int32)
bf_q = np.round(bf_f.flatten() / (CONV2_SCALE * wfc_scale)).astype(np.int32) if bf_f is not None else np.zeros(10, np.int32)

print(f"\nBias shapes: b1={b1_q.shape if b1_f is not None else None}, "
      f"b2={b2_q.shape if b2_f is not None else None}, "
      f"bf={bf_q.shape if bf_f is not None else None}")

# ── Test samples (from OnnxValidationData.scala) ──────────────────────────────
# Labels
labels = [7, 2, 1, 0, 4]

# Sample inputs as float [0,1], 28*28 each
# We'll quantize them to int8 with scale 1/127
sample_inputs_f = [
    # 5 samples, each 784 floats -- reading from the file below
]

# Read inputs from OnnxValidationData.scala
import re

scala_file = "src/test/scala/spinalnn/OnnxValidationData.scala"
with open(scala_file) as f:
    content = f.read()

# Extract all sample_N_input arrays
for i in range(5):
    pattern = rf"val sample_{i}_input = Array\(([^)]+)\)"
    m = re.search(pattern, content, re.DOTALL)
    if m:
        floats = [float(x.strip().rstrip('f')) for x in m.group(1).split(',')]
        sample_inputs_f.append(np.array(floats, dtype=np.float32))

print(f"\nLoaded {len(sample_inputs_f)} samples, shape={sample_inputs_f[0].shape}")

# ── Run INT8 inference for each sample ────────────────────────────────────────
print("\n=== INT8 Simulation Results ===")
print("(Calibration: input=1/127, conv1=4/127, conv2=8/127, fc=16/127)")
print()

correct = 0
for i, (x_f, label) in enumerate(zip(sample_inputs_f, labels)):
    # Quantize input: [0,1] -> int8 [0,127]
    x_q = np.clip(np.round(x_f * 127.0), -128, 127).astype(np.int8)
    x_hwc = x_q.reshape(28, 28, 1)  # [H, W, C]

    # Conv1: SAME_UPPER, kH=kW=5, sH=sW=1, padT=padB=padL=padR=2
    c1 = conv2d_int8_same(x_hwc, conv1_w_q, b1_q, INPUT_SCALE, w1_scale, CONV1_SCALE,
                          kH=5, kW=5, sH=1, sW=1, padT=2, padB=2, padL=2, padR=2)
    # ReLU1
    r1 = relu_int8(c1)
    # Pool1: kH=kW=2, sH=sW=2 -> 14x14x8
    p1 = maxpool2d(r1, kH=2, kW=2, sH=2, sW=2)

    # Conv2: SAME_UPPER, kH=kW=5, sH=sW=1, padT=padB=padL=padR=2
    c2 = conv2d_int8_same(p1, conv2_w_q, b2_q, CONV1_SCALE, w2_scale, CONV2_SCALE,
                          kH=5, kW=5, sH=1, sW=1, padT=2, padB=2, padL=2, padR=2)
    # ReLU2
    r2 = relu_int8(c2)
    # Pool2: kH=kW=3, sH=sW=3 -> 4x4x16
    p2 = maxpool2d(r2, kH=3, kW=3, sH=3, sW=3)

    # Flatten to HWC: [4,4,16] -> [256] in HWC order (h outer, c inner)
    flat = p2.flatten()  # already in HWC order since p2 is [H,W,C]

    # FC: [256] -> [10]
    logits = linear_int8(flat, fc_w_q_hwc, bf_q, CONV2_SCALE, wfc_scale, FC_SCALE)

    pred = int(np.argmax(logits))
    match = "MATCH" if pred == label else "MISMATCH"
    if pred == label:
        correct += 1

    print(f"[Sample {i}] label={label}, pred={pred}  {match}")
    print(f"  logits (int8): {logits.tolist()}")
    print(f"  logits (deq):  {[round(int(x)*FC_SCALE, 3) for x in logits]}")

    # Also show what pool2 output looks like (min/max/mean)
    print(f"  pool2 max={p2.max()}, min={p2.min()}, mean={p2.mean():.2f}")
    print()

print(f"=== Result: {correct}/5 correct ===")

# ── Also run float reference for comparison ────────────────────────────────────
print("\n=== Float Reference (ONNX Runtime) ===")
import onnxruntime as ort

session = ort.InferenceSession(MODEL_PATH, providers=["CPUExecutionProvider"])
inp_name = session.get_inputs()[0].name
out_name = session.get_outputs()[0].name

for i, (x_f, label) in enumerate(zip(sample_inputs_f, labels)):
    # ONNX Runtime expects NCHW float32
    x_nchw = x_f.reshape(1, 1, 28, 28)
    logits_f = session.run([out_name], {inp_name: x_nchw})[0].flatten()
    pred = int(np.argmax(logits_f))
    print(f"[Sample {i}] label={label}, pred={pred}  {'MATCH' if pred==label else 'MISMATCH'}")
    print(f"  logits (float): {[round(float(x), 3) for x in logits_f]}")
