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
		cd /storage/emulated/0/Download/ext/temp
		zip -r Tweak-MIUI12-Module-Apollo-Pro-firstboot.zip mod common META-INF module.prop customize.sh service.sh
		echo `date +"%r, %a, ngày %d, tháng %m, năm %Y"` >> /sdcard/Download/ext/temp/log
		echo "•Trichrome Library: $a." >> /storage/emulated/0/Download/ext/temp/log
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
		cd /storage/emulated/0/Download/ext/temp
		zip -r Tweak-MIUI12-Module-Apollo-Pro-firstboot.zip mod common META-INF module.prop customize.sh service.sh
		cp -f Tweak-MIUI12-Module-Apollo-Pro-firstboot.zip /storage/emulated/0
		echo `date +"%r, %a, ngày %d, tháng %m, năm %Y"` >> /sdcard/Download/ext/temp/log
		echo "•Trichrome Library: $b." >> /storage/emulated/0/Download/ext/temp/log
	else
		echo `date +"%r, %a, ngày %d, tháng %m, năm %Y"` >> /sdcard/Download/ext/temp/log
		echo "•Trichrome Library: Không có cập nhật." >> /storage/emulated/0/Download/ext/temp/log
	fi
fi

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

sed -i 's/ PM,/ CH,/g' /storage/emulated/0/Download/ext/temp/log
sed -i 's/ AM,/ SA,/g' /storage/emulated/0/Download/ext/temp/log
sed -i 's/ Mon, / thứ Hai, /g' /storage/emulated/0/Download/ext/temp/log
sed -i 's/ Tue, / thứ Ba, /g' /storage/emulated/0/Download/ext/temp/log
sed -i 's/ Wed, / thứ Tư, /g' /storage/emulated/0/Download/ext/temp/log
sed -i 's/ Thur, / thứ Năm, /g' /storage/emulated/0/Download/ext/temp/log
sed -i 's/ Fri, / thứ Sáu, /g' /storage/emulated/0/Download/ext/temp/log
sed -i 's/ Sat, / thứ Bảy, /g' /storage/emulated/0/Download/ext/temp/log
sed -i 's/ Sun, / Chủ nhật, /g' /storage/emulated/0/Download/ext/temp/log