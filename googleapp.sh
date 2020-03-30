#! bin/sh

rm /sdcard/Download/ext/temp/c 2>/dev/null
rm /sdcard/Download/ext/temp/c1 2>/dev/null
rm /sdcard/Download/ext/temp/c2 2>/dev/null
rm /sdcard/Download/ext/temp/c3 2>/dev/null
rm /sdcard/Download/ext/temp/c4 2>/dev/null
rm /sdcard/Download/ext/temp/c5 2>/dev/null
rm /sdcard/Download/ext/temp/c6 2>/dev/null
rm /sdcard/Download/ext/temp/c7 2>/dev/null
rm /sdcard/Download/ext/temp/META-INF 2>/dev/null
rm /sdcard/Download/ext/temp/system 2>/dev/null

unzip -qq -o /sdcard/tweak-havoc-capricorn-q-part2.zip -d /sdcard/Download/ext/temp
aapt dump badging /data/app/com.google.android.contacts-*/base.apk > /sdcard/Download/ext/temp/c
grep "versionName" /sdcard/Download/ext/temp/c > /sdcard/Download/ext/temp/c1
sed -i "s+' platform.*++g; s+^.*' versionName='++g" /sdcard/Download/ext/temp/c1
a=`cat /sdcard/Download/ext/temp/c1`

aapt dump badging /sdcard/Download/ext/temp/system/product/priv-app/Contacts/base.apk > /sdcard/Download/ext/temp/c2
grep "versionName" /sdcard/Download/ext/temp/c2 > /sdcard/Download/ext/temp/c3
sed -i "s+' platform.*++g; s+^.*' versionName='++g" /sdcard/Download/ext/temp/c3
b=`cat /sdcard/Download/ext/temp/c3`

function version {
echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

if [ $(version $a) -gt $(version $b) ]
then
	rm -rf /sdcard/Download/ext/temp/system/product/priv-app/Contacts/*
	cp -r /data/app/com.google.android.contacts-*/* /sdcard/Download/ext/temp/system/product/priv-app/Contacts
	echo "•Google_Contacts-$b --> Google_Contacts-$a" >> /sdcard/Download/ext/temp/log
	echo "1" >> /sdcard/Download/ext/temp/confirm
else
	echo "•Google Contacts: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
	echo "0" >> /sdcard/Download/ext/temp/confirm
fi

rm /sdcard/Download/ext/temp/c 2>/dev/null
rm /sdcard/Download/ext/temp/c1 2>/dev/null
rm /sdcard/Download/ext/temp/c2 2>/dev/null
rm /sdcard/Download/ext/temp/c3 2>/dev/null
rm /sdcard/Download/ext/temp/c4 2>/dev/null
rm /sdcard/Download/ext/temp/c5 2>/dev/null
rm /sdcard/Download/ext/temp/c6 2>/dev/null
rm /sdcard/Download/ext/temp/c7 2>/dev/null

rm /sdcard/Download/ext/temp/d 2>/dev/null
rm /sdcard/Download/ext/temp/d1 2>/dev/null
rm /sdcard/Download/ext/temp/d2 2>/dev/null
rm /sdcard/Download/ext/temp/d3 2>/dev/null
rm /sdcard/Download/ext/temp/d4 2>/dev/null
rm /sdcard/Download/ext/temp/d5 2>/dev/null
rm /sdcard/Download/ext/temp/d6 2>/dev/null
rm /sdcard/Download/ext/temp/d7 2>/dev/null

aapt dump badging /data/app/com.google.android.dialer-*/base.apk > /sdcard/Download/ext/temp/d
grep "versionName" /sdcard/Download/ext/temp/d > /sdcard/Download/ext/temp/d1
sed -i "s+' platform.*++g; s+^.*' versionName='++g" /sdcard/Download/ext/temp/d1
a=`cat /sdcard/Download/ext/temp/d1`

aapt dump badging /sdcard/Download/ext/temp/system/product/priv-app/Dialer/base.apk > /sdcard/Download/ext/temp/d2
grep "versionName" /sdcard/Download/ext/temp/d2 > /sdcard/Download/ext/temp/d3
sed -i "s+' platform.*++g; s+^.*' versionName='++g" /sdcard/Download/ext/temp/d3
b=`cat /sdcard/Download/ext/temp/d3`

function version {
echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

if [ $(version $a) -gt $(version $b) ]
then
	rm -rf /sdcard/Download/ext/temp/system/product/priv-app/Dialer/*
	cp -r /data/app/com.google.android.dialer-*/* /sdcard/Download/ext/temp/system/product/priv-app/Dialer
	echo "•Google_Dialer-$b --> Google_Dialer-$a" >> /sdcard/Download/ext/temp/log
	echo "1" >> /sdcard/Download/ext/temp/confirm
else
	echo "•Google Dialer: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
	echo "0" >> /sdcard/Download/ext/temp/confirm
fi

rm /sdcard/Download/ext/temp/d 2>/dev/null
rm /sdcard/Download/ext/temp/d1 2>/dev/null
rm /sdcard/Download/ext/temp/d2 2>/dev/null
rm /sdcard/Download/ext/temp/d3 2>/dev/null
rm /sdcard/Download/ext/temp/d4 2>/dev/null
rm /sdcard/Download/ext/temp/d5 2>/dev/null
rm /sdcard/Download/ext/temp/d6 2>/dev/null
rm /sdcard/Download/ext/temp/d7 2>/dev/null

rm /sdcard/Download/ext/temp/m 2>/dev/null
rm /sdcard/Download/ext/temp/m1 2>/dev/null
rm /sdcard/Download/ext/temp/m2 2>/dev/null
rm /sdcard/Download/ext/temp/m3 2>/dev/null
rm /sdcard/Download/ext/temp/m4 2>/dev/null
rm /sdcard/Download/ext/temp/m5 2>/dev/null
rm /sdcard/Download/ext/temp/m6 2>/dev/null
rm /sdcard/Download/ext/temp/m7 2>/dev/null

aapt dump badging /data/app/com.google.android.apps.messaging-*/base.apk > /sdcard/Download/ext/temp/m
grep "versionCode" /sdcard/Download/ext/temp/m > /sdcard/Download/ext/temp/m1
sed "s+' versionName.*++g; s+package: name='com.google.android.apps.messaging' versionCode='++g" /sdcard/Download/ext/temp/m1 > /sdcard/Download/ext/temp/m2
a=`cat /sdcard/Download/ext/temp/m2`
sed "s+' platform.*++g; s+^.*' versionName='++g" /sdcard/Download/ext/temp/m1 > /sdcard/Download/ext/temp/m3
c=`cat /sdcard/Download/ext/temp/m3`

aapt dump badging /sdcard/Download/ext/temp/system/product/app/messaging/base.apk > /sdcard/Download/ext/temp/m4
grep "versionCode" /sdcard/Download/ext/temp/m4 > /sdcard/Download/ext/temp/m5
sed "s+' versionName.*++g; s+package: name='com.google.android.apps.messaging' versionCode='++g" /sdcard/Download/ext/temp/m5 > /sdcard/Download/ext/temp/m6
b=`cat /sdcard/Download/ext/temp/m6`
sed "s+' platform.*++g; s+^.*' versionName='++g" /sdcard/Download/ext/temp/m5 > /sdcard/Download/ext/temp/m7
d=`cat /sdcard/Download/ext/temp/m7`

function version {
echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

if [ $(version $a) -gt $(version $b) ]
then
	rm -rf /sdcard/Download/ext/temp/system/product/app/messaging/*
	cp -r /data/app/com.google.android.apps.messaging-*/* /sdcard/Download/ext/temp/system/product/app/messaging
	echo "•Google_Messages-$d --> Google_Messages-$c" >> /sdcard/Download/ext/temp/log
	echo "1" >> /sdcard/Download/ext/temp/confirm
else
	echo "•Google Messages: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
	echo "0" >> /sdcard/Download/ext/temp/confirm
fi

rm /sdcard/Download/ext/temp/m 2>/dev/null
rm /sdcard/Download/ext/temp/m1 2>/dev/null
rm /sdcard/Download/ext/temp/m2 2>/dev/null
rm /sdcard/Download/ext/temp/m3 2>/dev/null
rm /sdcard/Download/ext/temp/m4 2>/dev/null
rm /sdcard/Download/ext/temp/m5 2>/dev/null
rm /sdcard/Download/ext/temp/m6 2>/dev/null
rm /sdcard/Download/ext/temp/m7 2>/dev/null
rm -rf /sdcard/Download/ext/temp/META-INF 2>/dev/null
rm -rf /sdcard/Download/ext/temp/system 2>/dev/null

if grep -Fxq "1" /sdcard/Download/ext/temp/confirm
then
	cd /sdcard/Download/ext/temp
	zip -r tweak-havoc-capricorn-q-part2.zip META-INF system
	rm /sdcard/tweak-havoc-capricorn-q-part2.zip
	mv -f /sdcard/Download/ext/temp/tweak-havoc-capricorn-q-part2.zip /sdcard
fi

rm /sdcard/Download/ext/temp/confirm
