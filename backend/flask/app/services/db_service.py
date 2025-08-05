from datetime import datetime, timezone
from app import mongo
from app.config import Config

def save_history(result) :
    db = mongo[Config.DB_NAME]
    db.history.insert_one({
        **result,
        "created_at" : datetime.now(timezone.utc),
        "image_base64": result["image_base64"],
       # "gradcam_base64": result["gradcam_base64"]
    })

def get_history (limit = 10) :
    db = mongo[Config.DB_NAME]
    return list(db.history.find().sort("created_at", -1).limit(limit))  