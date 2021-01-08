su -c "chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"
su -c "echo conservative > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"
su -c "chmod 777 /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor"
su -c "echo conservative > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor"
su -c "chmod 777 /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor"
su -c "echo conservative > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor"
su -c "chmod 777 /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor"
su -c "echo conservative > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor"
su -c "chmod 777 /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor"
su -c "echo conservative > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor"
su -c "chmod 777 /sys/devices/system/cpu/cpu5/cpufreq/scaling_governor"
su -c "echo conservative > /sys/devices/system/cpu/cpu5/cpufreq/scaling_governor"
su -c "chmod 777 /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor"
su -c "echo conservative > /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor"
su -c "chmod 777 /sys/devices/system/cpu/cpu7/cpufreq/scaling_governor"
su -c "echo conservative > /sys/devices/system/cpu/cpu7/cpufreq/scaling_governor"

su -c "chmod 777 /sys/class/kgsl/kgsl-3d0/min_clock_mhz"
su -c "echo 275 > /sys/class/kgsl/kgsl-3d0/min_clock_mhz"
su -c "chmod 777 /sys/class/kgsl/kgsl-3d0/devfreq/governor"
su -c "echo powersave > /sys/class/kgsl/kgsl-3d0/devfreq/governor"

su -c "chmod 777 /sys/class/kgsl/kgsl-3d0/default_pwrlevel"
su -c "echo 3 > /sys/class/kgsl/kgsl-3d0/default_pwrlevel"

su -c "pm enable com.android.vending"
su -c "pm enable com.android.deskclock"
su -c "pm enable com.android.providers.downloads"
su -c "pm enable com.facebook.katana"
su -c "pm enable com.android.deskclock"
su -c "pm enable com.lonelycatgames.Xplore"
su -c "pm enable org.telegram.messenger"
su -c "pm enable com.oasisfeng.greenify"
su -c "pm enable com.google.android.youtube"


su -c "pm enable com.topjohnwu.magisk"
su -c "pm enable com.android.bluetooth"
su -c "pm enable com.android.bluetoothmidiservice"
su -c "pm enable com.android.chrome"
su -c "pm enable org.swiftapps.swiftbackup"
su -c "pm enable com.android.camera"

a=`su -c "cat /sys/class/kgsl/kgsl-3d0/devfreq/governor"`
if [ $a != 'powersave' ]
then
     su -c "sh /sdcard/Download/ext/temp/powersave"
else
      killall -9 com.termux
fi