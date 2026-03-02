import xml.etree.ElementTree as ET
import os
import re
import time

UI_FILE = '/data/data/com.termux/files/home/ui.xml'
KEYWORDS = "Tài khoản và các chế độ cài đặt"

# Bước 1: Dump UI
print("🧩 Dump giao diện...")
os.system("su -ic 'uiautomator dump /sdcard/ui.xml' > /dev/null 2>&1")
os.system(f"cp /sdcard/ui.xml {UI_FILE}")

# Bước 2: Parse XML
tree = ET.parse(UI_FILE)
root = tree.getroot()

found = False
for node in root.iter():
    desc = node.attrib.get("content-desc", "")
    bounds = node.attrib.get("bounds", "")
    if KEYWORDS in desc and bounds:
        print(f"✅ Tìm thấy avatar có content-desc:\n{desc}")
        nums = list(map(int, re.findall(r'\d+', bounds)))
        if len(nums) == 4:
            x = (nums[0] + nums[2]) // 2
            y = (nums[1] + nums[3]) // 2
            print(f"📍 Tap tại: {x}, {y}")
            os.system(f"su -ic 'input tap {x} {y}'")
            found = True
            break

if not found:
    print("❌ Không tìm thấy avatar tài khoản.")