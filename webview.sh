#!/bin/bash

rm /sdcard/Download/ext/temp/w 2>/dev/null
rm /sdcard/Download/ext/temp/w1 2>/dev/null
rm /sdcard/Download/ext/temp/w2 2>/dev/null
rm /sdcard/Download/ext/temp/w3 2>/dev/null
rm /sdcard/Download/ext/temp/w4 2>/dev/null
rm /sdcard/Download/ext/temp/w5 2>/dev/null
rm /sdcard/Download/ext/temp/w6 2>/dev/null
rm /sdcard/Download/ext/temp/w7 2>/dev/null
rm -rf /sdcard/Download/ext/temp/META-INF 2>/dev/null
rm -rf /sdcard/Download/ext/temp/system 2>/dev/null

wget --no-check-certificate -O - https://m.apkpure.com/vn/android-system-webview/com.google.android.webview > /sdcard/Download/ext/temp/w
grep "meta name=" /sdcard/Download/ext/temp/w > /sdcard/Download/ext/temp/w1
sed -i '1!d' /sdcard/Download/ext/temp/w1
perl -pe '($_)=/([0-9]+([.][0-9]+)+)/' /sdcard/Download/ext/temp/w1 > /sdcard/Download/ext/temp/w2
a=`cat /sdcard/Download/ext/temp/w2`

unzip -qq -o /sdcard/tweak-havoc-capricorn-q-part2.zip -d /sdcard/Download/ext/temp
aapt dump badging /sdcard/Download/ext/temp/system/product/app/webview/*.apk > /sdcard/Download/ext/temp/w3
grep "versionName" /sdcard/Download/ext/temp/w3 > /sdcard/Download/ext/temp/w4
perl -pe '($_)=/([0-9]+([.][0-9]+)+)/' /sdcard/Download/ext/temp/w4 > /sdcard/Download/ext/temp/w5
b=`cat /sdcard/Download/ext/temp/w5`

function version {
echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

if [ $(version $a) -gt $(version $b) ]
then
	wget --no-check-certificate -O - https://m.apkpure.com/vn/android-system-webview/com.google.android.webview/download?from=details > /sdcard/Download/ext/temp/w6
	grep "https://download.apkpure.com/b/APK" /sdcard/Download/ext/temp/w6 > /sdcard/Download/ext/temp/w7
	sed -i '1!d; s+^.*href="++g; s+\hot=1.*+hot=1+g' /sdcard/Download/ext/temp/w7
	d=`cat /sdcard/Download/ext/temp/w7`
	wget  --no-check-certificate -P /sdcard/Download "$d"
	sed -i 's+https://download.apkpure.com/b/APK/++g' /sdcard/Download/ext/temp/w7
	awk -i inplace '{print substr($0,0,236)}' /sdcard/Download/ext/temp/w7
	rm /sdcard/Download/webview.apk
	name=`cat /sdcard/Download/ext/temp/w7`
	mv /sdcard/Download/$name /sdcard/Download/webview.apk
	rm /sdcard/Download/ext/temp/system/product/app/webview/*.apk
	mv -f /sdcard/Download/webview.apk /sdcard/Download/ext/temp/system/product/app/webview
	cd /sdcard/Download/ext/temp
	zip -r "tweak-havoc-capricorn-q-part2.zip" META-INF system
	rm /sdcard/tweak-havoc-capricorn-q-part2.zip
	mv -f /sdcard/Download/ext/temp/tweak-havoc-capricorn-q-part2.zip /sdcard
	echo "•Webview_Google-$b.apk --> Webview_Google-$a.apk" >> /sdcard/Download/ext/temp/log
else
	echo "•Webview Google: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
fi

rm /sdcard/Download/ext/temp/w 2>/dev/null
rm /sdcard/Download/ext/temp/w1 2>/dev/null
rm /sdcard/Download/ext/temp/w2 2>/dev/null
rm /sdcard/Download/ext/temp/w3 2>/dev/null
rm /sdcard/Download/ext/temp/w4 2>/dev/null
rm /sdcard/Download/ext/temp/w5 2>/dev/null
rm /sdcard/Download/ext/temp/w6 2>/dev/null
rm /sdcard/Download/ext/temp/w7 2>/dev/null
rm -rf /sdcard/Download/ext/temp/META-INF 2>/dev/null
rm -rf /sdcard/Download/ext/temp/system 2>/dev/null