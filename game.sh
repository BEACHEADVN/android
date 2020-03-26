#!/bin/bash

echo "GAME "
echo "1. Liên quân Mobile"
echo "2. PUBG Mobile VN"
echo "3. Phục hồi"
echo "Nhập số từ 1-3 (nhấn x để quay lại Menu):"
read game

case $game in
	1)
		sh /sdcard/Download/ext/temp/performance.sh
		pm disable com.VCB
		pm disable com.adguard.android
		pm disable com.android.chrome
		pm disable com.android.deskclock
		pm disable com.android.documentsui
		pm disable com.epi
		pm disable com.facebook.katana
		pm disable com.facebook.orca
		pm disable com.google.android.youtube
		pm disable com.keramidas.TitaniumBackup
		pm disable com.keramidas.TitaniumBackupAddon
		pm disable com.lonelycatgames.Xplore
		pm disable com.mgoogle.android.gms
		pm disable com.oasisfeng.greenify
		pm disable com.rhmsoft.edit
		pm disable com.topjohnwu.magisk
		pm disable com.vanced.android.youtube
		pm disable com.vng.pubgmobile
		pm disable g7.lockscreenroot
		pm disable org.telegram.messenger
		am start -a android.intent.action.MAIN -n com.garena.game.kgvn/com.garena.game.kgtw.BlankActivity
		pm disable com.topjohnwu.magisk
                pm disable com.termux
	;;
	2)
		sh /sdcard/Download/ext/temp/performance.sh
		pm disable com.VCB
		pm disable com.adguard.android
		pm disable com.android.chrome
		pm disable com.android.deskclock
		pm disable com.android.documentsui
		pm disable com.epi
		pm disable com.facebook.katana
		pm disable com.facebook.orca
		pm disable com.garena.game.kgvn
		pm disable com.google.android.youtube
		pm disable com.keramidas.TitaniumBackup
		pm disable com.keramidas.TitaniumBackupAddon
		pm disable com.lonelycatgames.Xplore
		pm disable com.mgoogle.android.gms
		pm disable com.oasisfeng.greenify
		pm disable com.rhmsoft.edit
		pm disable com.topjohnwu.magisk
		pm disable com.vanced.android.youtube
		pm disable g7.lockscreenroot
		pm disable org.telegram.messenger
		am start -a android.intent.action.MAIN -n com.vng.pubgmobile/com.epicgames.ue4.SplashActivity
		pm disable com.topjohnwu.magisk
                pm disable com.termux
	;;
	3)
                pm enable com.topjohnwu.magisk
		pm enable com.adguard.android
		pm enable com.android.chrome
		pm enable com.android.deskclock
		pm enable com.android.documentsui
		pm enable com.epi
		pm enable com.facebook.katana
		pm enable com.facebook.orca
		pm enable com.garena.game.kgvn
		pm enable com.keramidas.TitaniumBackup
		pm enable com.keramidas.TitaniumBackupAddon
		pm enable com.lonelycatgames.Xplore
		pm enable com.mgoogle.android.gms
		pm enable com.oasisfeng.greenify
		pm enable com.rhmsoft.edit
		pm enable com.topjohnwu.magisk
		pm enable com.vanced.android.youtube && pm enable com.google.android.youtube
		pm enable com.vng.pubgmobile
		pm enable g7.lockscreenroot
		pm enable org.telegram.messenger
		am start -a android.intent.action.MAIN -n com.facebook.katana/com.facebook.katana.LoginActivity
		sleep 3
		am start -a android.intent.action.MAIN -n com.facebook.orca/com.facebook.messaging.auth.LaunchScreenActivity
		sleep 3
		am start -a android.intent.action.MAIN -n com.keramidas.TitaniumBackup/com.keramidas.TitaniumBackup.MainActivity
		sleep 2
		sh /sdcard/Download/ext/temp/battery.sh
		killall -9 com.termux
	;;
	x)
		bash /sdcard/Download/ext/temp/menu.sh
	;;
esac
