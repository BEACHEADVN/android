cat <<EOT > /storage/emulated/0/Download/ext/temp/app
Hoyo Lab
Hack Data
Shopee
Adaway
VCB
MoMo
Lazada
Revancify
Quick Edit
Mt Manager
Zalo Pay
SmartPack Kernel Manager
Xiaomi Earbuds
My Viettel
Viettel Money
Twitter
EOT

line_number=`wc -l /storage/emulated/0/Download/ext/temp/app | cut -d' ' -f1`
line_number=$((line_number+1))
echo $line_number

clear
echo "Chọn công việc:" 
count=0
while read line; do
count=$((count+1))
echo "$count: $line"
done < /storage/emulated/0/Download/ext/temp/app
echo "$line_number: Thoát"
echo "Nhập số từ 1-$line_number:"
read chon
a=`echo $chon | cut -d' ' -f1`
b=`echo $chon | cut -d' ' -f2`
c=`echo $chon | cut -d' ' -f3`

rm -rf /storage/emulated/0/Download/ext/temp/app
rm -rf /storage/emulated/0/Download/ext/temp/vpndialog 2> /dev/null

function hoyo_lab {
	echo "•Bạn chọn Hoyo Lab"
	name="Hoyo Lab"
	package="com.mihoyo.hoyolab"
	activity="com.mihoyo.hoyolab.home.HoYoLabMainActivity"
}

function hack_data {
	echo "•Bạn chọn Hack Data"
	name="Clash Android"
	su -c "pm enable com.android.vpndialogs"
	if [[ $choose = off || $choose = of ]]
	then
		path=`su -c "find /storage/emulated/0/Download/ext/temp -type f -name 'vpndialog'"`
		if [ -z "$path" ]
		then
			echo ""
		else
			su -c "pm disable com.android.vpndialogs"
			rm -rf /storage/emulated/0/Download/ext/temp/vpndialog
		fi
	else
		echo 1 > /storage/emulated/0/Download/ext/temp/vpndialog
	fi
	#package="com.github.kr328.clash"
	#activity="com.github.kr328.clash.MainActivity"
	package="com.getsurfboard"
	activity="com.getsurfboard.ui.activity.MainActivity"
}

function shopee {
	echo "•Bạn chọn Shopee"
	name="Shopee"
	package="com.shopee.vn"
	activity="com.shopee.app.ui.home.HomeActivity_"
}

function adaway {
	echo "•Bạn chọn AdAway"
	name="AdAway"
	package="org.adaway"
	activity="org.adaway.ui.home.HomeActivity"
}

function vcb {
	echo "•Bạn chọn Vietcombank"
	name="Vietcombank"
	package="com.VCB"
	activity="com.VCB.activities.home.SplashActivity"
}

function momo {
	echo "•Bạn chọn MoMo"
	name="MoMo"
	package="com.mservice.momotransfer"
	activity="vn.momo.platform.entry.MainActivity"
}

function lazada {
	echo "•Bạn chọn Lazada"
	name="Lazada"
	package="com.lazada.android"
	activity="com.lazada.activities.EnterActivity"
}

#function G_drive {
	#echo "•Bạn chọn Google Drive"
	#package="com.google.android.apps.docs"
	#activity="com.google.android.apps.docs.drive.startup.StartupActivity"
#}

function quick_edit {
	echo "•Bạn chọn Quick Edit+"
	name="Quick Edit"
	package="com.rhmsoft.edit"
	activity="com.rhmsoft.edit.activity.MainActivity"
}

function mtm {
	echo "•Bạn chọn Mt Manager"
	name="Mt Manager"
	package="bin.mt.plus"
	#activity="bin.mt.plus.MainDarkIcon"
	activity="bin.mt.plus.Main"
}

function zalo_pay {
	echo "•Bạn chọn Zalo Pay"
	name="Zalo Pay"
	package="vn.com.vng.zalopay"
	activity="vn.com.vng.zalopay.ui.activity.SplashScreenActivity"
}

function skm {
	echo "•Bạn chọn SmartPack Kernel Manager"
	name="SmartPack Kernel Manager"
	package="com.smartpack.kernelmanager"
	activity="com.smartpack.kernelmanager.activities.StartActivity"
}

function xiaomiearbuds {
	echo "•Bạn chọn Xiaomi Earbuds"
	name="XiaomiEarbuds"
	package="com.mi.earphone"
	activity="com.mi.earphone.main.MainActivity"
}

function myviettel {
	echo "•Bạn chọn My Viettel"
	name="My Viettel"
	package="com.vttm.vietteldiscovery"
	activity="com.gem.myviettel.activity.ViettelDiscoveryLauncherActivity"
}

function viettelmoney {
	echo "•Bạn chọn Viettel Money"
	name="Viettel Money"
	package="com.bplus.vtpay"
	activity="com.bplus.vtpay.activity.SplashScreen"
}

function twitter {
	echo "•Bạn chọn Twitter"
	name="Twitter"
	package="com.twitter.android"
	activity="com.twitter.android.StartActivity"
}

function rvxmanager {
	echo "•Bạn chọn RVX Manager"
	name="RVXManager"
	package="app.rvx.manager.flutter"
	activity="app.revanced.manager.flutter.MainActivity"
}

function enable {
	path=`su -c "pm path $package | sed -n '/base/s/package://p'"`
	if [ -z "$path" ]
	then
		  echo "• $name khong duoc cai dat."
	else
		su -c "pm enable $package"
	fi
}
function run {
	su -c "am start --user 0 -n $package/$activity"
}
	
function disable {
	path=`su -c "pm path $package | sed -n '/base/s/package://p'"`
	if [ -z "$path" ]
	then
		  echo "• $name khong duoc cai dat."
	else
		su -c "pm disable $package"
	fi
}

function action {
	if [ $b = 1 ]
	then
		enable
		run
	elif [ $b = 2 ]
	then
		disable
	fi
}

function check_exit {
	if [[ -z $c ]]
	then
		ra
	else
		if [ $c = 1 ]
		then
			ra
		elif [ $c = 0 ]
		then
			su -c "killall -9 com.termux"
		fi
	fi
}

function s_exit {
	if [ $b = 1 ]
	then
		clear
	elif [ $b = 0 ]
	then
		su -c "killall -9 com.termux"
	fi
}

if [ $a = 1 ]
then
	hoyo_lab
	action
	check_exit
elif [ $a = 2 ]
then
	hack_data
	action
	check_exit
elif [ $a = 3 ]
then
	shopee
	action
	check_exit
elif [ $a = 4 ]
then
	adaway
	action
	check_exit
elif [ $a = 5 ]
then
	vcb
	action
	check_exit
elif [ $a = 6 ]
then
	momo
	action
	check_exit
elif [ $a = 7 ]
then
	lazada
	action
	check_exit
elif [ $a = 8 ]
then
		#rvxmanager
		#action
		#check_exit
	if [ -f /data/data/com.termux/files/home/Revancify/revancify ]
	then
		revancify
	else
		pkg update -y && pkg install git -y && git clone https://github.com/decipher3114/Revancify.git && ./Revancify/revancify
	fi
elif [ $a = 9 ]
then
	quick_edit
	action
	check_exit
elif [ $a = 10 ]
then
	mtm
	action
	check_exit
elif [ $a = 11 ]
then
	zalo_pay
	action
	check_exit
elif [ $a = 12 ]
then
	skm
	action
	check_exit
elif [ $a = 13 ]
then
	xiaomiearbuds
	action
	check_exit
elif [ $a = 14 ]
then
	myviettel
	action
	check_exit
elif [ $a = 15 ]
then
	viettelmoney
	action
	check_exit
elif [ $a = 16 ]
then
	twitter
	action
	check_exit
elif [ $a = $line_number ]
then
	s_exit
elif [ $a = on ]
then
	for i in hoyo_lab hack_data shopee adaway vcb momo lazada quick_edit mtm zalo_pay skm xiaomiearbuds myviettel viettelmoney twitter rvxmanager
	do
		$i
		enable
	done
	su -c "am start --user 0 -n org.adaway/org.adaway.ui.home.HomeActivity"
	sleep 2
	su -c "am start --user 0 -n com.android.vending/com.android.vending.AssetBrowserActivity"
	ra
elif [[ $a = off || $a = of ]]
then
	for i in hoyo_lab hack_data shopee adaway vcb momo lazada quick_edit mtm zalo_pay skm xiaomiearbuds myviettel viettelmoney twitter rvxmanager
	do
		$i
		disable
	done
	ra
elif [[ $a = off0 || $a = of0 ]]
then
	for i in hoyo_lab hack_data shopee adaway vcb momo lazada quick_edit mtm zalo_pay skm xiaomiearbuds myviettel viettelmoney twitter rvxmanager
	do
		$i
		disable
	done
	su -c "killall -9 com.termux"
fi