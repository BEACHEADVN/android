#!/bin/sh

rm -rf /sdcard/Download/ext/temp/META-INF 2>/dev/null
rm -rf /sdcard/Download/ext/temp/system 2>/dev/null
rm /sdcard/Download/ext/temp/l 2>/dev/null
rm /sdcard/Download/ext/temp/l1 2>/dev/null
rm /sdcard/Download/ext/temp/l2 2>/dev/null
rm /sdcard/Download/ext/temp/l3 2>/dev/null

wget --no-check-certificate -O - https://a2zapk.com/Search/Lawnchair/ > /sdcard/Download/ext/temp/l
grep "arm64-v8a" /sdcard/Download/ext/temp/l > /sdcard/Download/ext/temp/l1
sed -i '1!d' /sdcard/Download/ext/temp/l1
sed -i 's+-arm64.*++g' /sdcard/Download/ext/temp/l1
sed -i 's+^.*alpha-++g' /sdcard/Download/ext/temp/l1
a=`cat /sdcard/Download/ext/temp/l1`

aapt dump badging /system/priv-app/Lawnchair/*.apk > /sdcard/Download/ext/temp/l2
grep "versionCode" /sdcard/Download/ext/temp/l2 > /sdcard/Download/ext/temp/l3
sed -i "s+^.*Code='++g; s+' versionName.*++g" /sdcard/Download/ext/temp/l3
b=`cat /sdcard/Download/ext/temp/l3`

if [ $a -gt $b ]
then
	clear
	echo "Lawnchair có bản cập nhật mới."
	echo "•Lawnchair: Có bản cập nhật mới." >> /sdcard/Download/ext/temp/log
	echo "Bạn muốn tải Lawnchair?"
	echo "1. Có"
	echo "2. Không"
	read choose

	case $choose in
	        1)
	        	am start -n com.android.chrome/org.chromium.chrome.browser.ChromeTabbedActivity -d "https://www.apkmirror.com/apk/deletescape/lawnchair/" --activity-clear-task
         	;;
                2)
	        	echo ""
               ;;
        esac
else
	echo "•Lawnchair: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
fi

rm -rf /sdcard/Download/ext/temp/META-INF 2>/dev/null
rm -rf /sdcard/Download/ext/temp/system 2>/dev/null
rm /sdcard/Download/ext/temp/l 2>/dev/null
rm /sdcard/Download/ext/temp/l1 2>/dev/null
rm /sdcard/Download/ext/temp/l2 2>/dev/null
rm /sdcard/Download/ext/temp/l3 2>/dev/null
