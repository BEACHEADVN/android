#!/bin/sh -e

echo 0 > /sys/kernel/msm_thermal/enabled
chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/*
echo 1996800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo 307200 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo schedutil > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
chmod 777 /sys/devices/system/cpu/cpu1/cpufreq/*
echo 1996800 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
echo 307200 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
echo schedutil > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
chmod 777 /sys/devices/system/cpu/cpu2/cpufreq/*
echo 2150400 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
echo 307200 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
echo schedutil > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
chmod 777 /sys/devices/system/cpu/cpu3/cpufreq/*
echo 2150400 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
echo 307200 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
echo schedutil > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
chmod 777 /sys/module/cpu_input_boost/parameters/*
echo 1056000 > /sys/module/cpu_input_boost/parameters/input_boost_freq_lp
echo 1056000 > /sys/module/cpu_input_boost/parameters/input_boost_freq_hp
echo performance > /sys/class/kgsl/kgsl-3d0/devfreq/governor
echo deadline > /sys/block/sda/queue/scheduler
echo 30 > /sys/module/cpu_input_boost/parameters/input_boost_duration
echo 2048 > /sys/block/sda/queue/read_ahead_kb
echo 1 > /sys/kernel/dyn_fsync/Dyn_fsync_active
echo 60 > /proc/sys/vm/swappiness
