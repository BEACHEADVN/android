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
su -c "pm disable com.facebook.katana"
su -c "pm disable com.android.deskclock"
su -c "pm disable com.lonelycatgames.Xplore"
su -c "pm disable org.telegram.messenger"
su -c "pm disable com.oasisfeng.greenify"
su -c "pm disable com.android.location.fused"
su -c "pm disable com.google.android.youtube"
su -c "pm disable com.keramidas.TitaniumBackup"
su -c "pm disable com.keramidas.TitaniumBackupAddon"
su -c "pm disable org.lineageos.settings"
su -c "pm disable com.topjohnwu.magisk"
su -c "pm disable com.android.bluetooth"
su -c "pm disable com.android.bluetoothmidiservice"
su -c "pm disable com.android.chrome"
su -c "pm disable com.android.theme.icon_pack.rounded.android"
su -c "pm disable com.android.theme.icon_pack.rounded.themepicker"
su -c "pm disable com.android.theme.icon_pack.rounded.launcher"
su -c "pm disable com.android.theme.icon_pack.rounded.systemui"
su -c "pm disable com.android.theme.icon_pack.rounded.settings"
su -c "pm disable com.android.theme.icon.squircle"
su -c "pm disable com.android.storagemanager"
su -c "pm disable com.android.providers.downloads"

killall -9 com.termux