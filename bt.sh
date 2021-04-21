x=0
while [ $x -le 7 ]
do
   su -c "chmod 777 /sys/devices/system/cpu/cpu$x/cpufreq/scaling_governor"
   su -c "echo conservative > /sys/devices/system/cpu/cpu$x/cpufreq/scaling_governor"
   x=$(( $x + 1 ))
done

su -c "chmod 777 /sys/class/kgsl/kgsl-3d0/min_clock_mhz"
su -c "echo 305 > /sys/class/kgsl/kgsl-3d0/min_clock_mhz"
su -c "chmod 777 /sys/class/kgsl/kgsl-3d0/devfreq/governor"
su -c "echo powersave > /sys/class/kgsl/kgsl-3d0/devfreq/governor"
su -c "chmod 777 /sys/class/kgsl/kgsl-3d0/default_pwrlevel"
su -c "echo 5 > /sys/class/kgsl/kgsl-3d0/default_pwrlevel"

su -c "chmod 777 /sys/block/sda/queue/scheduler"
su -c "echo noop > /sys/block/sda/queue/scheduler"

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
su -c "pm enable com.miHoYo.GenshinImpact"
su -c "pm enable com.garena.game.kgvn"
su -c "pm disable com.jairath.ccaster"
su -c "pm disable com.google.android.play.games"
su -c "pm disable com.vng.pubgmobile"

a=`su -c "cat /sys/class/kgsl/kgsl-3d0/devfreq/governor"`
if [ $a != 'powersave' ]
then
     su -c "sh /sdcard/Download/ext/temp/powersave"
else
      su -c "am start --user 0 -n org.swiftapps.swiftbackup/org.swiftapps.swiftbackup.intro.IntroActivity"
      su -c "killall -9 com.termux"
fi
