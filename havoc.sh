#!/bin/sh

rm -rf /sdcard/Download/ext/temp/r 2>/dev/null

wget --no-check-certificate -O - https://osdn.net/projects/henma-p/storage/capricorn/ > /sdcard/Download/ext/temp/r
a=`cat /sdcard/Download/ext/temp/r | grep "Havoc-OS" | grep "href" | sed '/GApps/d' | grep -Eo '[0-9]+' | sort -rn | head -n 1`

b=`find /storage/emulated/0 -maxdepth 1 -type f -name "Havoc-OS*" | grep -Eo '[0-9]+' | sort -rn | head -n 1`

if [ $a -gt $b [
then
	download_link=`cat /sdcard/Download/ext/temp/r | grep "Havoc-OS" | grep "href" | sed '/GApps/d' | sed 's+^.*href="+https://osdn.net+g; s+">++g'`
	wget -P /sdcard/Download/ext/temp "$download_link"
fi
