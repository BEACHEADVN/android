#!/data/data/com.termux/files/usr/bin/bash

function install {
	if [ ! -f /data/data/com.termux/files/usr/bin/$package ]
	then
		echo $package >> /sdcard/Download/ext/temp/install_termux
	else
		echo ""
	fi
}

for i in wget aapt perl zip
do
	package=$i
	install
done

install=`cat /sdcard/Download/ext/temp/install_termux 2>/dev/null`
pkg install $install -y

wget --no-check-certificate -P /sdcard/Download/ext/temp https://github.com/BEACHEADVN/android/archive/master.zip
unzip -qq -o /sdcard/Download/ext/temp/master.zip -d /sdcard/Download/ext/temp
mv -f /sdcard/Download/ext/temp/android-master/* /sdcard/Download/ext/temp
rm -rf /sdcard/Download/ext/temp/android-master
rm /sdcard/Download/ext/temp/master.zip

pkg update -y && pkg upgdare -y

function command {
su -c "cp /storage/emulated/0/Download/ext/temp/$cl /data/data/com.termux/files/usr/bin"
su -c "chmod 777 /data/data/com.termux/files/usr/bin/$cl"
}

for i in aov bt gi r unpack termux magisk ytmanager gps core tcl adaway
do
	cl=$i
	command
done

rm -rf /sdcard/Download/ext/temp/install_termux