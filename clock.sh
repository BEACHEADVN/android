#!/bin/bash

rm /sdcard/Download/ext/temp/c 2>/dev/null
rm /sdcard/Download/ext/temp/c1 2>/dev/null
rm /sdcard/Download/ext/temp/c2 2>/dev/null
rm /sdcard/Download/ext/temp/c3 2>/dev/null
rm /sdcard/Download/ext/temp/c4 2>/dev/null
rm /sdcard/Download/ext/temp/c5 2>/dev/null
rm /sdcard/Download/ext/temp/c6 2>/dev/null
rm /sdcard/Download/ext/temp/c7 2>/dev/null
rm -rf /sdcard/Download/ext/temp/META-INF 2>/dev/null
rm -rf /sdcard/Download/ext/temp/system 2>/dev/null

wget --no-check-certificate -O - https://m.apkpure.com/vn/clock/com.google.android.deskclock > /sdcard/Download/ext/temp/c
grep "meta name=" /sdcard/Download/ext/temp/c > /sdcard/Download/ext/temp/c1
sed -i '1!d' /sdcard/Download/ext/temp/c1
perl -pe '($_)=/([0-9]+([.][0-9]+)+)/' /sdcard/Download/ext/temp/c1 > /sdcard/Download/ext/temp/c2
a=`cat /sdcard/Download/ext/temp/c2`

unzip -qq -o /sdcard/tweak-havoc-capricorn-q-part1.zip -d /sdcard/Download/ext/temp
aapt dump badging /sdcard/Download/ext/temp/system/product/app/DeskClock/*.apk > /sdcard/Download/ext/temp/c3
grep "versionName" /sdcard/Download/ext/temp/c3 > /sdcard/Download/ext/temp/c4
perl -pe '($_)=/([0-9]+([.][0-9]+)+)/' /sdcard/Download/ext/temp/c4 > /sdcard/Download/ext/temp/c5
b=`cat /sdcard/Download/ext/temp/c5`

function version {
echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

if [ $(version $a) -gt $(version $b) ]
then
	wget --no-check-certificate -O - https://m.apkpure.com/vn/clock/com.google.android.deskclock/download?from=details > /sdcard/Download/ext/temp/c6
	grep "https://download.apkpure.com/b/apk" /sdcard/Download/ext/temp/c6 > /sdcard/Download/ext/temp/c7
	sed -i '1!d; s+^.*href="++g; s+\hot=1.*+hot=1+g' /sdcard/Download/ext/temp/c7
	d=`cat /sdcard/Download/ext/temp/c7`
	wget  --no-check-certificate -P /sdcard/Download "$d"
	sed -i 's+https://download.apkpure.com/b/apk/++g' /sdcard/Download/ext/temp/c7
	awk -i inplace '{print substr($0,0,236)}' /sdcard/Download/ext/temp/c7
	rm /sdcard/Download/Deskclock.apk 2>/dev/null
	name=`cat /sdcard/Download/ext/temp/c7`
	mv /sdcard/Download/$name /sdcard/Download/Deskclock.apk
	rm /sdcard/Download/ext/temp/system/product/app/DeskClock/*.apk 2>/dev/null
	mv -f /sdcard/Download/Deskclock.apk /sdcard/Download/ext/temp/system/product/app/DeskClock
	cd /sdcard/Download/ext/temp
	zip -r "tweak-havoc-capricorn-q-part1.zip" META-INF system
	rm /sdcard/tweak-havoc-capricorn-q-part1.zip 2>/dev/null
	mv -f /sdcard/Download/ext/temp/tweak-havoc-capricorn-q-part1.zip /sdcard
	echo "•Desk_Clock_$b.apk --> Desk_Clock_$a.apk" >> /sdcard/Download/ext/temp/log
else
	echo "•Desk Clock: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
fi

rm /sdcard/Download/ext/temp/c 2>/dev/null
rm /sdcard/Download/ext/temp/c1 2>/dev/null
rm /sdcard/Download/ext/temp/c2 2>/dev/null
rm /sdcard/Download/ext/temp/c3 2>/dev/null
rm /sdcard/Download/ext/temp/c4 2>/dev/null
rm /sdcard/Download/ext/temp/c5 2>/dev/null
rm /sdcard/Download/ext/temp/c6 2>/dev/null
rm /sdcard/Download/ext/temp/c7 2>/dev/null
rm -rf /sdcard/Download/ext/temp/META-INF 2>/dev/null
rm -rf /sdcard/Download/ext/temp/system 2>/dev/null