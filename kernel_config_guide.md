# Hướng Dẫn Cấu Hình Kernel Android

## Tổng Quan

Việc cấu hình kernel Android là bước quan trọng để tối ưu hóa hiệu suất, tiết kiệm pin, và thêm các tính năng mới cho thiết bị của bạn.

## 1. Các Loại Defconfig

### 1.1 Defconfig Cơ Bản
- `defconfig`: Cấu hình mặc định cho ARM64
- `allmodconfig`: Bao gồm tất cả modules có thể
- `allnoconfig`: Cấu hình tối thiểu
- `tinyconfig`: Cấu hình rất nhỏ gọn

### 1.2 Defconfig Theo Device
- `lineageos_[device]_defconfig`: Cho LineageOS
- `android_[device]_defconfig`: Cho AOSP
- `[manufacturer]_[device]_defconfig`: Theo nhà sản xuất

## 2. Các Tùy Chọn Cấu Hình Quan Trọng

### 2.1 CPU Governor
```bash
# Interactive Governor (Mặc định, cân bằng hiệu suất/pin)
CONFIG_CPU_FREQ_GOV_INTERACTIVE=y

# Performance Governor (Hiệu suất tối đa)
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y

# Powersave Governor (Tiết kiệm pin tối đa)
CONFIG_CPU_FREQ_GOV_POWERSAVE=y

# Ondemand Governor (Tự động điều chỉnh)
CONFIG_CPU_FREQ_GOV_ONDEMAND=y

# Schedutil Governor (Mới, hiệu quả hơn)
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
```

### 2.2 I/O Scheduler
```bash
# CFQ Scheduler (Mặc định, cân bằng)
CONFIG_IOSCHED_CFQ=y

# Deadline Scheduler (Tốt cho SSD)
CONFIG_IOSCHED_DEADLINE=y

# Noop Scheduler (Đơn giản, ít overhead)
CONFIG_IOSCHED_NOOP=y

# BFQ Scheduler (Tốt cho desktop, ít phù hợp mobile)
CONFIG_IOSCHED_BFQ=y
```

### 2.3 Memory Management
```bash
# ZRAM (Nén RAM)
CONFIG_ZRAM=y
CONFIG_ZRAM_WRITEBACK=y

# ZSWAP (Nén swap)
CONFIG_ZSWAP=y

# KSM (Kernel Samepage Merging)
CONFIG_KSM=y

# Transparent Huge Pages
CONFIG_TRANSPARENT_HUGEPAGE=y
```

### 2.4 Power Management
```bash
# CPU Idle
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_MENU=y

# CPU Hotplug
CONFIG_HOTPLUG_CPU=y

# Suspend to RAM
CONFIG_SUSPEND=y
CONFIG_PM_SLEEP=y

# Wake Locks
CONFIG_PM_WAKELOCKS=y
```

### 2.5 Security Features
```bash
# SELinux
CONFIG_SECURITY_SELINUX=y

# AppArmor
CONFIG_SECURITY_APPARMOR=y

# Stack Protector
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y

# KASAN (Kernel Address Sanitizer)
CONFIG_KASAN=y
```

## 3. Cách Cấu Hình Kernel

### 3.1 Sử Dụng menuconfig
```bash
cd kernel-source
make menuconfig
```

### 3.2 Sử Dụng nconfig (Giao diện mới)
```bash
cd kernel-source
make nconfig
```

### 3.3 Sử Dụng xconfig (GUI)
```bash
cd kernel-source
make xconfig
```

### 3.4 Chỉnh Sửa Defconfig Trực Tiếp
```bash
# Mở file defconfig
nano arch/arm64/configs/your_defconfig

# Thêm hoặc sửa các dòng cấu hình
CONFIG_OPTION_NAME=y
# CONFIG_OPTION_NAME is not set
CONFIG_OPTION_NAME=m
```

## 4. Các Tùy Chọn Tối Ưu Hóa

### 4.1 Tối Ưu Hiệu Suất
```bash
# CPU Frequency Scaling
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

# GPU Frequency Scaling
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y

# I/O Optimization
CONFIG_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_DEADLINE=y

# Memory Optimization
CONFIG_ZRAM=y
CONFIG_ZSWAP=y
CONFIG_KSM=y
```

### 4.2 Tối Ưu Pin
```bash
# CPU Idle
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_MENU=y

# Power Management
CONFIG_PM=y
CONFIG_PM_SLEEP=y
CONFIG_SUSPEND=y

# Thermal Management
CONFIG_THERMAL=y
CONFIG_CPU_THERMAL=y

# Dynamic Frequency Scaling
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
```

### 4.3 Tối Ưu Kích Thước
```bash
# Disable Debug Features
# CONFIG_DEBUG_KERNEL is not set
# CONFIG_DEBUG_INFO is not set

# Disable Unused Drivers
# CONFIG_SOUND is not set
# CONFIG_USB_SUPPORT is not set

# Enable Module Support
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
```

## 5. Các Tùy Chọn Nâng Cao

### 5.1 Kernel Debugging
```bash
# KGDB (Kernel Debugger)
CONFIG_KGDB=y
CONFIG_KGDB_SERIAL_CONSOLE=y

# Ftrace
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y

# Kprobes
CONFIG_KPROBES=y
CONFIG_KRETPROBES=y
```

### 5.2 Virtualization
```bash
# KVM Support
CONFIG_KVM=y
CONFIG_KVM_ARM_HOST=y

# Xen Support
CONFIG_XEN=y
```

### 5.3 Networking
```bash
# Advanced Networking
CONFIG_NET=y
CONFIG_INET=y
CONFIG_IPV6=y

# Wireless
CONFIG_WIRELESS=y
CONFIG_CFG80211=y
CONFIG_MAC80211=y
```

## 6. Kiểm Tra Cấu Hình

### 6.1 Xem Cấu Hình Hiện Tại
```bash
# Xem tất cả cấu hình
zcat /proc/config.gz

# Xem cấu hình cụ thể
grep CONFIG_OPTION_NAME /proc/config.gz
```

### 6.2 So Sánh Cấu Hình
```bash
# So sánh với defconfig gốc
diff .config arch/arm64/configs/defconfig

# So sánh với cấu hình khác
diff .config other_config
```

## 7. Lưu Ý Quan Trọng

### 7.1 Tương Thích
- Đảm bảo cấu hình tương thích với device tree
- Kiểm tra dependencies giữa các options
- Test kỹ trước khi flash vào thiết bị

### 7.2 Performance vs Battery
- Cân bằng giữa hiệu suất và thời lượng pin
- Sử dụng governor phù hợp với nhu cầu
- Tối ưu I/O scheduler cho storage type

### 7.3 Security
- Luôn enable SELinux
- Cập nhật security patches
- Kiểm tra CVE vulnerabilities

## 8. Troubleshooting

### 8.1 Build Errors
```bash
# Clean build
make clean
make mrproper

# Check dependencies
make olddefconfig

# Verbose build
make V=1
```

### 8.2 Runtime Issues
```bash
# Check kernel logs
dmesg | grep -i error

# Check system logs
logcat | grep -i kernel

# Check hardware compatibility
cat /proc/cpuinfo
cat /proc/meminfo
```

## 9. Scripts Hữu Ích

### 9.1 Script Kiểm Tra Cấu Hình
```bash
#!/bin/bash
echo "=== Kernel Configuration Check ==="
echo "CPU Governors:"
grep -E "CONFIG_CPU_FREQ_GOV" .config
echo ""
echo "I/O Schedulers:"
grep -E "CONFIG_IOSCHED" .config
echo ""
echo "Memory Management:"
grep -E "CONFIG_ZRAM|CONFIG_ZSWAP|CONFIG_KSM" .config
```

### 9.2 Script Tối Ưu Hóa
```bash
#!/bin/bash
# Tối ưu hóa cấu hình kernel
sed -i 's/CONFIG_CPU_FREQ_GOV_INTERACTIVE=y/CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y/' .config
sed -i 's/CONFIG_IOSCHED_CFQ=y/CONFIG_IOSCHED_DEADLINE=y/' .config
make olddefconfig
```

## 10. Kết Luận

Cấu hình kernel Android là một quá trình phức tạp cần hiểu biết sâu về hệ thống. Hãy bắt đầu với cấu hình cơ bản và từ từ tối ưu hóa theo nhu cầu sử dụng của bạn.

**Lưu ý quan trọng**: Luôn backup cấu hình gốc và test kỹ trước khi áp dụng vào thiết bị chính!