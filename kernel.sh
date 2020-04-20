#!/bin/bash

echo "                   KERNEL INFOMATION"
echo "•CPU:"
echo "-Core 0:"
echo "   CPU Maximum Frequency: `cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq` MHz"
echo "   CPU Minimum Frequency: `cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq` MHz"
echo "   Governor: `cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor`"

echo "-Core 1:"
echo "   CPU Maximum Frequency: `cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq` MHz"
echo "   CPU Minimum Frequency: `cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq` MHz"
echo "   Governor: `cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor`"

echo "-Core 2:"
echo "   CPU Maximum Frequency: `cat /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq` MHz"
echo "   CPU Minimum Frequency: `cat /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq` MHz"
echo "   Governor: `cat /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor`"

echo "-Core 3:"
echo "   CPU Maximum Frequency: `cat /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq` MHz"
echo "   CPU Minimum Frequency: `cat /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq` MHz"
echo "   Governor: `cat /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor`"

echo "-CPU Boost:"
echo "   Input Interval: `cat /sys/module/cpu_boost/parameters/input_boost_ms` ms"
echo "   Input Boost Frequency:"
echo "      Core 1: `cat /sys/module/cpu_boost/parameters/input_boost_freq | sed 's+ 1:.*++g; s+0:++g'` MHz"
echo "      Core 2: `cat /sys/module/cpu_boost/parameters/input_boost_freq | sed 's+ 2:.*++g; s+^.*1:++g'` MHz"
echo "      Core 3: `cat /sys/module/cpu_boost/parameters/input_boost_freq | sed 's+ 3:.*++g; s+^.*2:++g'` MHz"
echo "      Core 3: `cat /sys/module/cpu_boost/parameters/input_boost_freq | sed 's+^.*3:++g'`MHz"

echo "•GPU:"
echo "-GPU Governor: `cat /sys/class/kgsl/kgsl-3d0/devfreq/governor`"

echo "•THERMAL:"
a=`cat /sys/kernel/msm_thermal/enabled`
if [ $a  == 1 ]
then
	echo "-Thermal Control: On"
else
	echo "-Thermal Control: Off"
fi

echo "•I/O Scheduler:"
echo "-Scheduler: `awk 'NR > 1 {print $1}' RS='[' FS=']' /sys/block/sda/queue/scheduler`"
echo "-Read-ahead: `cat /sys/block/sda/queue/read_ahead_kb` kB"

echo "•Vitural Memory:"
echo "-Drop caches: `cat /proc/sys/vm/drop_caches`"
swap_total=`cat /proc/meminfo | grep "SwapTotal" | sed 's/[^0-9]*//g'`
zram_total=`awk -v var1=$swap_total -v var2=1024 'BEGIN { print  ( var1 / var2 ) }'`

swap_free=`cat /proc/meminfo | grep "SwapFree" | sed 's/[^0-9]*//g'`
zram_free=`awk -v var1=$swap_free -v var2=1024 'BEGIN { print  ( var1 / var2 ) }'`

zram_used=`awk -v var1=$zram_total -v var2=$zram_free 'BEGIN { print  ( var1 - var2 ) }'`

echo "-Zram Total: $zram_total MB"
echo "-Zram Used: $zram_used MB"
echo "-Zram Free: $zram_free MB"
echo "-Swappiness: `cat /proc/sys/vm/swappiness`"
echo "•MISC:"
fsync=`cat /sys/kernel/dyn_fsync/Dyn_fsync_active`
if [ $fsync == 1 ]
then
	echo "-Fsync: Off"
else
	echo "-Fsync: On"
fi

read -r -s -p $'Nhấn Enter để tiếp tục...\n'
