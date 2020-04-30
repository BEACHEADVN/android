#!/bin/bash

rm /sdcard/Download/ext/temp/x 2>/dev/null

wget --no-check-certificate -O - https://a2zapk.com/Search/X-plore/user=akJ1bUhJZ3dKcmVIR2FXWmdpTmNJVXpBODNrS3NPNk9ueC9wTmFGWWdhNnErK1owM0VvbFk3TkRnMm9LQXpWVUV5THA3VFFPWnFSRWZ6am9XTXBGR1E9PQ==/ > /sdcard/Download/ext/temp/x
a=`cat /sdcard/Download/ext/temp/x | grep "X-plore File Manager" | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}' | awk 'min == "" || $1<min{min=$1} $1>max{max=$1} END{print max}'`

b=`aapt dump badging /data/app/com.lonelycatgames.Xplore*/*.apk | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}'`

function version {
	echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

if [ $(version $a) -gt $(version $b) ]
then
	clear
	echo "X-plore Donate có bản cập nhật mới."
	echo "•X-plore Donate: Có bản cập nhật mới: $a" >> /sdcard/Download/ext/temp/log
	echo "Bạn muốn tải X-plore Donate?"
	echo "1. Có"
	echo "2. Không"
	read choose

	case $choose in
		1)
			a=`echo ${a//./-}`
			url=`cat /sdcard/Download/ext/temp/x | grep "href" | grep "donate-a2z.html" | sed '/Lite/d; 1!d' | grep $a | sed 's+" title="X-plore File Manager">++g; s+<a href="+https://a2zapk.com/+g'`
			am start -n com.android.chrome/org.chromium.chrome.browser.ChromeTabbedActivity -d $url --activity-clear-task
		;;
		2)
			echo ""
		;;
	esac
else
	echo "•X-plore Donate: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
fi

rm /sdcard/Download/ext/temp/x 2>/dev/null