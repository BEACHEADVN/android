##########################################################################################
#
# MMT Extended Config Script
#
##########################################################################################

##########################################################################################
# Config Flags
##########################################################################################

# Uncomment and change 'MINAPI' and 'MAXAPI' to the minimum and maximum android version for your mod
# Uncomment DYNLIB if you want libs installed to vendor for oreo+ and system for anything older
# Uncomment DEBUG if you want full debug logs (saved to /sdcard)
#MINAPI=29
#MAXAPI=30
#DYNLIB=false
#DEBUG=false

##########################################################################################
# Replace list
##########################################################################################

# List all directories you want to directly replace in the system
# Check the documentations for more info why you would need this

# Construct your list in the following format
# This is an example
REPLACE_EXAMPLE="
/system/app/Youtube
/system/priv-app/SystemUI
/system/priv-app/Settings
/system/framework
"

# Construct your own list here
REPLACE="
/system/app/BTProductionLineTool
/system/app/BookmarkProvider
/system/app/Calculator
/system/app/CatchLog
/system/app/CatcherPatch
/system/app/CertInstaller
/system/app/Cit
/system/app/CloudService
/system/app/EasterEgg
/system/app/Email
/system/app/FidoAuthen
/system/app/FidoClient
/system/app/GooglePrintRecommendationService
/system/app/HTMLViewer
/system/app/Health
/system/app/Joyose
/system/app/KeyChain
/system/app/Lens
/system/app/LiveWallpapersPicker
/system/app/MiCloudSync
/system/app/MiDrive
/system/app/MiGalleryLockscreen
/system/app/MiLinkService
/system/app/MiPlayClient
/system/app/MiSound
/system/app/MiuiBugReport
/system/app/MiuiCompass
/system/app/MiuiContentCatcher
/system/app/MiuiDaemon
/system/app/MiuiFrequentPhrase
/system/app/MiuiScreenRecorder
/system/app/MiuiScreenshot
/system/app/MiuiVideoGlobal
/system/app/MiuiVpnSdkManager
/system/app/ModemTestBox
/system/app/NQNfcNci
/system/app/NextPay
/system/app/Notes
/system/app/PaymentService
/system/app/PlatformCaptivePortalLogin
/system/app/PrintSpooler
/system/app/Protips
/system/app/SimAppDialog
/system/app/SoterService
/system/app/Stk
/system/app/TouchAssistant
/system/app/Traceur
/system/app/WallpaperBackup
/system/app/XMSFKeeper
/system/app/XiaomiServiceFramework
/system/app/XiaomiSimActivateService
/system/app/com.miui.qr
/system/app/mi_connect_service
/system/app/wps-lite
/system/media/theme/miui_mod_icons
/system/media/wallpaper
/system/priv-app/Backup
/system/priv-app/BackupRestoreConfirmation
/system/priv-app/BlockedNumberProvider
/system/priv-app/BuiltInPrintService
/system/priv-app/Calendar
/system/priv-app/CalendarProvider
/system/priv-app/CallLogBackup
/system/priv-app/CellBroadcastServiceModulePlatform
/system/priv-app/CleanMaster
/system/priv-app/CloudBackup
/system/priv-app/DownloadProviderUi
/system/priv-app/DynamicSystemInstallationService
/system/priv-app/LocalTransport
/system/priv-app/ManagedProvisioning
/system/priv-app/MiBrowserGlobal
/system/priv-app/MiMover
/system/priv-app/MiRecycle
/system/priv-app/MiService
/system/priv-app/MiSettings
/system/priv-app/MiShare
/system/priv-app/MiShare
/system/priv-app/Mirror
/system/priv-app/MiuiExtraPhoto
/system/priv-app/MiuiFreeformService
/system/priv-app/MiuiGallery
/system/priv-app/MiuiGallery
/system/priv-app/MiuiScanner
/system/priv-app/MmsService
/system/priv-app/Music
/system/priv-app/MusicFX
/system/priv-app/ONS
/system/priv-app/PersonalAssistant
/system/priv-app/Provision
/system/priv-app/ProxyHandler
/system/priv-app/QuickSearchBox
/system/priv-app/SharedStorageBackup
/system/priv-app/SoundPicker
/system/priv-app/SoundRecorder
/system/priv-app/Tag
/system/priv-app/Updater
/system/priv-app/UserDictionaryProvider
/system/priv-app/VpnDialogs
/system/priv-app/Weather
/system/priv-app/XiaomiEUExt
/system/product/app/CloudPrint2
/system/product/app/GoogleCalendarSyncAdapter
/system/product/app/GoogleContactsSyncAdapter
/system/product/app/GoogleLocationHistory
/system/product/app/GoogleTTS
/system/product/app/LatinImeGoogle
/system/product/app/SoundPickerGoogle
/system/product/overlay/AccentColorBlack
/system/product/overlay/AccentColorCinnamon
/system/product/overlay/AccentColorGreen
/system/product/overlay/AccentColorOcean
/system/product/overlay/AccentColorOrchid
/system/product/overlay/AccentColorPurple
/system/product/overlay/AccentColorSpace
/system/product/overlay/DisplayCutoutEmulationCorner
/system/product/overlay/DisplayCutoutEmulationDouble
/system/product/overlay/DisplayCutoutEmulationHole
/system/product/overlay/DisplayCutoutEmulationTall
/system/product/overlay/DisplayCutoutEmulationWaterfall
/system/product/overlay/FontNotoSerifSource
/system/product/overlay/IconPackCircularAndroid
/system/product/overlay/IconPackCircularLauncher
/system/product/overlay/IconPackCircularSettings
/system/product/overlay/IconPackCircularSystemUI
/system/product/overlay/IconPackCircularThemePicker
/system/product/overlay/IconPackFilledAndroid
/system/product/overlay/IconPackFilledLauncher
/system/product/overlay/IconPackFilledSettings
/system/product/overlay/IconPackFilledSystemUI
/system/product/overlay/IconPackFilledThemePicker
/system/product/overlay/IconPackRoundedAndroid
/system/product/overlay/IconPackRoundedLauncher
/system/product/overlay/IconPackRoundedSettings
/system/product/overlay/IconPackRoundedSystemUI
/system/product/overlay/IconPackRoundedThemePicker
/system/product/overlay/IconShapePebble
/system/product/overlay/IconShapeRoundedRect
/system/product/overlay/IconShapeSquircle
/system/product/overlay/IconShapeTaperedRect
/system/product/overlay/IconShapeTeardrop
/system/product/overlay/IconShapeVessel
/system/product/overlay/NavigationBarMode3Button
/system/product/priv-app/AndroidAutoStub
/system/product/priv-app/CarrierServices
/system/product/priv-app/ConfigUpdater
/system/product/priv-app/GoogleRestore
/system/product/priv-app/HotwordEnrollmentOKGoogleHEXAGON
/system/product/priv-app/HotwordEnrollmentXGoogleHEXAGON
/system/product/priv-app/SettingsIntelligence
/system/product/priv-app/SetupWizard
/system/product/priv-app/Velvet
/system/system_ext/app/DeviceInfo
/system/system_ext/app/QdcmFF
/system/system_ext/app/WAPPushManager
/system/system_ext/app/atfwd
/system/system_ext/app/com.qualcomm.qti.services.systemhelper
/system/system_ext/app/xdivert
/system/system_ext/priv-app/CellBroadcastAppPlatform
/system/system_ext/priv-app/EmergencyInfo
/system/system_ext/priv-app/GoogleFeedback
/system/system_ext/priv-app/GoogleOneTimeInitializer
/system/system_ext/priv-app/WallpaperCropper
/system/system_ext/priv-app/WfdService
/system/system_ext/priv-app/beyondGnssService
/system/vendor/app/CACertService
/system/vendor/app/CneApp
/system/vendor/app/EidService
/system/vendor/app/IconShapeOverlay
/system/vendor/app/NotchOverlay
/system/vendor/app/SensorTestTool
/system/vendor/app/com.qualcomm.qti.gpudrivers.kona.api30
"

##########################################################################################
# Permissions
##########################################################################################

set_permissions() {
  : # Remove this if adding to this function

  # Note that all files/folders in magisk module directory have the $MODPATH prefix - keep this prefix on all of your files/folders
  # Some examples:
  
  # For directories (includes files in them):
  # set_perm_recursive  <dirname>                <owner> <group> <dirpermission> <filepermission> <contexts> (default: u:object_r:system_file:s0)
  
  # set_perm_recursive $MODPATH/system/lib 0 0 0755 0644
  # set_perm_recursive $MODPATH/system/vendor/lib/soundfx 0 0 0755 0644

  # For files (not in directories taken care of above)
  # set_perm  <filename>                         <owner> <group> <permission> <contexts> (default: u:object_r:system_file:s0)
  
  # set_perm $MODPATH/system/lib/libart.so 0 0 0644
set_perm $MODPATH/system/media/bootanimation.zip 0 0 0644
  # set_perm /data/local/tmp/file.txt 0 0 644
}

##########################################################################################
# MMT Extended Logic - Don't modify anything after this
##########################################################################################

SKIPUNZIP=1
unzip -qjo "$ZIPFILE" 'common/functions.sh' -d $TMPDIR >&2
. $TMPDIR/functions.sh