#!/bin/bash

rm /sdcard/Download/ext/temp/a 2>/dev/null

wget -O - https://f-droid.org/packages/com.termux/ > /sdcard/Download/ext/temp/a
a=`cat /sdcard/Download/ext/temp/a | grep "Version" | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}' | awk '{if ($1 > max) max=$1}END{print max}'`

path=`su -c "find /data/app -type d -name 'com.termux*'"`
b=`aapt dump badging $path/*.apk | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}'`

function version {
	echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

if [ $(version $a) -gt $(version $b) ]
then
	clear
	echo "Termux có bản cập nhật mới."
	echo "•Termux: Có bản cập nhật mới: $a" >> /sdcard/Download/ext/temp/log
	echo "Bạn muốn tải Termux?"
	echo "1. Có"
	echo "2. Không"
	read choose

	case $choose in
		1)
			cat /sdcard/Download/ext/temp/a | grep "Version" >> /sdcard/Download/ext/temp/aa
            c=`grep -Eo '[0-9]+' /sdcard/Download/ext/temp/aa | sort -rn | head -n 1`
			url=`cat /sdcard/Download/ext/temp/a | grep "$c" | grep "apk" | awk '!/asc/' | grep -Po '(?<=(=")).*(?=">)'`
			wget --no-check-certificate  -P /sdcard/Download/ext/temp $url
			pm install /sdcard/Download/ext/temp/com.termux*
			rm -rf /sdcard/Download/ext/temp/com.termux*
		;;
		2)
			echo ""
		;;
	esac
else
	echo "•Termux: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
fi

rm /sdcard/Download/ext/temp/a 2>/dev/null
rm /sdcard/Download/ext/temp/aa 2>/dev/null