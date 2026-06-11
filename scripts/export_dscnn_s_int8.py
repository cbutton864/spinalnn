#!/usr/bin/env python3
"""
Export DS-CNN-S to INT8 ONNX (QLinearConv format) for SpinalNN.

Architecture: "Hello Edge" DS-CNN-S — 4 depthwise-separable blocks,
designed for keyword spotting on 49×10 MFCC input (Google Speech Commands).
Reference: Zhang et al. 2017, arXiv:1711.07128

Input:  [B, 1, 49, 10]  — mono MFCC spectrogram
Output: [B, 12]          — 10 keywords + silence + unknown

NOTE: Weights are randomly initialised. This export validates the hardware
compilation pipeline (DWConv, standard conv, GAP, linear, INT8 requant).
To get production accuracy, replace the model state_dict with pretrained
weights from the ARM ML-examples repo or train on Google Speech Commands.
"""

import numpy as np
import os
import torch
import torch.nn as nn
import onnxruntime as ort
from onnxruntime.quantization import (
    quantize_static, CalibrationDataReader,
    QuantFormat, QuantType,
)
from onnxruntime.quantization import shape_inference as quant_shape_inference

# ── onnxruntime 1.26.0 per-channel bias quantisation bug fix ─────────────────
# qv.axis is None even with per_channel=True; bias quantisation then passes a
# per-channel scale with a per-tensor axis, causing a broadcast failure.
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


# ── Model ─────────────────────────────────────────────────────────────────────

class DWSBlock(nn.Module):
    """Depthwise-separable block: DW 3×3 SAME → BN → ReLU → PW 1×1 → BN → ReLU."""
    def __init__(self, channels: int):
        super().__init__()
        self.dw    = nn.Conv2d(channels, channels, 3, padding=1, groups=channels, bias=False)
        self.dw_bn = nn.BatchNorm2d(channels)
        self.pw    = nn.Conv2d(channels, channels, 1, bias=False)
        self.pw_bn = nn.BatchNorm2d(channels)

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        x = torch.relu(self.dw_bn(self.dw(x)))
        x = torch.relu(self.pw_bn(self.pw(x)))
        return x


class DSCNN_S(nn.Module):
    """
    DS-CNN-S — 12-class keyword spotter on 49×10 MFCC input.

    Stem uses symmetric padding (4,1) which maps cleanly to the ONNX Conv pads
    attribute. Output spatial dims are 24×5 (vs 25×5 for asymmetric SAME),
    sufficient for architecture validation and hardware benchmarking.
    """
    NUM_CLASSES: int = 12

    def __init__(self):
        super().__init__()
        # Stem: Conv2d(1→64, kernel 10×4, stride 2×2)
        # Symmetric padding=(4,1): H_out=24, W_out=5
        self.stem_conv = nn.Conv2d(1, 64, kernel_size=(10, 4), stride=(2, 2),
                                   padding=(4, 1), bias=False)
        self.stem_bn   = nn.BatchNorm2d(64)

        # 4× depthwise-separable blocks (all at 24×5×64)
        self.blocks = nn.Sequential(*[DWSBlock(64) for _ in range(4)])

        self.gap = nn.AdaptiveAvgPool2d(1)
        self.fc  = nn.Linear(64, self.NUM_CLASSES)

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        x = torch.relu(self.stem_bn(self.stem_conv(x)))
        x = self.blocks(x)
        x = self.gap(x)
        x = x.flatten(1)
        return self.fc(x)


# ── Calibration reader ────────────────────────────────────────────────────────

class MfccCalibReader(CalibrationDataReader):
    """
    Synthetic calibration data: standard-normal, clipped to ±4 (realistic
    MFCC range). 100 batches × 8 = 800 samples for PTQ calibration.
    """
    def __init__(self, num_batches: int = 100, batch_size: int = 8):
        rng  = np.random.default_rng(seed=42)
        data = rng.standard_normal(
            (num_batches * batch_size, 1, 49, 10)
        ).astype(np.float32)
        data = np.clip(data, -4.0, 4.0)
        self._batches = [
            {"input": data[i * batch_size:(i + 1) * batch_size]}
            for i in range(num_batches)
        ]
        self._iter = iter(self._batches)

    def get_next(self):
        return next(self._iter, None)


# ── Export pipeline ───────────────────────────────────────────────────────────

def main():
    os.makedirs("models", exist_ok=True)
    fp32_path = "models/dscnn_s-fp32.onnx"
    prep_path = "models/dscnn_s-fp32-prep.onnx"
    int8_path = "models/dscnn_s-int8.onnx"

    # 1. Build and export FP32 ONNX
    model = DSCNN_S().eval()
    dummy = torch.zeros(1, 1, 49, 10)

    # Verify shapes before export
    with torch.no_grad():
        out = model(dummy)
    assert out.shape == (1, 12), f"unexpected output shape {out.shape}"
    print(f"FP32 model OK — output shape {out.shape}")

    print(f"Exporting FP32 ONNX → {fp32_path} …")
    torch.onnx.export(
        model, dummy, fp32_path,
        input_names=["input"],
        output_names=["output"],
        dynamic_axes={"input": {0: "batch"}, "output": {0: "batch"}},
        opset_version=13,
        dynamo=False,
    )

    # 2. Shape inference pre-processing (required by onnxruntime PTQ)
    print(f"Pre-processing → {prep_path} …")
    quant_shape_inference.quant_pre_process(fp32_path, prep_path, skip_symbolic_shape=False)

    # 3. Static PTQ — QOperator (QLinearConv) format, INT8 weights, UINT8 activations
    print(f"Static PTQ (100×8 synthetic MFCC batches) → {int8_path} …")
    quantize_static(
        model_input=prep_path,
        model_output=int8_path,
        calibration_data_reader=MfccCalibReader(num_batches=100, batch_size=8),
        quant_format=QuantFormat.QOperator,
        activation_type=QuantType.QUInt8,
        weight_type=QuantType.QInt8,
        per_channel=True,
    )

    # 4. Smoke test
    sess = ort.InferenceSession(int8_path, providers=["CPUExecutionProvider"])
    result = sess.run(None, {"input": np.zeros((1, 1, 49, 10), dtype=np.float32)})
    assert result[0].shape == (1, 12), f"unexpected INT8 output shape {result[0].shape}"
    print(f"Smoke test passed — INT8 logits shape {result[0].shape}")
    print("Done.")


if __name__ == "__main__":
    main()
