from flask import Blueprint, request, jsonify
from PIL import Image, UnidentifiedImageError
from app.services.model_service import predict_label
from app.services.db_service import save_history
import io

predict_bp = Blueprint("predict", __name__)

@predict_bp.route("/predict", methods=["POST"])
def predict():
    if "image" not in request.files:
        return jsonify({"error": "No image uploaded"}), 400

    file = request.files["image"]

    # Kiểm tra định dạng file hợp lệ
    if not file.filename.lower().endswith(('.jpg', '.jpeg', '.png')):
        return jsonify({"error": "Invalid image format. Please upload JPG or PNG"}), 400

    try:
        # Đọc ảnh và xác minh ảnh hợp lệ
        image_bytes = file.read()
        image = Image.open(io.BytesIO(image_bytes))
        image.verify()  # Kiểm tra xem có phải ảnh thật không
        image = Image.open(io.BytesIO(image_bytes))  # Mở lại ảnh để dùng sau verify

        result = predict_label(image)
        save_history(result)

        return jsonify(result)

    except UnidentifiedImageError:
        return jsonify({"error": "File không phải là ảnh hợp lệ"}), 400
    except Exception as e:
        return jsonify({"error": str(e)}), 500
