import os
import gzip
import urllib.request
import numpy as np
import onnxruntime as ort

def download_file(url, filepath):
    if not os.path.exists(filepath):
        print(f"Downloading {url} to {filepath}...")
        urllib.request.urlretrieve(url, filepath)
    else:
        print(f"{filepath} already exists.")

def main():
    os.makedirs("models", exist_ok=True)
    os.makedirs("target", exist_ok=True)

    # Standard MNIST validation mirrors
    images_url = "https://github.com/cvdfoundation/mnist/raw/master/t10k-images-idx3-ubyte.gz"
    labels_url = "https://github.com/cvdfoundation/mnist/raw/master/t10k-labels-idx1-ubyte.gz"

    images_path = "models/t10k-images-idx3-ubyte.gz"
    labels_path = "models/t10k-labels-idx1-ubyte.gz"

    try:
        download_file(images_url, images_path)
        download_file(labels_url, labels_path)
    except Exception as e:
        print(f"Failed download using cvdfoundation mirror: {e}")
        # Try alternative mirror
        alt_images_url = "https://ossci-datasets.s3.amazonaws.com/mnist/t10k-images-idx3-ubyte.gz"
        alt_labels_url = "https://ossci-datasets.s3.amazonaws.com/mnist/t10k-labels-idx1-ubyte.gz"
        print("Trying AWS mirror...")
        download_file(alt_images_url, images_path)
        download_file(alt_labels_url, labels_path)

    # Unpack first 5 images & labels
    with gzip.open(images_path, 'rb') as f:
        # Header info
        magic = int.from_bytes(f.read(4), 'big')
        num_imgs = int.from_bytes(f.read(4), 'big')
        rows = int.from_bytes(f.read(4), 'big')
        cols = int.from_bytes(f.read(4), 'big')
        print(f"Images file: magic={magic}, num_imgs={num_imgs}, rows={rows}, cols={cols}")
        
        # Read first 5 images (28 * 28 = 784 bytes each)
        raw_images = np.frombuffer(f.read(5 * 28 * 28), dtype=np.uint8).reshape(5, 28, 28)

    with gzip.open(labels_path, 'rb') as f:
        magic = int.from_bytes(f.read(4), 'big')
        num_labels = int.from_bytes(f.read(4), 'big')
        print(f"Labels file: magic={magic}, num_labels={num_labels}")
        raw_labels = np.frombuffer(f.read(5), dtype=np.uint8)

    print(f"Extracted labels for first 5 images: {raw_labels}")

    # Load ONNX model and run inference with ONNX Runtime to get gold reference values
    session = ort.InferenceSession("models/mnist-8.onnx")
    input_name = session.get_inputs()[0].name
    output_name = session.get_outputs()[0].name

    scala_images_code = []

    for i in range(5):
        img = raw_images[i]
        label = raw_labels[i]

        # Normalization used by this CNTK MNIST model:
        # Check standard training preprocessing or do inference and check confidence.
        # Often, it is floating point division by 255.0. Let's try division by 255.0:
        norm_img_255 = (img.astype(np.float32) / 255.0).reshape(1, 1, 28, 28)
        outputs_255 = session.run([output_name], {input_name: norm_img_255})[0][0]
        pred_255 = np.argmax(outputs_255)
        print(f"Image {i} | True label={label} | Normalization /255.0 prediction={pred_255} | Logits: {outputs_255}")

        # Let's also check default raw pixel mapping, if ONNX expects [0, 255.0].
        outputs_raw = session.run([output_name], {input_name: img.astype(np.float32).reshape(1, 1, 28, 28)})[0][0]
        pred_raw = np.argmax(outputs_raw)
        print(f"Image {i} | True label={label} | Raw pixels prediction={pred_raw} | Logits: {outputs_raw}")

        # Choose the normalization scale that yields correct labels matching True labels.
        # This ONNX model was trained using raw pixels [0.0, 255.0] or scaled [0.0, 1.0] (often scaled).
        # We can see whichever gives correct results. Let's inspect confidence and use the correct one.
        gold_logits = outputs_255 if pred_255 == label else outputs_raw
        if pred_255 != label and pred_raw != label:
            print("WARNING: Neither normalization predicts correct label. We will choose standard /255.0.")
            gold_logits = outputs_255

        # Format image pixels as signed Bytes for our INT8 quantization model in SpinalNN.
        # In our QLinearConvPlugin, we quantize the input dynamically with custom q_input scale.
        # Under our compiler, we set:
        #   val q_input = QuantParams(1.0f / 127.0f, 0)
        # This means an input float value of `1.0` becomes `127.toByte` in hardware activations.
        # Therefore, if ONNX expects [0.0, 1.0], we scale x by 127.0, round, and cast toByte.
        # If ONNX expects [0.0, 255.0], we scale x / 255.0 * 127.0 => x * 127.0 / 255.0
        # Let's write out the raw bytes representing the floating point input quantized dynamically.
        # Let's save the exact floating point array, and during our test we will scale by 1.0/127.0
        # representing the floating scale input.
        # Let's save the raw float input array! This is even better, as we can check both float and quantized modes.
        img_floats = (img.astype(np.float32) / 255.0).flatten() if pred_255 == label else img.astype(np.float32).flatten()
        img_floats_str = ", ".join(f"{x:.6f}f" for x in img_floats)

        scala_images_code.append(f"""    // Sample {i}: True Label = {label}
    val sample_{i}_label = {label}
    val sample_{i}_logits = Array({", ".join(f"{x:.6f}f" for x in gold_logits)})
    val sample_{i}_input = Array(
      {img_floats_str}
    )
""")

    # Write Scala file
    scala_content = f"""package spinalnn

object OnnxValidationData {{

{chr(10).join(scala_images_code)}
}}
"""
    with open("src/test/scala/spinalnn/OnnxValidationData.scala", "w") as f:
        f.write(scala_content)
    print("Success! Created src/test/scala/spinalnn/OnnxValidationData.scala")

if __name__ == "__main__":
    main()
