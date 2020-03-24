#!/bin/bash

rm /sdcard/Download/ext/temp/t 2>/dev/null
rm /sdcard/Download/ext/temp/t1 2>/dev/null
rm /sdcard/Download/ext/temp/t2 2>/dev/null
rm /sdcard/Download/ext/temp/t3 2>/dev/null
rm /sdcard/Download/ext/temp/t4 2>/dev/null
rm /sdcard/Download/ext/temp/t5 2>/dev/null
rm /sdcard/Download/ext/temp/t6 2>/dev/null

wget -O - https://dl-android.com/p/index.php?id=titanium-backup-star-root > /sdcard/Download/ext/temp/t
grep "Download Free Titanium" /sdcard/Download/ext/temp/t > /sdcard/Download/ext/temp/t1
perl -pe '($_)=/([0-9]+([.][0-9]+)+)/' /sdcard/Download/ext/temp/t1 > /sdcard/Download/ext/temp/t2
a=`cat /sdcard/Download/ext/temp/t2`

aapt dump badging /data/app/com.keramidas.TitaniumBackup-*/*.apk > /sdcard/Download/ext/temp/t3
grep "versionName" /sdcard/Download/ext/temp/t3 > /sdcard/Download/ext/temp/t4
perl -pe '($_)=/([0-9]+([.][0-9]+)+)/' /sdcard/Download/ext/temp/t4 > /sdcard/Download/ext/temp/t5
b=`cat /sdcard/Download/ext/temp/t5`

function version {
echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

if [ $(version $a) -gt $(version $b) ]
then
	grep "dl-android.com" /sdcard/Download/ext/temp/t > /sdcard/Download/ext/temp/t6
	sed -i 's+apk.*+apk+g; s+^.*http+http+g; 1!d' /sdcard/Download/ext/temp/t6
	d=`cat /sdcard/Download/ext/temp/t6`
	wget  -P /sdcard/Download "$d"
	pm install /sdcard/Download/titanium*.apk 2>/dev/null
	rm /sdcard/Download/titanium*.apk 2>/dev/null
	echo "•Titanium Backup Pro v$b -->Titanium Backup Pro v$a" >> /sdcard/Download/ext/temp/log
else
	echo "•Titanium Backup Pro: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
fi

rm /sdcard/Download/ext/temp/t 2>/dev/null
rm /sdcard/Download/ext/temp/t1 2>/dev/null
rm /sdcard/Download/ext/temp/t2 2>/dev/null
rm /sdcard/Download/ext/temp/t3 2>/dev/null
rm /sdcard/Download/ext/temp/t4 2>/dev/null
rm /sdcard/Download/ext/temp/t5 2>/dev/null
rm /sdcard/Download/ext/temp/t6 2>/dev/null
