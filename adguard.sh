#!/bin/bash

rm /sdcard/Download/ext/temp/a 2>/dev/null
rm /sdcard/Download/ext/temp/a1 2>/dev/null

wget -O - https://a2zapk.com/Search/Adguard/user=akJ1bUhJZ3dKcmVIR2FXWmdpTmNJUnB1emxxTzZqLzlxKzdvemZLQnN0UE9SMi84V2c5bkxUdVRZZ1FBcUNEdlZrTEhEU0hnbEp5WGhQeXo4aWZteXc9PQ==/ > /sdcard/Download/ext/temp/a
a=`cat /sdcard/Download/ext/temp/a | grep "Adguard - Block Ads Without Root" | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}' | awk 'min == "" || $1<min{min=$1} $1>max{max=$1} END{print max}'`

aapt dump badging /data/app/com.adguard.android*/*.apk > /sdcard/Download/ext/temp/a1
b=`cat /sdcard/Download/ext/temp/a1 | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}'`

function version {
	echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

if [ $(version $a) -gt $(version $b) ]
then
	clear
	echo "Adguard Premium có bản cập nhật mới."
	echo "•Adguard Premium: Có bản cập nhật mới: $a" >> /sdcard/Download/ext/temp/log
	echo "Bạn muốn tải Adguard Premium?"
	echo "1. Có"
	echo "2. Không"
	read choose

	case $choose in
		1)
			a=`echo ${a//./-}`
			url=`cat /sdcard/Download/ext/temp/a | grep "href" | grep "premium-mod-a2z.html" | sed '/Lite/d; 1!d' | grep $a | sed 's+" title="Adguard - Block Ads Without Root">++g; s+<a href="+https://a2zapk.com/+g'`
			am start -n com.android.chrome/org.chromium.chrome.browser.ChromeTabbedActivity -d $url --activity-clear-task
		;;
		2)
			echo ""
		;;
	esac
else
	echo "•Adguard Premium: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
fi

rm /sdcard/Download/ext/temp/a 2>/dev/null
rm /sdcard/Download/ext/temp/a1 2>/dev/null
