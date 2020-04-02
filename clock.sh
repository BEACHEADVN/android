#!/bin/bash

rm /sdcard/Download/ext/temp/c 2>/dev/null
rm /sdcard/Download/ext/temp/c1 2>/dev/null
rm -rf /sdcard/Download/ext/temp/META-INF 2>/dev/null
rm -rf /sdcard/Download/ext/temp/system 2>/dev/null

if [ -d /data/app/com.google.android.deskclock-* ]
then
	aapt dump badging /data/app/com.google.android.deskclock-*/base.apk > /sdcard/Download/ext/temp/c
	a=`cat /sdcard/Download/ext/temp/c | grep "versionName" | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/'`
	
	unzip -qq -o /sdcard/tweak-havoc-capricorn-q-part1.zip -d /sdcard/Download/ext/temp
	aapt dump badging /sdcard/Download/ext/temp/system/product/app/DeskClock/*.apk > /sdcard/Download/ext/temp/c1
	b=`cat /sdcard/Download/ext/temp/c1 | grep "versionName" | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/'`
	
	function version {
		echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
	}
	
	if [ $(version $a) -gt $(version $b) ]
	then
		rm -rf /sdcard/Download/ext/temp/system/product/app/DeskClock/*
		cp -r /data/app/com.google.android.deskclock-*/* /sdcard/Download/ext/temp/system/product/app/DeskClock
		cd /sdcard/Download/ext/temp
		zip -r "tweak-havoc-capricorn-q-part1.zip" META-INF system
		rm /sdcard/tweak-havoc-capricorn-q-part1.zip 2>/dev/null
		mv -f /sdcard/Download/ext/temp/tweak-havoc-capricorn-q-part1.zip /sdcard
		echo "•Desk_Clock_$b.apk --> Desk_Clock_$a.apk" >> /sdcard/Download/ext/temp/log
	else
		echo "•Desk Clock: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
	fi
fi

rm /sdcard/Download/ext/temp/c 2>/dev/null
rm /sdcard/Download/ext/temp/c1 2>/dev/null
rm -rf /sdcard/Download/ext/temp/META-INF 2>/dev/null
rm -rf /sdcard/Download/ext/temp/system 2>/dev/null