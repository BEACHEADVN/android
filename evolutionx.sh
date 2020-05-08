#!/bin/sh

rm /sdcard/Download/ext/temp/ex 2>/dev/null
rm /sdcard/Download/ext/temp/ex1 2>/dev/null

wget --no-check-certificate -O - https://sourceforge.net/projects/henma-project/files/Evo-X-ten/ > /sdcard/Download/ext/temp/ex
ver_web=`cat /sdcard/Download/ext/temp/ex | grep "Click to download" | sed '1!d; s+                           title="Click to download ++g; s+">++g' | cut -d'_' -f 2`
day_web=`cat /sdcard/Download/ext/temp/ex | grep "Click to download" | sed '1!d; s+                           title="Click to download ++g; s+">++g' | cut -d'-' -f 3`
time_web=`cat /sdcard/Download/ext/temp/ex | grep "Click to download" | sed '1!d; s+                           title="Click to download ++g; s+">++g' | cut -d'-' -f 4`

find /storage/emulated/0 -name "EvolutionX*.zip" | sed  's+/storage/emulated/0/++g' > /sdcard/Download/ext/temp/ex1
ver_local=`cat /sdcard/Download/ext/temp/ex1 | cut -d'_' -f 2`
day_local=`cat /sdcard/Download/ext/temp/ex1 | cut -d'-' -f 3`
time_local=`cat /sdcard/Download/ext/temp/ex1 | cut -d'-' -f 4`

function version {
	echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

function download {
	name=`cat /sdcard/Download/ext/temp/ex | grep "Click to download" | sed '1!d; s+                           title="Click to download ++g; s+">++g'`
	wget --no-check-certificate  -P /sdcard/Download/ext/temp https://sourceforge.net/projects/henma-project/files/Evo-X-ten/$name
	md5sum=`md5sum /sdcard/Download/ext/temp/$name | sed 's+ /sdcard/+ +g' | awk '{print substr($0,0,32)}'`
	if grep -Fxq "$md5sum" /sdcard/Download/ext/temp/ex
	then
		rm /sdcard/EvolutionX_*.zip 2> /dev/null
		mv /sdcard/Download/ext/temp/$name
	else
		rm /sdcard/Download/ext/temp/$name
	fi
}

if [ $(version $ver_web) -gt $(version $ver_local) ]
then
	download
	echo "•EvolutionX: Tải $name" >> /sdcard/Download/ext/temp/log
else
	if [ $(version $day_web) -gt $(version $day_local) ]
	then
		download
		echo "•EvolutionX: Tải $name" >> /sdcard/Download/ext/temp/log
	else
		if [ $(version $time_web) -gt $(version $time_local) ]
		then
			download
			echo "•EvolutionX: Tải $name" >> /sdcard/Download/ext/temp/log
		else
			echo "•EvolutionX: Không có phiên bản mới." >> /sdcard/Download/ext/temp/log
		fi
	fi
fi