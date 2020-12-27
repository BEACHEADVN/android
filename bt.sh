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
echo 275 > /sys/class/kgsl/kgsl-3d0/min_clock_mhz
chmod 777 /sys/class/kgsl/kgsl-3d0/devfreq/governor
echo powersave > /sys/class/kgsl/kgsl-3d0/devfreq/governor

chmod 777 /sys/class/kgsl/kgsl-3d0/default_pwrlevel
echo 3 > /sys/class/kgsl/kgsl-3d0/default_pwrlevel

su -c "pm enable com.android.vending"
su -c "pm enable com.facebook.katana"
su -c "pm enable com.android.deskclock"
su -c "pm enable com.lonelycatgames.Xplore"
su -c "pm enable org.telegram.messenger"
su -c "pm enable com.oasisfeng.greenify"
su -c "pm enable com.android.location.fused"
su -c "pm enable com.google.android.youtube"
su -c "pm enable com.keramidas.TitaniumBackup"
su -c "pm enable com.keramidas.TitaniumBackupAddon"
su -c "pm enable org.lineageos.settings"
su -c "pm enable com.topjohnwu.magisk"
su -c "pm enable com.android.bluetooth"
su -c "pm enable com.android.bluetoothmidiservice"
su -c "pm enable com.android.chrome"
su -c "pm enable com.android.theme.icon_pack.rounded.android"
su -c "pm enable com.android.theme.icon_pack.rounded.themepicker"
su -c "pm enable com.android.theme.icon_pack.rounded.launcher"
su -c "pm enable com.android.theme.icon_pack.rounded.systemui"
su -c "pm enable com.android.theme.icon_pack.rounded.settings"
su -c "pm enable com.android.theme.icon.squircle"
su -c "pm enable com.android.storagemanager"
su -c "pm enable com.android.providers.downloads"

killall -9 com.termux
