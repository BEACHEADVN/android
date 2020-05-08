#!/bin/sh

rm -rf /sdcard/Download/ext/temp/META-INF 2>/dev/null
rm -rf /sdcard/Download/ext/temp/system 2>/dev/null
rm /sdcard/Download/ext/temp/r 2>/dev/null
rm /sdcard/Download/ext/temp/d 2>/dev/null
rm /sdcard/Download/ext/temp/z 2>/dev/null

function version {
	echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

function makezip {
	cd /sdcard/Download/ext/temp
	zip -r tweak-evolutionx-capricorn-q.zip META-INF system
	rm /sdcard/tweak-evolutionx-capricorn-q.zip
	mv /sdcard/Download/ext/temp/tweak-evolutionx-capricorn-q.zip /sdcard
}

unzip -qq -o /sdcard/tweak-evolutionx-capricorn-q.zip -d /sdcard/Download/ext/temp

path=`find /sdcard/Download/ext -name "EvolutionX*"`
aapt dump badging $path/system/system/product/priv-app/SettingsIntelligenceGooglePrebuilt/*.apk > /sdcard/Download/ext/temp/r
aapt dump badging /data/app/com.google.android.settings.intelligence*/*.apk > /sdcard/Download/ext/temp/d
aapt dump badging /sdcard/Download/ext/temp/system/product/priv-app/SettingsIntelligenceGooglePrebuilt/*.apk > /sdcard/Download/ext/temp/z
if [ -d $path/system/system/product/priv-app/SettingsIntelligenceGooglePrebuilt ]
then
	if [ -d /data/app/com.google.android.settings.intelligence* ]
	then
		aapt dump badging $path/system/system/product/priv-app/SettingsIntelligenceGooglePrebuilt/*.apk > /sdcard/Download/ext/temp/r
		r=`cat /sdcard/Download/ext/temp/r | grep "versionName" | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/'`
		
		aapt dump badging /data/app/com.google.android.settings.intelligence*/*.apk > /sdcard/Download/ext/temp/d
		d=`cat /sdcard/Download/ext/temp/d | grep "versionName" | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/'`
		
		if [ $(version $d) -gt $(version $r) ]
		then
			if [ -d /sdcard/Download/ext/temp/system/product/priv-app/SettingsIntelligenceGooglePrebuilt ]
			then
				aapt dump badging /sdcard/Download/ext/temp/system/product/priv-app/SettingsIntelligenceGooglePrebuilt/*.apk > /sdcard/Download/ext/temp/z
				z=`cat /sdcard/Download/ext/temp/z | grep "versionName" | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/'`
				if [ $(version $d) -gt $(version $z) ]
				then
					rm -rf /sdcard/Download/ext/temp/system/product/priv-app/SettingsIntelligenceGooglePrebuilt/SettingsIntelligenceGooglePrebuilt/*
					cp -r /data/app/com.google.android.settings.intelligence-*/* /sdcard/Download/ext/temp/system/product/priv-app/SettingsIntelligenceGooglePrebuilt
					makezip
				else
					echo ""
				fi
			else
				mkdir /sdcard/Download/ext/temp/system/product/priv-app
				mkdir /sdcard/Download/ext/temp/system/product/priv-app/SettingsIntelligenceGooglePrebuilt
				cp -r /data/app/com.google.android.settings.intelligence-*/* /sdcard/Download/ext/temp/system/product/priv-app/SettingsIntelligenceGooglePrebuilt
				sed -i '137i "/system/system/product/priv-app/SettingsIntelligenceGooglePrebuilt",' /sdcard/Download/ext/temp/META-INF/com/google/android/updater-script
				makezip
			fi
		else
			if [ -d /sdcard/Download/ext/temp/system/product/priv-app/SettingsIntelligenceGooglePrebuilt ]
			then
				aapt dump badging /sdcard/Download/ext/temp/system/product/priv-app/SettingsIntelligenceGooglePrebuilt/*.apk > /sdcard/Download/ext/temp/z
				z=`cat /sdcard/Download/ext/temp/z | grep "versionName" | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/'`
				if [ $(version $r) -gt $(version $z) ]
				then
					rm -rf /sdcard/Download/ext/temp/system/product/priv-app/SettingsIntelligenceGooglePrebuilt
					sed -i '/SettingsIntelligenceGooglePrebuilt/d' /sdcard/Download/ext/temp/META-INF/com/google/android/updater-script
					makezip
				else
					echo ""
				fi
			else
				echo ""
			fi
		fi
	else
		if [ -d /sdcard/Download/ext/temp/system/product/priv-app/SettingsIntelligenceGooglePrebuilt ]
		then
			aapt dump badging /sdcard/Download/ext/temp/system/product/priv-app/SettingsIntelligenceGooglePrebuilt/*.apk > /sdcard/Download/ext/temp/z
			z=`cat /sdcard/Download/ext/temp/z | grep "versionName" | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/'`
			if [ $(version $r) -gt $(version $z) ]
			then
				rm -rf /sdcard/Download/ext/temp/system/product/priv-app/SettingsIntelligenceGooglePrebuilt
				sed -i '/SettingsIntelligenceGooglePrebuilt/d' /sdcard/Download/ext/temp/META-INF/com/google/android/updater-script
				makezip
			else
				echo ""
			fi
		else
			echo ""
		fi
	fi
else
	if [ -d /sdcard/Download/ext/temp/system/product/priv-app/SettingsIntelligenceGooglePrebuilt ]
	then
		rm -rf /sdcard/Download/ext/temp/system/product/priv-app/SettingsIntelligenceGooglePrebuilt
		sed -i '/SettingsIntelligenceGooglePrebuilt/d' /sdcard/Download/ext/temp/META-INF/com/google/android/updater-script
		makezip
	else
		echo ""
	fi
fi

rm -rf /sdcard/Download/ext/temp/META-INF 2>/dev/null
rm -rf /sdcard/Download/ext/temp/system 2>/dev/null
rm /sdcard/Download/ext/temp/r 2>/dev/null
rm /sdcard/Download/ext/temp/d 2>/dev/null
rm /sdcard/Download/ext/temp/z 2>/dev/null