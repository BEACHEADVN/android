#!/data/data/com.termux/files/usr/bin/bash

rm -rf /storage/emulated/0/Download/ext/temp/mod 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/common 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/META-INF 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/module.prop 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/customize.sh 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/sevice.sh 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/tcl 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/tcl1 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/tcl2 2>/dev/null

wget -w 10 -O - https://apkcombo.com/vi/trichrome-library/com.google.android.trichromelibrary/download/apk > /sdcard/Download/ext/temp/tcl
a=`cat /sdcard/Download/ext/temp/tcl | grep "Trichrome Library" | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}' | awk 'min == "" || $1<min{min=$1} $1>max{max=$1} END{print max}'`

chrome_local=`su -c "find /data/app -type d -name 'com.android.chrome-*'"`
b=`aapt dump badging $chrome_local/base.apk | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}'`

function version {
	echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

if [ $(version $a) -eq $(version $b) ]
then
	lines=`su -c "find /data/app -type d -name 'com.google.android.trichromelibrary*'"`
	for line in $lines
	do
		line=`echo "${line::-71}"`
		su -c "rm -rf $line"
	done
	cat /sdcard/Download/ext/temp/tcl | grep "cdn.down-apk.com" > /sdcard/Download/ext/temp/tcl1
	sed -n 1p /sdcard/Download/ext/temp/tcl1 > /sdcard/Download/ext/temp/tcl2
	download_link=`cat /sdcard/Download/ext/temp/tcl2 | sed 's+" class="variant" rel="nofollow">++g; s+<a href="++g; s+amp;++g'`
	wget -P /sdcard/Download/ext/temp -O "TrichromeLibrary.apk" "$download_link"
	su -c "pm install TrichromeLibrary.apk"
	unzip -qq -o /storage/emulated/0/Tweak-MIUI12-Module-Apollo-Pro-firstboot.zip -d /sdcard/Download/ext/temp
	mv -f /data/data/com.termux/files/home/TrichromeLibrary.apk /storage/emulated/0/Download/ext/temp/mod/app/TrichromeLibrary
	cd /storage/emulated/0/Download/ext/temp
	zip -r Tweak-MIUI12-Module-Apollo-Pro-firstboot.zip mod common META-INF module.prop customize.sh service.sh
	echo `date +"%r, %a, ngày %d, tháng %m, năm %Y"` >> /sdcard/Download/ext/temp/log
	echo "•Trichrome Library: $b." >> /storage/emulated/0/Download/ext/temp/log
else
	echo `date +"%r, %a, ngày %d, tháng %m, năm %Y"` >> /sdcard/Download/ext/temp/log
	echo "•Trichrome Library không có cập nhật." >> /storage/emulated/0/Download/ext/temp/log
fi

rm -rf /storage/emulated/0/Download/ext/temp/mod 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/common 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/META-INF 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/module.prop 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/customize.sh 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/sevice.sh 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/tcl 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/tcl1 2>/dev/null
rm -rf /storage/emulated/0/Download/ext/temp/tcl2 2>/dev/null

sed -i 's/ PM,/ CH,/g' /storage/emulated/0/Download/ext/temp/log
sed -i 's/ AM,/ SA,/g' /storage/emulated/0/Download/ext/temp/log
sed -i 's/ Mon, / thứ Hai, /g' /storage/emulated/0/Download/ext/temp/log
sed -i 's/ Tue, / thứ Ba, /g' /storage/emulated/0/Download/ext/temp/log
sed -i 's/ Wed, / thứ Tư, /g' /storage/emulated/0/Download/ext/temp/log
sed -i 's/ Thur, / thứ Năm, /g' /storage/emulated/0/Download/ext/temp/log
sed -i 's/ Fri, / thứ Sáu, /g' /storage/emulated/0/Download/ext/temp/log
sed -i 's/ Sat, / thứ Bảy, /g' /storage/emulated/0/Download/ext/temp/log
sed -i 's/ Sun, / Chủ nhật, /g' /storage/emulated/0/Download/ext/temp/log