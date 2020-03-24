#!/bin/sh

rm /sdcard/Download/ext/temp/s 2>/dev/null
rm /sdcard/Download/ext/temp/s1 2>/dev/null
rm /sdcard/Download/ext/temp/s2 2>/dev/null
rm /sdcard/Download/ext/temp/s3 2>/dev/null
rm /sdcard/Download/ext/temp/s4 2>/dev/null

wget -O - https://github.com/SmartPack/SmartPack-Kernel-Manager/releases > /sdcard/Download/ext/temp/s
grep "Release tag:" /sdcard/Download/ext/temp/s > /sdcard/Download/ext/temp/s1
sed -i '1!d' /sdcard/Download/ext/temp/s1
a=`perl -pe '($_)=/([0-9]+([.][0-9]+)+)/' /sdcard/Download/ext/temp/s1`

aapt dump badging /data/app/com.smartpack.kernelmanager*/base.apk > /sdcard/Download/ext/temp/s2 2>/dev/null
if [[ -z $(grep '[^[:space:]]' /sdcard/Download/ext/temp/s2) ]]
then
	aapt dump badging /sdcard/Download/com.smartpack.kernelmanager*.apk > /sdcard/Download/ext/temp/s2 2>/dev/null
fi
grep "versionName" /sdcard/Download/ext/temp/s2 > /sdcard/Download/ext/temp/s3
b=`perl -pe '($_)=/([0-9]+([.][0-9]+)+)/' /sdcard/Download/ext/temp/s3`

function version {
echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

if [ $(version $a) -gt $(version $b) ]
then
	grep "/releases/download/" /sdcard/Download/ext/temp/s > /sdcard/Download/ext/temp/s4
	sed -i '1!d; s+apk.*+apk+g; s+^.*href="+https://github.com+g' /sdcard/Download/ext/temp/s4
	d=`cat /sdcard/Download/ext/temp/s4`
	rm /sdcard/Download/com.smartpack.kernelmanager*.apk 2>/dev/null
	wget  -P /sdcard/Download "$d"
	echo "•Smart-Park Kernel Manager-v$b.apk --> Smart-Park Kernel Manager-v$a.apk" >> /sdcard/Download/ext/temp/log
	echo "Cài đặt Smart-Park Kernel Manager"
	echo "1. Có"
	echo "2. Không"
	read install
	
	case $install in
		1)
			pm install /sdcard/Download/com.smartpack.kernelmanager*.apk
			rm /sdcard/Download/com.smartpack.kernelmanager*.apk 2>/dev/null
		;;
		*)
			echo ""
		;;
	esac
else
	echo "•Smart-Park Kernel Manager: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
fi

rm /sdcard/Download/ext/temp/s 2>/dev/null
rm /sdcard/Download/ext/temp/s1 2>/dev/null
rm /sdcard/Download/ext/temp/s2 2>/dev/null
rm /sdcard/Download/ext/temp/s3 2>/dev/null
rm /sdcard/Download/ext/temp/s4 2>/dev/null