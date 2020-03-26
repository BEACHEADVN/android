#!/bin/bash

rm /sdcard/Download/ext/temp/mg 2>/dev/null
rm /sdcard/Download/ext/temp/mg1 2>/dev/null
rm /sdcard/Download/ext/temp/mg2 2>/dev/null
rm /sdcard/Download/ext/temp/mg3 2>/dev/null
rm /sdcard/Download/ext/temp/mg4 2>/dev/null

wget --no-check-certificate -O - https://github.com/topjohnwu/Magisk/releases > /sdcard/Download/ext/temp/mg
grep "Magisk v" /sdcard/Download/ext/temp/mg > /sdcard/Download/ext/temp/mg1
sed -i '1!d' /sdcard/Download/ext/temp/mg1
perl -pe '($_)=/([0-9]+([.][0-9]+)+)/' /sdcard/Download/ext/temp/mg1 > /sdcard/Download/ext/temp/mg2
a=`cat /sdcard/Download/ext/temp/mg2`

find /storage/emulated/0 -name "Magisk-v*" > /sdcard/Download/ext/temp/mg3
perl -pe '($_)=/([0-9]+([.][0-9]+)+)/' /sdcard/Download/ext/temp/mg3 > /sdcard/Download/ext/temp/mg4
b=` cat /sdcard/Download/ext/temp/mg4`

function version {
echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

if [ $(version $a) -gt $(version $b) ]
then
	d=https://github.com/topjohnwu/Magisk/releases/download/v$a/Magisk-v$a.zip
	rm /sdcard/Magisk-v* 2>/dev/null
	wget --no-check-certificate  -P /sdcard "$d"
	echo "•Magisk-v$b.zip --> Magisk-v$a.zip" >> /sdcard/Download/ext/temp/log
else
	echo "•Magisk: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
fi

rm /sdcard/Download/ext/temp/mg1 2>/dev/null
rm /sdcard/Download/ext/temp/mg2 2>/dev/null
rm /sdcard/Download/ext/temp/mg3 2>/dev/null
rm /sdcard/Download/ext/temp/mg4 2>/dev/null


rm /sdcard/Download/ext/temp/mg5 2>/dev/null
rm /sdcard/Download/ext/temp/mg6 2>/dev/null
rm /sdcard/Download/ext/temp/mg7 2>/dev/null

grep "uninstaller" /sdcard/Download/ext/temp/mg > /sdcard/Download/ext/temp/mg5
sed -i '1!d; s+.zip.*++g; s+^.*uninstaller-++g' /sdcard/Download/ext/temp/mg5
a=`cat /sdcard/Download/ext/temp/mg5`

find /storage/emulated/0 -name "Magisk-uninstaller*" > /sdcard/Download/ext/temp/mg6
if [[ -z $(grep '[^[:space:]]' /sdcard/Download/ext/temp/mg6) ]]
then
	b=0
else
	sed -i 's+.zip++g; s+/storage/emulated/0/Magisk-uninstaller-++g' /sdcard/Download/ext/temp/mg6
	b=`cat /sdcard/Download/ext/temp/mg6`
fi

if [ $a -gt $b ]
then
	grep "uninstaller" /sdcard/Download/ext/temp/mg > /sdcard/Download/ext/temp/mg7
	sed -i '1!d; s+.zip.*+.zip+g; s+            <a href="+https://github.com+g' /sdcard/Download/ext/temp/mg7
	d=`cat /sdcard/Download/ext/temp/mg7`
	rm /sdcard/Magisk-uninstaller-* 2>/dev/null
	wget --no-check-certificate  -P /sdcard "$d"
	echo "•Magisk Uninstaller-v$b.zip --> Magisk Uninstaller-v$a.zip" >> /sdcard/Download/ext/temp/log
else
	echo "•Magisk Uninstaller: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
fi

rm /sdcard/Download/ext/temp/mg5 2>/dev/null
rm /sdcard/Download/ext/temp/mg6 2>/dev/null
rm /sdcard/Download/ext/temp/mg7 2>/dev/null


rm /sdcard/Download/ext/temp/mg7 2>/dev/null
rm /sdcard/Download/ext/temp/mg8 2>/dev/null
rm /sdcard/Download/ext/temp/mg9 2>/dev/null
rm /sdcard/Download/ext/temp/mg10 2>/dev/null
rm /sdcard/Download/ext/temp/mg11 2>/dev/null

grep "Manager" /sdcard/Download/ext/temp/mg > /sdcard/Download/ext/temp/mg7
sed -i '1!d' /sdcard/Download/ext/temp/mg7
perl -pe '($_)=/([0-9]+([.][0-9]+)+)/' /sdcard/Download/ext/temp/mg7 > /sdcard/Download/ext/temp/mg8
a=`cat /sdcard/Download/ext/temp/mg8`

aapt dump badging /data/app/com.topjohnwu.magisk*/base.apk > /sdcard/Download/ext/temp/mg9
grep "versionName" /sdcard/Download/ext/temp/mg9 > /sdcard/Download/ext/temp/mg10
perl -pe '($_)=/([0-9]+([.][0-9]+)+)/' /sdcard/Download/ext/temp/mg10 > /sdcard/Download/ext/temp/mg11
b=`cat /sdcard/Download/ext/temp/mg11`

if [ $(version $a) -gt $(version $b) ]
then
	d=https://github.com/topjohnwu/Magisk/releases/download/manager-v$a/MagiskManager-v$a.apk
	wget --no-check-certificate  -P /sdcard/Download "$d"
	pm install /sdcard/Download/MagiskManager*.apk
	rm /sdcard/Download/MagiskManager*.apk 2>/dev/null
	echo "•Magisk-Manager-v$b.apk --> Magisk-Manager-v$a.apk" >> /sdcard/Download/ext/temp/log
else
	echo "•Magisk Manager: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
fi

rm /sdcard/Download/ext/temp/mg7 2>/dev/null
rm /sdcard/Download/ext/temp/mg8 2>/dev/null
rm /sdcard/Download/ext/temp/mg9 2>/dev/null
rm /sdcard/Download/ext/temp/mg10 2>/dev/null
rm /sdcard/Download/ext/temp/mg11 2>/dev/null
rm /sdcard/Download/ext/temp/mg 2>/dev/null


rm /sdcard/Download/ext/temp/b 2>/dev/null
rm /sdcard/Download/ext/temp/b1 2>/dev/null
rm /sdcard/Download/ext/temp/b2 2>/dev/null
rm /sdcard/Download/ext/temp/b3 2>/dev/null
rm /sdcard/Download/ext/temp/b4 2>/dev/null
rm /sdcard/Download/ext/temp/b5 2>/dev/null
rmdir /sdcard/Download/ext/temp/busybox-ndk-master 2>/dev/null

wget --no-check-certificate -O - https://github.com/Magisk-Modules-Repo/busybox-ndk/blob/master/module.prop> /sdcard/Download/ext/temp/b
grep "blob-code blob-code-inner js-file-line" /sdcard/Download/ext/temp/b | grep "version" > /sdcard/Download/ext/temp/b1
perl -pe '($_)=/([0-9]+([.][0-9]+)+)/' /sdcard/Download/ext/temp/b1 > /sdcard/Download/ext/temp/b2
a=`cat /sdcard/Download/ext/temp/b2`

grep "versionCode" /sdcard/Download/ext/temp/b > /sdcard/Download/ext/temp/b3
sed -i 's+</td>++g; s+^.*Code=++g' /sdcard/Download/ext/temp/b3
c=`cat /sdcard/Download/ext/temp/b3`

find /storage/emulated/0 -name "Busybox_for_Android_NDK*" > /sdcard/Download/ext/temp/b4
perl -pe '($_)=/([0-9]+([.][0-9]+)+)/' /sdcard/Download/ext/temp/b4 > /sdcard/Download/ext/temp/b5
b=`cat /sdcard/Download/ext/temp/b5`

sed -i 's+).*++g; s+^.*(++g' /sdcard/Download/ext/temp/b4
d=`cat /sdcard/Download/ext/temp/b4`

function download {
	wget --no-check-certificate  -P /sdcard/Download/ext/temp https://github.com/topjohnwu/Magisk/archive/master.zip
	unzip -qq -o /sdcard/Download/ext/temp/master.zip -d /sdcard/Download/ext/temp
	cat /sdcard/Download/ext/temp/Magisk-master/scripts/module_installer.sh > /sdcard/Download/ext/temp/update-binary
	rm /sdcard/Download/ext/temp/master.zip
	rmdir /sdcard/Download/ext/temp/Magisk-master
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
rm /sdcard/Download/ext/temp/b2 2>/dev/null
rm /sdcard/Download/ext/temp/b3 2>/dev/null
rm /sdcard/Download/ext/temp/b4 2>/dev/null
rm /sdcard/Download/ext/temp/b5 2>/dev/null
rmdir /sdcard/Download/ext/temp/busybox-ndk-master 2>/dev/null


rm /sdcard/Download/ext/temp/w 2>/dev/null
rm /sdcard/Download/ext/temp/w1 2>/dev/null
rm /sdcard/Download/ext/temp/w2 2>/dev/null
rm /sdcard/Download/ext/temp/w3 2>/dev/null
rm /sdcard/Download/ext/temp/w4 2>/dev/null
rm /sdcard/Download/ext/temp/w5 2>/dev/null
rmdir /sdcard/Download/ext/temp/wifi-bonding-master 2>/dev/null

wget --no-check-certificate -O - https://github.com/Magisk-Modules-Repo/wifi-bonding/blob/master/module.prop > /sdcard/Download/ext/temp/w
grep "blob-code blob-code-inner js-file-line" /sdcard/Download/ext/temp/w | grep "version" > /sdcard/Download/ext/temp/w1
perl -pe '($_)=/([0-9]+([.][0-9]+)+)/' /sdcard/Download/ext/temp/w1 > /sdcard/Download/ext/temp/w2
a=`cat /sdcard/Download/ext/temp/w2`

grep "versionCode" /sdcard/Download/ext/temp/w > /sdcard/Download/ext/temp/w3
sed -i 's+</td>++g; s+^.*Code=++g' /sdcard/Download/ext/temp/w3
c=`cat /sdcard/Download/ext/temp/w3`

find /storage/emulated/0 -name "Wifi_Bonding_*" >> /sdcard/Download/ext/temp/w4
sed 's+/storage/emulated/0/Wifi_Bonding_(Qcom)-++g' /sdcard/Download/ext/temp/w4 > /sdcard/Download/ext/temp/w5
sed -i 's+(.*++g' /sdcard/Download/ext/temp/w5
b=`cat /sdcard/Download/ext/temp/w5`

sed -i 's+/storage/emulated/0/Wifi_Bonding_(Qcom)-++g; s+).*++g; s+^.*(++g' /sdcard/Download/ext/temp/w4
d=`cat /sdcard/Download/ext/temp/w4`

function download {
	wget --no-check-certificate  -P /sdcard/Download/ext/temp https://github.com/topjohnwu/Magisk/archive/master.zip
		unzip -qq -o /sdcard/Download/ext/temp/master.zip -d /sdcard/Download/ext/temp
		cat /sdcard/Download/ext/temp/Magisk-master/scripts/module_installer.sh > /sdcard/Download/ext/temp/update-binary
		rm /sdcard/Download/ext/temp/master.zip 2>/dev/null
		rmdir /sdcard/Download/ext/temp/Magisk-master
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
rm /sdcard/Download/ext/temp/w2 2>/dev/null
rm /sdcard/Download/ext/temp/w3 2>/dev/null
rm /sdcard/Download/ext/temp/w4 2>/dev/null
rm /sdcard/Download/ext/temp/w5 2>/dev/null
rmdir /sdcard/Download/ext/temp/wifi-bonding-master 2>/dev/null


rm /sdcard/Download/ext/temp/d 2>/dev/null
rm /sdcard/Download/ext/temp/d1 2>/dev/null
rm /sdcard/Download/ext/temp/d2 2>/dev/null
rm /sdcard/Download/ext/temp/d3 2>/dev/null
rm /sdcard/Download/ext/temp/d4 2>/dev/null
rm /sdcard/Download/ext/temp/d5 2>/dev/null

wget --no-check-certificate -O - https://forum.xda-developers.com/android/software/mm-p-dolby-digital-plus-arise-20181115-t3868192/amp/ > /sdcard/Download/ext/temp/d
grep "fa-download" /sdcard/Download/ext/temp/d > /sdcard/Download/ext/temp/d1
a=$(grep -o '[0-9]*' /sdcard/Download/ext/temp/d1 | sort -nr | head -1)

find /storage/emulated/0 -name "*Dolby*" >> /sdcard/Download/ext/temp/d2

function version {
echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

function download { 
grep -E "^#1:|$a" /sdcard/Download/ext/temp/d > /sdcard/Download/ext/temp/d3
grep "attachmentid" /sdcard/Download/ext/temp/d3 > /sdcard/Download/ext/temp/d4
sed 's+"><i.*++g' /sdcard/Download/ext/temp/d4 > /sdcard/Download/ext/temp/d5
d=`sed 's+^.*href="++g' /sdcard/Download/ext/temp/d5`
wget --no-check-certificate -P /sdcard "$d"
sed -i 's+</a>.*++g' /sdcard/Download/ext/temp/d4
name1=`sed 's+^.*</i>++g' /sdcard/Download/ext/temp/d4`
name2=`sed 's+^.*href="https://forum.xda-developers.com/++g' /sdcard/Download/ext/temp/d5`
name11=`echo "${name1// /_}"`
mv /sdcard/$name2 /sdcard/$name11
}

if [[ -z $(grep '[^[:space:]]' /sdcard/Download/ext/temp/d2) ]]
then
	download
	echo "•Dolby Digital Plus: Tải phiên bản $a." >> /sdcard/Download/ext/temp/log
else
	b=$(grep -o '[0-9]*' /sdcard/Download/ext/temp/d2 | sort -nr | head -1)
	if [ $a -gt $b ]
	then
		rm /sdcard/*Dolby*.zip 2>/dev/null
		download
		echo "•Dolby Digital Plus-$b --> Dolby Digital Plus-$a" >> /sdcard/Download/ext/temp/log
	else
		echo "•Dolby Digital Plus: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
	fi
fi

rm /sdcard/Download/ext/temp/d 2>/dev/null
rm /sdcard/Download/ext/temp/d1 2>/dev/null
rm /sdcard/Download/ext/temp/d2 2>/dev/null
rm /sdcard/Download/ext/temp/d3 2>/dev/null
rm /sdcard/Download/ext/temp/d4 2>/dev/null
rm /sdcard/Download/ext/temp/d5 2>/dev/null


rm /sdcard/Download/ext/temp/p 2>/dev/null
rm /sdcard/Download/ext/temp/p1 2>/dev/null
rm /sdcard/Download/ext/temp/p2 2>/dev/null
rm /sdcard/Download/ext/temp/p3 2>/dev/null
rm /sdcard/Download/ext/temp/p4 2>/dev/null
rm /sdcard/Download/ext/temp/p5 2>/dev/null
rm -rf /sdcard/Download/ext/temp/GoogleDialerFramework-master 2>/dev/null

wget --no-check-certificate -O - https://github.com/Magisk-Modules-Repo/GoogleDialerFramework/blob/master/module.prop > /sdcard/Download/ext/temp/p
grep "blob-code blob-code-inner js-file-line" /sdcard/Download/ext/temp/p | grep "version" > /sdcard/Download/ext/temp/p1
sed -i '1!d; s+</td>++g; s+^.*version=v++g' /sdcard/Download/ext/temp/p1
a=`cat /sdcard/Download/ext/temp/p1`

grep "versionCode" /sdcard/Download/ext/temp/p > /sdcard/Download/ext/temp/p2
sed -i 's+</td>++g; s+^.*Code=++g' /sdcard/Download/ext/temp/p2
c=`cat /sdcard/Download/ext/temp/p2`


find /storage/emulated/0 -name "Google_Dialer_Framework*" > /sdcard/Download/ext/temp/p3
sed 's+/storage/emulated/0/Google_Dialer_Framework-++g; s+(.*++g' /sdcard/Download/ext/temp/p3 > /sdcard/Download/ext/temp/p4
if [[ -z $(grep '[^[:space:]]' /sdcard/Download/ext/temp/p4) ]]
then
	b=0
else
	b=`cat /sdcard/Download/ext/temp/p4`
fi

sed -i 's+).*++g; s+^.*(++g' /sdcard/Download/ext/temp/p3
if [[ -z $(grep '[^[:space:]]' /sdcard/Download/ext/temp/p3 ]]
then
	d=0
else
	d=`cat /sdcard/Download/ext/temp/p3`
fi

function download {
	wget --no-check-certificate  -P /sdcard/Download/ext/temp https://github.com/topjohnwu/Magisk/archive/master.zip
	unzip -qq -o /sdcard/Download/ext/temp/master.zip -d /sdcard/Download/ext/temp
	cat /sdcard/Download/ext/temp/Magisk-master/scripts/module_installer.sh > /sdcard/Download/ext/temp/update-binary
	rm /sdcard/Download/ext/temp/master.zip
	rm -rf /sdcard/Download/ext/temp/Magisk-master
	wget --no-check-certificate  -P /sdcard/Download/ext/temp https://github.com/Magisk-Modules-Repo/GoogleDialerFramework/archive/master.zip
	unzip -qq -o /sdcard/Download/ext/temp/master.zip -d /sdcard/Download/ext/temp
	rm /sdcard/Download/ext/temp/master.zip
	rm /sdcard/Download/ext/temp/GoogleDialerFramework-master/META-INF/com/google/android/update-binary
	mv /sdcard/Download/ext/temp/update-binary /sdcard/Download/ext/temp/GoogleDialerFramework-master/META-INF/com/google/android
	cd /sdcard/Download/ext/temp/GoogleDialerFramework-master
	zip -r "Google_Dialer_Framework-$a($c).zip" META-INF common system install.sh module.prop README.md
	rm /sdcard/Google_Dialer_Framework*.zip
	mv /sdcard/Download/ext/temp/GoogleDialerFramework-master/"Google_Dialer_Framework-$a($c).zip" /sdcard
}

if [ $a -gt $b ]
then
	download
        if [ $b==0 ]
        then
               echo "•Google Dialer Framework: Tải Google_Dialer_Framework-$a($c).zip" >> /sdcard/Download/ext/temp/log
        else
	       echo "•Google_Dialer_Framework-$b($d).zip --> Google_Dialer_Framework-$a($c).zip" >> /sdcard/Download/ext/temp/log
        fi
else
	if [ $c -gt $d ]
	then
		download
		echo "•Google_Dialer_Framework-$b($d).zip --> Google_Dialer_Framework-$a($c).zip" >> /sdcard/Download/ext/temp/log
	else
		echo "•Google Dialer Framework: Không có phiên bản mới." >> /sdcard/Download/ext/temp/log
	fi
fi

rm /sdcard/Download/ext/temp/p 2>/dev/null
rm /sdcard/Download/ext/temp/p1 2>/dev/null
rm /sdcard/Download/ext/temp/p2 2>/dev/null
rm /sdcard/Download/ext/temp/p3 2>/dev/null
rm /sdcard/Download/ext/temp/p4 2>/dev/null
rm /sdcard/Download/ext/temp/p5 2>/dev/null
rm -rf /sdcard/Download/ext/temp/GoogleDialerFramework-master 2>/dev/null
