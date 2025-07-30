import xml.etree.ElementTree as ET
import os
import re

tree = ET.parse('/data/data/com.termux/files/home/ui.xml')
root = tree.getroot()

for node in root.iter():
    if node.attrib.get('content-desc') == 'Kiểm tra để tìm bản cập nhật':
        bounds = node.attrib.get('bounds')
        print("✅ Found bounds:", bounds)
        nums = list(map(int, re.findall(r'\d+', bounds)))
        if len(nums) == 4:
            x = (nums[0] + nums[2]) // 2
            y = (nums[1] + nums[3]) // 2
            print(f"📍 Tap tại: {x} {y}")
            # Gọi input tap
            os.system(f"su -c 'input tap {x} {y}'")
        break
else:
    print("❌ Không tìm thấy node có content-desc='Kiểm tra để tìm bản cập nhật'")
