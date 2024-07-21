echo "•Bạn chọn Mt Manager"

if su -c "find /data/app -type d -name 'bin.mt.plus*'" | grep -q .
then
	echo "•Mt Manager đã được cài đặt."
	name="Mt Manager"
	package="bin.mt.plus"
	activity="bin.mt.plus.Main"
else
	echo "•Mt Manager chưa được cài đặt."
	echo "•Bạn muốn cài đặt ứng dụng?"
	while true
	do
	    echo "Chọn một tùy chọn:"
	    echo "1. Cài đặt"
	    echo "2. Không cài đặt"
	
	    read -p "Nhập lựa chọn của bạn (1 hoặc 2): " choice
	
	    case $choice in
	        1)
	            echo "Bạn đã chọn Cài đặt."
	            termux-open https://m.apkpure.com/vn/mt-manager/bin.mt.plus/download
	            break
	            ;;
	        2)
	            echo "Bạn đã chọn Không cài đặt."
	            break
	            ;;
	        *)
		        clear
	            echo "Lựa chọn không hợp lệ. Vui lòng chọn lại."
	            ;;
	    esac
	done
fi