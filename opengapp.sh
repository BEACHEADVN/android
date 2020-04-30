#!/bin/sh

rm /sdcard/Download/ext/temp/g 2>/dev/null
rm /sdcard/Download/ext/temp/g1 2>/dev/null

a=`wget --no-check-certificate -O - https://sourceforge.net/projects/opengapps/files/arm64 | grep "Click to enter" | sed 's+[^0-9]*++g' | awk 'min == "" || $1<min{min=$1} $1>max{max=$1} END{print max}'`

find /storage/emulated/0 -name "open_gapps-arm64-10.0-pico-*" > /sdcard/Download/ext/temp/g1
sed -i 's+/storage/emulated/0/open_gapps-arm64-10.0-pico-++g; s+.zip++g' /sdcard/Download/ext/temp/g1
b=`cat /sdcard/Download/ext/temp/g1`

function version {
	echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

if [ $(version $a) -gt $(version $b) ]
then
	wget --no-check-certificate  -P /sdcard/Download/ext/temp https://sourceforge.net/projects/opengapps/files/arm64/$a/open_gapps-arm64-10.0-pico-$a.zip
	if [ -f /sdcard/Download/ext/temp/open_gapps-arm64-10.0-pico-$a.zip ]
	then
		md5sum1=`md5sum /sdcard/Download/ext/temp/open_gapps-arm64-10.0-pico-$a.zip | sed 's+ /sdcard/+ +g' | awk '{print substr($0,0,32)}'`
		wget --no-check-certificate  -P /sdcard/Download/ext/temp https://sourceforge.net/projects/opengapps/files/arm64/$a/open_gapps-arm64-10.0-pico-$a.zip.md5
		md5sum2=`cat /sdcard/Download/ext/temp/open_gapps-arm64-10.0-pico-$a.zip.md5 | awk '{print substr($0,0,32)}'`
		if [ "$md5sum1" = "$md5sum2" ]
		then
			if [ $b == 0 ]
			then
				echo "•Open gapps: Tải open_gapps-arm64-10.0-pico-$a.zip" >> /sdcard/Download/ext/temp/log
			else
			    echo "•open_gapps-arm64-10.0-pico-$b.zip --> open_gapps-arm64-10.0-pico-$a.zip" >> /sdcard/Download/ext/temp/log
			fi
			rm /sdcard/open_gapps-arm64-10.0-pico*.zip 2>/dev/null
			mv -f /sdcard/Download/ext/temp/open_gapps-arm64-10.0-pico-$a.zip /sdcard
		else
		    echo "•Open gapps 10.0: Lỗi tải xuống." >> /sdcard/Download/ext/temp/log
			rm /sdcard/Download/ext/temp/open_gapps-arm64-10.0-pico-$a.zip
		fi
	else
		echo "•Open gapps 10.0: Lỗi tải xuống." >> /sdcard/Download/ext/temp/log
		rm /sdcard/Download/ext/temp/open_gapps-arm64-10.0-pico-$a.zip
	fi
else
	echo "•Open gapps 10.0: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
fi

rm /sdcard/Download/ext/temp/g 2>/dev/null
rm /sdcard/Download/ext/temp/g1 2>/dev/null
rm /sdcard/Download/ext/temp/open_gapps-arm64-10.0-pico-$a.zip.md5 2>/dev/null
