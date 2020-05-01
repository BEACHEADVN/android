#!/bin/sh

rm -rf /sdcard/Download/ext/temp/META-INF 2>/dev/null
rm -rf /sdcard/Download/ext/temp/system 2>/dev/null
rm /sdcard/Download/ext/temp/remove1 2>/dev/null
rm /sdcard/Download/ext/temp/remove2 2>/dev/null
rm /sdcard/Download/ext/temp/remove3 2>/dev/null
rm /sdcard/Download/ext/temp/remove4 2>/dev/null
rm /sdcard/Download/ext/temp/remove5 2>/dev/null
rm /sdcard/Download/ext/temp/remove6 2>/dev/null
rm /sdcard/Download/ext/temp/zip 2>/dev/null
rm /sdcard/Download/ext/temp/zip1 2>/dev/null
rm /sdcard/Download/ext/temp/zip2 2>/dev/null

unzip -qq -o /sdcard/tweak-havoc-capricorn-q-part1.zip -d /sdcard/Download/ext/temp
cat /sdcard/Download/ext/temp/META-INF/com/google/android/updater-script > /sdcard/Download/ext/temp/remove1
awk -i inplace 'NR>y+x{print A[NR%y]} {A[NR%y]=$0}' x=37 y=19 /sdcard/Download/ext/temp/remove1
cat /sdcard/Download/ext/temp/remove1 | sort >> /sdcard/Download/ext/temp/remove2

sed -n -e '1,37p' /sdcard/Download/ext/temp/META-INF/com/google/android/updater-script > /sdcard/Download/ext/temp/updater-script
cat /sdcard/Download/ext/temp/remove2 >> /sdcard/Download/ext/temp/updater-script
tail -n19 /sdcard/Download/ext/temp/META-INF/com/google/android/updater-script >> /sdcard/Download/ext/temp/updater-script
rm /sdcard/Download/ext/temp/META-INF/com/google/android/updater-script 2>/dev/null
mv /sdcard/Download/ext/temp/updater-script /sdcard/Download/ext/temp/META-INF/com/google/android
cd /sdcard/Download/ext/temp
zip -r tweak-havoc-capricorn-q-part1.zip META-INF system
rm /sdcard/tweak-havoc-capricorn-q-part1.zip 2>/dev/null
mv -f /sdcard/Download/ext/temp/tweak-havoc-capricorn-q-part1.zip /sdcard
awk -i inplace '{print substr($0,2)}' /sdcard/Download/ext/temp/remove2
sed -i 's+..$++g' /sdcard/Download/ext/temp/remove2
find /sdcard/Download/ext -name "Havoc-OS*" > /sdcard/Download/ext/temp/zip1
awk -i inplace '$0="rm -rf "$0' /sdcard/Download/ext/temp/zip1
remove=`cat /sdcard/Download/ext/temp/zip1`
awk -v remove="$remove" '{print remove $0}' /sdcard/Download/ext/temp/remove2 > /sdcard/Download/ext/temp/remove3
bash /sdcard/Download/ext/temp/remove3 2>/dev/null

rm -rf /sdcard/Download/ext/temp/META-INF 2>/dev/null
rm -rf /sdcard/Download/ext/temp/system 2>/dev/null


unzip -qq -o /sdcard/tweak-havoc-capricorn-q-part2.zip -d /sdcard/Download/ext/temp
cat /sdcard/Download/ext/temp/META-INF/com/google/android/updater-script > /sdcard/Download/ext/temp/remove4
awk -i inplace 'NR>y+x{print A[NR%y]} {A[NR%y]=$0}' x=37 y=15 /sdcard/Download/ext/temp/remove4
cat /sdcard/Download/ext/temp/remove4 | sort >> /sdcard/Download/ext/temp/remove5
sed -n -e '1,37p' /sdcard/Download/ext/temp/META-INF/com/google/android/updater-script > /sdcard/Download/ext/temp/updater-script
cat /sdcard/Download/ext/temp/remove5 >> /sdcard/Download/ext/temp/updater-script
tail -n15 /sdcard/Download/ext/temp/META-INF/com/google/android/updater-script >> /sdcard/Download/ext/temp/updater-script
rm /sdcard/Download/ext/temp/META-INF/com/google/android/updater-script 2>/dev/null
mv /sdcard/Download/ext/temp/updater-script /sdcard/Download/ext/temp/META-INF/com/google/android
zip -r tweak-havoc-capricorn-q-part2.zip META-INF system
rm /sdcard/tweak-havoc-capricorn-q-part2.zip
mv -f /sdcard/Download/ext/temp/tweak-havoc-capricorn-q-part2.zip /sdcard

awk -i inplace '{print substr($0,2)}' /sdcard/Download/ext/temp/remove5
sed -i 's+..$++g' /sdcard/Download/ext/temp/remove5
find /sdcard/Download/ext -name "Havoc-OS*" > /sdcard/Download/ext/temp/zip2
awk -i inplace '$0="rm -rf "$0' /sdcard/Download/ext/temp/zip2
remove=`cat /sdcard/Download/ext/temp/zip2`
awk -v remove="$remove" '{print remove $0}' /sdcard/Download/ext/temp/remove5 > /sdcard/Download/ext/temp/remove6
bash /sdcard/Download/ext/temp/remove6 2>/dev/null

rm -rf /sdcard/Download/ext/temp/META-INF 2>/dev/null
rm -rf /sdcard/Download/ext/temp/system 2>/dev/null
rm /sdcard/Download/ext/temp/remove1 2>/dev/null
rm /sdcard/Download/ext/temp/remove2 2>/dev/null
rm /sdcard/Download/ext/temp/remove3 2>/dev/null
rm /sdcard/Download/ext/temp/remove4 2>/dev/null
rm /sdcard/Download/ext/temp/remove5 2>/dev/null
rm /sdcard/Download/ext/temp/remove6 2>/dev/null
rm /sdcard/Download/ext/temp/zip 2>/dev/null
rm /sdcard/Download/ext/temp/zip1 2>/dev/null
rm /sdcard/Download/ext/temp/zip2 2>/dev/null