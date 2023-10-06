#!/data/data/com.termux/files/usr/bin/bash

a=`wget -O - https://github.com/revanced/revanced-manager/releases | grep "releases/tag" | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}' | sed -n 1p`

clear
echo "••Phiên bản Youtube ReVanced Manager hiện tại: $a"
echo "••Bạn có muốn tải xuống?"
echo "1. Có"
echo "2. Không"
read ytm

case $ytm in
1)
	#download_link=`wget -O - https://github.com/inotia00/VancedManager_v2/releases | grep "download" | grep "apk" | sed '1!d; s+apk.*+apk+g; s+^.*href="+https://github.com+g'`
	download_link="https://github.com/revanced/revanced-manager/releases/download/v$a/revanced-manager-v$a.apk"
	wget --no-check-certificate  -O /storage/emulated/0/Download/ext/temp/ytmanager.apk "$download_link"
	su -c "mv -f /storage/emulated/0/Download/ext/temp/ytmanager.apk /data/local/tmp"
	su -c "pm install /data/local/tmp/ytmanager.apk"
	su -c "rm -rf /data/local/tmp/ytmanager.apk"
	su -c "am start --user 0 -n app.revanced.manager.flutter/app.revanced.manager.flutter.MainActivity"
;;
2)
   clear
;;
esac

echo `date +"%r, %a, ngày %d, tháng %m, năm %Y"` >> /storage/emulated/0/Download/ext/temp/log
echo "•Youtube ReVanced Manager: $a" >> /storage/emulated/0/Download/ext/temp/log

sed -i 's/ PM,/ CH,/g; s/ AM,/ SA,/g; s/ Mon, / thứ Hai, /g; s/ Tue, / thứ Ba, /g; s/ Wed, / thứ Tư, /g; s/ Thur, / thứ Năm, /g; s/ Fri, / thứ Sáu, /g; s/ Sat, / thứ Bảy, /g; s/ Sun, / Chủ nhật, /g' /storage/emulated/0/Download/ext/temp/log

echo "$(tail -56 /storage/emulated/0/Download/ext/temp/log)" > /storage/emulated/0/Download/ext/temp/log