#!/data/data/com.termux/files/usr/bin/bash

function install {
	if [ ! -f /data/data/com.termux/files/usr/bin/$i ]
	then
		echo $i >> /storage/emulated/0/Download/ext/temp/install_termux
	else
		echo ""
	fi
}

for i in wget aapt perl zip
do
	install
done

install=`cat /storage/emulated/0/Download/ext/temp/install_termux 2>/dev/null`
pkg install $install -y

wget --no-check-certificate -P /storage/emulated/0/Download/ext/temp https://github.com/BEACHEADVN/android/archive/master.zip
unzip -qq -o /storage/emulated/0/Download/ext/temp/master.zip -d /storage/emulated/0/Download/ext/temp
mv -f /storage/emulated/0/Download/ext/temp/android-master/* /storage/emulated/0/Download/ext/temp
rm -rf /storage/emulated/0/Download/ext/temp/android-master
rm /storage/emulated/0/Download/ext/temp/master.zip

pkg update -y && pkg upgdare -y

function command {
su -c "cp /storage/emulated/0/Download/ext/temp/$i /data/data/com.termux/files/usr/bin"
su -c "chmod 777 /data/data/com.termux/files/usr/bin/$i"
}

for i in aov bt gi r unpack termux magisk ytm gps core tcl adaway
do
	command
done

rm -rf /storage/emulated/0/Download/ext/temp/install_termux
