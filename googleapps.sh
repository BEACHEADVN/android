#! bin/sh

function version {
	echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

rm /sdcard/Download/ext/temp/c 2>/dev/null
rm /sdcard/Download/ext/temp/c1 2>/dev/null
rm /sdcard/Download/ext/temp/META-INF 2>/dev/null
rm /sdcard/Download/ext/temp/system 2>/dev/null

unzip -qq -o /sdcard/tweaktweak-havoc-capricorn-q-part2.zip -d /sdcard/Download/ext/temp

aapt dump badging /data/app/com.google.android.contacts-*/base.apk > /sdcard/Download/ext/temp/c
a=`cat /sdcard/Download/ext/temp/c | grep "versionName" | sed "s+' platform.*++g; s+^.*' versionName='++g"`

aapt dump badging /sdcard/Download/ext/temp/system/product/priv-app/Contacts/base.apk > /sdcard/Download/ext/temp/c1
b=`cat /sdcard/Download/ext/temp/c1 | grep "versionName" | sed "s+' platform.*++g; s+^.*' versionName='++g"`

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


rm /sdcard/Download/ext/temp/d 2>/dev/null
rm /sdcard/Download/ext/temp/d1 2>/dev/null

aapt dump badging /data/app/com.google.android.dialer-*/base.apk > /sdcard/Download/ext/temp/d
a=`cat /sdcard/Download/ext/temp/d | grep "versionName" | sed "s+' platform.*++g; s+^.*' versionName='++g"`

aapt dump badging /sdcard/Download/ext/temp/system/product/priv-app/Dialer/base.apk > /sdcard/Download/ext/temp/d1
b=`cat /sdcard/Download/ext/temp/d1 | grep "versionName" | sed "s+' platform.*++g; s+^.*' versionName='++g"`

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


rm /sdcard/Download/ext/temp/m 2>/dev/null
rm /sdcard/Download/ext/temp/m1 2>/dev/null

aapt dump badging /data/app/com.google.android.apps.messaging-*/base.apk > /sdcard/Download/ext/temp/m
a=`cat /sdcard/Download/ext/temp/m | grep "versionCode" | sed "s+' versionName.*++g; s+package: name='com.google.android.apps.messaging' versionCode='++g"`
c=`cat /sdcard/Download/ext/temp/m | grep "versionCode" | sed "s+' platform.*++g; s+^.*' versionName='++g"`

aapt dump badging /sdcard/Download/ext/temp/system/product/app/messaging/base.apk > /sdcard/Download/ext/temp/m1
b=`cat /sdcard/Download/ext/temp/m1 | grep "versionCode" | sed "s+' versionName.*++g; s+package: name='com.google.android.apps.messaging' versionCode='++g"`
d=`cat /sdcard/Download/ext/temp/m1 | grep "versionCode" | sed "s+' platform.*++g; s+^.*' versionName='++g"`

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


if grep -Fxq "1" /sdcard/Download/ext/temp/confirm
then
	cd /sdcard/Download/ext/temp
	zip -r tweaktweak-havoc-capricorn-q-part2.zip META-INF system
	rm /sdcard/tweaktweak-havoc-capricorn-q-part2.zip
	mv -f /sdcard/Download/ext/temp/tweaktweak-havoc-capricorn-q-part2.zip /sdcard
fi

rm /sdcard/Download/ext/temp/confirm
rm -rf /sdcard/Download/ext/temp/META-INF 2>/dev/null
rm -rf /sdcard/Download/ext/temp/system 2>/dev/null
