from PIL import Image
import numpy as np

TARGET_SIZE = (224, 224)

def preprocess(img_pil: Image.Image) -> np.ndarray:
    img = img_pil.convert("RGB").resize(TARGET_SIZE, Image.Resampling.LANCZOS)
    arr = np.asarray(img, dtype=np.float32) / 255.0
    return arr[np.newaxis, ...]
