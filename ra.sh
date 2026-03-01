#!/data/data/com.termux/files/usr/bin/bash

BASE="/storage/emulated/0/Download/ext/temp"
LOG="$BASE/log.txt"

# ===== DANH SÁCH APP =====
apps=(
hoyolab
hackdata
shopee
adaway
vcb
momo
photo
revancify
quickedit
mtmanager
vneid
tiktok
galaxywearable
myviettel
viettelmoney
instagram
x
)

# ===== FUNCTION =====
enable() {
    su -ic "pm enable $package"
}

disable() {
    su -ic "pm disable $package"
}

run() {
    su -ic "am start --user 0 -n $package/$activity"
}

log_time() {
    echo `date +"%r, %a, ngày %d, tháng %m, năm %Y"` >> "$LOG"
    sed -i 's/ PM,/ CH,/g; s/ AM,/ SA,/g; s/ Mon, / thứ Hai, /g; s/ Tue, / thứ Ba, /g; s/ Wed, / thứ Tư, /g; s/ Thur, / thứ Năm, /g; s/ Fri, / thứ Sáu, /g; s/ Sat, / thứ Bảy, /g; s/ Sun, / Chủ nhật, /g' "$LOG"
}

# ===== MENU =====
clear
echo "===== DANH SÁCH ỨNG DỤNG ====="
for i in "${!apps[@]}"
do
    echo "$((i+1)): ${apps[$i]}"
done

echo ""
echo "0     : Thoát"
echo ""
read -p "Nhập lựa chọn: " a


# ===== ENABLE ALL =====
if [ "$a" = "on" ]
then
    for i in "${apps[@]}"
    do
        source "$BASE/$i.sh"
        enable
    done
    echo "✓ Đã enable tất cả"
    su -ic "am start --user 0 -n org.adaway/org.adaway.ui.home.HomeActivity"
	sleep 2
	su -ic "am start --user 0 -n com.android.vending/com.android.vending.AssetBrowserActivity"
	sleep 1
	su -ic "input swipe 1251 241 300 321 500"
	sleep 1
	python /data/data/com.termux/files/usr/bin/tap_avatar.py
	sleep 1
	python /data/data/com.termux/files/usr/bin/tap_text.py "Quản lý ứng dụng và thiết bị"
	sleep 3
	su -ic 'uiautomator dump ui.xml' > /dev/null 2>&1
	FILE="/data/data/com.termux/files/home/ui.xml"
	if grep -q "Tất cả ứng dụng đều ở phiên bản mới nhất" "$FILE"
	then
		echo "Tất cả ứng dụng đều ở phiên bản mới nhất"
		python /data/data/com.termux/files/usr/bin/tap_text.py "Tất cả ứng dụng đều ở phiên bản mới nhất"
		sleep 1
		python /data/data/com.termux/files/usr/bin//tap.py "Kiểm tra để tìm bản cập nhật"
	elif grep -q "Có bản cập nhật" "$FILE"
	then
		echo "Có bản cập nhật"
		python /data/data/com.termux/files/usr/bin/tap_text.py "Có bản cập nhật"
		sleep 1
		python /data/data/com.termux/files/usr/bin/tap_text.py "Cập nhật tất cả"
	else
		echo `date +"%r, %a, ngày %d, tháng %m, năm %Y"` >> /storage/emulated/0/Download/ext/temp/log.txt
		sed -i 's/ PM,/ CH,/g; s/ AM,/ SA,/g; s/ Mon, / thứ Hai, /g; s/ Tue, / thứ Ba, /g; s/ Wed, / thứ Tư, /g; s/ Thur, / thứ Năm, /g; s/ Fri, / thứ Sáu, /g; s/ Sat, / thứ Bảy, /g; s/ Sun, / Chủ nhật, /g' /storage/emulated/0/Download/ext/temp/log.txt
		echo "Không tìm thấy thông tin cập nhật Google Play" >> /storage/emulated/0/Download/ext/temp/log.txt
	fi
	rm -rf ui.xml
	rm -rf /sdcard/ui.xml
    ra
fi


# ===== DISABLE ALL =====
if [ "$a" = "off" ] || [ "$a" = "of" ]
then
    for i in "${apps[@]}"
    do
        source "$BASE/$i.sh"
        disable
    done
    echo "✓ Đã disable tất cả"
    ra
fi


# ===== DISABLE ALL + KILL =====
if [ "$a" = "off0" ] || [ "$a" = "of0" ]
then
    for i in "${apps[@]}"
    do
        source "$BASE/$i.sh"
        disable
    done
    su -ic "killall -9 com.termux"
    ra
fi


# ===== THOÁT =====
if [ "$a" = "0" ]
then
    exit
fi


# ===== CHỌN THEO SỐ =====
if [[ "$a" =~ ^[0-9]+$ ]] && [ "$a" -ge 1 ] && [ "$a" -le ${#apps[@]} ]
then
    appname=${apps[$((a-1))]}
    source "$BASE/$appname.sh"
    enable
    run
    ra
else
    echo "Lựa chọn không hợp lệ"
fi
