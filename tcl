#!/data/data/com.termux/files/usr/bin/bash

rm -rf /storage/emulated/0/Download/ext/temp/mod 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/common 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/META-INF 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/module.prop 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/customize.sh 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/sevice.sh 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/trichromelibrary 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/trichromelibrary_a 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/trichromelibrary_b 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/folder_tcl1 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/folder_tcl2 2>/dev/null

su -c "find /data/app -type d -name 'com.google.android.trichromelibrary*' > /sdcard/Download/ext/temp/trichromelibrary"
sed -n 1p /sdcard/Download/ext/temp/trichromelibrary > /sdcard/Download/ext/temp/trichromelibrary_a
sed -n 2p /sdcard/Download/ext/temp/trichromelibrary > /sdcard/Download/ext/temp/trichromelibrary_b
path_a=`cat /sdcard/Download/ext/temp/trichromelibrary_a`
path_b=`cat /sdcard/Download/ext/temp/trichromelibrary_b`
a=`aapt dump badging $path_a/base.apk | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}'`
b=`aapt dump badging $path_b/base.apk | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}'`

function version {
	echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

if [ $(version $a) -gt $(version $b) ]
then
	path_b=`echo "${path_b::-71}"`
	su -c "rm -rf $path_b"
	unzip -qq -o /storage/emulated/0/Tweak-MIUI12-Module-Apollo-Pro-firstboot.zip -d /sdcard/Download/ext/temp
	c=`aapt dump badging /storage/emulated/0/Download/ext/temp/mod/app/TrichromeLibrary/base.apk | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}'`
	if [ $(version $a) -gt $(version $c) ]
	then
		su -c "cp -rf $path_a/* /storage/emulated/0/Download/ext/temp/mod/app/TrichromeLibrary"
		echo $path_a | sed 's/^.\{10\}//' | awk '{ print substr( $0, 1, length($0)-71 ) }' > /storage/emulated/0/Download/ext/temp/folder_tcl1
		echo $path_a | sed 's/^.\{37\}//' > /storage/emulated/0/Download/ext/temp/folder_tcl2
		cp -rf /storage/emulated/0/Download/ext/temp/folder_tcl1 /storage/emulated/0/Download/ext/temp/mod/app/TrichromeLibrary
		cp -rf /storage/emulated/0/Download/ext/temp/folder_tcl2 /storage/emulated/0/Download/ext/temp/mod/app/TrichromeLibrary
		cd /storage/emulated/0/Download/ext/temp
		zip -r Tweak-MIUI12-Module-Apollo-Pro-firstboot.zip mod common META-INF module.prop customize.sh service.sh
		mv -f Tweak-MIUI12-Module-Apollo-Pro-firstboot.zip /storage/emulated/0
		echo `date +"%r, %a, ngày %d, tháng %m, năm %Y"` >> /sdcard/Download/ext/temp/log
		echo "•Trichrome Library: $c -> $a" >> /storage/emulated/0/Download/ext/temp/log
	else
		echo `date +"%r, %a, ngày %d, tháng %m, năm %Y"` >> /sdcard/Download/ext/temp/log
		echo "•Trichrome Library: Không có cập nhật." >> /storage/emulated/0/Download/ext/temp/log
	fi
else
	path_a=`echo "${path_a::-71}"`
	su -c "rm -rf $path_a"
	unzip -qq -o /storage/emulated/0/Tweak-MIUI12-Module-Apollo-Pro-firstboot.zip -d /sdcard/Download/ext/temp
	c=`aapt dump badging /storage/emulated/0/Download/ext/temp/mod/app/TrichromeLibrary/base.apk | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}'`
	if [ $(version $b) -gt $(version $c) ]
	then
		su -c "cp -rf $path_a/* /storage/emulated/0/Download/ext/temp/mod/app/TrichromeLibrary"
		echo $path_b | sed 's/^.\{10\}//' | awk '{ print substr( $0, 1, length($0)-71 ) }' > /storage/emulated/0/Download/ext/temp/folder_tcl1
		echo $path_b | sed 's/^.\{37\}//' > /storage/emulated/0/Download/ext/temp/folder_tcl2
		cp -rf /storage/emulated/0/Download/ext/temp/folder_tcl1 /storage/emulated/0/Download/ext/temp/mod/app/TrichromeLibrary
		cp -rf /storage/emulated/0/Download/ext/temp/folder_tcl2 /storage/emulated/0/Download/ext/temp/mod/app/TrichromeLibrary
		cd /storage/emulated/0/Download/ext/temp
		zip -r Tweak-MIUI12-Module-Apollo-Pro-firstboot.zip mod common META-INF module.prop customize.sh service.sh
		mv -f Tweak-MIUI12-Module-Apollo-Pro-firstboot.zip /storage/emulated/0
		echo `date +"%r, %a, ngày %d, tháng %m, năm %Y"` >> /sdcard/Download/ext/temp/log
		echo "•Trichrome Library: $c -> $b" >> /storage/emulated/0/Download/ext/temp/log
	else
		echo `date +"%r, %a, ngày %d, tháng %m, năm %Y"` >> /sdcard/Download/ext/temp/log
		echo "•Trichrome Library: Không có cập nhật." >> /storage/emulated/0/Download/ext/temp/log
	fi
fi

rm -rf /storage/emulated/0/Download/ext/temp/mod 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/common 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/META-INF 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/module.prop 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/customize.sh 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/sevice.sh 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/trichromelibrary 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/trichromelibrary_a 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/trichromelibrary_b 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/folder_tcl1 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/folder_tcl2 2>/dev/null

sed -i 's/ PM,/ CH,/g; s/ AM,/ SA,/g; s/ Mon, / thứ Hai, /g; s/ Tue, / thứ Ba, /g; s/ Wed, / thứ Tư, /g; s/ Thur, / thứ Năm, /g; s/ Fri, / thứ Sáu, /g; s/ Sat, / thứ Bảy, /g; s/ Sun, / Chủ nhật, /g' /storage/emulated/0/Download/ext/temp/log