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
	echo "Thoát!!"
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
			rm -rf /sdcard/Download/ext/temp/META-INF 2>/dev/null
			rm -rf /sdcard/Download/ext/temp/system 2>/dev/null
			rm /sdcard/Download/ext/temp/remove1 2>/dev/null
			rm /sdcard/Download/ext/temp/remove2 2>/dev/null
			rm /sdcard/Download/ext/temp/remove3 2>/dev/null
			rm /sdcard/Download/ext/temp/remove4 2>/dev/null
			rm /sdcard/Download/ext/temp/remove5 2>/dev/null
			rm /sdcard/Download/ext/temp/remove6 2>/dev/null
			rm /sdcard/Download/ext/temp/zip 2>/dev/null
			rm /sdcard/Download/ext/temp/zip1 2>/dev/null
			rm /sdcard/Download/ext/temp/zip2 2>/dev/null
			
			unzip -qq -o /sdcard/tweak-havoc-capricorn-q-part1.zip -d /sdcard/Download/ext/temp
			cat /sdcard/Download/ext/temp/META-INF/com/google/android/updater-script > /sdcard/Download/ext/temp/remove1
			awk -i inplace 'NR>y+x{print A[NR%y]} {A[NR%y]=$0}' x=37 y=19 /sdcard/Download/ext/temp/remove1
			cat /sdcard/Download/ext/temp/remove1 | sort >> /sdcard/Download/ext/temp/remove2
			
			sed -n -e '1,37p' /sdcard/Download/ext/temp/META-INF/com/google/android/updater-script > /sdcard/Download/ext/temp/updater-script
			cat /sdcard/Download/ext/temp/remove2 >> /sdcard/Download/ext/temp/updater-script
			tail -n19 /sdcard/Download/ext/temp/META-INF/com/google/android/updater-script >> /sdcard/Download/ext/temp/updater-script
			rm /sdcard/Download/ext/temp/META-INF/com/google/android/updater-script 2>/dev/null
			mv /sdcard/Download/ext/temp/updater-script /sdcard/Download/ext/temp/META-INF/com/google/android
			cd /sdcard/Download/ext/temp
                        find /sdcard/Download/ext -name "Havoc-OS-v3.*" > /sdcard/Download/ext/temp/checkpath
			path=`cat /sdcard/Download/ext/temp/checkpath`
			if [ -d $path/system/system/product/priv-app/SettingsIntelligenceGooglePrebuilt ]
			then
				echo ""
			else
				rm -rf /sdcard/Download/ext/temp/system/product/priv-app
			fi
			zip -r tweak-havoc-capricorn-q-part1.zip META-INF system
			rm /sdcard/tweak-havoc-capricorn-q-part1.zip 2>/dev/null
			mv -f /sdcard/Download/ext/temp/tweak-havoc-capricorn-q-part1.zip /sdcard
			awk -i inplace '{print substr($0,2)}' /sdcard/Download/ext/temp/remove2
			sed -i 's+..$++g' /sdcard/Download/ext/temp/remove2
			find /sdcard/Download/ext -name "Havoc-OS*" > /sdcard/Download/ext/temp/zip1
			awk -i inplace '$0="rm -rf "$0' /sdcard/Download/ext/temp/zip1
			remove=`cat /sdcard/Download/ext/temp/zip1`
			awk -v remove="$remove" '{print remove $0}' /sdcard/Download/ext/temp/remove2 > /sdcard/Download/ext/temp/remove3
			bash /sdcard/Download/ext/temp/remove3 2>/dev/null
			
			
			rm -rf /sdcard/Download/ext/temp/META-INF 2>/dev/null
			rm -rf /sdcard/Download/ext/temp/system 2>/dev/null
			
			unzip -qq -o /sdcard/tweak-havoc-capricorn-q-part2.zip -d /sdcard/Download/ext/temp
			cat /sdcard/Download/ext/temp/META-INF/com/google/android/updater-script > /sdcard/Download/ext/temp/remove4
			awk -i inplace 'NR>y+x{print A[NR%y]} {A[NR%y]=$0}' x=36 y=15 /sdcard/Download/ext/temp/remove4
			cat /sdcard/Download/ext/temp/remove4 | sort >> /sdcard/Download/ext/temp/remove5
			sed -n -e '1,36p' /sdcard/Download/ext/temp/META-INF/com/google/android/updater-script > /sdcard/Download/ext/temp/updater-script
			cat /sdcard/Download/ext/temp/remove5 >> /sdcard/Download/ext/temp/updater-script
			tail -n15 /sdcard/Download/ext/temp/META-INF/com/google/android/updater-script >> /sdcard/Download/ext/temp/updater-script
			rm /sdcard/Download/ext/temp/META-INF/com/google/android/updater-script 2>/dev/null
			mv /sdcard/Download/ext/temp/updater-script /sdcard/Download/ext/temp/META-INF/com/google/android
			zip -r tweak-havoc-capricorn-q-part2.zip META-INF system
			rm /sdcard/tweak-havoc-capricorn-q-part2.zip
			mv -f /sdcard/Download/ext/temp/tweak-havoc-capricorn-q-part2.zip /sdcard
			
			awk -i inplace '{print substr($0,2)}' /sdcard/Download/ext/temp/remove5
			sed -i 's+..$++g' /sdcard/Download/ext/temp/remove5
			find /sdcard/Download/ext -name "Havoc-OS*" > /sdcard/Download/ext/temp/zip2
			awk -i inplace '$0="rm -rf "$0' /sdcard/Download/ext/temp/zip2
			remove=`cat /sdcard/Download/ext/temp/zip2`
			awk -v remove="$remove" '{print remove $0}' /sdcard/Download/ext/temp/remove5 > /sdcard/Download/ext/temp/remove6
			bash /sdcard/Download/ext/temp/remove6 2>/dev/null
			
			rm -rf /sdcard/Download/ext/temp/META-INF 2>/dev/null
			rm -rf /sdcard/Download/ext/temp/system 2>/dev/null
			rm /sdcard/Download/ext/temp/remove1 2>/dev/null
			rm /sdcard/Download/ext/temp/remove2 2>/dev/null
			rm /sdcard/Download/ext/temp/remove3 2>/dev/null
			rm /sdcard/Download/ext/temp/remove4 2>/dev/null
			rm /sdcard/Download/ext/temp/remove5 2>/dev/null
			rm /sdcard/Download/ext/temp/remove6 2>/dev/null
			rm /sdcard/Download/ext/temp/zip 2>/dev/null
			rm /sdcard/Download/ext/temp/zip1 2>/dev/null
			rm /sdcard/Download/ext/temp/zip2 2>/dev/null
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
