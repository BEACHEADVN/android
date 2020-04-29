#!/bin/bash

rm -rf /sdcard/Download/ext/temp/META-INF 2>/dev/null
rm -rf /sdcard/Download/ext/temp/system 2>/dev/null

if [ -d /data/app/com.google.android.webview-* ]
then
	a=`aapt dump badging /data/app/com.google.android.webview-*/base.apk | grep "versionName" | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/'`
	
	unzip -qq -o /sdcard/tweak-havoc-capricorn-q-part2.zip -d /sdcard/Download/ext/temp
	b=`aapt dump badging /sdcard/Download/ext/temp/system/product/app/webview/*.apk | grep "versionName" | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/'`
	
	function version {
		echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
	}
	
	if [ $(version $a) -gt $(version $b) ]
	then
		rm -rf /sdcard/Download/ext/temp/system/product/app/webview/*
		cp -r /data/app/com.google.android.webview-*/* /sdcard/Download/ext/temp/system/product/app/webview
		cd /sdcard/Download/ext/temp
		zip -r "tweak-havoc-capricorn-q-part2.zip" META-INF system
		rm /sdcard/tweak-havoc-capricorn-q-part2.zip 2>/dev/null
		mv -f /sdcard/Download/ext/temp/tweak-havoc-capricorn-q-part2.zip /sdcard
		echo "•Webview-$b.apk --> Webview-$a.apk" >> /sdcard/Download/ext/temp/log
	else
		echo "•Webview Google: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
	fi
fi

rm -rf /sdcard/Download/ext/temp/META-INF 2>/dev/null
rm -rf /sdcard/Download/ext/temp/system 2>/dev/null