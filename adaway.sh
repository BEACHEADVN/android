#!/data/data/com.termux/files/usr/bin/bash

a=`wget -O - https://github.com/AdAway/AdAway | grep "AdAway/AdAway/releases/tag" | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}' | awk '{if ($1 > max) max=$1}END{print max}'`

path=`su -c "find /data/app -type d -name 'org.adaway*'"`
b=`aapt dump badging $path/base.apk | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}'`

function version {
	echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

if [ $(version $a) -gt $(version $b) ]
then
	download_link=`wget -O - https://github.com/AdAway/AdAway/releases/tag/v$a | grep "AdAway/AdAway/releases/download/v$a" | sed '1!d; s+apk.*+apk+g; s+^.*href="+https://github.com+g'`
	wget -O "/storage/emulated/0/Download/ext/temp/AdAway.apk" "$download_link"
	su -c "cp -rf /storage/emulated/0/Download/ext/temp/AdAway.apk /data/local/tmp"
	su -c "pm install /data/local/tmp/AdAway.apk"
	rm -rf /storage/emulated/0/Download/ext/temp/AdAway.apk
	su -c "rm -rf /data/local/tmp/AdAway.apk"
	echo `date +"%r, %a, ngày %d, tháng %m, năm %Y"` >> /storage/emulated/0/Download/ext/temp/log
	echo "•AdAway: $b -> $a" >> /storage/emulated/0/Download/ext/temp/log
else
	clear
	echo "•AdAway: Không có cập nhật mới."
	echo `date +"%r, %a, ngày %d, tháng %m, năm %Y"` >> /storage/emulated/0/Download/ext/temp/log
	echo "•AdAway: Không có cập nhật mới." >> /storage/emulated/0/Download/ext/temp/log
fi

sed -i 's/ PM,/ CH,/g; s/ AM,/ SA,/g; s/ Mon, / thứ Hai, /g; s/ Tue, / thứ Ba, /g; s/ Wed, / thứ Tư, /g; s/ Thur, / thứ Năm, /g; s/ Fri, / thứ Sáu, /g; s/ Sat, / thứ Bảy, /g; s/ Sun, / Chủ nhật, /g' /storage/emulated/0/Download/ext/temp/log

echo "$(tail -56 /storage/emulated/0/Download/ext/temp/log)" > /storage/emulated/0/Download/ext/temp/log