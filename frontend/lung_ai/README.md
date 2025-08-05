# LungAI

Dự án phát hiện bệnh viêm phổi qua ảnh X-quang bằng AI

## Giới thiệu
- ## Mô tả
Đây là ứng dụng Flutter dùng để chẩn đoán bệnh phổi qua ảnh X-quang, sử dụng **AI (CNN)** phía backend bằng **Flask(API RESTful)** và **MongoDB** để lưu lịch sử
- Ứng dụng hỗ trợ xem lịch sử chuẩn đoán và chi tiết từng kết quả
- Ứng dụng chạy trên window, macOS, linux
## Yêu cầu hệ thống
- Flutter SDK (https://docs.flutter.dev/get-started/install)
- Git
- IDE: VS Code, Android Studio hoặc tương đương
- Kết nối Internet

## Cài đặt
1. Cài đặt các package:
   ```sh
   flutter pub get
   ```
2. Chạy ứng dụng:
   - Desktop (Windows/Linux/macOS):
     ```sh
     flutter run -d windows
     ```
     (Thay 'windows' bằng nền tảng của bạn nếu cần)

## Lưu ý
- Đảm bảo server backend (Flask) đang chạy và API endpoint đúng như trong file `lib/services/history_service.dart`.
- Nếu sử dụng ảnh hoặc tài nguyên ngoài, kiểm tra lại đường dẫn assets.

## Hỗ trợ
- Nếu gặp lỗi, chạy lệnh sau để kiểm tra môi trường:
```sh
flutter doctor
```
- Nếu đổi đường dẫn thư mục dự án và gặp lỗi khi chạy **"CMake Error: The current CMakeCache.txt directory"** , đây là lỗi do CMake vẫn lưu dường dẫn cũ trong file
```sh
flutter clean 
```
```sh
   flutter pub get
```

## Ví dụ  sử dụng
1. Mở ứng dụng FLutter
2. Thiết lập kết nối csdl MongoDB
3. Chạy Flask backend
4. Bấm chọn ảnh X - Quang và xem kết quả
5. Bấm vào phần lịch sử để hiển thị danh sách kết quả chuẩn đoán trước đó
6. Bấm vào 1 kết quả đã chuẩn đoán trong lịch sử để xem  chi tiết

