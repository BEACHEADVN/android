#!/bin/sh

rm -rf /sdcard/Download/ext/temp/r 2>/dev/null

wget --no-check-certificate -O - https://osdn.net/projects/henma-p/storage/capricorn/ > /sdcard/Download/ext/temp/r
a=`cat /sdcard/Download/ext/temp/r | grep "Havoc-OS" | grep "href" | sed '/GApps/d' | grep -Eo '[0-9]+' | sort -rn | head -n 1`

b=`find /storage/emulated/0 -maxdepth 1 -type f -name "Havoc-OS*" | grep -Eo '[0-9]+' | sort -rn | head -n 1`

function version {
	echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

if [ $(version $a) -gt $(version $b) ]
then
	rom_cloud=`cat /sdcard/Download/ext/temp/r | grep "Havoc-OS" | grep "href" | sed '1!d; /GApps/d; s+	 <a href="/projects/henma-p/storage/capricorn/++g; s+">++g'`
	rom_local=`find /storage/emulated/0 -maxdepth 1 -type f -name "Havoc-OS*" | sed 's+/storage/emulated/0/++g'`
	download_link=`cat /sdcard/Download/ext/temp/r | grep "Havoc-OS" | grep "href" | sed '/GApps/d' | sed 's+^.*href="+https://osdn.net+g; s+">++g'`
	wget -P /sdcard/Download/ext/temp "$download_link"
	rm /sdcard/Havoc-OS*.zip
	mv /sdcard/Download/ext/temp/Havoc-OS*.zip /sdcard
	echo "•$rom_local --> $rom_cloud" >> /sdcard/Download/ext/temp/log
else
	echo "•Havoc OS: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
fi

rm -rf /sdcard/Download/ext/temp/r 2>/dev/null
