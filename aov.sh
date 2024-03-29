#!/data/data/com.termux/files/usr/bin/bash

x=0
while [ $x -le 7 ]
do
	su -c "chmod 777 /sys/devices/system/cpu/cpu$x/online"
	su -c "echo 1 > /sys/devices/system/cpu/cpu$x/online"
	su -c "chmod 444 /sys/devices/system/cpu/cpu$x/online"
	su -c "chmod 777 /sys/devices/system/cpu/cpu$x/cpufreq/scaling_governor"
	su -c "echo schedutil > /sys/devices/system/cpu/cpu$x/cpufreq/scaling_governor"
	x=$(( $x + 1 ))
done

su -c "chmod 777 /sys/class/kgsl/kgsl-3d0/max_clock_mhz"
su -c "echo 587 > /sys/class/kgsl/kgsl-3d0/max_clock_mhz"
su -c "chmod 777 /sys/class/kgsl/kgsl-3d0/min_clock_mhz"
su -c "echo 305 > /sys/class/kgsl/kgsl-3d0/min_clock_mhz"
su -c "chmod 777 /sys/class/kgsl/kgsl-3d0/devfreq/governor"
su -c "echo 'msm-adreno-tz' > /sys/class/kgsl/kgsl-3d0/devfreq/governor"
su -c "chmod 777 /sys/class/kgsl/kgsl-3d0/default_pwrlevel"
su -c "echo 5 > /sys/class/kgsl/kgsl-3d0/default_pwrlevel"
su -c "echo 0 > /sys/class/kgsl/kgsl-3d0/throttling"
su -c "chmod 777 /sys/devices/system/cpu/cpu7/online"
su -c "echo 1 > /sys/devices/system/cpu/cpu7/online"
su -c "chmod 444 /sys/devices/system/cpu/cpu7/online"
su -c "chmod 777 /sys/devices/system/cpu/cpu6/online"
su -c "echo 1 > /sys/devices/system/cpu/cpu6/online"
su -c "chmod 444 /sys/devices/system/cpu/cpu6/online"
su -c "chmod 777 /sys/devices/system/cpu/cpu5/online"
su -c "echo 1 > /sys/devices/system/cpu/cpu5/online"
su -c "chmod 444 /sys/devices/system/cpu/cpu5/online"

su -c "chmod 777 /sys/block/sda/queue/scheduler"
su -c "echo deadline > /sys/block/sda/queue/scheduler"

cat <<EOT >> /storage/emulated/0/Download/ext/temp/aov_gpu
su -c "echo msm-adreno-tz > /sys/class/kgsl/kgsl-3d0/devfreq/governor"
a=`su -c "cat /sys/class/kgsl/kgsl-3d0/devfreq/governor"`
if [ $a != msm-adreno-tz ]
then
	su -c "sh /storage/emulated/0/Download/ext/temp/aov_gpu"
else
	echo "•gpu governor: msm-adreno-tz"
fi
EOT

a=`su -c "cat /sys/class/kgsl/kgsl-3d0/devfreq/governor"`
if [ $a != 'msm-adreno-tz' ]
then
	su -c "sh /storage/emulated/0/Download/ext/temp/aov_gpu"
else
	su -c "am start --user 0 -n com.garena.game.kgvn/com.garena.game.kgtw.SGameActivity"
	echo aov > /storage/emulated/0/Download/ext/temp/run_app
	rm -rf /storage/emulated/0/Download/ext/temp/aov_gpu
	su -c "killall -9 com.termux"
fi

su -c "am start --user 0 -n com.garena.game.kgvn/com.garena.game.kgtw.SGameActivity"
echo aov > /storage/emulated/0/Download/ext/temp/run_app
rm -rf /storage/emulated/0/Download/ext/temp/aov_gpu
su -c "killall -9 com.termux"
