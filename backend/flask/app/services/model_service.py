import numpy as np
from app import model
from app.utils.preprocess import preprocess
import base64
from io import BytesIO
from app.utils.gradcam import make_gradcam_heatmap, overlay_gradcam
def predict_label(img_pil):
    x = preprocess(img_pil)
    prob = float(model.predict(x)[0][0])
    label = "Pneumonia" if prob >= 0.65 else "Normal"
    confidence = prob * 100 if label == "Pneumonia" else (1 - prob) * 100
    #chyển ảnh về base64 để lưu vào môngdb
    buffered = BytesIO()
    img_pil.save(buffered, format="JPEG")
    img_str = base64.b64encode(buffered.getvalue()).decode()
    #gradcam
    #heatmap = make_gradcam_heatmap(x, model, last_conv_layer_name="conv2d_2")
    #gradcam_base64 = overlay_gradcam(img_pil, heatmap)

    return {
        "label": label,
        "confidence": round(confidence, 2),
        "probabilities": {
            "Pneumonia": round(prob * 100, 2),
            "Normal": round((1 - prob) * 100, 2)
        },
        "image_base64": f"data:image/jpeg;base64,{img_str}",
        #"gradcam_base64": gradcam_base64
    }
