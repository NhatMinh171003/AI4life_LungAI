
# Hướng dẫn cấu hình Git LFS để tải file model `.h5`

## Giới thiệu

Dự án này sử dụng **Git Large File Storage (Git LFS)** để lưu trữ file AI model (`.h5`) có dung lượng lớn.  
Để đảm bảo code hoạt động đúng, bạn cần **cài đặt Git LFS** trước khi clone dự án.



## Các bước cài đặt Git LFS

### 1. Cài Git LFS

#### 🔹 Với Windows (dễ nhất):

- Truy cập: https://git-lfs.github.com/
- Tải và cài file `.exe`

Nếu đã cài rồi thì có thể bỏ qua bước này.

---

### 2. Cấu hình Git LFS (chạy 1 lần duy nhất)

```bash
git lfs install
```



### 3. Clone repo

```bash
git clone https://github.com/Maestro1710/AI4life_LungAI.git
```



### 4. Kiểm tra file `.h5` đã được tải đúng chưa

- Kiểm tra thư mục chứa model (ví dụ: `chest_xray_adamdropmodel`)
- Nếu file `.h5` có dung lượng đầy đủ ( ~138MB) → OK  
- Nếu file chỉ vài dòng text như sau thì **bạn chưa cấu hình Git LFS đúng**:

```
version https://git-lfs.github.com/spec/v1
oid sha256:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
size 123456789
```

---

## 🛠 Nếu bạn quên chạy `git lfs install` trước khi clone

Chỉ cần:

```bash
git lfs install
git lfs pull
```

Git sẽ tải lại file `.h5` thật từ máy chủ Git LFS về.

---

##  Lưu ý quan trọng

- **Không commit file `.h5` trực tiếp**, chỉ push sau khi Git LFS đã theo dõi.

