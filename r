#!/data/data/com.termux/files/usr/bin/bash

if [ ! -f /data/data/com.termux/files/usr/bin/wget ]
then
  pkg install wget -y
else
  echo ""
  if [ ! -d /sdcard/Download/ext ]
  then
    	mkdir /sdcard/Download/ext
  fi
  rm -rf /sdcard/Download/ext/temp/*
fi
wget --no-check-certificate -P /sdcard/Download/ext/temp https://github.com/BEACHEADVN/android/archive/master.zip
unzip -qq -o /sdcard/Download/ext/temp/master.zip -d /sdcard/Download/ext/temp
mv -f /sdcard/Download/ext/temp/android-master/* /sdcard/Download/ext/temp
rm -rf /sdcard/Download/ext/temp/android-master
rm /sdcard/Download/ext/temp/master.zip

pkg update -y && pkg upgdare -y

su -c "cp /storage/emulated/0/Download/ext/temp/aov /data/data/com.termux/files/usr/bin"
su -c "chmod 777 /data/data/com.termux/files/usr/bin/aov"
su -c "cp /storage/emulated/0/Download/ext/temp/bt /data/data/com.termux/files/usr/bin"
su -c "chmod 777 /data/data/com.termux/files/usr/bin/bt"
su -c "cp /storage/emulated/0/Download/ext/temp/gi /data/data/com.termux/files/usr/bin"
su -c "chmod 777 /data/data/com.termux/files/usr/bin/gi"
su -c "cp /storage/emulated/0/r /data/data/com.termux/files/usr/bin"
su -c "chmod 777 /data/data/com.termux/files/usr/bin/r"
su -c "cp /storage/emulated/0/Download/ext/temp/pubg /data/data/com.termux/files/usr/bin"
su -c "chmod 777 /data/data/com.termux/files/usr/bin/pubg"

su -c "cp /storage/emulated/0/Download/ext/temp/unpack /data/data/com.termux/files/usr/bin"
su -c "chmod 777 /data/data/com.termux/files/usr/bin/unpack"

su -c "cp /storage/emulated/0/Download/ext/temp/termux /data/data/com.termux/files/usr/bin"
su -c "chmod 777 /data/data/com.termux/files/usr/bin/termux"

su -c "cp /storage/emulated/0/Download/ext/temp/magisk /data/data/com.termux/files/usr/bin"
su -c "chmod 777 /data/data/com.termux/files/usr/bin/magisk"

su -c "cp /storage/emulated/0/Download/ext/temp/ytmanager /data/data/com.termux/files/usr/bin"
su -c "chmod 777 /data/data/com.termux/files/usr/bin/ytmanager"