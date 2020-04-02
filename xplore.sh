#!/bin/bash

rm /sdcard/Download/ext/temp/x 2>/dev/null
rm /sdcard/Download/ext/temp/x1 2>/dev/null

wget -O - https://dl-android.com/p/index.php?id=x-plore-file-manager > /sdcard/Download/ext/temp/x
a=`cat /sdcard/Download/ext/temp/x | grep "Download Free X-plore" | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/'`

aapt dump badging /data/app/com.lonelycatgames.Xplore-*/*.apk > /sdcard/Download/ext/temp/x1
b=`cat /sdcard/Download/ext/temp/x1 | grep "versionName" | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/'`

function version {
	echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

if [ $(version $a) -gt $(version $b) ]
then
	download_link=`cat /sdcard/Download/ext/temp/x | grep "dl-android.com" | sed -i 's+apk.*+apk+g; s+^.*http+http+g; 1!d'`
	wget  -P /sdcard/Download/ext/temp "$download_link"
	pm install /sdcard/Download/ext/temp/x-plore*.apk 2>/dev/null
	rm /sdcard/Download/ext/temp/x-plore*.apk 2>/dev/null
	echo "•X-plore-$b --> Xplore-$a." >> /sdcard/Download/ext/temp/log
else
	echo "•X-plore: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
fi

rm /sdcard/Download/ext/temp/x 2>/dev/null
rm /sdcard/Download/ext/temp/x1 2>/dev/null