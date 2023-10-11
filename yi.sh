#!/data/data/com.termux/files/usr/bin/bash

rm -rf /storage/emulated/0/Download/ext/temp/jar
mkdir -p /storage/emulated/0/Download/ext/temp/jar
path="/data/data/com.termux/files/home/revancify-data"
su -c "find $path -type f -name '*patches*.jar' | sed 's+/data/data/com.termux/files/home/revancify-data/++g'" > /storage/emulated/0/Download/ext/temp/jar/path_jar.txt

function unjar {
	name=`cat /storage/emulated/0/Download/ext/temp/jar/patch$chon.txt`
	jar_name=`sed 's/.\{4\}$//' <<< "$name"`
	rm -rf /storage/emulated/0/Download/ext/temp/jar
	mkdir -p /storage/emulated/0/Download/ext/temp/jar
	mkdir -p /storage/emulated/0/Download/ext/temp/jar/$jar_name
	cp -rf $path/$name /sdcard/Download/ext/temp/jar/$jar_name
	cd /sdcard/Download/ext/temp/jar/$jar_name
	jar -xvf $name
	rm -rf /sdcard/Download/ext/temp/jar/$jar_name/$name
	cd /sdcard/Download/ext/temp/jar/$jar_name
	bundle=`ls -1 | tr '\n' ' '`
}

function jar_icon_red {
	jar_afn_red=revanced-patches-2.173.10
	mkdir -p /storage/emulated/0/Download/ext/temp/jar/$jar_afn_red
	wget --no-check-certificate -P /storage/emulated/0/Download/ext/temp/jar/$jar_afn_red https://github.com/BEACHEADVN/android/archive/refs/heads/termux_bin.zip
	unzip -qq -o /storage/emulated/0/Download/ext/temp/jar/$jar_afn_red/termux_bin.zip -d /storage/emulated/0/Download/ext/temp/jar/$jar_afn_red
	cp -rf /storage/emulated/0/Download/ext/temp/jar/$jar_afn_red/android-termux_bin/$jar_afn_red.jar /storage/emulated/0/Download/ext/temp/jar/$jar_afn_red
	rm -rf /storage/emulated/0/Download/ext/temp/jar/$jar_afn_red/android-termux_bin
	rm -rf /storage/emulated/0/Download/ext/temp/jar/$jar_afn_red/termux_bin.zip
	cd /storage/emulated/0/Download/ext/temp/jar/$jar_afn_red
	jar -xvf $jar_afn_red.jar
}


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

check=`cat /storage/emulated/0/Download/ext/temp/jar/patch$chon.txt`
check_source=${check%-patch*}
if [ $check_source = YT-Advanced ]
then
	echo "•Patch source YT-Advanced"
	unjar
	jar_icon_red
	cp -rf /storage/emulated/0/Download/ext/temp/jar/$jar_afn_red/youtube/branding/afn-red/* /storage/emulated/0/Download/ext/temp/jar/$jar_name/youtube/branding/mmt
	cp -rf /storage/emulated/0/Download/ext/temp/jar/$jar_afn_red/youtube/branding/afn-red/* /storage/emulated/0/Download/ext/temp/jar/$jar_name/youtube/branding/revancify-blue
	cp -rf /storage/emulated/0/Download/ext/temp/jar/$jar_afn_red/youtube/branding/afn-red/* /storage/emulated/0/Download/ext/temp/jar/$jar_name/youtube/branding/revancify-red
	cd /sdcard/Download/ext/temp/jar/$jar_name
	jar cf $name $bundle
	rm -rf $path/$name
	cp -rf /sdcard/Download/ext/temp/jar/$jar_name/$name /data/data/com.termux/files/home/revancify-data
elif [ $check_source = inotia00 ]
then
	echo "•Patch source inotia00"
	unjar
	jar_icon_red
	cp -rf /storage/emulated/0/Download/ext/temp/jar/$jar_afn_red/youtube/branding/afn-red/* /storage/emulated/0/Download/ext/temp/jar/$jar_name/youtube/branding/mmt
	cp -rf /storage/emulated/0/Download/ext/temp/jar/$jar_afn_red/youtube/branding/afn-red/* /storage/emulated/0/Download/ext/temp/jar/$jar_name/youtube/branding/revancify-blue
	cp -rf /storage/emulated/0/Download/ext/temp/jar/$jar_afn_red/youtube/branding/afn-red/* /storage/emulated/0/Download/ext/temp/jar/$jar_name/youtube/branding/revancify-red
	cd /sdcard/Download/ext/temp/jar/$jar_name
	jar cf $name $bundle
	rm -rf $path/$name
	cp -rf /sdcard/Download/ext/temp/jar/$jar_name/$name /data/data/com.termux/files/home/revancify-data
elif [ $check_source = revanced ]
then
	echo "•Patch source Revanced"
	unjar
	jar_icon_red
	cp -rf /storage/emulated/0/Download/ext/temp/jar/revanced-patches-2.173.10/youtube/branding/afn-red/launchericon/hdpi/* /storage/emulated/0/Download/ext/temp/jar/$jar_name/branding/mipmap-hdpi
	cp -rf /storage/emulated/0/Download/ext/temp/jar/revanced-patches-2.173.10/youtube/branding/afn-red/launchericon/mdpi/* /storage/emulated/0/Download/ext/temp/jar/$jar_name/branding/mipmap-mdpi
	cp -rf /storage/emulated/0/Download/ext/temp/jar/revanced-patches-2.173.10/youtube/branding/afn-red/launchericon/xhdpi/* /storage/emulated/0/Download/ext/temp/jar/$jar_name/branding/mipmap-xhdpi
	cp -rf /storage/emulated/0/Download/ext/temp/jar/revanced-patches-2.173.10/youtube/branding/afn-red/launchericon/xxhdpi/* /storage/emulated/0/Download/ext/temp/jar/$jar_name/branding/mipmap-xxhdpi
	cp -rf /storage/emulated/0/Download/ext/temp/jar/revanced-patches-2.173.10/youtube/branding/afn-red/launchericon/xxxhdpi/* /storage/emulated/0/Download/ext/temp/jar/$jar_name/branding/mipmap-xxxhdpi
	jar cf $name $bundle
	rm -rf $path/$name
	cp -rf /sdcard/Download/ext/temp/jar/$jar_name/$name /data/data/com.termux/files/home/revancify-data
fi

rm -rf /storage/emulated/0/Download/ext/temp/jar
echo `date +"%r, %a, ngày %d, tháng %m, năm %Y"` >> /storage/emulated/0/Download/ext/temp/log.txt
echo "•Da va patch $name" > /storage/emulated/0/Download/ext/temp/log.txt
sed -i 's/ PM,/ CH,/g; s/ AM,/ SA,/g; s/ Mon, / thứ Hai, /g; s/ Tue, / thứ Ba, /g; s/ Wed, / thứ Tư, /g; s/ Thur, / thứ Năm, /g; s/ Fri, / thứ Sáu, /g; s/ Sat, / thứ Bảy, /g; s/ Sun, / Chủ nhật, /g' /storage/emulated/0/Download/ext/temp/log.txt
clear
echo "•Da va patch $name"