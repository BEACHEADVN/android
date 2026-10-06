# Hướng Dẫn Build Kernel Android

Bộ công cụ hoàn chỉnh để build và flash kernel Android từ source code.

## 📋 Danh Sách Files

- `setup_android_kernel_build.sh` - Script cài đặt môi trường build
- `build_android_kernel.sh` - Script build kernel chính
- `flash_android_kernel.sh` - Script flash kernel vào thiết bị
- `kernel_config_guide.md` - Hướng dẫn cấu hình kernel chi tiết
- `kernel.sh` - Script kiểm tra thông tin kernel hiện tại

## 🚀 Bắt Đầu Nhanh

### 1. Cài Đặt Môi Trường
```bash
chmod +x setup_android_kernel_build.sh
./setup_android_kernel_build.sh
```

### 2. Build Kernel
```bash
chmod +x build_android_kernel.sh
./build_android_kernel.sh -s ~/kernel-source -d oneplus8 -c lineageos_oneplus8_defconfig
```

### 3. Flash Kernel
```bash
chmod +x flash_android_kernel.sh
sudo ./flash_android_kernel.sh -k ~/android-kernel-build/output/kernel-oneplus8-*/Image.gz --reboot
```

## 📖 Hướng Dẫn Chi Tiết

### Bước 1: Chuẩn Bị Môi Trường

Chạy script setup để cài đặt tất cả dependencies cần thiết:

```bash
./setup_android_kernel_build.sh
```

Script này sẽ cài đặt:
- Build tools (gcc, make, etc.)
- Android SDK tools
- ARM64 cross-compiler
- Clang compiler
- Repo tool

### Bước 2: Lấy Kernel Source

Có 2 cách để lấy kernel source:

#### Cách 1: Clone từ Git Repository
```bash
# Ví dụ với LineageOS kernel
git clone https://github.com/LineageOS/android_kernel_oneplus_sm8250.git ~/kernel-source
```

#### Cách 2: Sử dụng Repo Tool
```bash
mkdir ~/android-source
cd ~/android-source
repo init -u https://github.com/LineageOS/android.git -b lineage-20.0
repo sync kernel/oneplus/sm8250
```

### Bước 3: Cấu Hình Kernel

#### Sử Dụng Defconfig Có Sẵn
```bash
cd ~/kernel-source
make lineageos_oneplus8_defconfig
```

#### Tùy Chỉnh Cấu Hình
```bash
cd ~/kernel-source
make menuconfig
# Hoặc
make nconfig
```

Xem `kernel_config_guide.md` để biết các tùy chọn cấu hình quan trọng.

### Bước 4: Build Kernel

#### Build Cơ Bản
```bash
./build_android_kernel.sh -s ~/kernel-source -d oneplus8
```

#### Build Với Tùy Chọn
```bash
./build_android_kernel.sh \
  -s ~/kernel-source \
  -d oneplus8 \
  -c lineageos_oneplus8_defconfig \
  -t userdebug \
  -j 8 \
  --clean \
  --verbose
```

#### Các Tham Số:
- `-s, --source`: Đường dẫn kernel source hoặc git URL
- `-d, --device`: Tên device (oneplus8, pixel4, etc.)
- `-c, --config`: Defconfig file
- `-t, --type`: Build type (user, userdebug, eng)
- `-j, --jobs`: Số luồng build song song
- `--clean`: Clean build directory trước khi build
- `--verbose`: Hiển thị output chi tiết

### Bước 5: Flash Kernel

#### Chuẩn Bị Thiết Bị
1. Bật USB Debugging trong Developer Options
2. Kết nối thiết bị với máy tính
3. Cho phép USB Debugging khi được hỏi

#### Flash Kernel
```bash
sudo ./flash_android_kernel.sh -k ~/android-kernel-build/output/kernel-oneplus8-*/Image.gz
```

#### Flash Với Tùy Chọn
```bash
sudo ./flash_android_kernel.sh \
  -k ~/android-kernel-build/output/kernel-oneplus8-*/Image.gz \
  -p /dev/block/bootdevice/by-name/boot \
  --reboot \
  --no-backup
```

#### Các Tham Số:
- `-k, --kernel`: Đường dẫn kernel image
- `-p, --partition`: Boot partition
- `--no-backup`: Bỏ qua backup kernel hiện tại
- `--no-verify`: Bỏ qua verification sau flash
- `--reboot`: Reboot thiết bị sau khi flash
- `--force`: Force flash ngay cả khi verification thất bại

## 🔧 Cấu Hình Nâng Cao

### Tối Ưu Hóa Hiệu Suất

1. **CPU Governor**: Sử dụng `schedutil` thay vì `interactive`
2. **I/O Scheduler**: Sử dụng `deadline` cho SSD
3. **Memory Management**: Bật ZRAM và ZSWAP
4. **Thermal Management**: Cấu hình thermal throttling

### Tối Ưu Hóa Pin

1. **CPU Idle**: Bật CPU idle states
2. **Power Management**: Cấu hình suspend/resume
3. **Frequency Scaling**: Sử dụng governor tiết kiệm pin
4. **Background Tasks**: Giới hạn background processes

### Tối Ưu Hóa Kích Thước

1. **Disable Debug**: Tắt debug features
2. **Module Support**: Build drivers as modules
3. **Unused Drivers**: Loại bỏ drivers không cần thiết
4. **Compression**: Sử dụng compression cho kernel image

## 🐛 Troubleshooting

### Lỗi Build

#### Lỗi Compiler
```bash
# Kiểm tra cross-compiler
aarch64-linux-gnu-gcc --version

# Cài đặt lại nếu cần
sudo apt install --reinstall gcc-aarch64-linux-gnu
```

#### Lỗi Dependencies
```bash
# Cài đặt dependencies thiếu
sudo apt install build-essential libssl-dev libncurses5-dev

# Cập nhật package list
sudo apt update
```

#### Lỗi Configuration
```bash
# Clean và reconfigure
make clean
make mrproper
make defconfig
```

### Lỗi Flash

#### Device Không Kết Nối
```bash
# Kiểm tra ADB connection
adb devices

# Restart ADB server
adb kill-server
adb start-server
```

#### Permission Denied
```bash
# Chạy với sudo
sudo ./flash_android_kernel.sh -k kernel-image

# Hoặc thêm user vào dialout group
sudo usermod -a -G dialout $USER
```

#### Boot Loop
1. Boot vào recovery mode
2. Restore kernel backup
3. Kiểm tra lại cấu hình kernel
4. Build lại với cấu hình ổn định hơn

## 📚 Tài Liệu Tham Khảo

- [Android Kernel Development](https://source.android.com/docs/setup/build/kernel)
- [LineageOS Kernel Development](https://wiki.lineageos.org/kernel/)
- [AOSP Kernel Configuration](https://source.android.com/docs/setup/build/kernel#configuring-the-kernel)
- [ARM64 Linux Kernel](https://www.kernel.org/doc/Documentation/arm64/)

## ⚠️ Lưu Ý Quan Trọng

1. **Backup**: Luôn backup kernel gốc trước khi flash
2. **Testing**: Test kernel trên thiết bị test trước khi dùng chính
3. **Compatibility**: Đảm bảo kernel tương thích với ROM
4. **Security**: Cập nhật security patches thường xuyên
5. **Warranty**: Flash kernel có thể void warranty

## 🤝 Đóng Góp

Nếu bạn tìm thấy bug hoặc có đề xuất cải thiện, hãy tạo issue hoặc pull request.

## 📄 License

MIT License - Xem file LICENSE để biết thêm chi tiết.

---

**Chúc bạn build kernel thành công! 🎉**