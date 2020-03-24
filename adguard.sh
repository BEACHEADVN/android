#!/bin/bash

rm /sdcard/Download/ext/temp/a 2>/dev/null
rm /sdcard/Download/ext/temp/a1 2>/dev/null
rm /sdcard/Download/ext/temp/a2 2>/dev/null
rm /sdcard/Download/ext/temp/a3 2>/dev/null
rm /sdcard/Download/ext/temp/a4 2>/dev/null
rm /sdcard/Download/ext/temp/a5 2>/dev/null
rm /sdcard/Download/ext/temp/a6 2>/dev/null

wget -O - https://dl-android.com/p/index.php?id=adguard-apk > /sdcard/Download/ext/temp/a
grep "Download Free Adguard" /sdcard/Download/ext/temp/a > /sdcard/Download/ext/temp/a1
perl -pe '($_)=/([0-9]+([.][0-9]+)+)/' /sdcard/Download/ext/temp/a1 > /sdcard/Download/ext/temp/a2
a=`cat /sdcard/Download/ext/temp/a2`

aapt dump badging /data/app/com.adguard.android*/*.apk > /sdcard/Download/ext/temp/a3
grep "versionName" /sdcard/Download/ext/temp/a3 > /sdcard/Download/ext/temp/a4
perl -pe '($_)=/([0-9]+([.][0-9]+)+)/' /sdcard/Download/ext/temp/a4 > /sdcard/Download/ext/temp/a5
b=`cat /sdcard/Download/ext/temp/a5`

function version {
echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

if [ $(version $a) -gt $(version $b) ]
then
	grep "dl-android.com" /sdcard/Download/ext/temp/a > /sdcard/Download/ext/temp/a6
	sed -i '1!d; s+apk.*+apk+g; s+^.*http+http+g' /sdcard/Download/ext/temp/a6
	d=`cat /sdcard/Download/ext/temp/a6`
	wget  -P /sdcard/Download "$d"
	pm install /sdcard/Download/adguard*.apk 2>/dev/null
	rm /sdcard/Download/adguard*.apk 2>/dev/null
	echo "•Adguard v$b --> Adguard v$a" >> /sdcard/Download/ext/temp/log
else
	echo "•Adguard: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
fi

rm /sdcard/Download/ext/temp/a 2>/dev/null
rm /sdcard/Download/ext/temp/a1 2>/dev/null
rm /sdcard/Download/ext/temp/a2 2>/dev/null
rm /sdcard/Download/ext/temp/a3 2>/dev/null
rm /sdcard/Download/ext/temp/a4 2>/dev/null
rm /sdcard/Download/ext/temp/a5 2>/dev/null
rm /sdcard/Download/ext/temp/a6 2>/dev/null
