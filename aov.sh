x=0
while [ $x -le 7 ]
do
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

su -c "chmod 777 /sys/block/sda/queue/scheduler"
su -c "echo deadline > /sys/block/sda/queue/scheduler"

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
su -c "pm disable com.miHoYo.GenshinImpact"
su -c "pm disable com.epi"
su -c "pm disable com.VCB"

a=`su -c "cat /sys/class/kgsl/kgsl-3d0/devfreq/governor"`
if [ $a != 'msm-adreno-tz' ]
then
     su -c "sh /sdcard/Download/ext/temp/aov_msm-adreno-tz"
else
      su -c "am start --user 0 -n com.garena.game.kgvn/com.garena.game.kgtw.SGameActivity"
      su -c "killall -9 com.termux"
fi
