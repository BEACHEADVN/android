#!/bin/bash

rm /sdcard/Download/ext/temp/zip 2>/dev/null
cd /sdcard
find . -name "*.zip" >> /sdcard/Download/ext/temp/zip
awk -i inplace '{print substr($0,3)}' /sdcard/Download/ext/temp/zip
x=`wc -l < /sdcard/Download/ext/temp/zip`
for (( c=1; c<=$x; c++ ))
do
	sed -n "$c"p /sdcard/Download/ext/temp/zip >> /sdcard/Download/ext/temp/$c
	zipinfo -1 "`cat /sdcard/Download/ext/temp/$c`" >> /sdcard/Download/ext/temp/zip$c
	if grep -Fxq "system.new.dat.br" /sdcard/Download/ext/temp/zip$c
	then
		sed -n 1p /sdcard/Download/ext/temp/$c >> /sdcard/Download/ext/temp/system$c
	fi
	if grep -Fxq "system.transfer.list" /sdcard/Download/ext/temp/zip$c
	then
		sed -n 1p /sdcard/Download/ext/temp/$c >> /sdcard/Download/ext/temp/system$c
	fi
	if grep -Fxq "vendor.new.dat.br" /sdcard/Download/ext/temp/zip$c
	then
		sed -n 1p /sdcard/Download/ext/temp/$c >> /sdcard/Download/ext/temp/vendor$c
	fi
	if grep -Fxq "vendor.transfer.list" /sdcard/Download/ext/temp/zip$c
	then
		sed -n 1p /sdcard/Download/ext/temp/$c >> /sdcard/Download/ext/temp/vendor$c
	fi
	if [ -f /sdcard/Download/ext/temp/system$c ]
	then
		s=`wc -l < /sdcard/Download/ext/temp/system$c`
		if [[ $s == 1 ]]
		then
			rm -rf /sdcard/Download/ext/temp/system$c
		else
			sed -n 1p /sdcard/Download/ext/temp/system$c >> /sdcard/Download/ext/temp/rom
		fi
	fi
	if [ -f /sdcard/Download/ext/temp/vendor$c ]
	then
		v=`wc -l < /sdcard/Download/ext/temp/vendor$c`
		if [[ $v == 1 ]]
		then
			rm /sdcard/Download/ext/temp/vendor$c 2>/dev/null
		else
			sed -n 1p /sdcard/Download/ext/temp/vendor$c >> /sdcard/Download/ext/temp/rom
		fi
	fi
	rm /sdcard/Download/ext/temp/$c 2>/dev/null
	rm /sdcard/Download/ext/temp/zip$c 2>/dev/null
	rm /sdcard/Download/ext/temp/system$c 2>/dev/null
	rm /sdcard/Download/ext/temp/vendor$c 2>/dev/null
	p=`echo "$c*100/$x" | bc`
	echo "$p %"
done
rm /sdcard/Download/ext/temp/zip 2>/dev/null
cat /sdcard/Download/ext/temp/rom |sort|uniq -d >> /sdcard/Download/ext/temp/romlist
awk '{print NR  ". " $s}' /sdcard/Download/ext/temp/romlist >> /sdcard/Download/ext/temp/romlist1
l=`wc -l < /sdcard/Download/ext/temp/romlist1`
for (( v=1; v<=$l; v++ ))
do
	sed -n "$v"p /sdcard/Download/ext/temp/romlist >> /sdcard/Download/ext/temp/rompath$v
done
clear
echo "Các rom trong điện thoại:"
cat /sdcard/Download/ext/temp/romlist1
echo "Chọn rom (nhấn x để quay lại Menu):"
read m
if [[ $m == x ]]
then
	echo ""
else
	name=`cat /sdcard/Download/ext/temp/rompath$m`
	echo "Bạn đã chọn rom `basename $name`"
	unzip -qq -o `cat /sdcard/Download/ext/temp/rompath$m` -d /sdcard/Download/ext/temp
	rm -rf /sdcard/Download/ext/temp/install 2>/dev/null
	rm -rf /sdcard/Download/ext/temp/META-INF 2>/dev/null
	rm -rf /sdcard/Download/ext/temp/system 2>/dev/null
	rm /sdcard/Download/ext/temp/system.patch.dat 2>/dev/null
	rm /sdcard/Download/ext/temp/vendor.patch.dat 2>/dev/null
	rm /sdcard/Download/ext/temp/boot.img 2>/dev/null
	echo "Giải nén `basename $name` hoàn tất"
	echo "Trích xuất system"
	rm /sdcard/Download/ext/temp/system.new.dat 2>/dev/null
	echo "Chuyển đổi system.new.dat.br-->system.new.dat"
	brotli -d /sdcard/Download/ext/temp/system.new.dat.br -o /sdcard/Download/ext/temp/system.new.dat
	echo "Chuyển đổi system.new.dat-->system.img"
	python /sdcard/Download/ext/temp/sdat2img.py /sdcard/Download/ext/temp/system.transfer.list /sdcard/Download/ext/temp/system.new.dat /sdcard/Download/ext/temp/system.img
	rom=`basename $name`
	romfolder=${rom%.*}
	rm /sdcard/Download/ext/$romfolder 2>/dev/null
	mkdir -p /sdcard/Download/ext/$romfolder
	mkdir -p /sdcard/Download/ext/$romfolder/system
	mv -f /sdcard/Download/ext/temp/system.img /sdcard/Download/ext/$romfolder/system
	echo "Chuyển đổi system.img-->thư mục system"
	python /sdcard/Download/ext/temp/imgextractor.py /sdcard/Download/ext/$romfolder/system/system.img /sdcard/Download/ext/$romfolder/system
	echo "Trích xuất vendor"
	rm /sdcard/Download/ext/temp/vendor.new.dat 2>/dev/null
	echo "Chuyển đổi vendor.new.dat.br-->vendor.new.dat"
	brotli -d /sdcard/Download/ext/temp/vendor.new.dat.br -o /sdcard/Download/ext/temp/vendor.new.dat
	echo "Chuyển đổi vendor.new.dat-->vendor.img"
	python /sdcard/Download/ext/temp/sdat2img.py /sdcard/Download/ext/temp/vendor.transfer.list /sdcard/Download/ext/temp/vendor.new.dat /sdcard/Download/ext/temp/vendor.img
	rom=`basename $name`
	romfolder=${rom%.*}
	mkdir -p /sdcard/Download/ext/$romfolder
	mkdir -p /sdcard/Download/ext/$romfolder/vendor
	mv -f /sdcard/Download/ext/temp/vendor.img /sdcard/Download/ext/$romfolder/vendor
	echo "Chuyển đổi vendor.img-->thư mục vendor"
	python /sdcard/Download/ext/temp/imgextractor.py /sdcard/Download/ext/$romfolder/vendor/vendor.img /sdcard/Download/ext/$romfolder/vendor/
	rm /sdcard/Download/ext/$romfolder/vendor/vendor.img 2>/dev/null
	rm /sdcard/Download/ext/$romfolder/system/system.img 2>/dev/null
	rm /sdcard/Download/ext/$romfolder/system_size.txt 2>/dev/null
	rm /sdcard/Download/ext/temp/system.new.dat.br 2>/dev/null
	rm /sdcard/Download/ext/temp/system.transfer.list 2>/dev/null
	rm /sdcard/Download/ext/temp/system.new.dat 2>/dev/null
	rm /sdcard/Download/ext/temp/vendor.new.dat.br 2>/dev/null
	rm /sdcard/Download/ext/temp/vendor.transfer.list 2>/dev/null
	rm /sdcard/Download/ext/temp/vendor.new.dat 2>/dev/null
	
	echo "Debloat ?"
	echo "1. Có"
	echo "2. Không"
	read debloat
	
	case $debloat in
		1)
			rom_name=`echo $rom | sed "s+_+-+g" | cut -d'-' -f 1`
			if [[ $rom_name ="EvolutionX" ]]
			then
				bash /sdcard/Download/ext/temp/sig_evolutionx.sh
				bash /sdcard/Download/ext/temp/debloat_evolutionx.sh
			fi
			if [[ $rom_name ="Havoc" ]]
			then
				bash /sdcard/Download/ext/temp/sig_havoc.sh
				bash /sdcard/Download/ext/temp/debloat_havoc.sh
			fi
		;;
		2)
			echo "Bỏ qua Debloat"
		;;
	esac
fi
for (( v=1; v<=$l; v++ ))
do
	rm /sdcard/Download/ext/temp/rompath$v 2>/dev/null
done
rm /sdcard/Download/ext/temp/rom 2>/dev/null
rm /sdcard/Download/ext/temp/romlist 2>/dev/null
rm /sdcard/Download/ext/temp/romlist1 2>/dev/null
rm -rf /sdcard/Download/ext/temp/__pycache__ 2>/dev/null