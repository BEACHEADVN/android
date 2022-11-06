#!/data/data/com.termux/files/usr/bin/bash

if [ ! -d /sdcard/Download/ext/temp ]
then
	mkdir -p /sdcard/Download/ext/temp
fi

for i in wget aapt perl zip
do
	if [ ! -f /data/data/com.termux/files/usr/bin/$i ]
	then
		echo $i >> /sdcard/Download/ext/temp/install_termux
	fi
done

if [ -f /sdcard/Download/ext/temp/install_termux ]
then
	install=`cat /sdcard/Download/ext/temp/install_termux 2>/dev/null`
	pkg install $install -y
fi

cd /sdcard/Download/ext/temp && ls | grep -v 'log' | xargs rm

wget --no-check-certificate -P /sdcard/Download/ext/temp https://github.com/BEACHEADVN/android/archive/refs/heads/termux_bin.zip
unzip -qq -o /sdcard/Download/ext/temp/termux_bin.zip -d /sdcard/Download/ext/temp
mv -f /sdcard/Download/ext/temp/android-termux_bin/* /sdcard/Download/ext/temp
rm -rf /sdcard/Download/ext/temp/android-termux_bin
rm /sdcard/Download/ext/temp/termux_bin.zip

pkg update -y && pkg upgdare -y && apt autoremove -y

function command {
su -c "cp /storage/emulated/0/Download/ext/temp/$i /data/data/com.termux/files/usr/bin"
su -c "chmod 777 /data/data/com.termux/files/usr/bin/$i"
}

for i in aov bt gi r termux magisk ytm core adaway ra
do
	if [ ! -f /storage/emulated/0/Download/ext/temp/$i ]
	then
		echo "$i command not found in temp folder. Cannot copy!"
	else
		command
	fi
done

if [ -f /sdcard/Download/ext/temp/install_termux ]
then
	rm -rf /sdcard/Download/ext/temp/install_termux
fi

if [ ! -f /storage/emulated/0/Download/ext/temp/r ]
	then
		bash /sdcard/r
	fi