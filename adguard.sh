#!/bin/bash

rm /sdcard/Download/ext/temp/a 2>/dev/null
rm /sdcard/Download/ext/temp/a1 2>/dev/null

wget -O - https://dl-android.com/p/index.php?id=adguard-apk > /sdcard/Download/ext/temp/a
a=`cat /sdcard/Download/ext/temp/a | grep "Download Free Adguard" | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/'`

aapt dump badging /data/app/com.adguard.android*/*.apk > /sdcard/Download/ext/temp/a1
b=`cat /sdcard/Download/ext/temp/a1 | grep "versionName" | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/'`

function version {
	echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

if [ $(version $a) -gt $(version $b) ]
then
	download_link=`cat /sdcard/Download/ext/temp/a | grep "dl-android.com" | sed '1!d; s+apk.*+apk+g; s+^.*http+http+g'`
	wget  -P /sdcard/Download "$download_link"
	pm install /sdcard/Download/adguard*.apk 2>/dev/null
	rm /sdcard/Download/adguard*.apk 2>/dev/null
	echo "•Adguard v$b --> Adguard v$a" >> /sdcard/Download/ext/temp/log
else
	echo "•Adguard: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
fi

rm /sdcard/Download/ext/temp/a 2>/dev/null
rm /sdcard/Download/ext/temp/a1 2>/dev/null