#!/bin/sh

rm -rf /sdcard/Download/ext/temp/META-INF 2>/dev/null
rm -rf /sdcard/Download/ext/temp/system 2>/dev/null
rm /sdcard/Download/ext/temp/remove1 2>/dev/null
rm /sdcard/Download/ext/temp/remove2 2>/dev/null
rm /sdcard/Download/ext/temp/remove3 2>/dev/null
rm /sdcard/Download/ext/temp/zip 2>/dev/null

unzip -qq -o /sdcard/tweak-evolutionx-capricorn-q.zip -d /sdcard/Download/ext/temp
cat /sdcard/Download/ext/temp/META-INF/com/google/android/updater-script > /sdcard/Download/ext/temp/remove1
awk -i inplace 'NR>y+x{print A[NR%y]} {A[NR%y]=$0}' x=37 y=17 /sdcard/Download/ext/temp/remove1
cat /sdcard/Download/ext/temp/remove1 | sort >> /sdcard/Download/ext/temp/remove2

sed -n -e '1,37p' /sdcard/Download/ext/temp/META-INF/com/google/android/updater-script > /sdcard/Download/ext/temp/updater-script
cat /sdcard/Download/ext/temp/remove2 >> /sdcard/Download/ext/temp/updater-script
tail -n17 /sdcard/Download/ext/temp/META-INF/com/google/android/updater-script >> /sdcard/Download/ext/temp/updater-script
rm /sdcard/Download/ext/temp/META-INF/com/google/android/updater-script 2>/dev/null
mv /sdcard/Download/ext/temp/updater-script /sdcard/Download/ext/temp/META-INF/com/google/android
cd /sdcard/Download/ext/temp
zip -r tweak-evolutionx-capricorn-q.zip META-INF system
rm /sdcard/tweak-evolutionx-capricorn-q.zip 2>/dev/null
mv -f /sdcard/Download/ext/temp/tweak-evolutionx-capricorn-q.zip /sdcard
awk -i inplace '{print substr($0,2)}' /sdcard/Download/ext/temp/remove2
sed -i 's+..$++g' /sdcard/Download/ext/temp/remove2
find /sdcard/Download/ext -name "EvolutionX_*" > /sdcard/Download/ext/temp/zip
awk -i inplace '$0="rm -rf "$0' /sdcard/Download/ext/temp/zip
remove=`cat /sdcard/Download/ext/temp/zip`
awk -v remove="$remove" '{print remove $0}' /sdcard/Download/ext/temp/remove2 > /sdcard/Download/ext/temp/remove3
bash /sdcard/Download/ext/temp/remove3 2>/dev/null

rm -rf /sdcard/Download/ext/temp/META-INF 2>/dev/null
rm -rf /sdcard/Download/ext/temp/system 2>/dev/null
rm /sdcard/Download/ext/temp/remove1 2>/dev/null
rm /sdcard/Download/ext/temp/remove2 2>/dev/null
rm /sdcard/Download/ext/temp/remove3 2>/dev/null
rm /sdcard/Download/ext/temp/zip 2>/dev/null