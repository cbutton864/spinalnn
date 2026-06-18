#!/usr/bin/env python3
"""
Export QARepVGG-A0 to INT8 ONNX (QLinearConv format) for SpinalNN.

Pipeline:
  1. Load timm pretrained RepVGG-A0 (training-time multi-branch structure)
  2. Fuse branches via reparameterize() -> single 3x3 conv per layer
  3. Export FP32 ONNX
  4. Static PTQ with onnxruntime (random calibration) -> INT8 QLinearConv ONNX

Usage:
    python scripts/export_repvgg_a0_int8.py [--output models/repvgg_a0-int8.onnx] [--num-cal 50]
"""
import argparse
import glob
import os
import numpy as np
import torch
import timm
import onnx
import onnxruntime
from onnxruntime.quantization import (
    quantize_static, CalibrationDataReader,
    QuantType, QuantFormat,
)
from onnxruntime.quantization import shape_inference as quant_shape_inference

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_DIR = os.path.dirname(SCRIPT_DIR)


class RandomCalibReader(CalibrationDataReader):
    """Feed random normal tensors as calibration data.

    WARNING: random-noise activations have a wildly different distribution
    from real images (which are spatially smooth / low-frequency), so the
    output-quantization scale derived from this calibration is degenerate
    in practice (collapses many classes to the same logit). Prefer
    ImageCalibReader when any real images are available.
    """
    def __init__(self, input_name: str, n: int = 50):
        self._iter = iter([
            {input_name: np.random.randn(1, 3, 224, 224).astype(np.float32)}
            for _ in range(n)
        ])

    def get_next(self):
        return next(self._iter, None)


class ImageCalibReader(CalibrationDataReader):
    """Feed real preprocessed images as calibration data.

    Uses the same RGB / [0,1] / ImageNet-mean-std preprocessing the model
    was trained with, so calibration sees activation statistics representative
    of real inference inputs (unlike RandomCalibReader's Gaussian noise).
    """
    def __init__(self, input_name: str, image_paths):
        from PIL import Image
        mean = np.array([0.485, 0.456, 0.406], dtype=np.float32)
        std = np.array([0.229, 0.224, 0.225], dtype=np.float32)
        samples = []
        for path in image_paths:
            img = Image.open(path).convert("RGB")
            w, h = img.size
            scale = 256 / min(w, h)
            img = img.resize((max(224, int(w * scale)), max(224, int(h * scale))), Image.BILINEAR)
            w2, h2 = img.size
            left, top = (w2 - 224) // 2, (h2 - 224) // 2
            img = img.crop((left, top, left + 224, top + 224))
            arr = np.array(img, dtype=np.float32) / 255.0
            arr = (arr - mean) / std
            arr = arr.transpose(2, 0, 1)[np.newaxis].astype(np.float32)
            samples.append({input_name: arr})
        self._iter = iter(samples)

    def get_next(self):
        return next(self._iter, None)


def fuse_repvgg_branches(model: torch.nn.Module) -> int:
    from timm.models.byobnet import RepVggBlock
    count = 0
    for m in model.modules():
        if isinstance(m, RepVggBlock):
            m.reparameterize()
            count += 1
    return count


def main():
    parser = argparse.ArgumentParser(description="Export RepVGG-A0 INT8 ONNX for SpinalNN")
    parser.add_argument(
        "--output",
        default=os.path.join(PROJECT_DIR, "models", "repvgg_a0-int8.onnx"),
        help="Output INT8 ONNX path (default: models/repvgg_a0-int8.onnx)",
    )
    parser.add_argument(
        "--num-cal", type=int, default=50,
        help="Number of random calibration samples (default: 50, ignored if --cal-images-dir given)",
    )
    parser.add_argument(
        "--cal-images-dir", default=None,
        help="Directory of real images (jpg/png) to use for calibration instead of random noise",
    )
    args = parser.parse_args()

    fp32_path = args.output.replace("-int8.onnx", "-fp32.onnx")
    os.makedirs(os.path.dirname(args.output), exist_ok=True)

    # ── 1. Load pretrained RepVGG-A0 ───────────────────────────────────────────
    print("[1/4] Loading repvgg_a0 (pretrained=True) from timm ...")
    model = timm.create_model("repvgg_a0", pretrained=True)
    model.eval()
    print(f"      Loaded: {sum(p.numel() for p in model.parameters()):,} parameters")

    # ── 2. Fuse multi-branch -> single 3x3 conv ────────────────────────────────
    print("[2/4] Reparameterizing (branch fusion) ...")
    n_fused = fuse_repvgg_branches(model)
    print(f"      Fused {n_fused} RepVggBlocks -> inference-only architecture")

    # Verify forward pass still works
    with torch.no_grad():
        dummy = torch.randn(1, 3, 224, 224)
        out_pt = model(dummy)
    print(f"      PyTorch forward OK — output shape {tuple(out_pt.shape)}, argmax {out_pt.argmax().item()}")

    # ── 3. Export FP32 ONNX ────────────────────────────────────────────────────
    # Use dynamo=False (legacy exporter) to get opset 13 — required by the
    # onnxruntime static quantizer which does not fully support opset 18.
    prep_path = fp32_path.replace("-fp32.onnx", "-fp32-prep.onnx")
    print(f"[3/4] Exporting FP32 ONNX -> {fp32_path}")
    torch.onnx.export(
        model, dummy, fp32_path,
        opset_version=13,
        input_names=["input"],
        output_names=["output"],
        dynamic_axes={"input": {0: "batch"}, "output": {0: "batch"}},
        dynamo=False,   # legacy exporter; respects opset_version=13
    )
    onnx.checker.check_model(onnx.load(fp32_path))
    print("      FP32 ONNX verified OK")

    # Pre-process: shape inference + simplification required before PTQ
    print(f"      Pre-processing for quantizer -> {prep_path}")
    quant_shape_inference.quant_pre_process(fp32_path, prep_path, skip_symbolic_shape=False)

    # ── 4. Static INT8 PTQ ─────────────────────────────────────────────────────
    # onnxruntime 1.26.0 bug: _requantize_weight stores qv.axis=None even when
    # per_channel=True; bias quantization then calls quantize_onnx_initializer
    # with axis=None but a per-channel scale, causing a broadcast error.
    # Patch: if qv.axis is None but the new scale is per-channel, set axis=0.
    import onnxruntime.quantization.onnx_quantizer as _oq
    _orig_requantize = _oq.ONNXQuantizer._requantize_weight

    def _patched_requantize(self, weight_name, new_scale):
        if weight_name in self.quantized_value_map:
            qv = self.quantized_value_map[weight_name]
            s = np.asarray(new_scale)
            if qv.axis is None and s.ndim == 1 and s.size > 1:
                qv.axis = 0
        return _orig_requantize(self, weight_name, new_scale)

    _oq.ONNXQuantizer._requantize_weight = _patched_requantize

    sess_fp32 = onnxruntime.InferenceSession(prep_path, providers=["CPUExecutionProvider"])
    in_name = sess_fp32.get_inputs()[0].name

    if args.cal_images_dir:
        image_paths = sorted(
            glob.glob(os.path.join(args.cal_images_dir, "*.jpg"))
            + glob.glob(os.path.join(args.cal_images_dir, "*.jpeg"))
            + glob.glob(os.path.join(args.cal_images_dir, "*.png"))
        )
        if not image_paths:
            raise ValueError(f"No images found in {args.cal_images_dir}")
        print(f"[4/4] Static PTQ (QLinearConv, per-channel, {len(image_paths)} real images) ...")
        calib_reader = ImageCalibReader(in_name, image_paths)
    else:
        print(f"[4/4] Static PTQ (QLinearConv, per-channel, {args.num_cal} random samples) ...")
        calib_reader = RandomCalibReader(in_name, args.num_cal)

    quantize_static(
        prep_path,
        args.output,
        calib_reader,
        quant_format=QuantFormat.QOperator,   # QLinearConv — matches SpinalNN frontend
        activation_type=QuantType.QUInt8,     # unsigned activations (post-ReLU range 0..255)
        weight_type=QuantType.QInt8,          # signed weights per output channel
        per_channel=True,
    )
    print(f"      INT8 ONNX written to {args.output}")

    # ── Sanity check ───────────────────────────────────────────────────────────
    sess_q = onnxruntime.InferenceSession(args.output, providers=["CPUExecutionProvider"])
    dummy_np = np.random.randn(1, 3, 224, 224).astype(np.float32)
    out_q = sess_q.run(None, {in_name: dummy_np})
    print(f"      INT8 inference OK — output shape {out_q[0].shape}, argmax {out_q[0].argmax()}")
    print()
    print("Done. Next steps:")
    print(f"  1. Create examples/repvgg_a0_ti180.json pointing to {os.path.relpath(args.output, PROJECT_DIR)}")
    print("  2. sbt 'runMain spinalnn.compiler.Compile examples/repvgg_a0_ti180.json'")
    print("  3. ./pnr_run.sh benchmark_repvgg_a0 \"repvgg_a0_N16\"")


if __name__ == "__main__":
    main()
