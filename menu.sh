#!/bin/bash
clear
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+                   UNPACK ROM ANDROID                       +"
echo "+                        BEACHEAD                            +"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo "MENU "
echo "1. Trích xuất rom"
echo "2. Dọn dẹp rom"
echo "3. Hệ thống"
echo "4. Thông tin Kernel"
echo "5. Game"
echo "Nhập số từ 1-5 (nhấn x để thoát):"
read menu

case $menu in
	1)
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
		echo "HỆ THỐNG"
		echo "1. Tùy biến"
		echo "2. Kiểm tra cập nhật ứng dụng"
		echo "Nhập số từ 1-2 (nhấn x để quay lại Menu):"
		read system
		
		case $system in
			1)
				pm disable com.android.documentsui
				pm disable com.android.certinstaller
			;;
			2)
			
				function thoigian {
					echo `date +"%r ngày %d, tháng %m, năm %Y"` >> /sdcard/Download/ext/temp/log
					sed -i "s+ AM + SA +g" /sdcard/Download/ext/temp/log
					sed -i "s+ PM + CH +g" /sdcard/Download/ext/temp/log
				}
			
				clear
				echo "KIỂM TRA CẬP NHẬT ỨNG DỤNG"
				echo "1. AdGuard Premium"
				echo "2. Google Clock"
				echo "3. Greenify"
				echo "4. Lawnchair"
				echo "5. Magisk + Module"
				echo "6. Open Gapps"
				echo "7. SmartPark-Kernel Manager"
				echo "8. Titanium Backup Pro"
				echo "9. Webview Google"
				echo "10. X-plore Donate"
				echo "11. Youtube Vanced"
				echo "12. Google Contacts+Dialer+Message"
				echo "13.Tất cả"
				echo "Nhập số từ 1-13 (nhấn x để quay lại Menu):"
				read app
				
				case $app in
					1)
						thoigian
						bash /sdcard/Download/ext/temp/adguard.sh
					;;
					2)
						thoigian
						bash /sdcard/Download/ext/temp/clock.sh
					;;
					3)
						thoigian
						bash /sdcard/Download/ext/temp/greenify.sh
					;;
					4)
						thoigian
						bash /sdcard/Download/ext/temp/lawnchair.sh
					;;
					5)
						thoigian
						bash /sdcard/Download/ext/temp/magisk.sh
					;;
					6)
						thoigian
						bash /sdcard/Download/ext/temp/opengapp.sh
					;;
					7)
						thoigian
						bash /sdcard/Download/ext/temp/skm.sh
					;;
					8)
						thoigian
						bash /sdcard/Download/ext/temp/titan.sh
					;;
					9)
						thoigian
						bash /sdcard/Download/ext/temp/webview.sh
					;;
					10)
						thoigian
						bash /sdcard/Download/ext/temp/xplore.sh
					;;
					11)
						thoigian
						bash /sdcard/Download/ext/temp/youtube.sh
					;;
					12)
						thoigian
						bash /sdcard/Download/ext/temp/googleapp.sh
					;;
					13)
						thoigian
						bash /sdcard/Download/ext/temp/adguard.sh
						bash /sdcard/Download/ext/temp/googleapp.sh
						bash /sdcard/Download/ext/temp/clock.sh
						bash /sdcard/Download/ext/temp/greenify.sh
						bash /sdcard/Download/ext/temp/lawnchair.sh
						bash /sdcard/Download/ext/temp/magisk.sh
						bash /sdcard/Download/ext/temp/opengapp.sh
						bash /sdcard/Download/ext/temp/skm.sh
						bash /sdcard/Download/ext/temp/titan.sh
						bash /sdcard/Download/ext/temp/webview.sh
						bash /sdcard/Download/ext/temp/xplore.sh
						bash /sdcard/Download/ext/temp/youtube.sh
					;;
					x)
						echo ""
					;;
				esac
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