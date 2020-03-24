#!/bin/bash

rm /sdcard/Download/ext/temp/x 2>/dev/null
rm /sdcard/Download/ext/temp/x1 2>/dev/null
rm /sdcard/Download/ext/temp/x2 2>/dev/null
rm /sdcard/Download/ext/temp/x3 2>/dev/null
rm /sdcard/Download/ext/temp/x4 2>/dev/null
rm /sdcard/Download/ext/temp/x5 2>/dev/null
rm /sdcard/Download/ext/temp/x6 2>/dev/null

wget -O - https://dl-android.com/p/index.php?id=x-plore-file-manager > /sdcard/Download/ext/temp/x
grep "Download Free X-plore" /sdcard/Download/ext/temp/x > /sdcard/Download/ext/temp/x1
perl -pe '($_)=/([0-9]+([.][0-9]+)+)/' /sdcard/Download/ext/temp/x1 > /sdcard/Download/ext/temp/x2
a=`cat /sdcard/Download/ext/temp/x2`

aapt dump badging /data/app/com.lonelycatgames.Xplore-*/*.apk > /sdcard/Download/ext/temp/x3
grep "versionName" /sdcard/Download/ext/temp/x3 > /sdcard/Download/ext/temp/x4
perl -pe '($_)=/([0-9]+([.][0-9]+)+)/' /sdcard/Download/ext/temp/x4 > /sdcard/Download/ext/temp/x5
b=`cat /sdcard/Download/ext/temp/x5`

function version {
echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

if [ $(version $a) -gt $(version $b) ]
then
	grep "dl-android.com" /sdcard/Download/ext/temp/x > /sdcard/Download/ext/temp/x6
	sed -i 's+apk.*+apk+g; s+^.*http+http+g; 1!d' /sdcard/Download/ext/temp/x6
	d=`cat /sdcard/Download/ext/temp/x6`
	wget  -P /sdcard/Download "$d"
	pm install /sdcard/Download/x-plore*.apk 2>/dev/null
	rm /sdcard/Download/x-plore*.apk 2>/dev/null
	echo "•X-plore-$b --> Xplore-$a." >> /sdcard/Download/ext/temp/log
else
	echo "•X-plore: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
fi

rm /sdcard/Download/ext/temp/x 2>/dev/null
rm /sdcard/Download/ext/temp/x1 2>/dev/null
rm /sdcard/Download/ext/temp/x2 2>/dev/null
rm /sdcard/Download/ext/temp/x3 2>/dev/null
rm /sdcard/Download/ext/temp/x4 2>/dev/null
rm /sdcard/Download/ext/temp/x5 2>/dev/null
rm /sdcard/Download/ext/temp/x6 2>/dev/null
