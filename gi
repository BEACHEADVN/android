#!/data/data/com.termux/files/usr/bin/bash

function DISABLE {
su -c "pm disable com.android.vending"
su -c "pm disable com.android.deskclock"
su -c "pm disable com.android.providers.downloads"
su -c "pm disable com.facebook.katana"
su -c "pm disable com.lonelycatgames.Xplore"
su -c "pm disable org.telegram.messenger"
su -c "pm disable com.oasisfeng.greenify"
su -c "pm disable com.google.android.youtube"
su -c "pm disable com.keramidas.TitaniumBackup"
su -c "pm disable com.keramidas.TitaniumBackupAddon"
su -c "pm disable com.topjohnwu.magisk"
su -c "pm disable com.android.bluetooth"
su -c "pm disable com.android.bluetoothmidiservice"
su -c "pm disable com.android.chrome"
su -c "pm disable org.swiftapps.swiftbackup"
su -c "pm disable com.android.camera"
su -c "pm disable com.garena.game.kgvn"
su -c "pm disable com.epi"
su -c "pm disable com.VCB"
su -c "pm disable com.jairath.ccaster"
su -c "pm disable com.google.android.play.games"
su -c "pm disable com.vng.pubgmobile"
su -c "pm disable com.chrome.beta"
}

function CPU×GPU {
x=0
while [ $x -le 7 ]
do
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

printf 'su -c "echo 0 > /proc/sys/vm/swappiness"
a=`su -c "cat /proc/sys/vm/swappiness"`
if [ $a != 0 ]
then
     su -c "sh /sdcard/Download/ext/temp/gi_swappiness"
else
      echo "•swappiness: 0"
fi
' > /storage/emulated/0/Download/ext/temp/gi_swappiness

a=`su -c "cat /proc/sys/vm/swappiness"`
if [ $a != '0' ]
then
     su -c "sh /sdcard/Download/ext/temp/gi_swappiness"
else
      echo "•swappiness: 0"
fi
}

function GPU_GOVERNOR {

su -c "chmod 777 /sys/class/kgsl/kgsl-3d0/devfreq/governor"
su -c "echo $gpu > /sys/class/kgsl/kgsl-3d0/devfreq/governor"

printf 'su -c "echo $gpu > /sys/class/kgsl/kgsl-3d0/devfreq/governor"
a=`su -c "cat /sys/class/kgsl/kgsl-3d0/devfreq/governor"`
if [ $a != $gpu ]
then
     su -c "sh /storage/emulated/0/Download/ext/temp/gi_$gpu"
else
      su -c "am start --user 0 -n com.miHoYo.GenshinImpact/com.miHoYo.GetMobileInfo.MainActivity"
      su -c "killall -9 com.termux"
fi
' > /sdcard/Download/ext/temp/gi_$gpu

a=`su -c "cat /sys/class/kgsl/kgsl-3d0/devfreq/governor"`
if [ $a != $gpu ]
then
     su -c "sh /sdcard/Download/ext/temp/gi_$gpu"
else
      su -c "am start --user 0 -n com.miHoYo.GenshinImpact/com.miHoYo.GetMobileInfo.MainActivity"
      echo gi > /storage/emulated/0/Download/ext/temp/run_app
      rm -rf /storage/emulated/0/Download/ext/temp/gi_swappiness
      rm -rf /storage/emulated/0/Download/ext/temp/gi_$gpu
      su -c "killall -9 com.termux"
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
		cpu=schedutil
		gpu=msm-adreno-tz
		minMhz=305
		pwrlevel=3
		echo "Chạy profile kernel: $gpu"
		DISABLE
		CPU×GPU
		SWAPPINESS
		GPU_GOVERNOR
	;;
	2)
		cpu=performance
		gpu=performance
		minMhz=587
		pwrlevel=1
		echo "Chạy profile kernel: $gpu"
		DISABLE
		CPU×GPU
		SWAPPINESS
		GPU_GOVERNOR
	;;
esac
