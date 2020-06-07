#!/bin/sh

rm -rf /sdcard/Download/ext/temp/l 2>/dev/null

wget -O -  https://a2zapk.com/Search/Lawnchair/user=akJ1bUhJZ3dKcmVIR2FXWmdpTmNJZklKaHNHKzd3VEZqNWNEK2tyNURJZzhrYkxxODZyODIxTTZzelJXZy9FdGVKNGpBUy93WXRNclc0Z0Q4aDNOU0E9PQ==/  > /sdcard/Download/ext/temp/l
a=`cat /sdcard/Download/ext/temp/l | grep "arm64-v8a" | sed '1!d' | grep -o -E '[0-9]+'| sed '1d' | sort -nr | head -1`

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
			url=`cat /sdcard/Download/ext/temp/l | grep $a | sed 's+.html.*+.html+g; s+<a href="+https://a2zapk.com/+g'`
			am start -n com.android.chrome/org.chromium.chrome.browser.ChromeTabbedActivity -d $url --activity-clear-task
		;;
		2)
			echo ""
		;;
	esac
else
	echo "•Lawnchair: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
fi

rm -rf /sdcard/Download/ext/temp/l 2>/dev/null