import xml.etree.ElementTree as ET
import os
import re
import time
import sys

# 📥 Lấy tham số dòng lệnh
if len(sys.argv) < 2:
    print("❌ Vui lòng nhập nội dung content-desc cần tìm (VD: python tap.py \"Kiểm tra để tìm bản cập nhật\")")
    exit(1)

TARGET_DESC = sys.argv[1]
UI_FILE = '/data/data/com.termux/files/home/ui.xml'

x = y = None
bounds = ''
still_visible = False

# Dump giao diện lần đầu
os.system("su -c 'uiautomator dump /sdcard/ui.xml' > /dev/null 2>&1")
os.system(f"cp /sdcard/ui.xml {UI_FILE}")

tree = ET.parse(UI_FILE)
root = tree.getroot()

found = False
for node in root.iter():
    if node.attrib.get('content-desc') == TARGET_DESC:
        bounds = node.attrib.get('bounds')
        print("✅ Found bounds:", bounds)
        nums = list(map(int, re.findall(r'\d+', bounds)))
        if len(nums) == 4:
            x = (nums[0] + nums[2]) // 2
            y = (nums[1] + nums[3]) // 2
            print(f"📍 Tap tại: {x} {y}")
            os.system(f"su -c 'input tap {x} {y}'")
            found = True
        break

if not found:
    print(f"❌ Không tìm thấy nút: {TARGET_DESC}")
    exit()

# ⏳ Chờ vài giây rồi kiểm tra lại
time.sleep(3)

# Dump lại lần 2
os.system("su -c 'uiautomator dump /sdcard/ui.xml' > /dev/null 2>&1")
os.system(f"cp /sdcard/ui.xml {UI_FILE}")

tree = ET.parse(UI_FILE)
root = tree.getroot()

# Kiểm tra nút còn không
for node in root.iter():
    if node.attrib.get('content-desc') == TARGET_DESC:
        still_visible = True
        break

if still_visible:
    print(f"⚠️ Nút vẫn còn: {TARGET_DESC} → thoát Google Play...")
    os.system("su -c 'am force-stop com.android.vending'")
else:
    print(f"✅ Nút đã biến mất: {TARGET_DESC} → không cần thoát.")
