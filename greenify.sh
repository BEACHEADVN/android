#!/bin/bash

rm /sdcard/Download/ext/temp/g 2>/dev/null

wget --no-check-certificate -O - https://a2zapk.com/Search/greenify/user=akJ1bUhJZ3dKcmVIR2FXWmdpTmNJVXpBODNrS3NPNk9ueC9wTmFGWWdhNnErK1owM0VvbFk3TkRnMm9LQXpWVWJZVHdyNGJIb3h4ajNPQVYxaFRwd1E9PQ==/ > /sdcard/Download/ext/temp/g
a=`cat /sdcard/Download/ext/temp/g | grep "Greenify" | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}' | awk 'min == "" || $1<min{min=$1} $1>max{max=$1} END{print max}'`

b=`aapt dump badging /system/priv-app/Greenify/*.apk | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}'`

function version {
	echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

if [ $(version $a) -gt $(version $b) ]
then
	clear
	echo "Greenify Donate có bản cập nhật mới."
	echo "•Greenify Donate: Có bản cập nhật mới: $a" >> /sdcard/Download/ext/temp/log
	echo "Bạn muốn tải Greenify Donate?"
	echo "1. Có"
	echo "2. Không"
	read choose

	case $choose in
		1)
			a=`echo ${a//./-}`
			url=`cat /sdcard/Download/ext/temp/g | grep "href" | grep "donate-a2z.html" | sed '/Lite/d; 1!d' | grep $a | sed 's+" title="Greenify">++g; s+<a href="+https://a2zapk.com/+g'`
			am start -n com.android.chrome/org.chromium.chrome.browser.ChromeTabbedActivity -d $url --activity-clear-task
		;;
		2)
			echo ""
		;;
	esac
else
	echo "•Greenify Donate: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
fi

rm /sdcard/Download/ext/temp/g 2>/dev/null