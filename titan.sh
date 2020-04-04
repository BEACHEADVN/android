#!/bin/bash

rm /sdcard/Download/ext/temp/t 2>/dev/null
rm /sdcard/Download/ext/temp/t1 2>/dev/null

wget -O - https://dl-android.com/p/index.php?id=titanium-backup-star-root > /sdcard/Download/ext/temp/t
a=`cat /sdcard/Download/ext/temp/t | grep "Download Free Titanium" | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/'`

aapt dump badging /data/app/com.keramidas.TitaniumBackup-*/*.apk > /sdcard/Download/ext/temp/t1
b=`cat /sdcard/Download/ext/temp/t1 | grep "versionName" | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/'`

function version {
	echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

if [ $(version $a) -gt $(version $b) ]
then
	download_link=`cat /sdcard/Download/ext/temp/t | grep "dl-android.com" | sed '1!d; s+apk.*+apk+g; s+^.*http+http+g'`
	wget  -P /sdcard/Download/ext/temp "$download_link"
	pm install /sdcard/Download/ext/temp/titanium*.apk 2>/dev/null
	rm /sdcard/Download/ext/temp/titanium*.apk 2>/dev/null
	echo "•Titanium Backup Pro v$b -->Titanium Backup Pro v$a" >> /sdcard/Download/ext/temp/log
else
	echo "•Titanium Backup Pro: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
fi

rm /sdcard/Download/ext/temp/t 2>/dev/null
rm /sdcard/Download/ext/temp/t1 2>/dev/null