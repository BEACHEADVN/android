echo "•Bạn chọn Galaxy Wearable"

if su -c "find /data/app -type d -name 'com.samsung.android.app.watchmanager*'" | grep -q .
then
	echo "•Galaxy Wearable đã được cài đặt."
	name="Galaxy Wearable"
	package="com.samsung.android.app.watchmanager"
	activity="com.samsung.android.app.watchmanager.setupwizard.SetupWizardWelcomeActivity"
else
	echo "•Galaxy Wearable chưa được cài đặt."
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
	            termux-open https://play.google.com/store/apps/details?id=com.samsung.android.app.watchmanager
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