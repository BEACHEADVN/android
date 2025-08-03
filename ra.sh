cat <<EOT > /storage/emulated/0/Download/ext/temp/app
Hoyo Lab
Hack Data
Shopee
Adaway
VCB
MoMo
Google Photo
Revancify
Quick Edit
Mt Manager
VNeID
TikTok
Galaxy Wearable
My Viettel
Viettel Money
Instagram
X
EOT

if su -c "find /data/app -type d -name 'com.google.ar.core*'" | grep -q .
then
	echo `date +"%r, %a, ngày %d, tháng %m, năm %Y"` >> /storage/emulated/0/Download/ext/temp/log.txt
	sed -i 's/ PM,/ CH,/g; s/ AM,/ SA,/g; s/ Mon, / thứ Hai, /g; s/ Tue, / thứ Ba, /g; s/ Wed, / thứ Tư, /g; s/ Thur, / thứ Năm, /g; s/ Fri, / thứ Sáu, /g; s/ Sat, / thứ Bảy, /g; s/ Sun, / Chủ nhật, /g' /storage/emulated/0/Download/ext/temp/log.txt
	echo "•Uninstall google ar core" >> /storage/emulated/0/Download/ext/temp/log.txt
	su -c "pm uninstall -k com.google.ar.core" 
fi

line_number=`wc -l /storage/emulated/0/Download/ext/temp/app | cut -d' ' -f1`
line_number=$((line_number+1))

clear
echo "Chọn công việc:" 
count=0
while read line
do
	count=$((count+1))
	echo "$count: $line"
done < /storage/emulated/0/Download/ext/temp/app
rm -rf /storage/emulated/0/Download/ext/temp/app

echo "$line_number: Thoát"
echo "Nhập số từ 1-$line_number:"
read chon

spacenumber=`echo "$chon" | awk -F" " '{print NF-1}'`
if [ $spacenumber = 0 ]
then
	a=$(echo $chon | cut -d ' ' -f 1)
	b=1
	c=1
elif [ $spacenumber = 1 ]
then
	a=$(echo $chon | cut -d ' ' -f 1)
	b=$(echo $chon | cut -d ' ' -f 2)
	c=1
else
	a=$(echo $chon | cut -d ' ' -f 1)
	b=$(echo $chon | cut -d ' ' -f 2)
	c=$(echo $chon | cut -d ' ' -f 3)
fi

function enable {
	su -c "pm enable $package"
}
function run {
	su -c "am start --user 0 -n $package/$activity"
}

function disable {
	su -c "pm disable $package"
}

if [ $a = on ]
then
	for i in hoyolab shopee adaway vcb momo photo x quickedit mtm tiktok galaxywearable myviettel mtmanager vneid instagram
	do
		source /storage/emulated/0/Download/ext/temp/$i.sh
		enable
	done
	su -c "am start --user 0 -n org.adaway/org.adaway.ui.home.HomeActivity"
	sleep 2
	su -c "am start --user 0 -n com.android.vending/com.android.vending.AssetBrowserActivity"
	sleep 2
	su -c "input swipe 1251 241 256 321 500"
	su -c 'uiautomator dump /sdcard/ui.xml' >/dev/null 2>&1
	cp /sdcard/ui.xml ~/ui.xml
	python /sdcard/tap_avatar.py
	sleep 1
	su -c 'uiautomator dump /sdcard/ui.xml' >/dev/null 2>&1
	cp /sdcard/ui.xml ~/ui.xml
	python /sdcard/tap_text.py "Quản lý ứng dụng và thiết bị"
	sleep 2
	su -c 'uiautomator dump /sdcard/ui.xml' >/dev/null 2>&1
	cp /sdcard/ui.xml ~/ui.xml
	python /sdcard/tap_text.py "Có bản cập nhật"
	sleep 1
	su -c 'uiautomator dump /sdcard/ui.xml' >/dev/null 2>&1
	cp /sdcard/ui.xml ~/ui.xml
	python /sdcard/tap_text.py "Tất cả ứng dụng đều ở phiên bản mới nhất"
	python /sdcard/tap.py "Kiểm tra để tìm bản cập nhật"
	ra
fi

if [[ $a = off || $a = of ]]
then
	rm -rf /storage/emulated/0/Download/ext/temp/vpndialog
	for i in hoyolab shopee adaway vcb momo photo x quickedit mtm tiktok galaxywearable myviettel mtmanager vneid instagram
	do
		source /storage/emulated/0/Download/ext/temp/$i.sh
		disable
	done
	ra
fi

if [[ $a = off0 || $a = of0 ]]
then
	rm -rf /storage/emulated/0/Download/ext/temp/vpndialog
	for i in hoyolab shopee adaway vcb momo photo x quickedit mtm tiktok galaxywearable myviettel mtmanager vneid instagram
	do
		source /storage/emulated/0/Download/ext/temp/$i.sh
		disable
	done
	su -c "killall -9 com.termux"
fi

if [[ "$a" =~ ^[0-9]+$ ]] && [ "$a" -ge 1 ] && [ "$a" -le 18 ]
then
    echo ""
else
    ra
fi

if [ "$b" -eq 1 ] || [ "$b" -eq 2 ] || [ "$b" -eq 0 ]
then
    echo ""
else
    ra
fi

if [ "$c" -eq 1 ] || [ "$c" -eq 0 ]
then
    echo ""
else
    ra
fi

if [ $a = 1 ]
then
	source /storage/emulated/0/Download/ext/temp/hoyolab.sh
	if [ $b = 1 ]
	then
		enable
		run
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	else
		disable
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	fi
fi

if [ $a = 2 ]
then
	source /storage/emulated/0/Download/ext/temp/hackdata.sh
	if [ $b = 1 ]
	then
		enable
		run
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	else
		disable
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	fi
fi

if [ $a = 3 ]
then
	source /storage/emulated/0/Download/ext/temp/shopee.sh
	if [ $b = 1 ]
	then
		enable
		run
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	else
		disable
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	fi
fi

if [ $a = 4 ]
then
	source /storage/emulated/0/Download/ext/temp/adaway.sh
	if [ $b = 1 ]
	then
		enable
		run
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	else
		disable
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	fi
fi

if [ $a = 5 ]
then
	source /storage/emulated/0/Download/ext/temp/vcb.sh
	if [ $b = 1 ]
	then
		enable
		run
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	else
		disable
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	fi
fi

if [ $a = 6 ]
then
	source /storage/emulated/0/Download/ext/temp/momo.sh
	if [ $b = 1 ]
	then
		enable
		run
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	else
		disable
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	fi
fi

if [ $a = 7 ]
then
	source /storage/emulated/0/Download/ext/temp/photo.sh
	if [ $b = 1 ]
	then
		enable
		run
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	else
		disable
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	fi
fi

if [ $a = 9 ]
then
	source /storage/emulated/0/Download/ext/temp/quickedit.sh
	if [ $b = 1 ]
	then
		enable
		run
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	else
		disable
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	fi
fi

if [ $a = 10 ]
then
	source /storage/emulated/0/Download/ext/temp/mtmanager.sh
	if [ $b = 1 ]
	then
		enable
		run
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	else
		disable
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	fi
fi

if [ $a = 11 ]
then
	source /storage/emulated/0/Download/ext/temp/vneid.sh
	if [ $b = 1 ]
	then
		enable
		run
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	else
		disable
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	fi
fi

if [ $a = 12 ]
then
	source /storage/emulated/0/Download/ext/temp/tiktok.sh
	if [ $b = 1 ]
	then
		enable
		run
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	else
		disable
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	fi
fi

if [ $a = 13 ]
then
	source /storage/emulated/0/Download/ext/temp/galaxywearable.sh
	if [ $b = 1 ]
	then
		enable
		run
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	else
		disable
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	fi
fi

if [ $a = 14 ]
then
	source /storage/emulated/0/Download/ext/temp/myviettel.sh
	if [ $b = 1 ]
	then
		enable
		run
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	else
		disable
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	fi
fi

if [ $a = 15 ]
then
	source /storage/emulated/0/Download/ext/temp/viettelmoney.sh
	if [ $b = 1 ]
	then
		enable
		run
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	else
		disable
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	fi
fi

if [ $a = 16 ]
then
	source /storage/emulated/0/Download/ext/temp/instagram.sh
	if [ $b = 1 ]
	then
		enable
		run
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	else
		disable
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	fi
fi

if [ $a = 17 ]
then
	source /storage/emulated/0/Download/ext/temp/x.sh
	if [ $b = 1 ]
	then
		enable
		run
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	else
		disable
		if [ $c = 1 ]
		then
			ra
		else
			su -c "killall -9 com.termux"
		fi
	fi
fi

if [ $a = 18 ]
then
	if [ $b = 0 ]
	then
		su -c "killall -9 com.termux"
	else
		clear
	fi
fi

if [ $a = 8 ]
then
	 bash /storage/emulated/0/Download/ext/temp/revancify_mod.sh
fi
