#!/bin/bash

# Android Kernel Flash Script
# Script để flash kernel đã build vào thiết bị Android

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
KERNEL_IMAGE=""
DEVICE_PARTITION="/dev/block/bootdevice/by-name/boot"
BACKUP_DIR="$HOME/kernel-backups"
TEMP_DIR="/tmp/kernel-flash"

# Default values
BACKUP_CURRENT=true
VERIFY_FLASH=true
REBOOT_AFTER_FLASH=false
FORCE_FLASH=false

# Function to print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to show usage
show_usage() {
    echo "Android Kernel Flash Script"
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -k, --kernel IMAGE      Path to kernel image file"
    echo "  -p, --partition PART    Boot partition (default: /dev/block/bootdevice/by-name/boot)"
    echo "  -b, --backup-dir DIR    Backup directory (default: $HOME/kernel-backups)"
    echo "  --no-backup             Skip backing up current kernel"
    echo "  --no-verify             Skip verification after flash"
    echo "  --reboot                Reboot device after successful flash"
    echo "  --force                 Force flash even if verification fails"
    echo "  -h, --help              Show this help"
    echo ""
    echo "Examples:"
    echo "  $0 -k ~/kernel-image.gz"
    echo "  $0 -k ~/kernel-image.gz -p /dev/block/mmcblk0p1"
    echo "  $0 -k ~/kernel-image.gz --reboot --no-backup"
}

# Function to parse command line arguments
parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -k|--kernel)
                KERNEL_IMAGE="$2"
                shift 2
                ;;
            -p|--partition)
                DEVICE_PARTITION="$2"
                shift 2
                ;;
            -b|--backup-dir)
                BACKUP_DIR="$2"
                shift 2
                ;;
            --no-backup)
                BACKUP_CURRENT=false
                shift
                ;;
            --no-verify)
                VERIFY_FLASH=false
                shift
                ;;
            --reboot)
                REBOOT_AFTER_FLASH=true
                shift
                ;;
            --force)
                FORCE_FLASH=true
                shift
                ;;
            -h|--help)
                show_usage
                exit 0
                ;;
            *)
                print_error "Unknown option: $1"
                show_usage
                exit 1
                ;;
        esac
    done
}

# Function to check prerequisites
check_prerequisites() {
    print_info "Kiểm tra prerequisites..."
    
    # Check if running as root
    if [ "$EUID" -ne 0 ]; then
        print_error "Script này cần chạy với quyền root (sudo)"
        exit 1
    fi
    
    # Check if device is connected
    if ! adb devices | grep -q "device$"; then
        print_error "Không tìm thấy thiết bị Android được kết nối"
        print_info "Hãy đảm bảo:"
        print_info "1. USB Debugging được bật"
        print_info "2. Thiết bị được kết nối qua USB"
        print_info "3. ADB drivers đã được cài đặt"
        exit 1
    fi
    
    # Check if kernel image exists
    if [ -z "$KERNEL_IMAGE" ]; then
        print_error "Kernel image không được chỉ định. Sử dụng -k hoặc --kernel"
        exit 1
    fi
    
    if [ ! -f "$KERNEL_IMAGE" ]; then
        print_error "Kernel image không tồn tại: $KERNEL_IMAGE"
        exit 1
    fi
    
    print_success "Tất cả prerequisites đã sẵn sàng"
}

# Function to get device information
get_device_info() {
    print_info "Lấy thông tin thiết bị..."
    
    local device_model=$(adb shell getprop ro.product.model)
    local device_codename=$(adb shell getprop ro.product.device)
    local android_version=$(adb shell getprop ro.build.version.release)
    local kernel_version=$(adb shell uname -r)
    
    print_info "Device Model: $device_model"
    print_info "Device Codename: $device_codename"
    print_info "Android Version: $android_version"
    print_info "Current Kernel: $kernel_version"
}

# Function to backup current kernel
backup_current_kernel() {
    if [ "$BACKUP_CURRENT" = false ]; then
        print_info "Bỏ qua backup kernel hiện tại"
        return
    fi
    
    print_info "Backup kernel hiện tại..."
    
    # Create backup directory
    mkdir -p "$BACKUP_DIR"
    
    # Get current timestamp
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_file="$BACKUP_DIR/kernel_backup_${timestamp}.img"
    
    # Backup current boot partition
    print_info "Đang backup boot partition..."
    if adb shell "dd if=$DEVICE_PARTITION of=/sdcard/kernel_backup.img" && \
       adb pull /sdcard/kernel_backup.img "$backup_file" && \
       adb shell "rm /sdcard/kernel_backup.img"; then
        print_success "Kernel đã được backup tại: $backup_file"
    else
        print_error "Không thể backup kernel hiện tại"
        if [ "$FORCE_FLASH" = false ]; then
            exit 1
        fi
    fi
}

# Function to prepare kernel for flashing
prepare_kernel() {
    print_info "Chuẩn bị kernel để flash..."
    
    # Create temp directory
    mkdir -p "$TEMP_DIR"
    
    # Check if kernel is compressed
    if file "$KERNEL_IMAGE" | grep -q "gzip compressed"; then
        print_info "Kernel image đã được nén (gzip)"
        cp "$KERNEL_IMAGE" "$TEMP_DIR/kernel.img"
    elif file "$KERNEL_IMAGE" | grep -q "data"; then
        print_info "Kernel image không nén"
        cp "$KERNEL_IMAGE" "$TEMP_DIR/kernel.img"
    else
        print_warning "Không xác định được định dạng kernel image"
        cp "$KERNEL_IMAGE" "$TEMP_DIR/kernel.img"
    fi
    
    # Push kernel to device
    print_info "Upload kernel lên thiết bị..."
    if adb push "$TEMP_DIR/kernel.img" /sdcard/kernel_new.img; then
        print_success "Kernel đã được upload lên thiết bị"
    else
        print_error "Không thể upload kernel lên thiết bị"
        exit 1
    fi
}

# Function to flash kernel
flash_kernel() {
    print_info "Bắt đầu flash kernel..."
    
    # Check if device is in fastboot mode
    if fastboot devices | grep -q "fastboot"; then
        print_info "Thiết bị đang ở chế độ fastboot"
        flash_kernel_fastboot
    else
        print_info "Thiết bị đang ở chế độ ADB"
        flash_kernel_adb
    fi
}

# Function to flash kernel via ADB
flash_kernel_adb() {
    print_info "Flash kernel qua ADB..."
    
    # Remount system as read-write
    adb shell "su -c 'mount -o remount,rw /system'"
    
    # Flash kernel
    if adb shell "su -c 'dd if=/sdcard/kernel_new.img of=$DEVICE_PARTITION'"; then
        print_success "Kernel đã được flash thành công"
    else
        print_error "Không thể flash kernel"
        exit 1
    fi
    
    # Clean up
    adb shell "rm /sdcard/kernel_new.img"
}

# Function to flash kernel via fastboot
flash_kernel_fastboot() {
    print_info "Flash kernel qua fastboot..."
    
    # Reboot to fastboot if needed
    if ! fastboot devices | grep -q "fastboot"; then
        print_info "Reboot thiết bị vào fastboot mode..."
        adb reboot bootloader
        sleep 10
    fi
    
    # Flash kernel
    if fastboot flash boot "$KERNEL_IMAGE"; then
        print_success "Kernel đã được flash thành công"
    else
        print_error "Không thể flash kernel"
        exit 1
    fi
}

# Function to verify flash
verify_flash() {
    if [ "$VERIFY_FLASH" = false ]; then
        print_info "Bỏ qua verification"
        return
    fi
    
    print_info "Xác minh kernel đã được flash..."
    
    # Wait for device to be ready
    sleep 5
    
    # Check if device is accessible
    if ! adb devices | grep -q "device$"; then
        print_warning "Không thể kết nối với thiết bị để verification"
        return
    fi
    
    # Get new kernel version
    local new_kernel_version=$(adb shell uname -r)
    print_info "Kernel version sau khi flash: $new_kernel_version"
    
    # Check if kernel is working
    if adb shell "cat /proc/version" | grep -q "$new_kernel_version"; then
        print_success "Kernel đã được flash và hoạt động bình thường"
    else
        print_error "Kernel có thể không hoạt động đúng"
        if [ "$FORCE_FLASH" = false ]; then
            print_info "Hãy restore kernel backup nếu cần thiết"
        fi
    fi
}

# Function to reboot device
reboot_device() {
    if [ "$REBOOT_AFTER_FLASH" = false ]; then
        print_info "Không reboot thiết bị"
        return
    fi
    
    print_info "Reboot thiết bị..."
    adb reboot
    print_success "Thiết bị đang reboot..."
}

# Function to cleanup
cleanup() {
    print_info "Dọn dẹp temporary files..."
    rm -rf "$TEMP_DIR"
    print_success "Cleanup hoàn thành"
}

# Function to show recovery instructions
show_recovery_instructions() {
    print_info "Hướng dẫn khôi phục kernel nếu cần:"
    echo ""
    echo "1. Kết nối thiết bị với máy tính"
    echo "2. Boot vào recovery mode (TWRP/CWM)"
    echo "3. Mount system partition"
    echo "4. Restore kernel backup từ: $BACKUP_DIR"
    echo "5. Reboot thiết bị"
    echo ""
    echo "Hoặc sử dụng fastboot:"
    echo "fastboot flash boot [backup_file.img]"
}

# Main function
main() {
    echo "=========================================="
    echo "    ANDROID KERNEL FLASH SCRIPT"
    echo "=========================================="
    
    # Parse arguments
    parse_args "$@"
    
    # Check prerequisites
    check_prerequisites
    
    # Get device information
    get_device_info
    
    # Backup current kernel
    backup_current_kernel
    
    # Prepare kernel
    prepare_kernel
    
    # Flash kernel
    flash_kernel
    
    # Verify flash
    verify_flash
    
    # Reboot device
    reboot_device
    
    # Cleanup
    cleanup
    
    print_success "Hoàn thành flash kernel Android!"
    show_recovery_instructions
}

# Trap to cleanup on exit
trap cleanup EXIT

# Run main function
main "$@"