#!/data/data/com.termux/files/usr/bin/bash

rm -rf /storage/emulated/0/Download/ext/temp/jar
mkdir -p /storage/emulated/0/Download/ext/temp/jar
path="/data/data/com.termux/files/home/revancify-data"
su -c "find $path -type f -name '*patches*.jar' | sed 's+/data/data/com.termux/files/home/revancify-data/++g'" > /storage/emulated/0/Download/ext/temp/jar/path_jar.txt

c=`wc -l < /storage/emulated/0/Download/ext/temp/jar/path_jar.txt`

for (( i=1; i<=$c; i++ ))
do 
   sed -n "$i"p /storage/emulated/0/Download/ext/temp/jar/path_jar.txt > /storage/emulated/0/Download/ext/temp/jar/patch$i.txt
done

clear
echo "•Chon patch can va:"
for (( i=1; i<=$c; i++ ))
do
echo "$i. `cat /storage/emulated/0/Download/ext/temp/jar/patch$i.txt`"
done
echo "Nhập số từ 1-$c:"
read chon

if [ $chon = 1 ]
then
	name=`cat /storage/emulated/0/Download/ext/temp/jar/patch1.txt`
	echo "•Ban chon $name"
elif [ $chon = 2 ]
then
	name=`cat /storage/emulated/0/Download/ext/temp/jar/patch2.txt`
	echo "•Ban chon $name"
elif [ $chon = 3 ]
then
	name=`cat /storage/emulated/0/Download/ext/temp/jar/patch3.txt`
	echo "•Ban chon $name"
fi
jar_name=`sed 's/.\{4\}$//' <<< "$name"`
rm -rf /storage/emulated/0/Download/ext/temp/jar
mkdir -p /storage/emulated/0/Download/ext/temp/jar
mkdir -p /storage/emulated/0/Download/ext/temp/jar/$jar_name
cp -rf $path/$name /sdcard/Download/ext/temp/jar/$jar_name
cd /sdcard/Download/ext/temp/jar/$jar_name
jar -xvf $name
rm -rf /sdcard/Download/ext/temp/jar/$jar_name/$name
for i in mmt revancify-blue revancify-red
do
	cd /sdcard/Download/ext/temp/jar/$jar_name/youtube/branding/$i
	rm -rf launchericon
	rm -rf monochromeicon
	rm -rf splashicon
done

jar_afn_red=revanced-patches-2.173.10
mkdir -p /storage/emulated/0/Download/ext/temp/jar/$jar_afn_red
wget --no-check-certificate -P /storage/emulated/0/Download/ext/temp/jar/$jar_afn_red https://github.com/BEACHEADVN/android/archive/refs/heads/termux_bin.zip
unzip -qq -o /storage/emulated/0/Download/ext/temp/jar/$jar_afn_red/termux_bin.zip -d /storage/emulated/0/Download/ext/temp/jar/$jar_afn_red
cp -rf /storage/emulated/0/Download/ext/temp/jar/$jar_afn_red/android-termux_bin/$jar_afn_red.jar /storage/emulated/0/Download/ext/temp/jar/$jar_afn_red
rm -rf /storage/emulated/0/Download/ext/temp/jar/$jar_afn_red/android-termux_bin
rm -rf /storage/emulated/0/Download/ext/temp/jar/$jar_afn_red/termux_bin.zip
cd /storage/emulated/0/Download/ext/temp/jar/$jar_afn_red
jar -xvf $jar_afn_red.jar

cp -rf /storage/emulated/0/Download/ext/temp/jar/$jar_afn_red/youtube/branding/afn-red/* /storage/emulated/0/Download/ext/temp/jar/$jar_name/youtube/branding/mmt
cp -rf /storage/emulated/0/Download/ext/temp/jar/$jar_afn_red/youtube/branding/afn-red/* /storage/emulated/0/Download/ext/temp/jar/$jar_name/youtube/branding/revancify-blue
cp -rf /storage/emulated/0/Download/ext/temp/jar/$jar_afn_red/youtube/branding/afn-red/* /storage/emulated/0/Download/ext/temp/jar/$jar_name/youtube/branding/revancify-red

cd /sdcard/Download/ext/temp/jar/$jar_name
jar cf $name app META-INF music youtube classes.dex
rm -rf $path/$name
cp -rf /sdcard/Download/ext/temp/jar/$jar_name/$name /data/data/com.termux/files/home/revancify-data

rm -rf /storage/emulated/0/Download/ext/temp/jar
echo "•Da va patch $name" > /storage/emulated/0/Download/ext/temp/log.txt
clear
echo "•Da va patch $name"