echo "•Bạn chọn Instagram"

echo "• Bạn chọn ứng dụng VPN:
1. 1.1.1.1
2. Box for root
3. Surfboard
4. V2rayNG
5. Viefast VPN"

read -p "Nhập lựa chọn của bạn (1 hoặc 2): " choice

while true
do
	case $choice in
		1)
			echo "•Bạn đã chọn 1.1.1.1"
			bash /storage/emulated/0/Download/ext/temp/1.1.1.1.sh
			break
		;;
		2)
			echo "•Bạn đã chọn Box for root"
			break
			;;
		3)
			echo "•Bạn đã chọn Surfboard"
			break
			;;
		4)
			echo "•Bạn đã chọn V2rayNG"
			break
			;;
		5)
			echo "•Bạn đã chọn Viefast VPN"
			break
			;;
		*)
			clear
			echo "Lựa chọn không hợp lệ. Vui lòng chọn lại."
			;;
	esac
done