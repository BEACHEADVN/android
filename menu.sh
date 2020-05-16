#!/bin/bash
clear
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+                   UNPACK ROM ANDROID                    +"
echo "+                        BEACHEAD                         +"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo "MENU "
echo "1. Trích xuất rom"
echo "2. Dọn dẹp rom"
echo "3. Kiểm tra, cập nhật"
echo "4. Thông tin Kernel"
echo "5. Game"
echo "Nhập số từ 1-5 (nhấn x để thoát):"
read menu

case $menu in
	1)
		clear
		echo "Chạy profile kernel: performance"
		sh /sdcard/Download/ext/temp/performance.sh
		bash /sdcard/Download/ext/temp/unpack.sh
		echo "Chạy profile kernel: battery"
		sh /sdcard/Download/ext/temp/battery.sh
		sh /sdcard/Download/ext/temp/menu.sh
	;;
	2)
		echo "Chạy profile kernel: performance"
		clear
		sh /sdcard/Download/ext/temp/performance.sh
		bash /sdcard/Download/ext/temp/cleanrom.sh
		echo "Chạy profile kernel: battery"
		sh /sdcard/Download/ext/temp/battery.sh
		sh /sdcard/Download/ext/temp/menu.sh
	;;
	3)
		clear
		sh /sdcard/Download/ext/temp/performance.sh
		echo "KIỂM TRA, CẬP NHẬT"
		echo "1. AdGuard Premium"
		echo "2. Greenify"
		echo "3. Lawnchair"
		echo "4. Magisk + Module"
		echo "5. Open Gapps"
		echo "6. SmartPark-Kernel Manager"
		echo "7. Titanium Backup Pro"
		echo "8. X-plore Donate"
		echo "9. Youtube Vanced"
		echo "10. Google Apps"
		echo "11. Rom"
		echo "12. Tất cả (trừ kiểm tra Rom)"
		echo "Nhập số từ 1-12 (nhấn x để quay lại Menu):"
		read app
		
		case $app in
			1)
				echo `date +"%r ngày %d, tháng %m, năm %Y"` >> /sdcard/Download/ext/temp/log
				sed -i "s+ AM + SA +g; s+ PM + CH +g" /sdcard/Download/ext/temp/log
				bash /sdcard/Download/ext/temp/adguard.sh
			;;
			2)
				echo `date +"%r ngày %d, tháng %m, năm %Y"` >> /sdcard/Download/ext/temp/log
				sed -i "s+ AM + SA +g; s+ PM + CH +g" /sdcard/Download/ext/temp/log
				bash /sdcard/Download/ext/temp/greenify.sh
			;;
			3)
				echo `date +"%r ngày %d, tháng %m, năm %Y"` >> /sdcard/Download/ext/temp/log
				sed -i "s+ AM + SA +g; s+ PM + CH +g" /sdcard/Download/ext/temp/log
				bash /sdcard/Download/ext/temp/lawnchair.sh
			;;
			4)
				echo `date +"%r ngày %d, tháng %m, năm %Y"` >> /sdcard/Download/ext/temp/log
				sed -i "s+ AM + SA +g; s+ PM + CH +g" /sdcard/Download/ext/temp/log
				bash /sdcard/Download/ext/temp/magisk.sh
			;;
			5)
				echo `date +"%r ngày %d, tháng %m, năm %Y"` >> /sdcard/Download/ext/temp/log
				sed -i "s+ AM + SA +g; s+ PM + CH +g" /sdcard/Download/ext/temp/log
				bash /sdcard/Download/ext/temp/opengapp.sh
			;;
			6)
				echo `date +"%r ngày %d, tháng %m, năm %Y"` >> /sdcard/Download/ext/temp/log
				sed -i "s+ AM + SA +g; s+ PM + CH +g" /sdcard/Download/ext/temp/log
				bash /sdcard/Download/ext/temp/skm.sh
			;;
			7)
				echo `date +"%r ngày %d, tháng %m, năm %Y"` >> /sdcard/Download/ext/temp/log
				sed -i "s+ AM + SA +g; s+ PM + CH +g" /sdcard/Download/ext/temp/log
				bash /sdcard/Download/ext/temp/titan.sh
			;;
			8)
				echo `date +"%r ngày %d, tháng %m, năm %Y"` >> /sdcard/Download/ext/temp/log
				sed -i "s+ AM + SA +g; s+ PM + CH +g" /sdcard/Download/ext/temp/log
				bash /sdcard/Download/ext/temp/xplore.sh
			;;
			9)
				echo `date +"%r ngày %d, tháng %m, năm %Y"` >> /sdcard/Download/ext/temp/log
				sed -i "s+ AM + SA +g; s+ PM + CH +g" /sdcard/Download/ext/temp/log
				bash /sdcard/Download/ext/temp/youtube.sh
			;;
			10)
				echo `date +"%r ngày %d, tháng %m, năm %Y"` >> /sdcard/Download/ext/temp/log
				sed -i "s+ AM + SA +g; s+ PM + CH +g" /sdcard/Download/ext/temp/log
				bash /sdcard/Download/ext/temp/googleapps.sh
			;;
			11)
				echo `date +"%r ngày %d, tháng %m, năm %Y"` >> /sdcard/Download/ext/temp/log
				sed -i "s+ AM + SA +g; s+ PM + CH +g" /sdcard/Download/ext/temp/log
				bash /sdcard/Download/ext/temp/evolutionx.sh
				bash /sdcard/Download/ext/temp/havoc.sh
			;;
			12)
				echo `date +"%r ngày %d, tháng %m, năm %Y"` >> /sdcard/Download/ext/temp/log
				sed -i "s+ AM + SA +g; s+ PM + CH +g" /sdcard/Download/ext/temp/log
				bash /sdcard/Download/ext/temp/adguard.sh
				bash /sdcard/Download/ext/temp/googleapps.sh
				bash /sdcard/Download/ext/temp/greenify.sh
				bash /sdcard/Download/ext/temp/lawnchair.sh
				bash /sdcard/Download/ext/temp/magisk.sh
				bash /sdcard/Download/ext/temp/opengapp.sh
				bash /sdcard/Download/ext/temp/skm.sh
				bash /sdcard/Download/ext/temp/titan.sh
				bash /sdcard/Download/ext/temp/xplore.sh
				bash /sdcard/Download/ext/temp/youtube.sh
			;;
			x)
				echo ""
			;;
		esac
	bash /sdcard/Download/ext/temp/menu.sh
	;;
	4)
		clear
		bash /sdcard/Download/ext/temp/kernel.sh
		bash /sdcard/Download/ext/temp/menu.sh
	;;
	5)
		clear
		bash /sdcard/Download/ext/temp/game.sh
	;;
	x)
		echo "Chạy profile kernel: battery"
		sh /sdcard/Download/ext/temp/battery.sh
		find /sdcard/Download/ext/temp -type f -not -name 'log' -print0 | xargs -0 rm
		clear
		echo "Đóng Termux?"
		echo "1. Có"
		echo "2. Không"
		read termux

		case $termux in
			1)
	        	killall -9 com.termux
        	;;
        	*)
                clear
        	;;
		esac
	;;
esac
