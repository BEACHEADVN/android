#!/bin/bash

rm /sdcard/Download/ext/temp/d 2>/dev/null

ls /sdcard/Download/ext > /sdcard/Download/ext/temp/d
awk -i inplace '!/temp/' /sdcard/Download/ext/temp/d
if [[ -z $(grep '[^[:space:]]' /sdcard/Download/ext/temp/d) ]]
then
	echo "Không có rom đã giải nén!"
else
	x=`wc -l < /sdcard/Download/ext/temp/d`
	echo "DỌN DẸP"
	echo "1. Dọn dẹp rom đơn lẻ"
	echo "2. Dọn dẹp tất cả"
	echo "Nhập số từ 1-2 (nhấn x quay lại Menu):"
	read clean
	
	case $clean in
		1)
			clear
			awk '{print NR  ". " $s}' /sdcard/Download/ext/temp/d >> /sdcard/Download/ext/temp/d1
			echo "Rom đã giải nén:"
			cat /sdcard/Download/ext/temp/d1
			rm /sdcard/Download/ext/temp/d1 2>/dev/null
			echo "Chọn rom đã giải nén cần xóa:"
			echo "Nhập số từ 1-$x: (nhấn x để quay lại Menu)"
			read c
			if [[ $c == x ]]
			then
				echo ""
			else
				sed -n "$c"p /sdcard/Download/ext/temp/d >> /sdcard/Download/ext/temp/rom$c
				rm -rf /sdcard/Download/ext/`cat /sdcard/Download/ext/temp/rom$c`
				rm -rf /sdcard/Download/ext/temp/rom$c
			fi
		;;
		2)
			echo "Xóa ROM:"
			for (( v=1; v<=$x; v++ ))
			do
				sed -n "$v"p /sdcard/Download/ext/temp/d >> /sdcard/Download/ext/temp/rom$v
				echo "[$v/$x] `cat /sdcard/Download/ext/temp/rom$v`"
				rm -rf /sdcard/Download/ext/`cat /sdcard/Download/ext/temp/rom$v`
				echo "Hoàn thành !"
				rm -rf /sdcard/Download/ext/temp/rom$v
			done
		;;
		x)
			echo ""
		;;
	esac
fi

rm /sdcard/Download/ext/temp/d 2>/dev/null
