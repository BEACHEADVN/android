chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
chmod 777 /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo performance > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
chmod 777 /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo performance > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
chmod 777 /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
echo performance > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
chmod 777 /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
echo performance > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
chmod 777 /sys/devices/system/cpu/cpu5/cpufreq/scaling_governor
echo performance > /sys/devices/system/cpu/cpu5/cpufreq/scaling_governor
chmod 777 /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
echo performance > /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
chmod 777 /sys/devices/system/cpu/cpu7/cpufreq/scaling_governor
echo performance > /sys/devices/system/cpu/cpu7/cpufreq/scaling_governor

chmod 777 /sys/class/kgsl/kgsl-3d0/min_clock_mhz
echo 625 > /sys/class/kgsl/kgsl-3d0/min_clock_mhz
chmod 777 /sys/class/kgsl/kgsl-3d0/devfreq/governor
echo performance > /sys/class/kgsl/kgsl-3d0/devfreq/governor

chmod 777 /sys/class/kgsl/kgsl-3d0/default_pwrlevel
echo 1 > /sys/class/kgsl/kgsl-3d0/default_pwrlevel

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

killall -9 com.termux
