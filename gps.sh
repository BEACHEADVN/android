#!/data/data/com.termux/files/usr/bin/bash

function delete {
	rm -rf /storage/emulated/0/Download/ext/temp/$i 2>/dev/null
}

for i in app mod common META-INF module.prop customize.sh service.sh
do
	delete
done

path=`su -c "find /data/app -type d -name 'com.android.vending*'"`
a=`aapt dump badging $path/base.apk | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}'`

if [ -z "$path" ]
then
	  echo `date +"%r, %a, ngày %d, tháng %m, năm %Y"` >> /storage/emulated/0/Download/ext/temp/log
	  echo "•Google Play Store: Không có cập nhật." >> /storage/emulated/0/Download/ext/temp/log
else
	function version {
		echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
	}
	unzip -qq -o /storage/emulated/0/Tweak-MIUI12-Module-Apollo-Pro-firstboot.zip -d /storage/emulated/0/Download/ext/temp
	b=`aapt dump badging /storage/emulated/0/Download/ext/temp/mod/app/Phonesky/base.apk | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}'`
	if [ $(version $a) -gt $(version $b) ]
	then
		sed -i 's/Store(.*)./Store('$a')./g' /storage/emulated/0/Download/ext/temp/module.prop
		rm -rf /storage/emulated/0/Download/ext/temp/mod/app/Phonesky/*
		su -c "cp -rf $path/* /storage/emulated/0/Download/ext/temp/mod/app/Phonesky"
		#rm -rf /storage/emulated/0/Download/ext/temp/app/Phonesky/lib
		#rm -rf /storage/emulated/0/Download/ext/temp/app/Phonesky/oat
		cd /storage/emulated/0/Download/ext/temp
		zip -r Tweak-MIUI12-Module-Apollo-Pro-firstboot.zip mod common META-INF module.prop customize.sh service.sh
		mv -f Tweak-MIUI12-Module-Apollo-Pro-firstboot.zip /storage/emulated/0
		echo `date +"%r, %a, ngày %d, tháng %m, năm %Y"` >> /storage/emulated/0/Download/ext/temp/log
	echo "•Google Play Store có cập nhật: $a." >> /storage/emulated/0/Download/ext/temp/log
	else
		echo `date +"%r, %a, ngày %d, tháng %m, năm %Y"` >> /storage/emulated/0/Download/ext/temp/log
	  echo "•Google Play Store: Không có cập nhật." >> /storage/emulated/0/Download/ext/temp/log
	fi
	for i in app mod common META-INF module.prop customize.sh service.sh uninstall.sh
	do
		delete
	done
fi

sed -i 's/ PM,/ CH,/g; s/ AM,/ SA,/g; s/ Mon, / thứ Hai, /g; s/ Tue, / thứ Ba, /g; s/ Wed, / thứ Tư, /g; s/ Thur, / thứ Năm, /g; s/ Fri, / thứ Sáu, /g; s/ Sat, / thứ Bảy, /g; s/ Sun, / Chủ nhật, /g' /storage/emulated/0/Download/ext/temp/log

echo "$(tail -56 /storage/emulated/0/Download/ext/temp/log)" > /storage/emulated/0/Download/ext/temp/log