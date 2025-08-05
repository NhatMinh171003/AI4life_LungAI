# Hệ thống Chẩn đoán Viêm phổi từ Ảnh X-quang 

- Dự án này sử dụng Deep Learning để phân loại ảnh X-quang ngực, phát hiện viêm phổi với độ chính xác cao. 
- Hệ thống được xây dựng bằng **Flask (API RESTful)** và tích hợp MongoDB để lưu trữ lịch sử chẩn đoán.

## Tính năng chính

- **Chuẩn đoán tự động**: Phân loại ảnh X-quang thành "Normal" hoặc "Pneumonia"
- **Độ tin cậy**: Hiển thị độ chính xác của kết quả dự đoán
- **Lịch sử chẩn đoán**: Lưu trữ và truy xuất lịch sử các lần chẩn đoán
- **API RESTful**: Giao diện API dễ sử dụng

## Yêu cầu hệ thống

- Python 3.9 - 3.12
- TensorFlow 2.13 +
- MongoDB (community edition chạy local  https://www.mongodb.com/try/download/community )
- Flask

## Cài đặt

1. Cài đặt dependencies
```bash
pip install -r requirements.txt
```

2. Cấu hình MongoDB
Đảm bảo MongoDB đang chạy và cập nhật chuỗi kết nối trong [`app/config.py`](app/config.py)

3. Chạy ứng dụng
```bash
python run.py
```

## 🔧 API Endpoints

### POST /predict
Chẩn đoán ảnh X-quang ngực

**Request:**
- Method: POST
- Content-Type: multipart/form-data
- Body: File ảnh (JPEG, PNG)

**Response:**
```json
[
  {
    "label": "Pneumonia",
    "confidence": 85.42,
    "probabilities": {
                "Pneumonia":85.42 ,
                "Normal": 14.58,
            },
    "timestamp": "2024-01-15T10:30:00",
    "image_base64": "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAgGBgcGBQgHBwc…",
  }
]
```

### GET /history
Lấy lịch sử chẩn đoán

**Response:**
```json
[
  {
    "label": "Pneumonia",
    "confidence": 85.42,
    "probabilities": {
                "Pneumonia":85.42 ,
                "Normal": 14.58,
            },
    "timestamp": "2024-01-15T10:30:00",
    "image_base64": "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAgGBgcGBQgHBwc…",
  }
]
```


## Mô hình AI

- **Kiến trúc**: Convolutional Neural Network (CNN)
- **Optimizer**: Adam với Dropout
- **Ngưỡng phân loại**: 0.65 (có thể điều chỉnh trong (app/services/model_service.py))
- **File mô hình**: `chest_xray_adamdropmodel.h5`

### Cách hoạt động:
1. Ảnh đầu vào được tiền xử lý (resize, normalize)
2. Mô hình CNN dự đoán xác suất viêm phổi
3. Kết quả được phân loại dựa trên ngưỡng 0.65

## Cấu hình

Chỉnh sửa [`app/config.py`](app/config.py) để cấu hình:

- Chuỗi kết nối MongoDB
- Các tham số khác

## Xử lý lỗi

- **Import TensorFlow lỗi**: Đảm bảo đã cài đặt đúng version TensorFlow
- **Kết nối MongoDB lỗi**: Kiểm tra MongoDB service và chuỗi kết nối
- **File model không tìm thấy**: Đảm bảo file `chest_xray_adamdropmodel.h5` ở đúng vị trí

## Ghi chú

- Dự án hỗ trợ các định dạng ảnh: JPEG, PNG
- Kích thước ảnh đầu vào được tự động điều chỉnh
- Lịch sử chẩn đoán được lưu trữ vĩnh viễn trong MongoDB
