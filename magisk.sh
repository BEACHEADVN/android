#!/bin/bash

rm /sdcard/Download/ext/temp/mg 2>/dev/null
rm /sdcard/Download/ext/temp/mg1 2>/dev/null

wget --no-check-certificate -O - https://github.com/topjohnwu/Magisk/releases > /sdcard/Download/ext/temp/mg
a=`cat /sdcard/Download/ext/temp/mg | grep "Magisk v" | sed '1!d' | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/'`

find /storage/emulated/0 -name "Magisk-v*" > /sdcard/Download/ext/temp/mg1
b=`cat /sdcard/Download/ext/temp/mg1 | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/'`

function version {
	echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

if [ $(version $a) -gt $(version $b) ]
then
	download_link=https://github.com/topjohnwu/Magisk/releases/download/v$a/Magisk-v$a.zip
	rm /sdcard/Magisk-v* 2>/dev/null
	wget --no-check-certificate  -P /sdcard "$download_link"
	echo "•Magisk-v$b.zip --> Magisk-v$a.zip" >> /sdcard/Download/ext/temp/log
else
	echo "•Magisk: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
fi

rm /sdcard/Download/ext/temp/mg1 2>/dev/null


rm /sdcard/Download/ext/temp/mg2 2>/dev/null

a=`cat /sdcard/Download/ext/temp/mg | grep "uninstaller" | sed '1!d; s+.zip.*++g; s+^.*uninstaller-++g'`

find /storage/emulated/0 -name "Magisk-uninstaller*" > /sdcard/Download/ext/temp/mg2
if [[ -z $(grep '[^[:space:]]' /sdcard/Download/ext/temp/mg2) ]]
then
	b=0
else
	b=`cat /sdcard/Download/ext/temp/mg2 | sed 's+.zip++g; s+/storage/emulated/0/Magisk-uninstaller-++g'`
fi

if [ $a -gt $b ]
then
	download_link=`cat /sdcard/Download/ext/temp/mg | grep "uninstaller" | sed '1!d; s+.zip.*+.zip+g; s+            <a href="+https://github.com+g'`
	rm /sdcard/Magisk-uninstaller-* 2>/dev/null
	wget --no-check-certificate  -P /sdcard "$download_link"
	echo "•Magisk Uninstaller-v$b.zip --> Magisk Uninstaller-v$a.zip" >> /sdcard/Download/ext/temp/log
else
	echo "•Magisk Uninstaller: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
fi

rm /sdcard/Download/ext/temp/mg2 2>/dev/null


rm /sdcard/Download/ext/temp/mg3 2>/dev/null

a=`cat /sdcard/Download/ext/temp/mg | grep "Manager" | sed '1!d' | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/'`

aapt dump badging /data/app/com.topjohnwu.magisk*/base.apk > /sdcard/Download/ext/temp/mg3
b=`cat /sdcard/Download/ext/temp/mg3 | grep "versionName" | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/'`

if [ $(version $a) -gt $(version $b) ]
then
	download_link=https://github.com/topjohnwu/Magisk/releases/download/manager-v$a/MagiskManager-v$a.apk
	wget --no-check-certificate  -P /sdcard/Download "$download_link"
	pm install /sdcard/Download/MagiskManager*.apk
	rm /sdcard/Download/MagiskManager*.apk 2>/dev/null
	echo "•Magisk-Manager-v$b.apk --> Magisk-Manager-v$a.apk" >> /sdcard/Download/ext/temp/log
else
	echo "•Magisk Manager: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
fi

rm /sdcard/Download/ext/temp/mg 2>/dev/null
rm /sdcard/Download/ext/temp/mg3 2>/dev/null


rm /sdcard/Download/ext/temp/b 2>/dev/null
rm /sdcard/Download/ext/temp/b1 2>/dev/null
rm -rf /sdcard/Download/ext/temp/busybox-ndk-master 2>/dev/null

wget --no-check-certificate -O - https://github.com/Magisk-Modules-Repo/busybox-ndk/blob/master/module.prop> /sdcard/Download/ext/temp/b
a=`cat /sdcard/Download/ext/temp/b | grep "blob-code blob-code-inner js-file-line" | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/'`

c=`cat /sdcard/Download/ext/temp/b | grep "versionCode" | sed 's+</td>++g; s+^.*Code=++g'`

find /storage/emulated/0 -name "Busybox_for_Android_NDK*" > /sdcard/Download/ext/temp/b1
b=`cat /sdcard/Download/ext/temp/b1 | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/'`

d=`cat /sdcard/Download/ext/temp/b1 | sed 's+).*++g; s+^.*(++g'`

function download {
	wget --no-check-certificate  -P /sdcard/Download/ext/temp https://github.com/topjohnwu/Magisk/archive/master.zip
	unzip -qq -o /sdcard/Download/ext/temp/master.zip -d /sdcard/Download/ext/temp
	cat /sdcard/Download/ext/temp/Magisk-master/scripts/module_installer.sh > /sdcard/Download/ext/temp/update-binary
	rm /sdcard/Download/ext/temp/master.zip
	rm -rf /sdcard/Download/ext/temp/Magisk-master
	wget --no-check-certificate  -P /sdcard/Download/ext/temp https://github.com/Magisk-Modules-Repo/busybox-ndk/archive/master.zip
	unzip -qq -o /sdcard/Download/ext/temp/master.zip -d /sdcard/Download/ext/temp
	rm /sdcard/Download/ext/temp/master.zip
	rm /sdcard/Download/ext/temp/busybox-ndk-master/META-INF/com/google/android/update-binary
	mv /sdcard/Download/ext/temp/update-binary /sdcard/Download/ext/temp/busybox-ndk-master/META-INF/com/google/android
	cd /sdcard/Download/ext/temp/busybox-ndk-master
	zip -r "Busybox_for_Android_NDK-$a($c).zip" META-INF README.md busybox-arm busybox-arm64 busybox-mips busybox-mips64 busybox-x86 busybox-x86_64 install.sh module.prop
	rm /sdcard/Busybox_for_Android_NDK*.zip
	mv /sdcard/Download/ext/temp/busybox-ndk-master/"Busybox_for_Android_NDK-$a($c).zip" /sdcard
}

if [ $(version $a) -gt $(version $b) ]
then
	download
	echo "•Busybox_for_Android_NDK-v$b($d).zip --> v$a($c).zip" >> /sdcard/Download/ext/temp/log
else
	if [ $c -gt $d ]
	then
		download
		echo "•Busybox_for_Android_NDK-v$b($d).zip --> Busybox_for_Android_NDK-v$a($c).zip" >> /sdcard/Download/ext/temp/log
	else
		echo "•Busybox for Android NDK: Không có phiên bản mới." >> /sdcard/Download/ext/temp/log
	fi
fi

rm /sdcard/Download/ext/temp/b 2>/dev/null
rm /sdcard/Download/ext/temp/b1 2>/dev/null
rm -rf /sdcard/Download/ext/temp/busybox-ndk-master 2>/dev/null


rm /sdcard/Download/ext/temp/w 2>/dev/null
rm /sdcard/Download/ext/temp/w1 2>/dev/null
rm -rf /sdcard/Download/ext/temp/wifi-bonding-master 2>/dev/null

wget --no-check-certificate -O - https://github.com/Magisk-Modules-Repo/wifi-bonding/blob/master/module.prop > /sdcard/Download/ext/temp/w
a=`cat /sdcard/Download/ext/temp/w | grep "blob-code blob-code-inner js-file-line" | grep "version" | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/'`

c=`cat /sdcard/Download/ext/temp/w | grep "versionCode" | sed 's+</td>++g; s+^.*Code=++g'`

find /storage/emulated/0 -name "Wifi_Bonding_*" >> /sdcard/Download/ext/temp/w1
b=`cat /sdcard/Download/ext/temp/w1 | sed 's+/storage/emulated/0/Wifi_Bonding_(Qcom)-++g; s+(.*++g'`

d=`cat /sdcard/Download/ext/temp/w1 | sed 's+/storage/emulated/0/Wifi_Bonding_(Qcom)-++g; s+).*++g; s+^.*(++g'`

function download {
	wget --no-check-certificate  -P /sdcard/Download/ext/temp https://github.com/topjohnwu/Magisk/archive/master.zip
		unzip -qq -o /sdcard/Download/ext/temp/master.zip -d /sdcard/Download/ext/temp
		cat /sdcard/Download/ext/temp/Magisk-master/scripts/module_installer.sh > /sdcard/Download/ext/temp/update-binary
		rm /sdcard/Download/ext/temp/master.zip 2>/dev/null
		rm -rf /sdcard/Download/ext/temp/Magisk-master
		wget --no-check-certificate  -P /sdcard/Download/ext/temp https://github.com/Magisk-Modules-Repo/wifi-bonding/archive/master.zip
		unzip -qq -o /sdcard/Download/ext/temp/master.zip -d /sdcard/Download/ext/temp
		rm /sdcard/Download/ext/temp/master.zip 2>/dev/null
		rm /sdcard/Download/ext/temp/wifi-bonding-master/META-INF/com/google/android/update-binary
		mv /sdcard/Download/ext/temp/update-binary /sdcard/Download/ext/temp/wifi-bonding-master/META-INF/com/google/android
		cd /sdcard/Download/ext/temp/wifi-bonding-master
		zip -r "Wifi_Bonding_(Qcom)-$a($c).zip" META-INF customize.sh module.prop .gitattributes README.md
		rm /sdcard/Wifi_Bonding_*.zip 2>/dev/null
		mv /sdcard/Download/ext/temp/wifi-bonding-master/"Wifi_Bonding_(Qcom)-$a($c).zip" /sdcard
}

if [ $(version $a) -gt $(version $b) ]
then
	download
	echo "•Wifi_Bonding_v$b($d).zip --> Wifi_Bonding_(Qcom)-$a($c).zip" >> /sdcard/Download/ext/temp/log
else
	if [ $c -gt $d ]
	then
		download
		echo "•Wifi_Bonding_(Qcom)-$b($d).zip --> Wifi_Bonding_(Qcom)-$a($c).zip" >> /sdcard/Download/ext/temp/log
	else
		echo "•Wifi Bonding (Qcom): Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
	fi
fi

rm /sdcard/Download/ext/temp/w 2>/dev/null
rm /sdcard/Download/ext/temp/w1 2>/dev/null
rm -rf /sdcard/Download/ext/temp/wifi-bonding-master 2>/dev/null


rm -rf /sdcard/Download/ext/temp/Jancox-tool-android-master 2>/dev/null

a=`wget --no-check-certificate -O - https://github.com/Wahyu6070/Jancox-tool-android/blob/master/module.prop | grep "blob-code blob-code-inner js-file-line" | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/'`

b=`find /storage/emulated/0 -name "Jancox-Tool-Android*.zip" | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/'`

function version {
	echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

if [ $(version $a) -gt $(version $b) ]
then
	wget --no-check-certificate  -P /sdcard/Download/ext/temp https://github.com/Wahyu6070/Jancox-tool-android/archive/master.zip
	unzip -qq -o /sdcard/Download/ext/temp/master.zip -d /sdcard/Download/ext/temp
	rm /sdcard/Download/ext/temp/master.zip
	cd /sdcard/Download/ext/temp/Jancox-tool-android-master
	zip -r "Jancox-Tool-Android-v$a.zip" bin META-INF system changelog README.md module.prop customize.sh uninstall.sh
	rm /sdcard/Jancox-Tool-Android*.zip 2>/dev/null
	mv /sdcard/Download/ext/temp/Jancox-tool-android-master/"Jancox-Tool-Android-v$a.zip" /sdcard
	echo "•Jancox-Tool-Android-v$b.zip --> Jancox-Tool-Android-v$a.zip" >> /sdcard/Download/ext/temp/log
else
	echo "•Jancox-Tool-Android: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
fi

rm -rf /sdcard/Download/ext/temp/Jancox-tool-android-master 2>/dev/null