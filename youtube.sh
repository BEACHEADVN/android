#!/bin/bash

rm /sdcard/Download/ext/temp/y 2>/dev/null
rm /sdcard/Download/ext/temp/y1 2>/dev/null
rm /sdcard/Download/ext/temp/y2 2>/dev/null
rm /sdcard/Download/ext/temp/y3 2>/dev/null
rm /sdcard/Download/ext/temp/y4 2>/dev/null
rm /sdcard/Download/ext/temp/y5 2>/dev/null

wget -O - https://vanced.app > /sdcard/Download/ext/temp/y
grep "YouTube_Vanced-v" /sdcard/Download/ext/temp/y > /sdcard/Download/ext/temp/y1
perl -pe '($_)=/([0-9]+([.][0-9]+)+)/' /sdcard/Download/ext/temp/y1 > /sdcard/Download/ext/temp/y2
a=`cat /sdcard/Download/ext/temp/y2`

aapt dump badging /data/app/com.vanced.android.youtube*/base.apk > /sdcard/Download/ext/temp/y3
grep "versionName" /sdcard/Download/ext/temp/y3 > /sdcard/Download/ext/temp/y4
perl -pe '($_)=/([0-9]+([.][0-9]+)+)/' /sdcard/Download/ext/temp/y4 > /sdcard/Download/ext/temp/y5
b=`cat /sdcard/Download/ext/temp/y5`

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
rm /sdcard/Download/ext/temp/y2 2>/dev/null
rm /sdcard/Download/ext/temp/y3 2>/dev/null
rm /sdcard/Download/ext/temp/y4 2>/dev/null
rm /sdcard/Download/ext/temp/y5 2>/dev/null


rm /sdcard/Download/ext/temp/m 2>/dev/null
rm /sdcard/Download/ext/temp/m1 2>/dev/null
rm /sdcard/Download/ext/temp/m2 2>/dev/null
rm /sdcard/Download/ext/temp/m3 2>/dev/null
rm /sdcard/Download/ext/temp/m4 2>/dev/null

grep "microg_YouTube_Vanced" /sdcard/Download/ext/temp/y > /sdcard/Download/ext/temp/m
perl -pe '($_)=/([0-9]+([.][0-9]+)+)/' /sdcard/Download/ext/temp/m > /sdcard/Download/ext/temp/m1
a=`cat /sdcard/Download/ext/temp/m1`

aapt dump badging /data/app/com.mgoogle.android.gms*/*.apk > /sdcard/Download/ext/temp/m2
grep "versionName" /sdcard/Download/ext/temp/m2 > /sdcard/Download/ext/temp/m3
perl -pe '($_)=/([0-9]+([.][0-9]+)+)/' /sdcard/Download/ext/temp/m3 > /sdcard/Download/ext/temp/m4
b=`cat /sdcard/Download/ext/temp/m4`

if [ $(version $a) -gt $(version $b) ]
then
	sed -i 's+      window.location = "+https://vanced.app/+g; s+apk.*+apk+g' /sdcard/Download/ext/temp/m
	download_link=`cat /sdcard/Download/ext/temp/m`
	rm /sdcard/Download/microg_YouTube_Vanced*.apk 2>/dev/null
	wget  -P /sdcard/Download "$download_link"
	pm install /sdcard/Download/microg_YouTube_Vanced*.apk 2>/dev/null
	echo "•MicroG-v$b --> MicroG-v$a." >> /sdcard/Download/ext/temp/log
else
	echo "•MicroG: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
fi

rm /sdcard/Download/ext/temp/y 2>/dev/null
rm /sdcard/Download/ext/temp/m 2>/dev/null
rm /sdcard/Download/ext/temp/m1 2>/dev/null
rm /sdcard/Download/ext/temp/m2 2>/dev/null
rm /sdcard/Download/ext/temp/m3 2>/dev/null
rm /sdcard/Download/ext/temp/m4 2>/dev/null