echo "•Bạn chọn VNeID"

if su -c "find /data/app -type d -name 'com.vnid*'" | grep -q .
then
	echo "•VNeID đã được cài đặt."
	name="VNeID"
	package="com.vnid"
	activity="com.vnid.MainActivity"
else
	echo "•VNeID chưa được cài đặt."
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
	            termux-open https://play.google.com/store/apps/details?id=com.vnid
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