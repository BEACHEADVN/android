#!/bin/bash

rm /sdcard/Download/ext/temp/y 2>/dev/null
rm /sdcard/Download/ext/temp/y1 2>/dev/null

wget -O - https://vanced.app > /sdcard/Download/ext/temp/y
a=`cat /sdcard/Download/ext/temp/y | grep "YouTube_Vanced-v" | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/'`

aapt dump badging /data/app/com.vanced.android.youtube*/base.apk > /sdcard/Download/ext/temp/y1
b=`cat /sdcard/Download/ext/temp/y1 | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}'`

function version {
	echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

if [ $(version $a) -gt $(version $b) ]
then
	download_link=vanced.app//downloads/YouTube_Vanced-v$a-nonroot-default-dark.apks
	wget  -P /sdcard/Download "$download_link"
	echo "•Youtube Vanced: Tải phiên bản mới $a." >> /sdcard/Download/ext/temp/log
else
	echo "•Youtube Vanced: Không có phiên bản mới." >> /sdcard/Download/ext/temp/log
fi

rm /sdcard/Download/ext/temp/y1 2>/dev/null


rm /sdcard/Download/ext/temp/m 2>/dev/null
rm /sdcard/Download/ext/temp/m1 2>/dev/null

a=`cat /sdcard/Download/ext/temp/y | grep "microg_YouTube_Vanced" | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/'`

aapt dump badging /data/app/com.mgoogle.android.gms*/*.apk > /sdcard/Download/ext/temp/m
b=`cat /sdcard/Download/ext/temp/m | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}'`

if [ $(version $a) -gt $(version $b) ]
then
	download_link=`cat /sdcard/Download/ext/temp/y | grep "microg_YouTube_Vanced" | sed 's+      window.location = "+https://vanced.app/+g; s+apk.*+apk+g'`
	wget  -P /sdcard/Download/ext/temp "$download_link"
	rm /sdcard/Download/ext/temp/microg_YouTube_Vanced*.apk 2>/dev/null
	pm install /sdcard/Download/ext/temp/microg_YouTube_Vanced*.apk 2>/dev/null
	rm /sdcard/Download/ext/temp/microg_YouTube_Vanced*.apk 2>/dev/null
	echo "•MicroG-v$b --> MicroG-v$a." >> /sdcard/Download/ext/temp/log
else
	echo "•MicroG: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
fi

rm /sdcard/Download/ext/temp/y 2>/dev/null
rm /sdcard/Download/ext/temp/m 2>/dev/null
