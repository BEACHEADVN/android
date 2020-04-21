#!/bin/sh -e

chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/*
echo 1209600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo 307200 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo pwrutilx > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
chmod 777 /sys/devices/system/cpu/cpu1/cpufreq/*
echo 1209600 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
echo 307200 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
echo pwrutilx > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
chmod 777 /sys/devices/system/cpu/cpu2/cpufreq/*
echo 1209600 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
echo 307200 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
echo pwrutilx > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
chmod 777 /sys/devices/system/cpu/cpu3/cpufreq/*
echo 1209600 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
echo 307200 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
echo pwrutilx > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
chmod 777 /sys/module/cpu_input_boost/parameters/*
echo 307200 > /sys/module/cpu_input_boost/parameters/input_boost_freq_lp
echo 307200 > /sys/module/cpu_input_boost/parameters/input_boost_freq_hp
echo powersave > /sys/class/kgsl/kgsl-3d0/devfreq/governor
echo noop > /sys/block/sda/queue/scheduler
echo 5 > /sys/module/cpu_input_boost/parameters/input_boost_duration
echo 128 > /sys/block/sda/queue/read_ahead_kb
echo 0 > /sys/kernel/dyn_fsync/Dyn_fsync_active
echo 1 > /sys/kernel/msm_thermal/enabled
