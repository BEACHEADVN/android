#!/data/data/com.termux/files/usr/bin/bash

function DISABLE {
for i in com.vng.pubgmobile com.garena.game.kgvn com.android.vending com.android.deskclock com.android.providers.downloads com.facebook.katana com.android.deskclock com.lonelycatgames.Xplore org.telegram.messenger com.oasisfeng.greenify com.google.android.youtube com.topjohnwu.magisk com.android.bluetooth com.android.chrome com.android.bluetoothmidiservice org.swiftapps.swiftbackup com.android.camera com.jairath.ccaster app.greyshirts.firewall com.google.android.play.games com.twitter.android free.vpn.unblock.proxy.turbovpn com.pandavpn.androidproxy com.android.vpndialogs com.hellraiser.unitemod com.forexgaming com.jairath.tencentig com.misaki.putri com.Putri com.chrome.beta com.putri.esp
do
	path=`su -c "pm path $i"`
	if [ -z "$path" ]
	then
		  echo $i >> /storage/emulated/0/Download/ext/temp/p_n_i
	else
		echo $i >> /storage/emulated/0/Download/ext/temp/p_i
	fi
done

echo "•Package không được cài đặt:"
cat /storage/emulated/0/Download/ext/temp/p_n_i
echo "•Tắt Package:"
lines=`cat /storage/emulated/0/Download/ext/temp/p_i`
for line in $lines
do
	su -c "pm disable $line"
done
}

function CPU×GPU {
x=0
while [ $x -le 7 ]
do
	su -c "chmod 777 /sys/devices/system/cpu/cpu$x/online"
	su -c "echo 1 > /sys/devices/system/cpu/cpu$x/online"
	su -c "chmod 444 /sys/devices/system/cpu/cpu$x/online"
	su -c "chmod 777 /sys/devices/system/cpu/cpu$x/cpufreq/scaling_governor"
	su -c "echo $cpu > /sys/devices/system/cpu/cpu$x/cpufreq/scaling_governor"
	x=$(( $x + 1 ))
done

su -c "chmod 777 /sys/class/kgsl/kgsl-3d0/max_clock_mhz"
su -c "echo 587 > /sys/class/kgsl/kgsl-3d0/max_clock_mhz"
su -c "chmod 777 /sys/class/kgsl/kgsl-3d0/min_clock_mhz"
su -c "echo $minMhz > /sys/class/kgsl/kgsl-3d0/min_clock_mhz"
su -c "chmod 777 /sys/class/kgsl/kgsl-3d0/default_pwrlevel"
su -c "echo $pwrlevel > /sys/class/kgsl/kgsl-3d0/default_pwrlevel"
su -c "echo 0 > /sys/class/kgsl/kgsl-3d0/throttling"

su -c "chmod 777 /sys/block/sda/queue/scheduler"
su -c "echo deadline > /sys/block/sda/queue/scheduler"
}

function SWAPPINESS {

su -c "echo 0 > /proc/sys/vm/swappiness"

cat <<EOT >> /storage/emulated/0/Download/ext/temp/gi_swappiness
su -c "echo 0 > /proc/sys/vm/swappiness"
a=`su -c "cat /proc/sys/vm/swappiness"`
if [ $a != 0 ]
then
     su -c "sh /storage/emulated/0/Download/ext/temp/gi_swappiness"
else
      echo "•swappiness: 0"
fi
EOT

a=`su -c "cat /proc/sys/vm/swappiness"`
if [ $a != '0' ]
then
	su -c "sh /storage/emulated/0/Download/ext/temp/gi_swappiness"
else
	echo "•swappiness: 0"
fi
}

function GPU_GOVERNOR {

su -c "chmod 777 /sys/class/kgsl/kgsl-3d0/devfreq/governor"
su -c "echo $gpu > /sys/class/kgsl/kgsl-3d0/devfreq/governor"

cat <<EOT >> /storage/emulated/0/Download/ext/temp/gi_$gpu
su -c "echo $gpu > /sys/class/kgsl/kgsl-3d0/devfreq/governor"
a=`su -c "cat /sys/class/kgsl/kgsl-3d0/devfreq/governor"`
if [ $a != $gpu ]
then
	su -c "sh /storage/emulated/0/Download/ext/temp/gi_$gpu"
else
	echo ""
fi
EOT

a=`su -c "cat /sys/class/kgsl/kgsl-3d0/devfreq/governor"`
if [ $a != $gpu ]
then
	su -c "sh /storage/emulated/0/Download/ext/temp/gi_$gpu"
else
	echo ""
fi
}

clear
echo "Chọn chế độ:"
echo "1. HOT"
echo "2. COLD"
echo "Nhập số từ 1-2:"
read temperature

case $temperature in
	1)
		#cpu=schedutil
		#gpu=msm-adreno-tz
		minMhz=220
		pwrlevel=7
		echo "Chạy profile kernel: $gpu"
		#DISABLE
		#CPU×GPU
		#SWAPPINESS
		#GPU_GOVERNOR
		su -c "chmod 777 /sys/class/kgsl/kgsl-3d0/max_clock_mhz"
		su -c "echo 680 > /sys/class/kgsl/kgsl-3d0/max_clock_mhz"
		su -c "chmod 777 /sys/class/kgsl/kgsl-3d0/min_clock_mhz"
		su -c "echo $minMhz > /sys/class/kgsl/kgsl-3d0/min_clock_mhz"
		su -c "chmod 777 /sys/class/kgsl/kgsl-3d0/default_pwrlevel"
		su -c "echo $pwrlevel > /sys/class/kgsl/kgsl-3d0/default_pwrlevel"
		su -c "echo 0 > /sys/class/kgsl/kgsl-3d0/throttling"
		
		su -c "chmod 777 /sys/block/sda/queue/scheduler"
		su -c "echo mq-deadline > /sys/block/sda/queue/scheduler"
		echo gi > /storage/emulated/0/Download/ext/temp/run_app
		#rm -rf /storage/emulated/0/Download/ext/temp/gi_swappiness
		#rm -rf /storage/emulated/0/Download/ext/temp/gi_$gpu
		su -c "am start --user 0 -n com.miHoYo.GenshinImpact/com.miHoYo.GetMobileInfo.MainActivity"
		su -c "killall -9 com.termux"
	;;
	2)
		#cpu=performance
		#gpu=performance
		minMhz=680
		pwrlevel=1
		echo "Chạy profile kernel: $gpu"
		#DISABLE
		#CPU×GPU
		#SWAPPINESS
		#GPU_GOVERNOR
		su -c "chmod 777 /sys/class/kgsl/kgsl-3d0/max_clock_mhz"
		su -c "echo 680 > /sys/class/kgsl/kgsl-3d0/max_clock_mhz"
		su -c "chmod 777 /sys/class/kgsl/kgsl-3d0/min_clock_mhz"
		su -c "echo $minMhz > /sys/class/kgsl/kgsl-3d0/min_clock_mhz"
		su -c "chmod 777 /sys/class/kgsl/kgsl-3d0/default_pwrlevel"
		su -c "echo $pwrlevel > /sys/class/kgsl/kgsl-3d0/default_pwrlevel"
		su -c "echo 0 > /sys/class/kgsl/kgsl-3d0/throttling"
		
		su -c "chmod 777 /sys/block/sda/queue/scheduler"
		su -c "echo mq-deadline > /sys/block/sda/queue/scheduler"
		echo gi > /storage/emulated/0/Download/ext/temp/run_app
		rm -rf /storage/emulated/0/Download/ext/temp/gi_swappiness
		rm -rf /storage/emulated/0/Download/ext/temp/gi_$gpu
		su -c "am start --user 0 -n com.miHoYo.GenshinImpact/com.miHoYo.GetMobileInfo.MainActivity"
		su -c "killall -9 com.termux"
	;;
esac