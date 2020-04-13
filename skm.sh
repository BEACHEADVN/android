#!/bin/sh

rm /sdcard/Download/ext/temp/s 2>/dev/null
rm /sdcard/Download/ext/temp/s1 2>/dev/null

wget -O - https://github.com/SmartPack/SmartPack-Kernel-Manager/releases > /sdcard/Download/ext/temp/s
a=`cat /sdcard/Download/ext/temp/s | grep "Release tag:" | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}' | awk 'min == "" || $1<min{min=$1} $1>max{max=$1} END{print max}'`

aapt dump badging /data/app/com.smartpack.kernelmanager*/base.apk > /sdcard/Download/ext/temp/s1 2>/dev/null
if [[ -z $(grep '[^[:space:]]' /sdcard/Download/ext/temp/s1) ]]
then
	aapt dump badging /sdcard/Download/com.smartpack.kernelmanager*.apk > /sdcard/Download/ext/temp/s1 2>/dev/null
fi
b=`cat /sdcard/Download/ext/temp/s1 | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}'`

function version {
	echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

if [ $(version $a) -gt $(version $b) ]
then
	download_link=`cat /sdcard/Download/ext/temp/s | grep "/releases/download/" | sed '1!d; s+apk.*+apk+g; s+^.*href="+https://github.com+g'`
	wget  -P /sdcard/Download/ext/temp "$download_link"
	rm /sdcard/Download/com.smartpack.kernelmanager*.apk 2>/dev/null
	mv -f /sdcard/Download/ext/temp/com.smartpack.kernelmanager*.apk /sdcard/Download
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
