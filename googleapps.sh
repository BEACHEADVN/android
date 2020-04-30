#! bin/sh

function version {
	echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

rm /sdcard/Download/ext/temp/confirm 2>/dev/null
rm -rf /sdcard/Download/ext/temp/META-INF 2>/dev/null
rm -rf /sdcard/Download/ext/temp/system 2>/dev/null

unzip -qq -o /sdcard/tweak-havoc-capricorn-q-part1.zip -d /sdcard/Download/ext/temp

a=`aapt dump badging /data/app/com.google.android.contacts-*/base.apk | grep "versionName" | sed "s+' platform.*++g; s+^.*' versionName='++g"`

b=`aapt dump badging /sdcard/Download/ext/temp/system/product/priv-app/GoogleContacts/base.apk | grep "versionName" | sed "s+' platform.*++g; s+^.*' versionName='++g"`

if [ $(version $a) -gt $(version $b) ]
then
	rm -rf /sdcard/Download/ext/temp/system/product/priv-app/GoogleContacts/*
	cp -r /data/app/com.google.android.contacts-*/* /sdcard/Download/ext/temp/system/product/priv-app/GoogleContacts
	echo "•Google_Contacts-$b --> Google_Contacts-$a" >> /sdcard/Download/ext/temp/log
	echo "1" >> /sdcard/Download/ext/temp/confirm
else
	echo "•Google Contacts: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
	echo "0" >> /sdcard/Download/ext/temp/confirm
fi


a=`aapt dump badging /data/app/com.google.android.dialer-*/base.apk | grep "versionName" | sed "s+' platform.*++g; s+^.*' versionName='++g"`

b=`aapt dump badging /sdcard/Download/ext/temp/system/product/priv-app/Dialer/base.apk | grep "versionName" | sed "s+' platform.*++g; s+^.*' versionName='++g"`

if [ $(version $a) -gt $(version $b) ]
then
	rm -rf /sdcard/Download/ext/temp/system/product/priv-app/GoogleDialer/*
	cp -r /data/app/com.google.android.dialer-*/* /sdcard/Download/ext/temp/system/product/priv-app/GoogleDialer
	echo "•Google_Dialer-$b --> Google_Dialer-$a" >> /sdcard/Download/ext/temp/log
	echo "1" >> /sdcard/Download/ext/temp/confirm
else
	echo "•Google Dialer: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
	echo "0" >> /sdcard/Download/ext/temp/confirm
fi


a=`aapt dump badging /data/app/com.google.android.apps.messaging-*/base.apk | grep "versionCode" | sed "s+' versionName.*++g; s+package: name='com.google.android.apps.messaging' versionCode='++g"`
c=`aapt dump badging /data/app/com.google.android.apps.messaging-*/base.apk | grep "versionCode" | sed "s+' platform.*++g; s+^.*' versionName='++g"`

b=`aapt dump badging /sdcard/Download/ext/temp/system/product/app/GoogleMessages/base.apk | grep "versionCode" | sed "s+' versionName.*++g; s+package: name='com.google.android.apps.messaging' versionCode='++g"`
d=`aapt dump badging /sdcard/Download/ext/temp/system/product/app/GoogleMessages/base.apk | grep "versionCode" | sed "s+' platform.*++g; s+^.*' versionName='++g"`

if [ $(version $a) -gt $(version $b) ]
then
	rm -rf /sdcard/Download/ext/temp/system/product/app/GoogleMessages/*
	cp -r /data/app/com.google.android.apps.messaging-*/* /sdcard/Download/ext/temp/system/product/app/GoogleMessages
	echo "•Google_Messages-$d --> Google_Messages-$c" >> /sdcard/Download/ext/temp/log
	echo "1" >> /sdcard/Download/ext/temp/confirm
else
	echo "•Google Messages: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
	echo "0" >> /sdcard/Download/ext/temp/confirm
fi


if grep -Fxq "1" /sdcard/Download/ext/temp/confirm
then
	cd /sdcard/Download/ext/temp
	zip -r tweak-havoc-capricorn-q-part1.zip META-INF system
	rm /sdcard/tweak-havoc-capricorn-q-part1.zip
	mv -f /sdcard/Download/ext/temp/tweak-havoc-capricorn-q-part1.zip /sdcard
fi

rm /sdcard/Download/ext/temp/confirm
rm -rf /sdcard/Download/ext/temp/META-INF 2>/dev/null
rm -rf /sdcard/Download/ext/temp/system 2>/dev/null
