#!/bin/bash

# Android Kernel Build Environment Setup Script
# Script này sẽ cài đặt môi trường cần thiết để build kernel Android

echo "=========================================="
echo "    ANDROID KERNEL BUILD ENVIRONMENT"
echo "=========================================="

# Kiểm tra hệ điều hành
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "✓ Đang chạy trên Linux"
else
    echo "✗ Script này chỉ hỗ trợ Linux"
    exit 1
fi

# Cập nhật package list
echo "📦 Cập nhật package list..."
sudo apt update

# Cài đặt các dependencies cần thiết
echo "🔧 Cài đặt dependencies..."

# Các package cơ bản
sudo apt install -y \
    build-essential \
    git \
    curl \
    wget \
    unzip \
    python3 \
    python3-pip \
    bc \
    bison \
    flex \
    libssl-dev \
    libncurses5-dev \
    libncursesw5-dev \
    zlib1g-dev \
    gawk \
    gettext \
    liblz4-tool \
    libelf-dev \
    pkg-config \
    ccache \
    rsync

# Cài đặt Android SDK tools
echo "📱 Cài đặt Android SDK tools..."
if [ ! -d "$HOME/android-sdk" ]; then
    mkdir -p $HOME/android-sdk
    cd $HOME/android-sdk
    
    # Tải Android SDK command line tools
    wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip
    unzip commandlinetools-linux-9477386_latest.zip
    rm commandlinetools-linux-9477386_latest.zip
    
    # Tạo thư mục platform-tools
    mkdir -p cmdline-tools/latest
    mv cmdline-tools/* cmdline-tools/latest/ 2>/dev/null || true
    
    echo "export ANDROID_HOME=\$HOME/android-sdk" >> ~/.bashrc
    echo "export PATH=\$PATH:\$ANDROID_HOME/cmdline-tools/latest/bin:\$ANDROID_HOME/platform-tools" >> ~/.bashrc
fi

# Cài đặt repo tool
echo "📥 Cài đặt repo tool..."
if [ ! -f "/usr/local/bin/repo" ]; then
    sudo curl -o /usr/local/bin/repo https://storage.googleapis.com/git-repo-downloads/repo
    sudo chmod a+x /usr/local/bin/repo
fi

# Cài đặt GCC cross-compiler (ARM64)
echo "🔨 Cài đặt GCC cross-compiler..."
sudo apt install -y gcc-aarch64-linux-gnu g++-aarch64-linux-gnu

# Cài đặt Clang (nếu chưa có)
echo "⚡ Cài đặt Clang..."
sudo apt install -y clang

# Tạo thư mục workspace
echo "📁 Tạo workspace..."
KERNEL_WORKSPACE="$HOME/android-kernel-build"
mkdir -p $KERNEL_WORKSPACE
cd $KERNEL_WORKSPACE

echo "✅ Hoàn thành setup môi trường build kernel Android!"
echo ""
echo "📋 Các bước tiếp theo:"
echo "1. Chạy: source ~/.bashrc"
echo "2. Chạy: ./build_android_kernel.sh"
echo "3. Hoặc xem hướng dẫn chi tiết trong file README.md"
echo ""
echo "📂 Workspace: $KERNEL_WORKSPACE"
echo "🔧 Dependencies đã cài đặt:"
echo "   - Build tools (gcc, make, etc.)"
echo "   - Android SDK tools"
echo "   - ARM64 cross-compiler"
echo "   - Clang compiler"
echo "   - Repo tool"