#!/data/data/com.termux/files/usr/bin/bash

su -c "rm -rf /data/local/tmp/termux.apk"

a=`wget -O - https://f-droid.org/packages/com.termux/ | grep "Version" | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}' | awk '{if ($1 > max) max=$1}END{print max}'`

path=`su -c "find /data/app -type d -name 'com.termux*'"`
b=`aapt dump badging $path/*.apk | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}'`

function version {
	echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

if [ $(version $a) -gt $(version $b) ]
then
	download_link=`wget -O - https://f-droid.org/packages/com.termux/ | grep "https://f-droid.org/repo" | grep "apk" | awk '!/asc/' | grep -Po '(?<=(=")).*(?=">)' | sort -rn | head -n 1`
	wget --no-check-certificate  -O /storage/emulated/0/Download/ext/temp/termux.apk $download_link
	su -c "mv -f /storage/emulated/0/Download/ext/temp/termux.apk /data/local/tmp"
	su -c "pm install /data/local/tmp/termux.apk"
	su -c "rm -rf /data/local/tmp/termux.apk"
else
	clear
	echo "•Termux: Không có cập nhật mới."
	echo `date +"%r, %a, ngày %d, tháng %m, năm %Y"` >> /storage/emulated/0/Download/ext/temp/log
	echo "•Termux: Không có cập nhật mới." >> /storage/emulated/0/Download/ext/temp/log
fi

sed -i 's/ PM,/ CH,/g; s/ AM,/ SA,/g; s/ Mon, / thứ Hai, /g; s/ Tue, / thứ Ba, /g; s/ Wed, / thứ Tư, /g; s/ Thur, / thứ Năm, /g; s/ Fri, / thứ Sáu, /g; s/ Sat, / thứ Bảy, /g; s/ Sun, / Chủ nhật, /g' /storage/emulated/0/Download/ext/temp/log

echo "$(tail -56 /storage/emulated/0/Download/ext/temp/log)" > /storage/emulated/0/Download/ext/temp/log