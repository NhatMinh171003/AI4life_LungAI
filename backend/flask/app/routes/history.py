from flask import Blueprint, jsonify
from app.services.db_service import get_history

history_bp = Blueprint('history_bp', __name__)

@history_bp.route('/history', methods=['GET'])
def history():
    raw_results = get_history(limit=10)
    results = []
    for item in raw_results:
        results.append({
            "label": item['label'],
            "confidence": float(item['confidence']),
            "probabilities": {
                "Pneumonia": float(item['probabilities']['Pneumonia']),
                "Normal": float(item['probabilities']['Normal'])
            },
            "timestamp": item['created_at'],
            "image_base64": item.get("image_base64", ""),
           # "gradcam_base64": item.get("gradcam_base64"),
        }) #Trả về có cả timesttamp 
    return jsonify(results)
