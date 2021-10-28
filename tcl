#!/data/data/com.termux/files/usr/bin/bash

rm -rf /storage/emulated/0/Download/ext/temp/mod 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/common 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/META-INF 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/module.prop 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/customize.sh 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/sevice.sh 2>/dev/null

su -c "find /data/app -type d -name 'com.google.android.trichromelibrary*' > /storage/emulated/0/Download/ext/temp/paths"
x=`wc -l < /sdcard/Download/ext/temp/paths`

sed -n 1p /sdcard/Download/ext/temp/paths > /sdcard/Download/ext/temp/a
path_a=`cat /sdcard/Download/ext/temp/a`
a=`aapt dump badging $path_a/base.apk | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}'`

sed -n 2p /sdcard/Download/ext/temp/paths > /sdcard/Download/ext/temp/b
path_b=`cat /sdcard/Download/ext/temp/b`
b=`aapt dump badging $path_b/base.apk | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}'`

unzip -qq -o /storage/emulated/0/Tweak-MIUI12-Module-Apollo-Pro-firstboot.zip -d /sdcard/Download/ext/temp
path_c=`find /storage/emulated/0/Download/ext/temp/mod/app/TrichromeLibrary -type d -name 'com.google.android.trichromelibrary*'`
c=`aapt dump badging $path_c/base.apk | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}'`

function version {
	echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

if [ $(version $a) -gt $(version $b) ]
then
	if [ $(version $a) -gt $(version $c) ]
	then
		path_b=`echo "${path_b::-71}"`
		su -c "rm -rf $path_b"
		path_a=`echo "${path_a::-71}"`
		rm -rf /storage/emulated/0/Download/ext/temp/mod/app/TrichromeLibrary/*
		su -c "cp -rf $path_a /storage/emulated/0/Download/ext/temp/mod/app/TrichromeLibrary"
		cd /storage/emulated/0/Download/ext/temp
		zip -r Tweak-MIUI12-Module-Apollo-Pro-firstboot.zip modapp common META-INF module.prop customize.sh service.sh
		mv -f Tweak-MIUI12-Module-Apollo-Pro-firstboot.zip /storage/emulated/0
		echo `date +"%r, %a, ngày %d, tháng %m, năm %Y"` >> /sdcard/Download/ext/temp/log
		echo "Trichrome Library: $c -> $a" >> /storage/emulated/0/Download/ext/temp/log
	else
		echo `date +"%r, %a, ngày %d, tháng %m, năm %Y"` >> /sdcard/Download/ext/temp/log
		echo "Trichrome Library không có cập nhật mới." >> /storage/emulated/0/Download/ext/temp/log
	fi
else
	if [ $(version $b) -gt $(version $c) ]
	then
		path_a=`echo "${path_a::-71}"`
		su -c "rm -rf $path_a"
		path_b=`echo "${path_b::-71}"`
		rm -rf /storage/emulated/0/Download/ext/temp/mod/app/TrichromeLibrary/*
		su -c "cp -rf $path_b /storage/emulated/0/Download/ext/temp/mod/app/TrichromeLibrary"
		cd /storage/emulated/0/Download/ext/temp
		zip -r Tweak-MIUI12-Module-Apollo-Pro-firstboot.zip mod common META-INF module.prop customize.sh service.sh
		rm -rf app
		rm -rf common
		rm -rf META-INF
		rm -rf module.prop
		rm -rf customize.sh
		rm -rf service.sh
		mv -f Tweak-MIUI12-Module-Apollo-Pro-firstboot.zip /storage/emulated/0
		echo `date +"%r, %a, ngày %d, tháng %m, năm %Y"` >> /sdcard/Download/ext/temp/log
		echo "Trichrome Library: $c -> $b" >> /storage/emulated/0/Download/ext/temp/log
	else
		echo `date +"%r, %a, ngày %d, tháng %m, năm %Y"` >> /sdcard/Download/ext/temp/log
		echo "Trichrome Library không có cập nhật mới." >> /storage/emulated/0/Download/ext/temp/log
	fi
fi

rm -rf /storage/emulated/0/Download/ext/temp/mod 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/common 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/META-INF 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/module.prop 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/customize.sh 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/sevice.sh 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/a
rm -rf /storage/emulated/0/Download/ext/temp/b
rm -rf /storage/emulated/0/Download/ext/temp/path
rm -rf /storage/emulated/0/Download/ext/temp/paths
rm -rf /storage/emulated/0/Download/ext/temp/path_c