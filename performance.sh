#!/bin/sh -e
echo 0 > /sys/module/msm_thermal/core_control/enabled
echo N > /sys/module/msm_thermal/parameters/enabled
chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/*
echo 1996800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
chmod 777 /sys/devices/system/cpu/cpu1/cpufreq/*
echo 1996800 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
chmod 777 /sys/devices/system/cpu/cpu2/cpufreq/*
echo 2150400 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
chmod 777 /sys/devices/system/cpu/cpu3/cpufreq/*
echo 2150400 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
echo 30 > /sys/module/cpu_boost/parameters/input_boost_ms
echo '0:1056000 1:1056000 2:1056000 3:1056000' > /sys/module/cpu_boost/parameters/input_boost_freq
echo msm-adreno-tz > /sys/class/kgsl/kgsl-3d0/devfreq/governor
echo deadline > /sys/block/sda/queue/scheduler
echo 2048 > /sys/block/sda/queue/read_ahead_kb
echo 35 > /proc/sys/vm/swappiness
echo 1 > /sys/kernel/dyn_fsync/Dyn_fsync_active
echo 3 > /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost
echo 3 > /sys/class/kgsl/kgsl-3d0/default_pwrlevel