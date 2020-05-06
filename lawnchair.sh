#!/bin/sh

rm -rf /sdcard/Download/ext/temp/META-INF 2>/dev/null
rm -rf /sdcard/Download/ext/temp/system 2>/dev/null

a=`wget --no-check-certificate -O - https://a2zapk.com/Search/Lawnchair/ | grep "arm64-v8a" | sed '1!d' | cut -d'-' -f 6`

b=`aapt dump badging /system/priv-app/Lawnchair/*.apk | grep "versionCode" | sed "s+^.*Code='++g; s+' versionName.*++g"`

function version {
	echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

if [ $(version $a) -gt $(version $b) ]
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
