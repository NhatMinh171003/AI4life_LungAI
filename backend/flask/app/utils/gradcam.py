import numpy as np
import tensorflow as tf
import cv2
import base64
from io import BytesIO
from PIL import Image

def make_gradcam_heatmap(img_array, model, last_conv_layer_name):
    # Lấy layer cuối cùng của conv
    grad_model = tf.keras.models.Model(
        [model.inputs], 
        [model.get_layer(last_conv_layer_name).output, model.output]
    )

    with tf.GradientTape() as tape:
        conv_outputs, predictions = grad_model(img_array)
        loss = predictions[:, 0]

    grads = tape.gradient(loss, conv_outputs)
    pooled_grads = tf.reduce_mean(grads, axis=(0, 1, 2))

    conv_outputs = conv_outputs[0]
    heatmap = conv_outputs @ pooled_grads[..., tf.newaxis]
    heatmap = tf.squeeze(heatmap)
    heatmap = tf.maximum(heatmap, 0) / tf.math.reduce_max(heatmap)
    return heatmap.numpy()

def overlay_gradcam(img_pil, heatmap, alpha=0.4):
    # Resize heatmap để khớp với ảnh gốc
    heatmap = cv2.resize(heatmap, img_pil.size)
    heatmap = np.uint8(255 * heatmap)
    heatmap_color = cv2.applyColorMap(heatmap, cv2.COLORMAP_JET)

    img_array = np.array(img_pil)
    if img_array.shape[-1] == 1:
        img_array = np.repeat(img_array, 3, axis=-1)

    # Chồng heatmap lên ảnh gốc
    superimposed_img = heatmap_color * alpha + img_array
    superimposed_img = np.uint8(superimposed_img)

    # Chuyển sang base64
    result_pil = Image.fromarray(superimposed_img)
    buffered = BytesIO()
    result_pil.save(buffered, format="JPEG")
    img_str = base64.b64encode(buffered.getvalue()).decode()
    return f"data:image/jpeg;base64,{img_str}"
