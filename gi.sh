#!/bin/bash
clear
echo "1. HOT"
echo "2. COLD"
echo "Nhập số từ 1-2:"
read temperature

case $temperature in
	1)
		echo "Chạy profile kernel: msm-adreno-tz"
		sh /sdcard/Download/ext/temp/gi_hot.sh
	;;
	2)
		echo "Chạy profile kernel: performance"
		sh /sdcard/Download/ext/temp/gi_cold.sh
	;;
esac