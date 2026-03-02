import xml.etree.ElementTree as ET
import os
import re
import sys

UI_FILE = '/data/data/com.termux/files/home/ui.xml'

# 📥 Lấy tham số dòng lệnh
if len(sys.argv) < 2:
    print("❌ Vui lòng nhập tên nút (VD: python tap.py \"Quản lý ứng dụng và thiết bị\")")
    exit(1)

TARGET = sys.argv[1]
found = False

# Bước 1: Dump UI
print("🧩 Dump giao diện...")
os.system("su -ic 'uiautomator dump /sdcard/ui.xml' > /dev/null 2>&1")
os.system(f"cp /sdcard/ui.xml {UI_FILE}")

# Bước 2: Phân tích XML
tree = ET.parse(UI_FILE)
root = tree.getroot()

for node in root.iter():
    text = node.attrib.get('text', '')
    desc = node.attrib.get('content-desc', '')
    bounds = node.attrib.get('bounds', '')
    
    if (TARGET in text or TARGET in desc) and bounds:
        print(f"✅ Tìm thấy: {TARGET}")
        print(f"📄 bounds = {bounds}")
        nums = list(map(int, re.findall(r'\d+', bounds)))
        if len(nums) == 4:
            x = (nums[0] + nums[2]) // 2
            y = (nums[1] + nums[3]) // 2
            print(f"📍 Tap tại: {x} {y}")
            os.system(f"su -ic 'input tap {x} {y}'")
            found = True
        break

if not found:
    print(f"❌ Không tìm thấy nút có tên: {TARGET}")
