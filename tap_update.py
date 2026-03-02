import xml.etree.ElementTree as ET
import os
import re
import time

UI_FILE = '/data/data/com.termux/files/home/ui.xml'

# Dump giao diện
os.system("su -ic 'uiautomator dump /sdcard/ui.xml' > /dev/null 2>&1")
os.system(f"cp /sdcard/ui.xml {UI_FILE}")

tree = ET.parse(UI_FILE)
root = tree.getroot()

found = False
for node in root.iter():
    if node.attrib.get('content-desc') == 'Kiểm tra để tìm bản cập nhật':
        bounds = node.attrib.get('bounds')
        print("✅ Found bounds:", bounds)
        nums = list(map(int, re.findall(r'\d+', bounds)))
        if len(nums) == 4:
            x = (nums[0] + nums[2]) // 2
            y = (nums[1] + nums[3]) // 2
            print(f"📍 Tap tại: {x} {y}")
            os.system(f"su -ic 'input tap {x} {y}'")
            found = True
        break

if not found:
    print("❌ Không tìm thấy nút cập nhật")
    exit()

# ⏳ Chờ 5 giây để kiểm tra lại
time.sleep(5)

# Dump lại lần 2
os.system("su -ic 'uiautomator dump /sdcard/ui.xml' > /dev/null 2>&1")
os.system(f"cp /sdcard/ui.xml {UI_FILE}")

tree = ET.parse(UI_FILE)
root = tree.getroot()

# Kiểm tra lại xem nút vẫn còn không
still_visible = False
for node in root.iter():
    if node.attrib.get('content-desc') == 'Kiểm tra để tìm bản cập nhật':
        still_visible = True
        break

if still_visible:
    print("⚠️ Nút vẫn còn → thoát Google Play...")
    os.system("su -ic 'am force-stop com.android.vending'")
else:
    print("✅ Nút đã biến mất → không cần thoát.")
