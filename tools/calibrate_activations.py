#!/usr/bin/env python3
"""Activation calibration for the float MNIST ONNX model.

Derives the per-layer output activation scales (q_*_out) that the SpinalNN
ONNX compiler currently *guesses* (4/127, 8/127, 16/127). It runs real MNIST
test images through the float graph, observes the true range of the exact
tensors our hardware quantizes, and reports calibrated scales.

Calibration points (must match the hardware quantization points):
  q_conv1_out <- max|Plus30_Output_0|   (conv1 + bias, pre-ReLU)
  q_conv2_out <- max|Plus112_Output_0|  (conv2 + bias, pre-ReLU)
  q_fc_out    <- max|Plus214_Output_0|  (final logits)

Usage:
  .venv/bin/python3 tools/calibrate_activations.py [--num 500] [--percentile 100]
"""
import argparse
import gzip
import struct

import numpy as np
import onnx
import onnxruntime as ort

MODEL = "models/mnist-8.onnx"
IMAGES = "models/t10k-images-idx3-ubyte.gz"

# tensor name -> (hardware scale symbol, current guessed max range)
CALIB_POINTS = [
    ("Plus30_Output_0", "q_conv1_out", 4.0),
    ("Plus112_Output_0", "q_conv2_out", 8.0),
    ("Plus214_Output_0", "q_fc_out", 16.0),
]


def load_images(path, n):
    with gzip.open(path, "rb") as f:
        magic, count, rows, cols = struct.unpack(">IIII", f.read(16))
        assert magic == 2051, f"bad IDX magic {magic}"
        n = min(n, count)
        buf = f.read(n * rows * cols)
    arr = np.frombuffer(buf, dtype=np.uint8).astype(np.float32) / 255.0  # -> [0,1]
    return arr.reshape(n, 1, rows, cols)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--num", type=int, default=500, help="number of calibration images")
    ap.add_argument("--percentile", type=float, default=100.0,
                    help="abs-value percentile for range (100 = true max)")
    args = ap.parse_args()

    # Expose the intermediate tensors as graph outputs.
    model = onnx.load(MODEL)
    existing = {o.name for o in model.graph.output}
    for name, _, _ in CALIB_POINTS:
        if name not in existing:
            model.graph.output.append(onnx.helper.make_tensor_value_info(
                name, onnx.TensorProto.FLOAT, None))

    sess = ort.InferenceSession(model.SerializeToString(),
                                providers=["CPUExecutionProvider"])
    in_name = sess.get_inputs()[0].name
    out_names = [n for n, _, _ in CALIB_POINTS]

    imgs = load_images(IMAGES, args.num)
    print(f"Calibrating on {len(imgs)} MNIST test images "
          f"(percentile={args.percentile})...\n")

    abs_pool = {n: [] for n in out_names}
    for i in range(len(imgs)):
        outs = sess.run(out_names, {in_name: imgs[i:i + 1]})
        for n, o in zip(out_names, outs):
            abs_pool[n].append(np.abs(o).ravel())

    print(f"{'layer':12s} {'tensor':20s} | {'guess':>7s} {'guessScale':>11s} "
          f"| {'calMax':>8s} {'calScale':>11s} | {'ratio':>6s} {'sat?':>5s}")
    print("-" * 96)
    results = {}
    for name, sym, guess in CALIB_POINTS:
        allabs = np.concatenate(abs_pool[name])
        cal_max = float(np.percentile(allabs, args.percentile))
        cal_scale = cal_max / 127.0
        guess_scale = guess / 127.0
        ratio = cal_max / guess
        sat = "YES" if cal_max > guess else ""
        results[sym] = (cal_max, cal_scale)
        print(f"{sym:12s} {name:20s} | {guess:7.2f} {guess_scale:11.6f} "
              f"| {cal_max:8.3f} {cal_scale:11.6f} | {ratio:6.2f} {sat:>5s}")

    print("\nSuggested calibrated Scala constants for OnnxCompiler:")
    for _, sym, _ in CALIB_POINTS:
        cal_max, cal_scale = results[sym]
        print(f"  val {sym} = QuantParams({cal_max:.4f}f / 127.0f, 0)  "
              f"// calibrated (was guessed)")


if __name__ == "__main__":
    main()
