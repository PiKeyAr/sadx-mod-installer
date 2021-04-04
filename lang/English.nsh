!insertmacro LANGFILE "English" = "English" =
;Examples of other languages with translated strings
;!insertmacro LANGFILE "French" = "Français" "Francais"
;!insertmacro LANGFILE "Spanish" = "Español" "Espanol"
;!insertmacro LANGFILE "German" = "Deutsch" =

;General strings for NSIS MUI
${LangFileString} MUI_TEXT_LICENSE_TITLE "Information"
${LangFileString} MUI_TEXT_LICENSE_SUBTITLE "Please read the following notes before using this installer"
${LangFileString} MUI_INNERTEXT_LICENSE_TOP "Scroll down or press Page Down to see the rest of the notes."
${LangFileString} MUI_INNERTEXT_LICENSE_BOTTOM "Please back up your SADX folder before using this installer. Click Continue to proceed."
${LangFileString} MUI_TEXT_COMPONENTS_TITLE "Choose components"
${LangFileString} MUI_TEXT_COMPONENTS_SUBTITLE "Choose which mods and features you want to install."
${LangFileString} MUI_INNERTEXT_COMPONENTS_DESCRIPTION_TITLE "Description"
${LangFileString} MUI_INNERTEXT_COMPONENTS_DESCRIPTION_INFO "Move the mouse cursor over a component to see its description."
${LangFileString} MUI_TEXT_DIRECTORY_TITLE "Choose install location"
${LangFileString} MUI_TEXT_DIRECTORY_SUBTITLE "Select your SADX folder to be used by the installer."
${LangFileString} MUI_TEXT_INSTALLING_TITLE "Installing"
${LangFileString} MUI_TEXT_INSTALLING_SUBTITLE "Please wait while SADX Mod Installer is working on the game."
${LangFileString} MUI_BUTTONTEXT_FINISH "&Finish"

;Install types and profile names
LangString INSTTYPE_DC 1033 "Dreamcast mods"
LangString INSTTYPE_SADX 1033 "SADX + enhancements"
LangString INSTTYPE_MIN 1033 "Minimal/Vanilla"
LangString PROFILENAME_DC 1033 "Dreamcast"
LangString PROFILENAME_SADX 1033 "Enhanced SADX"
LangString PROFILENAME_MIN 1033 "Minimal"
LangString PROFILENAME_CUSTOM 1033 "Custom mode"

;Section names
LangString SECTIONNAME_REMOVEMODS 1033 "Remove all current mods"
LangString SECTIONNAME_PERMISSIONS 1033 "Check and fix permissions of SADX folder"
LangString SECTIONNAME_MODLOADER 1033 "SADX Mod Loader by MainMemory & SonicFreak94"
LangString SECTIONNAME_LAUNCHER 1033 "SADX Launcher by PkR"
LangString SECTIONNAME_DEPENDENCIES 1033 "Mod Loader dependencies"
LangString SECTIONNAME_VCC 1033 "Visual C++ runtimes"
LangString SECTIONNAME_DX9 1033 "DirectX 9.0c"
LangString SECTIONNAME_BUGFIXES 1033 "Bug fixes and control/camera mods"
LangString SECTIONNAME_SADXFE 1033 "SADX: Fixed Edition by SonicFreak94"
LangString SECTIONNAME_INPUTMOD 1033 "Input Mod by SonicFreak94"
LangString SECTIONNAME_FRAMELIMIT 1033 "Frame Limiter by SonicFreak94"
LangString SECTIONNAME_CCEF 1033 "Camera Fix by VeritasDL & SonicFreak94"
LangString SECTIONNAME_DCMODS 1033 "Dreamcast mods"
LangString SECTIONNAME_DCCONV 1033 "Dreamcast Conversion by PkR"
LangString SECTIONNAME_SA1CHARS 1033 "Dreamcast Characters Pack by ItsEasyActually"
LangString SECTIONNAME_LANTERN 1033 "Lantern Engine by SonicFreak94"
LangString SECTIONNAME_DLCS 1033 "Sonic Adventure DLCs by PkR"
LangString SECTIONNAME_ENH 1033 "Enhancements and gameplay mods"
LangString SECTIONNAME_SMOOTH 1033 "Smooth Camera by SonicFreak94"
LangString SECTIONNAME_ONION 1033 "Onion Skin Blur by SonicFreak94"
LangString SECTIONNAME_IDLE 1033 "Idle Chatter by SonicFreak94"
LangString SECTIONNAME_PAUSE 1033 "Pause Hide by SonicFreak94"
LangString SECTIONNAME_STEAM 1033 "Steam Achievements by MainMemory"
LangString SECTIONNAME_SUPER 1033 "Super Sonic by x-hax"
LangString SECTIONNAME_EEC 1033 "Enhanced Emerald Coast by PkR"
LangString SECTIONNAME_TIME 1033 "Time of Day by PkR"
LangString SECTIONNAME_ECMUSIC 1033 "Egg Carrier Ocean Music by MainMemory"
LangString SECTIONNAME_ADX 1033 "ADX voices and music (for 2004 port)"
LangString SECTIONNAME_SND 1033 "Sound Overhaul 3 by PkR"
LangString SECTIONNAME_HDGUI 1033 "HD GUI 2 by PkR & others"

;Guide Mode descriptions and checkboxes
LangString GUIDE_INFO_LANTERN 1033 "The Lantern Engine mod recreates the Dreamcast version's lighting system in SADX PC. Lantern Engine removes excessive gloss on character models and makes the lighting on levels, objects and characters more vibrant."
LangString GUIDE_INFO_DCCONV 1033 "Dreamcast Conversion is a complete overhaul of the game that makes it look and feel more like the Dreamcast version of SA1. It fixes many bugs and restores Dreamcast levels, textures, object models, special effects and branding."
LangString GUIDE_INFO_DXWTR 1033 "Dreamcast Conversion comes with an option to enable alternative water textures, which are similar to vanilla SADX water but higher quality and better animated. Some people may prefer to use these textures in Dreamcast levels."
LangString GUIDE_INFO_SA1CHARS 1033 "Dreamcast Characters Pack is a mod that restores Dreamcast character models in the PC version. Although SADX characters are higher poly, some people may prefer the original Dreamcast models for their proportions or aesthetics."
LangString GUIDE_INFO_ONION 1033 "The Onion Skin Blur mod recreates the 'motion blur' effect on Sonic's feet and Tails' tails. This effect was originally in the Japanese Dreamcast version of SA1, but it was removed in later revisions."
LangString GUIDE_INFO_HDGUI 1033 "HD GUI 2 replaces most GUI textures (menus, HUD, item capsule icons etc.) with custom high resolution textures."
LangString GUIDE_INST_LANTERN 1033 "Install Lantern Engine by SonicFreak94"
LangString GUIDE_INST_DCCONV 1033 "Install Dreamcast Conversion by PkR"
LangString GUIDE_INST_DXWTR 1033 "Enable SADX Style Water textures by SteG"
LangString GUIDE_INST_SA1CHARS 1033 "Install Dreamcast Characters Pack by ItsEasyActually"
LangString GUIDE_INST_ONION 1033 "Install Onion Skin Blur by SonicFreak94"
LangString GUIDE_INST_HDGUI 1033 "Install HD GUI 2 by PkR, Dark Sonic, Sonikko and SPEEPSHighway"

;Download strings
LangString D_DSOUND 1033 "Downloading DirectSound wrapper DLL..."
LangString D_DLCS 1033 "Downloading Dreamcast DLC content..."
LangString D_D3D8 1033 "Downloading D3D8to9 DLL..."
LangString D_DCCONV 1033 "Downloading Dreamcast Conversion..."
LangString D_STEAM 1033 "Downloading Steam Achievements..."
LangString D_RESOURCES 1033 "Downloading custom resources..."
LangString D_DX9 1033 "Downloading DirectX Setup..."
LangString D_VC2010 1033 "Downloading VS2010 runtimes..."
LangString D_VC2012 1033 "Downloading VS2012 runtimes..."
LangString D_VC2013 1033 "Downloading VS2013 runtimes..."
LangString D_VC2019 1033 "Downloading VS2019 runtimes..."
LangString D_LAUNCHER 1033 "Downloading SADX Launcher..."
LangString D_NET 1033 "Downloading .NET Web Setup..."
LangString D_CHRMODELS 1033 "Downloading CHRMODELS..."
LangString D_STEAMTOOLS 1033 "Downloading SADX Steam tools..."
LangString D_2004BIN 1033 "Downloading SADX 2004 binaries..."
LangString D_2004EXE 1033 "Downloading SADX 2004 EXE file..."
LangString D_VOICES 1033 "Downloading additional voices..."
LangString D_MODLOADER 1033 "Downloading SADX Mod Loader..."
LangString D_FILELIST 1033 "Downloading file list..."
LangString D_INSTCHK 1033 "Checking installer updates..."
LangString D_GENERIC 1033 "Downloading $Modname..."
LangString D_UPDATE 1033 "Checking $UpdateFilename ..."
LangString D_INSTALLER 1033 "Downloading the installer..."
LangString D_INSTALLER_R 1033 "Executing the new version..."

;Headers
LangString MISC_INSTALLER 1033 "SADX Mod Installer"
LangString HEADER_GUIDE_TITLE 1033 "Mod selection guide"
LangString HEADER_GUIDE_TEXT 1033 "Check the checkbox if you want to install this mod. Click the screenshot for a more detailed comparison."
LangString HEADER_ADD_TITLE 1033 "Additional mods"
LangString HEADER_ADD_TEXT 1033 "Check the checkboxes for mods you want to install."
LangString HEADER_UPDATES_TITLE 1033 "Check for updates"
LangString HEADER_UPDATES_TEXT 1033 "It's recommended to keep mods and the Mod Loader up to date."
LangString HEADER_SET_TITLE 1033 "Mod Loader configuration"
LangString HEADER_SET_TEXT 1033 "SADX/Mod Loader settings. You can always change them later in the Mod Manager."
LangString HEADER_ICON_TITLE 1033 "Select your EXE icon"
LangString HEADER_ICON_TEXT 1033 "Select a custom icon for SADX EXE file."
LangString HEADER_TYPE_TITLE 1033 "Installation type"
LangString HEADER_TYPE_TEXT 1033 "Select the type of installation."

;Mod Loader settings
LangString SET_TRUE 1033 "True"
LangString SET_FALSE 1033 "False"
LangString SET_DISP 1033 "Display options"
LangString SET_RES 1033 "Resolution"
LangString SET_SCREEN 1033 "Screen mode"
LangString SET_WINDOWED 1033 "Windowed"
LangString SET_FULLSCREEN 1033 "Fullscreen"
LangString SET_BORDERLESS 1033 "Borderless fullscreen"
LangString SET_SCALE 1033 "Scale to screen (for downsampling)"
LangString SET_VSYNC 1033 "VSync"
LangString SET_DETAIL 1033 "Detail level"
LangString SET_HIGH 1033 "High (best)"
LangString SET_LOW 1033 "Low"
LangString SET_LOWEST 1033 "Lowest"
LangString SET_FRAMERATE 1033 "Framerate"
LangString SET_OTHER 1033 "Other options"
LangString SET_PAUSE 1033 "Pause when inactive (ALT+TAB)"
LangString SET_UI 1033 "UI scaling (recommended)"
LangString SET_UPD 1033 "Update options"
LangString SET_CHECKMODUPD 1033 "Check for mod updates"
LangString SET_CHECKUPD 1033 "Check for updates"
LangString SET_FREQ 1033 "Update frequency"
LangString SET_DAYS 1033 "Days"
LangString SET_WEEKS 1033 "Weeks"
LangString SET_HOURS 1033 "Hours"
LangString SET_ALWAYS 1033 "Always"

;Options
LangString OPTIONNAME_INSTMODE 1033 "Installer mode"
LangString OPTIONNAME_GUIDE 1033 "Guide mode - select this if unsure"
LangString OPTIONNAME_PRESET 1033 "Preset mode"
LangString OPTIONNAME_PRESETS 1033 "Presets"
LangString OPTIONNAME_ADVANCED 1033 "Show advanced options"
LangString OPTIONNAME_PRESERVE 1033 "Preserve individual mod settings (if any)"
LangString OPTIONNAME_OPTIMAL 1033 "Use optimal Mod Loader settings"
LangString OPTIONNAME_MANUAL 1033 "Configure Mod Loader settings manually"
LangString OPTIONNAME_FAILSAFE 1033 "Use failsafe Mod Loader settings"
LangString OPTIONNAME_ICONSEL 1033 "Select the preferred icon for your SADX executable."
LangString OPTIONNAME_ICON_DX 1033 "SADX Gamecube save icon"
LangString OPTIONNAME_ICON_HD 1033 "Custom HD icon by Lester LJSTAR"
LangString OPTIONNAME_ICON_SA1 1033 "SA1 box art icon by PkR"
LangString OPTIONNAME_ICON_VM 1033 "SA1 VMU icon recreated by McAleeCh"
LangString OPTIONNAME_UPDATES 1033 "Check for updates"
LangString OPTIONNAME_NOUPDATES 1033 "Don't check for updates: only download required files (if any)"
LangString OPTIONNAME_WTITLE 1033 "Change window title to $\"Sonic Adventure$\""
LangString OPTIONNAME_ICON 1033 "Choose a custom icon for sonic.exe"

;Messages
LangString MSG_UPDATES 1033 "Would you like to check for updates?$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n\
This installer, SADX Mod Loader and the mods are all works in progress. Updates fix bugs and add new features.$\r$\n\
$\r$\nKeep your mods up to date to receive new content and avoid issues."
LangString MSG_OFFLINE 1033 "For offline installation, pick the second option."
LangString MSG_FOLDER_FOUND 1033 "Setup has detected the following folder as your SADX install location.$\r$\n\
$\r$\nTo install in a different folder, click Browse and select another folder."
LangString MSG_FOLDER_NOTFOUND 1033 "Setup could not detect SADX install location. Please choose the install location manually.$\r$\n\
$\r$\nIf you own a rare version of SADX (such as a non-Steam digital download) or believe this is a bug, please contact PkR (@pkr_sadx)."
LangString MSG_DEFAULT 1033 "Your Mod Loader settings will be reset to failsafe defaults:$\r$\n\
$\r$\nResolution: 640x480$\r$\n\
Fullscreen: on$\r$\n\
Borderless fullscreen: off$\r$\n\
VSync: off$\r$\n\
Texture filtering and mipmaps: off$\r$\n\
Scale to screen: off$\r$\n\
HUD scaling: off$\r$\n\
Background and FMV scaling: stretch$\r$\n\
$\r$\n\
Continue?"
LangString MSG_INSTALLERUPDATE 1033 "Updates found for the installer! Perform an auto-update?$\r$\n\
$\r$\nThe new version will relaunch automatically."
LangString MSG_FOUNDUPD 1033 "Found updates for $UpdatesFound package(s)!$\r$\n\
$\r$\n$WhichUpdates$\r$\n\
The instdata folder has been cleaned up, and latest versions of the above packages will be downloaded instead."
LangString MSG_CHECKUPDATES 1033 "Checking for Mod Loader updates..."
LangString MSG_PROFILE 1033 "Select the preferred kind of modded SADX setup. You can use a common mod preset or select the mods manually."
LangString MSG_START 1033 "Welcome to SADX Mod Installer!"
LangString MSG_WELCOME 1033 "This program will install MainMemory's SADX Mod Loader and a selection of mods by several creators.$\r$\n$\r$\nA default installation with all mods will add approximately 1.3GB to the size of your SADX folder.$\r$\n$\r$\nIf you use the web version of this installer, make sure there is also at least 1GB available on the drive with sadx_setup.exe$\r$\n$\r$\nClick Next to continue."
LangString MSG_COMPLETE 1033 "Installation complete!"
LangString MSG_FINISH 1033 "You can now play SADX with the mods you have installed.$\r$\n\
$\r$\nThe files used by this installer have been saved in the 'instdata' folder. You can keep it to use the installer offline later, or delete it to save space."

;Errors
LangString ERR_REQUIREDOS 1033 "Incompatible OS detected. This program requires Windows 7 SP1 or later to work properly.$\r$\nContinue?"
LangString ERR_NET_MISSING 1033 "The Steam conversion tool requires .NET Framework 4.8 to be installed.$\r$\nPlease install .NET Framework manually and run the installer again."
LangString ERR_D_RESOURCES 1033 "Resource data download failed: $DownloadErrorCode. Continue?"
LangString ERR_D_DSOUND 1033 "Download failed: $DownloadErrorCode. Sound Overhaul will not function correctly until dsound.dll is placed into SADX main folder."
LangString ERR_D_STEAM 1033 "Steam Achievements download failed: $DownloadErrorCode. Continue installing other mods?"
LangString ERR_D_DLCS 1033 "SA1 DLC content download failed: $DownloadErrorCode. Continue installing other mods?"
LangString ERR_D_D3D8 1033 "Download failed: $DownloadErrorCode. Lantern Engine will not function correctly until d3d8.dll is placed into SADX main folder."
LangString ERR_D_DCCONV 1033 "DC Conversion download failed: $DownloadErrorCode. Continue installing other mods?"
LangString ERR_D_DX9 1033 "Download failed: $DownloadErrorCode. Please run DirectX setup manually."
LangString ERR_D_VC2010 1033 "Download failed: $DownloadErrorCode. Please install Visual C++ 2010 runtimes manually."
LangString ERR_D_VC2012 1033 "Download failed: $DownloadErrorCode. Please install Visual C++ 2012 runtimes manually."
LangString ERR_D_VC2013 1033 "Download failed: $DownloadErrorCode. Please install Visual C++ 2013 runtimes manually."
LangString ERR_D_VC2019 1033 "Download failed: $DownloadErrorCode. Please install Visual C++ 2019 runtimes manually."
LangString ERR_D_LAUNCHER 1033 "Download failed: $DownloadErrorCode. Please download the launcher manually or run the setup program again.$\r$\n\
$\r$\n\
If you are running into this issue consistently, please download an offline version of the installer."
LangString ERR_D_NET 1033 "Download failed: $DownloadErrorCode. Please install .NET Framework manually."
LangString ERR_SIZE 1033 "Size of $UpdateFilename not found!"
LangString ERR_FOLDER 1033 "Setup has detected that some files are missing in your SADX installation.$\r$\n\
$\r$\n\
Make sure you are installing the Mod Loader into SADX main folder (where sonic.exe or Sonic Adventure DX.exe is)."
LangString ERR_2004CHECK 1033 "Setup has detected that SADX 2004 EXE has either failed to download or has an incorrect checksum. $\r$\n\
Please check your Internet connection and run the installer again.$\r$\n\
$\r$\n\
If you are running into this issue consistently, please download an offline version of the installer."
LangString ERR_MODLOADER 1033 "Setup has detected that the Mod Loader has not been downloaded or installed correctly. $\r$\n\
Please check your Internet connection and run the installer again.$\r$\n\
$\r$\n\
If you are running into this issue consistently, please download an offline version of the installer."
LangString ERR_DOWNLOAD_TOOLS 1033 "Setup has detected that some tools have failed to download. $\r$\n\
Please check your Internet connection and run the installer again.$\r$\n\
$\r$\n\
If you are running into this issue consistently, please download an offline version of the installer."
LangString ERR_DOWNLOAD_2004BIN 1033 "Setup has detected that some SADX 2004 files have failed to download.$\r$\n\
Please check your Internet connection and run the installer again.$\r$\n\
$\r$\n\
If you are running into this issue consistently, please download an offline version of the installer."
LangString ERR_MODDOWNLOAD 1033 "$ModName download failed: $DownloadErrorCode. Continue installing other mods?"
LangString ERR_DOWNLOAD_FILE 1033 "Error downloading file. Try again?"
LangString ERR_MODDATE 1033 "Failed to check last modified date of mod.manifest for mod $ModFilename. Make sure the mod was installed correctly."
LangString ERR_MISSINGFILES 1033 "Setup has detected that some files are missing in your SADX installation.$\r$\n\
$\r$\n\
Make sure you are installing the Mod Loader into SADX main folder (where sonic.exe or Sonic Adventure DX.exe is).$\r$\n\
$\r$\n\
If you have mixed files from different versions of SADX, the installer may fail to detect your version correctly. To fix that, start with a clean version of the game."
LangString ERR_DOWNLOAD_CANCEL_Q 1033 "Cancel download?"
LangString ERR_DOWNLOAD_CANCEL_A 1033 "Cancel download"
LangString ERR_DOWNLOAD_FATAL 1033 "Download failed: $DownloadErrorCode. Please run the setup program again.$\r$\n\
$\r$\n\
If you are running into this issue consistently, please download an offline version of the installer."
LangString ERR_DOWNLOAD_RETRY 1033 "Download failed. Would you like to try again?"
LangString ERR_PERMISSION 1033 "Error setting SADX folder permissions!$\r$\n\
$\r$\n\
Please take ownership of your SADX folder and set access permissions manually."
LangString ERR_CHRMODELS 1033 "Error downloading CHRMODELS.dll: $DownloadErrorCode $\r$\n\
Please check your Internet connection and run the installer again.$\r$\n\
$\r$\n\
If you are running into this issue consistently, please download an offline version of the installer."
LangString ERR_CHRMODELSBAD 1033 "Setup has detected a modified CHRMODELS.DLL. $\r$\n\
$\r$\n\
It will be backed up as CHRMODELS.bak and replaced with a standard CHRMODELS.DLL. This is required for the Mod Loader to work properly.$\r$\n\
$\r$\n\
If you use old mods that modify CHRMODELS.DLL, please be aware that they are not supported by the Mod Loader."
LangString ERR_EXEMD5 1033 "The MD5 hash of downloaded sonic.exe is incorrect. Please run the setup program again.$\r$\n\
$\r$\n\
If you are running into this issue consistently, please download an offline version of the installer."

;Mod descriptions
LangString DESC_ADD_ALL 1033 "These mods introduce gameplay changes and non-visual improvements.$\r$\n\
$\r$\nSelect which mods you want to install."
LangString DESC_ADD_SND 1033 "Install Sound Overhaul to improve sound quality and volume, fix SADX sound bugs and restore missing sounds"
LangString DESC_ADD_DLCS 1033 "Install the DLCs mod to add Sonic Adventure holiday events and challenges from the Dreamcast"
LangString DESC_ADD_SUPER 1033 "Install the Super Sonic mod to be able to transform into Super Sonic in Action Stages after beating the story"
LangString DESC_REMOVEMODS 1033 "Delete all mods in the mods folder before proceeding.$\r$\n\
$\r$\n\
WARNING! This is a dangerous option because it will delete all your mods.$\r$\n\
Use it only if you're having problems with current mods and want to start afresh."
LangString DESC_MODLOADER 1033 "Install or update SADX Mod Loader (required).$\r$\n\
$\r$\n\
The Steam version of SADX will be converted to the 2004 version before installation."
LangString DESC_LAUNCHER 1033 "Install SADX Launcher (required).$\r$\n\
$\r$\n\
SADX Launcher is a tool to change Mod Loader settings and configure controls for the Input Mod."
LangString DESC_NET 1033 "Install or update .NET Framework, which is required for SADX Mod Manager to work properly. $\r$\n\
$\r$\n\
The installer checks if .NET Framework 4.8 is already installed before downloading it."
LangString DESC_RUNTIME 1033 "Install/update Visual C++ 2010, 2012, 2013 and 2015/2017/2019 runtimes, which are needed for DLL-based mods to work properly. $\r$\n\
$\r$\n\
The installer checks if Visual C++ runtimes are already installed before downloading them."
LangString DESC_DIRECTX 1033 "Update DirectX runtimes, which are needed for SADX and the Lantern Engine mod. $\r$\n\
$\r$\n\
The installer checks if DirectX 9.0c is already installed before downloading it."
LangString DESC_PERMISSIONS 1033 "Take ownership of the SADX folder and set recursive permissions. This prevents permission errors when enabling or disabling the Mod Loader without administrator rights.$\r$\n\
$\r$\n\
The permission fix only runs when SADX is installed in the Program Files folder."
LangString DESC_ADXAUDIO 1033 "Higher quality ADX music and voices from the Dreamcast version. $\r$\n\
$\r$\n\
Not needed when installing on the Steam version as it already has ADX voices and music."
LangString DESC_SADXFE 1033 "A mod containing various bug fixes and improvements for the original PC version of SADX.$\r$\n\
$\r$\n\
Recommended!"
LangString DESC_INPUTMOD 1033 "Complete revamp of SADX input system with rebindable controls. Fixes issues with XInput and some DInput controllers. $\r$\n\
$\r$\n\
Recommended!"
LangString DESC_SMOOTHCAM 1033 "Smooth camera movement in first person.$\r$\n\
$\r$\n\
Can be used together with the Input Mod for even smoother movement."
LangString DESC_FRAMELIMIT 1033 "A more accurate framerate limiter.$\r$\n\
$\r$\n\
Fixes framerate issues (such as the game running at 63 instead of 60 FPS) on some computers.$\r$\n\
$\r$\n\
Makes gameplay smoother, but may have a slight impact on performance on older systems."
LangString DESC_PAUSEHIDE 1033 "Hides the Pause menu when X+Y is pressed like on the Dreamcast. DC Conversion already includes this."
LangString DESC_ONIONBLUR 1033 "Adds a 'motion blur' effect to Sonic's feet (like in the Japanese version of Dreamcast SA1) and Tails' tails."
LangString DESC_DLCS 1033 "Dreamcast-exclusive downloadable content recreated as a mod for SADX. $\r$\n\
$\r$\n\
See the mod's configuration for more details."
LangString DESC_STEAM 1033 "Support for Steam achievements in the 2004 port. $\r$\n\
$\r$\n\
You must own SADX on Steam for this mod to work."
LangString DESC_LANTERN 1033 "A mod for SADX that reimplements the lighting engine from the Dreamcast version of Sonic Adventure. $\r$\n\
$\r$\n\
Recommended!"
LangString DESC_DCMODS 1033 "Dreamcast Sonic Adventure levels, object models, effects, bosses, branding etc."
LangString DESC_SNDOVERHAUL 1033 "Fixes several sound issues and replaces the majority of sound effects with higher quality sounds ripped from the Dreamcast version."
LangString DESC_HDGUI 1033 "Replaces most GUI elements, such as HUD, buttons, life icons, menus etc. with higher resolution assets."
LangString DESC_TIMEOFDAY 1033 "You can change the time of day by taking the train between Station Square and the Mystic Ruins."
LangString DESC_DCCONV 1033 "Mods that add back/replace various ingame assets and make SADX more like the Dreamcast version of SA1."
LangString DESC_BUGFIXES 1033 "Mods that fix issues or add technical enhancements without major changes to assets or core gameplay."
LangString DESC_SA1CHARS 1033 "Character models from the Dreamcast version."
LangString DESC_MODLOADERSTUFF 1033 "Various dependencies required for the Mod Loader and mods to work properly."
LangString DESC_SUPERSONIC 1033 "Allows to transform into Super Sonic after completing the Final story."
LangString DESC_EEC 1033 "Improves the look of Emerald Coast and adds back the ocean wave effect from the Dreamcast version. $\r$\n\
$\r$\n\
This mod is for vanilla SADX only, use SADX Style Water if you want similar-looking water with Dreamcast mods."
LangString DESC_CCEF 1033 "Prevents the camera from resetting back to auto on level reload. Included in SADXFE. $\r$\n\
$\r$\n\
Useful for speedrunners who don't use SADXFE."
LangString DESC_ENHANCEMENTS 1033 "Mods that add new gameplay features or improve the vanilla SADX look."
LangString DESC_ECMUSIC 1033 "Plays 'The Ocean' music in the outside areas of the Egg Carrier when it's sunk."
LangString DESC_IDLECHATTER 1033 "Press Z to hear what your character has to say about the stage!"

;Other descriptions
LangString DESC_DESC 1033 "Description"
LangString DESC_PRESERVE 1033 "Enabling this will preserve config.ini when updating and reinstalling mods."
LangString DESC_ICON 1033 "The executable will be patched with one of the custom icons available in this installer."
LangString DESC_DCMODS_ALL 1033 "These mods make SADX look more like the original Dreamcast version of SA1.$\r$\n\
Mods included: SADX: Fixed Edition, Onion Blur, Dreamcast Conversion, DC Characters, DLC content, Sound Overhaul, HD GUI, Lantern Engine, Time of Day, Input Mod, Idle Chatter, Smooth Camera, Frame Limit, Super Sonic, Egg Carrier Ocean Music."
LangString DESC_SADX_ALL 1033 "Enhanced vanilla SADX experience.$\r$\n\
Mods included: SADX: Fixed Edition, Onion Blur, Enhanced Emerald Coast, Sound Overhaul, HD GUI, Time of Day, Input Mod, Idle Chatter, Pause Hide, Smooth Camera, Frame Limit, Super Sonic, Egg Carrier Ocean Music."
LangString DESC_MIN_ALL 1033 "Only essential/speedrun friendly mods will be installed.$\r$\n\
Mods included: Frame Limit, Camera Code Error Fix."
LangString DESC_CUSTOM_ALL 1033 "Custom installation.$\r$\n\
You will be able to select which mods to install and configure Mod Loader settings."
LangString DESC_GUIDE_ALL 1033 "Guide mode.$\r$\n\
The installer will show comparison screenshots to help you decide whether you want to install each mod."
LangString DESC_MANUAL 1033 "You will be able to select resolution, framerate, clipping, VSync and other options manually."
LangString DESC_OPTIMAL 1033 "The installer will detect your screen resolution and configure the game and the Mod Loader for best visual quality."
LangString DESC_FAILSAFE 1033 "Use this if the game crashes on startup.$\r$\n\
The resolution will be reset to 640x480 fullscreen, and all enhancements such as borderless fullscreen will be disabled."
LangString DESC_WINDOWTITLE 1033 "The game's window title will be set to $\"Sonic Adventure$\" instead of $\"SonicAdventureDXPC$\".$\r$\n\
$\r$\n\
WARNING! DO NOT ENABLE THIS IF YOU WANT TO USE FUSION'S CHAO EDITOR!"
LangString DESC_MOREMODS 1033 "More SADX mods"
LangString DESC_SHORTCUTS 1033 "Create desktop shortcuts"
LangString DESC_RUNSADX 1033 "Run Sonic Adventure DX"
LangString DESC_RUNLAUNCHER 1033 "Change controls and settings with SADX Launcher"
;The resources below are only available in English. Please indicate that in your translation
LangString DESC_DREAMCASTIFY 1033 "Dreamcastify - a website about SADX downgrades"
LangString DESC_DISCORD 1033 "Join SADX modding Discord server"

;Detail output
LangString DE_SND 1033 "Converting soundbanks to SADX 2004 format (this may take a while)..."
LangString DE_MOV 1033 "Converting SFD movies to MPG (this may also take a while)..."
LangString DE_VOICES 1033 "Downloading additional voices..."
LangString DE_INSTDATA 1033 "Creating instdata folder..."
LangString DE_7Z 1033 "Copying 7Z..."
LangString DE_OWNER 1033 "Taking ownership of SADX folder: $Permission1"
LangString DE_PERM 1033 "Permissions of SADX folder: $Permission2"
LangString DE_REALL 1033 "Removing all mods..."
LangString DE_PRGFILES 1033 "Checking whether SADX is in Program Files..."
LangString DE_RECU 1033 "SADX is in Program Files. Setting recursive folder permissions..."
LangString DE_2004FOUND 1033 "2004 version detected (sonic.exe)"
LangString DE_CHRM 1033 "Found CHRMODELS.DLL. Checking MD5..."
LangString DE_MANIFEST 1033 "Manifest date for $ModFilename: $2-$1-$0T$4:$5:$6Z"
LangString DE_PREVIOUS_DX 1033 "Loading previous SADX settings..."
LangString DE_PREVIOUS_ML 1033 "Loading previous Mod Loader settings..."
LangString DE_TAKEOWN 1033 "Taking ownership of $R9: $0"
LangString DE_PERMSET1 1033 "Setting permissions for $R9 (1): $0"
LangString DE_PERMSET2 1033 "Setting permissions for $R9 (2): $0"
LangString DE_PERMSET3 1033 "Setting permissions for $R9 (3): $0"
LangString DE_E_GENERIC 1033 "Extracting $Modname..."
LangString DE_B_CHR 1033 "Backing up old CHRMODELS..."
LangString DE_D_CHR 1033 "Downloading CHRMODELS... (~1.7MB)"
LangString DE_E_CHR 1033 "Extracting CHRMODELS..."
LangString DE_C_CHR 1033 "Verifying integrity of CHRMODELS..."
LangString DE_B_EXE 1033 "Backing up sonic.exe..."
LangString DE_E_EXE 1033 "Extracting SADX 2004 EXE file..."
LangString DE_C_EXE 1033 "Checking MD5 of sonic.exe..."
LangString DE_E_BIN 1033 "Extracting SADX 2004 binaries..."
LangString DE_C_BIN 1033 "Verifying SADX 2004 binaries..."
LangString DE_E_ML 1033 "Extracting SADX Mod Loader..."
LangString DE_I_ML 1033 "Installing/updating SADX Mod Loader..."
LangString DE_EXEFOUND 1033 "Found usable sonic.exe, proceeding with Mod Loader installation."
LangString DE_EXEUNK 1033 "Unknown sonic.exe, proceeding with US EXE + Mod Loader installation."
LangString DE_DETECT 1033 "Detecting the type of SADX installation..."
LangString DE_2010FOUND 1033 "2010 version detected (Sonic Adventure DX.exe)"
LangString DE_C_2010 1033 "Checking integrity of SADX 2010 installation..."
LangString DE_E_TOOLS 1033 "Extracting tools..."
LangString DE_C_TOOLS 1033 "Verifying tools..."
LangString DE_E_SCR 1033 "Extracting scripts..."
LangString DE_E_VOICES 1033 "Installing additional voices..."
LangString DE_SAVE 1033 "Copying SADX 2010 saves to SADX 2004 savedata folder..."
LangString DE_DPI 1033 "Adding High DPI/fullscreen optimizations exception for sonic.exe..."
LangString DE_FSOPT 1033 "Adding fullscreen optimization and DPI exception for sonic.exe..."
LangString DE_FSOPTNOTFOUND 1033 "Fullscreen optimizations toggle not present, adding DPI exception..."
LangString DE_CLEANUP 1033 "Cleaning up..."
LangString DE_E_LAUNCHER 1033 "Extracting SADX Launcher..."
LangString DE_CHECKNET 1033 "Checking .NET Framework version..."
LangString DE_E_NET 1033 "Installing .NET Framework..."
LangString DE_NETPRESENT 1033 ".NET Framework 4.8 is already installed ($NetFrameworkVersion)."
LangString DE_C_VCC 1033 "Checking Visual C++ runtimes and installing if necessary..."
LangString DE_E_VC2010 1033 "Extracting Visual C++ 2010 runtime..."
LangString DE_I_VC2010 1033 "Installing Visual C++ 2010 runtime..."
LangString DE_E_VC2012 1033 "Extracting Visual C++ 2012 runtime..."
LangString DE_I_VC2012 1033 "Installing Visual C++ 2012 runtime..."
LangString DE_E_VC2013 1033 "Extracting Visual C++ 2013 runtime..."
LangString DE_I_VC2013 1033 "Installing Visual C++ 2013 runtime..."
LangString DE_E_VC2019 1033 "Extracting Visual C++ 2019 runtime..."
LangString DE_I_VC2019 1033 "Installing Visual C++ 2019 runtime..."
LangString DE_C_DX9 1033 "Checking DirectX 9.0c and installing if necessary..."
LangString DE_I_DX9_1 1033 "Running DirectX Setup (1)..."
LangString DE_I_DX9_2 1033 "Running DirectX Setup (2)..."
LangString DE_B_SADXFE 1033 "Backing up SADXFE settings..."
LangString DE_R_SADXFE 1033 "Restoring SADXFE config..."
LangString DE_B_INPUT 1033 "Backing up Input Mod settings..."
LangString DE_R_INPUT 1033 "Restoring Input Mod config..."
LangString DE_B_GAMEC 1033 "Backing up game controller database..."
LangString DE_R_GAMEC 1033 "Restoring game controller database..."
LangString DE_B_DCCONV 1033 "Backing up Dreamcast Conversion settings..."
LangString DE_E_DCCONV 1033 "Extracting Dreamcast Conversion..."
LangString DE_R_DCCONV 1033 "Restoring Dreamcast Conversion settings..."
LangString DE_DCTITLE_ON 1033 "Enabling DC Conversion window title..."
LangString DE_DCTITLE_OFF 1033 "Disabling DC Conversion window title..."
LangString DE_WTR_ON 1033 "Enabling SADX Style Water..."
LangString DE_WTR_OFF 1033 "Disabling SADX Style Water..."
LangString DE_B_SA1CHARS 1033 "Backing up Dreamcast Characters config..."
LangString DE_R_SA1CHARS 1033 "Restoring Dreamcast Characters config..."
LangString DE_B_DLCS 1033 "Backing up Dreamcast DLCs config..."
LangString DE_E_DLCS 1033 "Extracting SA1 DLC Content..."
LangString DE_R_DLCS 1033 "Restoring Dreamcast DLCs config..."
LangString DE_E_STEAM 1033 "Extracting Steam Achievements..."
LangString DE_E_DSOUND 1033 "Adding DirectSound DLL wrapper..."
LangString DE_I_DSOUNDINI 1033 "Adding dsound.ini..."
LangString DE_MODORDER 1033 "Configuring mod order..."
LangString DE_B_MLINI 1033 "Backing up SADXModLoader.ini..."
LangString DE_I_MLINI 1033 "Adding SADXModLoader.ini..."
LangString DE_B_SADXINI 1033 "Backing up sonicDX.ini..."
LangString DE_I_SADXINI 1033 "Adding sonicDX.ini..."
LangString DE_E_RESOURCES 1033 "Extracting resource data..."
LangString DE_I_RESOURCES 1033 "Patching sonic.exe with custom resources..."

;Mod names (generic installer)
LangString MOD_SADXFE 1033 "SADXFE"
LangString MOD_INPUT 1033 "Input Mod"
LangString MOD_FRAME 1033 "Frame Limiter"
LangString MOD_CCEF 1033 "Camera Code Error Fix"
LangString MOD_SA1CHARS 1033 "Dreamcast Characters"
LangString MOD_LANTERN 1033 "Lantern Engine"
LangString MOD_SMOOTHCAM 1033 "Smooth Camera"
LangString MOD_ONION 1033 "Onion Skin Blur"
LangString MOD_IDLE 1033 "Idle Chatter"
LangString MOD_PAUSE 1033 "Pause Hide"
LangString MOD_SUPER 1033 "Super Sonic"
LangString MOD_EEC 1033 "Enhanced Emerald Coast"
LangString MOD_TIME 1033 "Time Of Day"
LangString MOD_ECMUSIC 1033 "Egg Carrier Ocean Music"
LangString MOD_ADX 1033 "ADX Audio"
LangString MOD_SND 1033 "Sound Overhaul"
LangString MOD_HDGUI 1033 "HD GUI"

;inetc stuff
LangString INETC_DOWNLOADING 1033 "Downloading %s" 
LangString INETC_CONNECT 1033 "Connecting ..."
LangString INETC_SECOND 1033 "second"
LangString INETC_MINUTE 1033 "minute"
LangString INETC_HOUR 1033 "hour"
LangString INETC_PLURAL 1033 "s" 
LangString INETC_PROGRESS 1033 "%dkB (%d%%) of %dkB @ %d.%01dkB/s" 
LangString INETC_REMAINING 1033 "(%d %s%s remaining)"

;Unused strings
${LangFileString} MUI_TEXT_WELCOME_INFO_TITLE " "
${LangFileString} MUI_TEXT_WELCOME_INFO_TEXT " "
${LangFileString} MUI_TEXT_FINISH_TITLE "  "
${LangFileString} MUI_TEXT_FINISH_SUBTITLE "  "
${LangFileString} MUI_TEXT_ABORT_TITLE " "
${LangFileString} MUI_TEXT_ABORT_SUBTITLE " "
${LangFileString} MUI_TEXT_FINISH_INFO_TITLE " "
${LangFileString} MUI_TEXT_FINISH_INFO_TEXT " "
${LangFileString} MUI_TEXT_FINISH_INFO_REBOOT " "
${LangFileString} MUI_TEXT_FINISH_REBOOTNOW " "
${LangFileString} MUI_TEXT_FINISH_REBOOTLATER " "
${LangFileString} MUI_TEXT_FINISH_RUN " "
${LangFileString} MUI_TEXT_FINISH_SHOWREADME " "
${LangFileString} MUI_INNERTEXT_LICENSE_BOTTOM_CHECKBOX " "
${LangFileString} MUI_INNERTEXT_LICENSE_BOTTOM_RADIOBUTTONS " "