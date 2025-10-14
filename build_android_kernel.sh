#!/bin/bash

# Android Kernel Build Script
# Script chính để build kernel Android từ source code

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
KERNEL_WORKSPACE="$HOME/android-kernel-build"
BUILD_DIR="$KERNEL_WORKSPACE/build"
OUTPUT_DIR="$KERNEL_WORKSPACE/output"

# Default values
KERNEL_SOURCE=""
DEVICE_CODENAME=""
KERNEL_DEFCONFIG=""
BUILD_TYPE="user"  # user, userdebug, eng
JOBS=$(nproc)  # Number of parallel jobs
CLEAN_BUILD=false
VERBOSE=false

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
    echo "Android Kernel Build Script"
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -s, --source SOURCE     Kernel source directory or git URL"
    echo "  -d, --device DEVICE     Device codename (e.g., oneplus8, pixel4)"
    echo "  -c, --config CONFIG     Kernel defconfig (e.g., lineageos_oneplus8_defconfig)"
    echo "  -t, --type TYPE         Build type: user, userdebug, eng (default: user)"
    echo "  -j, --jobs JOBS         Number of parallel jobs (default: $(nproc))"
    echo "  --clean                 Clean build directory before building"
    echo "  -v, --verbose           Verbose output"
    echo "  -h, --help              Show this help"
    echo ""
    echo "Examples:"
    echo "  $0 -s ~/kernel-source -d oneplus8 -c lineageos_oneplus8_defconfig"
    echo "  $0 -s https://github.com/LineageOS/android_kernel_oneplus_sm8250.git -d oneplus8"
    echo "  $0 --clean -s ~/kernel-source -d pixel4 -c lineageos_pixel4_defconfig"
}

# Function to parse command line arguments
parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -s|--source)
                KERNEL_SOURCE="$2"
                shift 2
                ;;
            -d|--device)
                DEVICE_CODENAME="$2"
                shift 2
                ;;
            -c|--config)
                KERNEL_DEFCONFIG="$2"
                shift 2
                ;;
            -t|--type)
                BUILD_TYPE="$2"
                shift 2
                ;;
            -j|--jobs)
                JOBS="$2"
                shift 2
                ;;
            --clean)
                CLEAN_BUILD=true
                shift
                ;;
            -v|--verbose)
                VERBOSE=true
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
    
    # Check if required tools are installed
    local missing_tools=()
    
    command -v make >/dev/null 2>&1 || missing_tools+=("make")
    command -v gcc >/dev/null 2>&1 || missing_tools+=("gcc")
    command -v aarch64-linux-gnu-gcc >/dev/null 2>&1 || missing_tools+=("gcc-aarch64-linux-gnu")
    command -v clang >/dev/null 2>&1 || missing_tools+=("clang")
    command -v git >/dev/null 2>&1 || missing_tools+=("git")
    
    if [ ${#missing_tools[@]} -ne 0 ]; then
        print_error "Missing required tools: ${missing_tools[*]}"
        print_info "Chạy script setup trước: ./setup_android_kernel_build.sh"
        exit 1
    fi
    
    print_success "Tất cả prerequisites đã sẵn sàng"
}

# Function to setup kernel source
setup_kernel_source() {
    print_info "Thiết lập kernel source..."
    
    if [ -z "$KERNEL_SOURCE" ]; then
        print_error "Kernel source không được chỉ định. Sử dụng -s hoặc --source"
        exit 1
    fi
    
    # Check if source is a git URL
    if [[ $KERNEL_SOURCE == http* ]] || [[ $KERNEL_SOURCE == git* ]]; then
        print_info "Cloning kernel source từ: $KERNEL_SOURCE"
        if [ -d "$BUILD_DIR/kernel" ]; then
            rm -rf "$BUILD_DIR/kernel"
        fi
        git clone "$KERNEL_SOURCE" "$BUILD_DIR/kernel"
        cd "$BUILD_DIR/kernel"
    else
        # Local directory
        if [ ! -d "$KERNEL_SOURCE" ]; then
            print_error "Kernel source directory không tồn tại: $KERNEL_SOURCE"
            exit 1
        fi
        print_info "Sử dụng kernel source local: $KERNEL_SOURCE"
        if [ -d "$BUILD_DIR/kernel" ]; then
            rm -rf "$BUILD_DIR/kernel"
        fi
        cp -r "$KERNEL_SOURCE" "$BUILD_DIR/kernel"
        cd "$BUILD_DIR/kernel"
    fi
    
    # Check if it's a valid kernel source
    if [ ! -f "Makefile" ] || [ ! -d "arch" ]; then
        print_error "Đây không phải là kernel source hợp lệ"
        exit 1
    fi
    
    print_success "Kernel source đã sẵn sàng"
}

# Function to setup build environment
setup_build_env() {
    print_info "Thiết lập build environment..."
    
    # Create build directories
    mkdir -p "$BUILD_DIR"
    mkdir -p "$OUTPUT_DIR"
    
    # Set environment variables
    export ARCH=arm64
    export SUBARCH=arm64
    export CROSS_COMPILE=aarch64-linux-gnu-
    export KBUILD_BUILD_USER=android-builder
    export KBUILD_BUILD_HOST=build-server
    export KBUILD_BUILD_TIMESTAMP=$(date)
    
    # Set Android build environment
    if [ -n "$ANDROID_HOME" ]; then
        export PATH="$PATH:$ANDROID_HOME/platform-tools"
    fi
    
    print_success "Build environment đã sẵn sàng"
}

# Function to configure kernel
configure_kernel() {
    print_info "Cấu hình kernel..."
    
    cd "$BUILD_DIR/kernel"
    
    if [ -z "$KERNEL_DEFCONFIG" ]; then
        # Try to find defconfig automatically
        if [ -n "$DEVICE_CODENAME" ]; then
            # Look for device-specific defconfig
            local defconfigs=($(find arch/arm64/configs -name "*${DEVICE_CODENAME}*" 2>/dev/null))
            if [ ${#defconfigs[@]} -gt 0 ]; then
                KERNEL_DEFCONFIG=$(basename "${defconfigs[0]}" .defconfig)
                print_info "Tự động tìm thấy defconfig: $KERNEL_DEFCONFIG"
            else
                print_warning "Không tìm thấy defconfig cho device: $DEVICE_CODENAME"
                print_info "Sử dụng defconfig mặc định: defconfig"
                KERNEL_DEFCONFIG="defconfig"
            fi
        else
            KERNEL_DEFCONFIG="defconfig"
        fi
    fi
    
    print_info "Sử dụng defconfig: $KERNEL_DEFCONFIG"
    
    # Clean if requested
    if [ "$CLEAN_BUILD" = true ]; then
        print_info "Cleaning build directory..."
        make clean
        make mrproper
    fi
    
    # Configure kernel
    make "$KERNEL_DEFCONFIG"
    
    print_success "Kernel đã được cấu hình"
}

# Function to build kernel
build_kernel() {
    print_info "Bắt đầu build kernel..."
    print_info "Build type: $BUILD_TYPE"
    print_info "Parallel jobs: $JOBS"
    
    cd "$BUILD_DIR/kernel"
    
    # Build kernel
    local build_cmd="make -j$JOBS"
    if [ "$VERBOSE" = true ]; then
        build_cmd="$build_cmd V=1"
    fi
    
    print_info "Chạy lệnh: $build_cmd"
    
    if eval $build_cmd; then
        print_success "Kernel build thành công!"
    else
        print_error "Kernel build thất bại!"
        exit 1
    fi
}

# Function to package kernel
package_kernel() {
    print_info "Đóng gói kernel..."
    
    cd "$BUILD_DIR/kernel"
    
    # Find kernel image
    local kernel_image=""
    if [ -f "arch/arm64/boot/Image.gz" ]; then
        kernel_image="arch/arm64/boot/Image.gz"
    elif [ -f "arch/arm64/boot/Image" ]; then
        kernel_image="arch/arm64/boot/Image"
    else
        print_error "Không tìm thấy kernel image"
        exit 1
    fi
    
    # Create output directory
    local output_name="kernel-${DEVICE_CODENAME:-unknown}-$(date +%Y%m%d-%H%M%S)"
    local output_path="$OUTPUT_DIR/$output_name"
    mkdir -p "$output_path"
    
    # Copy kernel image
    cp "$kernel_image" "$output_path/"
    
    # Copy modules if exist
    if [ -d "modules" ]; then
        cp -r modules "$output_path/"
    fi
    
    # Copy dtb files if exist
    if [ -d "arch/arm64/boot/dts" ]; then
        find arch/arm64/boot/dts -name "*.dtb" -exec cp {} "$output_path/" \;
    fi
    
    # Create info file
    cat > "$output_path/build_info.txt" << EOF
Kernel Build Information
=======================
Build Date: $(date)
Device: ${DEVICE_CODENAME:-unknown}
Defconfig: $KERNEL_DEFCONFIG
Build Type: $BUILD_TYPE
Architecture: arm64
Compiler: $(aarch64-linux-gnu-gcc --version | head -n1)
Kernel Version: $(make kernelversion 2>/dev/null || echo "Unknown")
Git Commit: $(git rev-parse HEAD 2>/dev/null || echo "Unknown")
EOF
    
    print_success "Kernel đã được đóng gói tại: $output_path"
    print_info "Files:"
    ls -la "$output_path"
}

# Main function
main() {
    echo "=========================================="
    echo "    ANDROID KERNEL BUILD SCRIPT"
    echo "=========================================="
    
    # Parse arguments
    parse_args "$@"
    
    # Check prerequisites
    check_prerequisites
    
    # Setup build environment
    setup_build_env
    
    # Setup kernel source
    setup_kernel_source
    
    # Configure kernel
    configure_kernel
    
    # Build kernel
    build_kernel
    
    # Package kernel
    package_kernel
    
    print_success "Hoàn thành build kernel Android!"
    print_info "Output directory: $OUTPUT_DIR"
}

# Run main function
main "$@"