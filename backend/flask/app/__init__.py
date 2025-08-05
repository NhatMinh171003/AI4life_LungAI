from flask import Flask
from pymongo import MongoClient
import tensorflow as tf
import os 
import sys
model = None
mongo = None

def create_app() :
    global model, mongo
    app = Flask (__name__)
    app.config.from_object("app.config.Config")

    # === Xử lý đường dẫn model tương thích PyInstaller
    if getattr(sys, 'frozen', False):
        # App đang chạy dưới dạng .exe được build bởi PyInstaller
        base_path = sys._MEIPASS
    else:
        # App chạy bằng Python bình thường
        # Đi lên 1 cấp từ thư mục hiện tại (app/) lên thư mục gốc (flask/)
        base_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))

    # Đường dẫn đến model .h5 nằm ở thư mục gốc
    model_path = os.path.join(base_path, "chest_xray_adamdropmodel.h5")

    # Load model
    model = tf.keras.models.load_model(model_path)
    model.summary()

    #MongoDB connect
    mongo = MongoClient(app.config["MONGO_URI"])

    #Routes
    from app.routes.predict import predict_bp
    from app.routes.history import history_bp
    app.register_blueprint(predict_bp)
    app.register_blueprint(history_bp)

    return app
