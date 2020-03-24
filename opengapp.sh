#!/bin/sh

rm /sdcard/Download/ext/temp/g 2>/dev/null
rm /sdcard/Download/ext/temp/g1 2>/dev/null
rm /sdcard/Download/ext/temp/g2 2>/dev/null
rm /sdcard/Download/ext/temp/g3 2>/dev/null

wget --no-check-certificate -O - https://sourceforge.net/projects/opengapps/files/arm64 > /sdcard/Download/ext/temp/g
grep "Click to enter" /sdcard/Download/ext/temp/g > /sdcard/Download/ext/temp/g1
sed -i '1!d; s+[^0-9]*++g' /sdcard/Download/ext/temp/g1
a=`cat /sdcard/Download/ext/temp/g1`

find /storage/emulated/0 -name "open_gapps-arm64-10.0-pico-*" >> /sdcard/Download/ext/temp/g2
sed -i 's+/storage/emulated/0/open_gapps-arm64-10.0-pico-++g; s+.zip++g' /sdcard/Download/ext/temp/g2
if [[ -z $(grep '[^[:space:]]' /sdcard/Download/ext/temp/g2) ]]
then
	b=0
else
	b=`cat /sdcard/Download/ext/temp/g2`
fi

if [ $a -gt $b ]
then
	rm /sdcard/open_gapps-arm64-10.0-pico*.zip 2>/dev/null
	wget --no-check-certificate  -P /sdcard https://sourceforge.net/projects/opengapps/files/arm64/$a/open_gapps-arm64-10.0-pico-$a.zip
	if [ -f /sdcard/open_gapps-arm64-10.0-pico-$a.zip ]
	then
		md5sum /sdcard/open_gapps-arm64-10.0-pico-$a.zip | sed 's+ /sdcard/+ +g' | awk '{print substr($0,0,32)}' > /sdcard/Download/ext/temp/md5sum1
		md5sum1=`cat /sdcard/Download/ext/temp/md5sum1`
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
		else
		    echo "•Open gapps 10.0: Lỗi tải xuống." >> /sdcard/Download/ext/temp/log
		fi
	else
		echo "•Open gapps 10.0: Lỗi tải xuống." >> /sdcard/Download/ext/temp/log
	fi
else

	echo "•Open gapps 10.0: Không có cập nhật mới." >> /sdcard/Download/ext/temp/log
fi

rm /sdcard/Download/ext/temp/g 2>/dev/null
rm /sdcard/Download/ext/temp/g1 2>/dev/null
rm /sdcard/Download/ext/temp/g2 2>/dev/null
rm /sdcard/Download/ext/temp/g3 2>/dev/null
rm /sdcard/Download/ext/temp/md5sum1 2>/dev/null
rm /sdcard/Download/ext/temp/open_gapps-arm64-10.0-pico-$a.zip.md5 2>/dev/null
