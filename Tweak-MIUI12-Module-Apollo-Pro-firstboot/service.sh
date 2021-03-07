#!/system/bin/sh
# Edit by BEACHEAD for Apollo Pro

sleep 15

#Zram
toybox swapoff /dev/block/zram0
echo 1 > /sys/block/zram0/reset
echo 0 > /sys/block/zram0/disksize
echo 1 > /sys/block/zram0/max_comp_streams
echo 0 > /sys/block/zram0/disksize
toybox mkswap /dev/block/zram0
toybox swapon /dev/block/zram0
echo 0 > /proc/sys/vm/drop_caches
echo 2048 > /sys/block/sda/queue/read_ahead_kb

#Misc
echo 'N' > /sys/module/sync/parameters/fsync_enabled
echo '0' >/sys/kernel/dyn_fsync/Dyn_fsync_active 

#Fstrim 
fstrim /cache
fstrim /system
fstrim /data

#Davik, Cache
rm -rf /data/dalvik-cache/*

#Swapiness
sleep 10
echo 0 > /proc/sys/vm/swappiness

#Battery
chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo conservative > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
chmod 777 /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo conservative > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
chmod 777 /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo conservative > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
chmod 777 /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
echo conservative > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
chmod 777 /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
echo conservative > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
chmod 777 /sys/devices/system/cpu/cpu5/cpufreq/scaling_governor
echo conservative > /sys/devices/system/cpu/cpu5/cpufreq/scaling_governor
chmod 777 /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
echo conservative > /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
chmod 777 /sys/devices/system/cpu/cpu7/cpufreq/scaling_governor
echo conservative > /sys/devices/system/cpu/cpu7/cpufreq/scaling_governor
chmod 777 /sys/class/kgsl/kgsl-3d0/min_clock_mhz
echo 305 > /sys/class/kgsl/kgsl-3d0/min_clock_mhz
chmod 777 /sys/class/kgsl/kgsl-3d0/devfreq/governor
echo powersave > /sys/class/kgsl/kgsl-3d0/devfreq/governor
chmod 777 /sys/class/kgsl/kgsl-3d0/default_pwrlevel
echo 5 > /sys/class/kgsl/kgsl-3d0/default_pwrlevel
chmod 777 /sys/block/sda/queue/scheduler
echo noop > /sys/block/sda/queue/scheduler