#!/bin/bash

echo "GAME "
echo "1. Liên quân Mobile"
echo "2. Don't Starve"
echo "3. Phục hồi"
echo "Nhập số từ 1-3 (nhấn x để quay lại Menu):"
read game

case $game in
	1)
		sh /sdcard/Download/ext/temp/performance.sh
		pm disable com.VCB
		pm disable com.adguard.android
		pm disable com.android.chrome
		pm disable com.android.documentsui
		pm disable com.epi
		pm disable com.facebook.katana
		pm disable com.facebook.orca
		pm disable com.google.android.deskclock
		pm disable com.google.android.youtube
		pm disable com.keramidas.TitaniumBackup
		pm disable com.keramidas.TitaniumBackupAddon
		pm disable com.lonelycatgames.Xplore
		pm disable com.mgoogle.android.gms
		pm disable com.oasisfeng.greenify
		pm disable com.rhmsoft.edit
		pm disable com.topjohnwu.magisk
		pm disable com.topjohnwu.magisk
		pm disable catch_.me_.if_.you_.can_
		pm disable com.vanced.android.youtube
		pm disable com.vng.inputmethod.labankey
		pm disable com.vng.pubgmobile
		pm disable com.kleientertainment.doNotStarvePocket
		pm disable g7.lockscreenroot
		pm disable org.telegram.messenger
		pm enable com.garena.game.kgvn
		pm disable com.facebook.games
		pm enable com.vng.inputmethod.labankey
		am start -a android.intent.action.MAIN -n com.garena.game.kgvn/com.garena.game.kgtw.BlankActivity
		pm disable com.termux
	;;
	2)
		sh /sdcard/Download/ext/temp/performance.sh
		pm disable com.VCB
		pm disable com.adguard.android
		pm disable com.android.chrome
		pm disable com.android.documentsui
		pm disable com.epi
		pm disable com.facebook.katana
		pm disable com.facebook.orca
		pm disable com.garena.game.kgvn
		pm disable com.google.android.deskclock
		pm disable com.google.android.youtube
		pm disable com.keramidas.TitaniumBackup
		pm disable com.keramidas.TitaniumBackupAddon
		pm disable com.lonelycatgames.Xplore
		pm disable com.mgoogle.android.gms
		pm disable com.oasisfeng.greenify
		pm disable com.rhmsoft.edit
		pm disable com.topjohnwu.magisk
		pm disable com.vng.codmvn
		pm disable com.vanced.android.youtube
		pm disable com.vng.inputmethod.labankey
		pm disable g7.lockscreenroot
		pm disable org.telegram.messenger
		pm enable com.vng.inputmethod.labankey
		pm disable com.moonactive.coinmaster
		pm disable com.edditionstudio.spinsandcoins.dailynews
		pm disable com.facebook.games
		pm enable com.kleientertainment.doNotStarvePocket
		pm enable catch_.me_.if_.you_.can_
		am start -a android.intent.action.MAIN -n catch_.me_.if_.you_.can_/catch_.me_.if_.you_.can_.MainActivity
		am start -a android.intent.action.MAIN -n com.kleientertainment.doNotStarvePocket/com.kleientertainment.doNotStarvePocket.DoNotStarveActivity
		pm disable com.termux
	;;
	3)
		pm disable com.garena.game.kgvn
		pm disable com.noodlecake.altosodyssey
		pm disable catch_.me_.if_.you_.can_
		pm enable com.adguard.android
		pm enable com.android.chrome
		pm enable com.epi
		pm enable com.facebook.games
		pm enable com.facebook.katana
		pm enable com.facebook.orca
		pm enable com.google.android.deskclock
		pm enable com.keramidas.TitaniumBackup
		pm enable com.keramidas.TitaniumBackupAddon
		pm enable com.lonelycatgames.Xplore
		pm enable com.mgoogle.android.gms
		pm enable com.oasisfeng.greenify
		pm enable com.rhmsoft.edit
		pm enable com.topjohnwu.magisk
		pm enable com.topjohnwu.magisk
		pm enable com.vanced.android.youtube
		pm enable g7.lockscreenroot
		pm disable com.kleientertainment.doNotStarvePocket
		pm enable org.telegram.messenger
		pm disable com.moonactive.coinmaster
		pm disable com.edditionstudio.spinsandcoins.dailynews
		am start -a android.intent.action.MAIN -n com.facebook.katana/com.facebook.katana.LoginActivity
		sleep 2
		am start -a android.intent.action.MAIN -n com.facebook.orca/com.facebook.messaging.auth.LaunchScreenActivity
		sleep 2
		am start -a android.intent.action.MAIN -n com.keramidas.TitaniumBackup/com.keramidas.TitaniumBackup.MainActivity
		sleep 2
		sh /sdcard/Download/ext/temp/battery.sh
		killall -9 com.termux
    ;;
	x)
		bash /sdcard/Download/ext/temp/menu.sh
	;;
esac
