; Main settings
Unicode true
OutFile "sadx_setup.exe"
Icon "resources\installer.ico"
DirText $DirTextThing
BrandingText " "
ShowInstDetails show
RequestExecutionLevel admin
ManifestDPIAware true

; NSIS includes
!include "MUI2.nsh"
!include "FileFunc.nsh"
!include "TextFunc.nsh"
!include "nsProcess.nsh"
!include "Sections.nsh"
!include "nsdialogs_setimageole.nsh"
!include "LogicLib.nsh"
!include "Locate.nsh"
!include "nsDialogs.nsh"
!include "X64.NSH"
!include "WinVer.nsh"

; Custom includes
!include Variables.nsh
!include FunctionsMisc.nsh
!include FunctionsMods.nsh
!include FunctionsGame.nsh
!include MySections.nsh
!include MyPages.nsh

; Use custom UI resources
!define MUI_UI_COMPONENTSPAGE_SMALLDESC "ui\modern_smalldesc.exe"
!define MUI_UI "ui\modern.exe"

; UI settings
!define MUI_LANGDLL_ALLLANGUAGES
!define PRODUCT_NAME $(MISC_INSTALLER)
!define PRODUCT_VERSION "1.0"
!define MUI_COMPONENTSPAGE_SMALLDESC
!define MUI_ICON "resources\installer.ico"

; Pages
Page custom fnc_WelcomePage_Show
!insertmacro MUI_PAGE_LICENSE $(MUILicense)
!define MUI_PAGE_CUSTOMFUNCTION_LEAVE CheckInstallFolder
Page custom SelectUpdates CheckUpdates
!define MUI_PAGE_CUSTOMFUNCTION_PRE CheckDir
!insertmacro MUI_PAGE_DIRECTORY
Page custom SelectType CheckReset
Page custom Guide1
Page custom Guide2
Page custom Guide3
Page custom Guide4
Page custom Guide5
Page custom Guide6
Page custom fnc_Additional_Show
Page custom fnc_iconselect_Show
Page custom ModLoaderSettings WriteSettings
!define MUI_PAGE_CUSTOMFUNCTION_PRE CheckCustom
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_INSTFILES
;!define MUI_FINISHPAGE_NOAUTOCLOSE
Page custom fnc_FinishPage_Show CreateShortcuts
!insertmacro MUI_PAGE_FINISH

; Translations
!insertmacro MUI_LANGUAGEEX "lang" "English"
!insertmacro MUI_LANGUAGEEX "lang" "French"
!insertmacro MUI_LANGUAGEEX "lang" "Spanish"
!insertmacro MUI_LANGUAGEEX "lang" "Italian"
!insertmacro MUI_LANGUAGEEX "lang" "PortugueseBR"
!insertmacro MUI_LANGUAGEEX "lang" "Japanese"
!insertmacro MUI_LANGUAGEEX "lang" "Korean"
!insertmacro MUI_LANGUAGEEX "lang" "Russian"

LicenseLangString MUILicense ${LANG_ENGLISH} "lang\license\License_EN.rtf"
LicenseLangString MUILicense ${LANG_FRENCH} "lang\license\License_FR.rtf"
LicenseLangString MUILicense ${LANG_SPANISH} "lang\license\License_ES.rtf"
LicenseLangString MUILicense ${LANG_ITALIAN} "lang\license\License_IT.rtf"
LicenseLangString MUILicense ${LANG_PORTUGUESEBR} "lang\license\License_PTBR.rtf"
LicenseLangString MUILicense ${LANG_JAPANESE} "lang\license\License_JP.rtf"
LicenseLangString MUILicense ${LANG_KOREAN} "lang\license\License_KO.rtf"
LicenseLangString MUILicense ${LANG_RUSSIAN} "lang\license\License_RU.rtf"

SetFont "Tahoma" 8

; Localized settings
Name $(MISC_INSTALLER)
Caption $(MISC_INSTALLER)
InstType $(INSTTYPE_DC)
InstType $(INSTTYPE_SADX)
InstType $(INSTTYPE_MIN)

; Assign language strings to sections
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${SECTION_IDLECHATTER} $(DESC_IDLECHATTER)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTION_REMOVEMODS} $(DESC_REMOVEMODS)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTION_MODLOADER} $(DESC_MODLOADER)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTION_LAUNCHER} $(DESC_LAUNCHER)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTION_NET} $(DESC_NET)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTION_VCC} $(DESC_RUNTIME)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTION_ADX} $(DESC_ADXAUDIO)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTION_DIRECTX} $(DESC_DIRECTX)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTION_SADXFE} $(DESC_SADXFE)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTION_INPUTMOD} $(DESC_INPUTMOD)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTION_SMOOTHCAM} $(DESC_SMOOTHCAM)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTION_DLCS} $(DESC_DLCS)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTION_ONIONBLUR} $(DESC_ONIONBLUR)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTION_PERMISSIONS} $(DESC_PERMISSIONS)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTION_STEAM} $(DESC_STEAM)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTION_FRAMELIMIT} $(DESC_FRAMELIMIT)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTION_PAUSEHIDE} $(DESC_PAUSEHIDE)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTION_LANTERN} $(DESC_LANTERN)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTION_DCMODS} $(DESC_DCMODS)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTIONGROUP_BUGFIXES} $(DESC_BUGFIXES)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTIONGROUP_DCCONV} $(DESC_DCCONV)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTIONGROUP_ENHANCEMENTS} $(DESC_ENHANCEMENTS)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTION_SNDOVERHAUL} $(DESC_SNDOVERHAUL)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTION_HDGUI} $(DESC_HDGUI)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTION_TIMEOFDAY} $(DESC_TIMEOFDAY)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTION_SA1CHARS} $(DESC_SA1CHARS)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTIONGROUP_MODLOADER} $(DESC_MODLOADERSTUFF)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTION_SUPERSONIC} $(DESC_SUPERSONIC)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTION_CCEF} $(DESC_CCEF)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTION_EEC} $(DESC_EEC)
!insertmacro MUI_DESCRIPTION_TEXT ${SECTION_ECMUSIC} $(DESC_ECMUSIC)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

; Initialization
Function .onInit
	!insertmacro MUI_LANGDLL_DISPLAY
	; Check Windows version
	StrCpy $IncompatibleOS "0"
	; Not NT based
	${IfNot} ${IsNT}
		StrCpy $IncompatibleOS "1"
	${EndIf}
	; Not Windows 7 or later
	${IfNot} ${AtLeastWin7}
		StrCpy $IncompatibleOS "1"
	${EndIf}
	; Not SP1 on 7
	${If} ${IsWin7}
		${IfNot} ${AtLeastServicePack} 1
			StrCpy $IncompatibleOS "1"
		${EndIf}
	${EndIf}
	; Show incompatible OS message
	StrCmp $IncompatibleOS "1" 0 +3
	MessageBox MB_YESNO $(ERR_REQUIREDOS) IDYES +2 IDNO 0
	Quit
	StrCpy $BuildNumber "Build 33"
	; Delete old mods
	${If} ${FileExists} "$EXEDIR\instdata\OptionalMods.7z"
		Delete "$EXEDIR\instdata\OptionalMods.7z"
	${EndIf}
	${If} ${FileExists} "$EXEDIR\instdata\DLCCircuits.7z"
		Delete "$EXEDIR\instdata\DLCCircuits.7z"
	${EndIf}
	${If} ${FileExists} "$EXEDIR\instdata\input-mod.7z"
		Delete "$EXEDIR\instdata\input-mod.7z"
	${EndIf}
	${If} ${FileExists} "$EXEDIR\instdata\DC_Branding.7z"
		Delete "$EXEDIR\instdata\DC_Branding.7z"
	${EndIf}
	${If} ${FileExists} "$EXEDIR\instdata\DC_Levels.7z"
		Delete "$EXEDIR\instdata\DC_Levels.7z"
	${EndIf}
	${If} ${FileExists} "$EXEDIR\instdata\ECGardenOceanFix.7z"
		Delete "$EXEDIR\instdata\ECGardenOceanFix.7z"
	${EndIf}
	${If} ${FileExists} "$EXEDIR\instdata\MR_FinalEggFix.7z"
		Delete "$EXEDIR\instdata\MR_FinalEggFix.7z"
	${EndIf}
	${If} ${FileExists} "$EXEDIR\instdata\SETFixes.7z"
		Delete "$EXEDIR\instdata\SETFixes.7z"
	${EndIf}
	; Self-update
	${If} $EXEFILE != "sadx_setup.exe"
		${nsProcess::KillProcess} "sadx_setup.exe" $R0
		Pop $R0
		Delete "$EXEDIR\sadx_setup.exe"
		CopyFiles /SILENT "$EXEDIR\$EXEFILE" "$EXEDIR\sadx_setup.exe"
		ExecShell "" "$EXEDIR\sadx_setup.exe"
		Quit
	${EndIf}
	; Delete self-update leftovers
	${If} $EXEFILE == "sadx_setup.exe"
		${nsProcess::KillProcess} "sadx_setup2.exe" $R0
		Pop $R0
		Delete "$EXEDIR\sadx_setup2.exe"
	${EndIf}
	; Section setup
	SetCurInstType 0
	SectionSetFlags ${SECTION_MODLOADER} 17
	SectionSetFlags ${SECTION_LAUNCHER} 17
	SectionSetSize ${SECTION_NET} 1200
	SectionSetSize ${SECTION_DIRECTX} 98304
	SectionSetSize ${SECTION_MODLOADER} 5800
	SectionSetSize ${SECTION_LAUNCHER} 15000
	SectionSetSize ${SECTION_VCC} 35000
	SectionSetSize ${SECTION_INPUTMOD} 1100
	SectionSetSize ${SECTION_DLCS} 30000
	SectionSetSize ${SECTION_PAUSEHIDE} 7
	SectionSetSize ${SECTION_SMOOTHCAM} 8
	SectionSetSize ${SECTION_FRAMELIMIT} 16
	SectionSetSize ${SECTION_STEAM} 115
	SectionSetSize ${SECTION_ADX} 620000
	SectionSetSize ${SECTION_SADXFE} 15000
	SectionSetSize ${SECTION_LANTERN} 1400
	SectionSetSize ${SECTION_DCMODS} 316000
	SectionSetSize ${SECTION_SNDOVERHAUL} 206000
	SectionSetSize ${SECTION_HDGUI} 36000
	SectionSetSize ${SECTION_TIMEOFDAY} 400
	SectionSetSize ${SECTION_CCEF} 7
	SectionSetSize ${SECTION_IDLECHATTER} 7
	SectionSetSize ${SECTION_PAUSEHIDE} 7
	SectionSetSize ${SECTION_SA1CHARS} 7000
	SectionSetSize ${SECTION_SUPERSONIC} 11
	SectionSetSize ${SECTION_FRAMELIMIT} 15
	SectionSetSize ${SECTION_TIMEOFDAY} 10
	SectionSetSize ${SECTION_EEC} 2850
	SectionSetSize ${SECTION_INPUTMOD} 1050
	SectionSetSize ${SECTION_ECMUSIC} 7
	; Initialize variables
	IntOp $EnableWindowTitle 0 + 0
	StrCpy $EnableCustomIcon "0"
	StrCpy $CustomIconNumber "0"
	StrCpy $ModScreenNumber "0"
	StrCpy $ModScreenOff "0"
	StrCpy $Final_SADX "0"
	StrCpy $Final_Shortcuts "0"
	StrCpy $Final_Launcher "0"
	IntOp $ModLoaderSettingMode 0 + 0
	IntOp $ModIndex 0 + 0
	IntOp $INST_ADX 0 + 0
	IntOp $INST_SADXFE 0 + 0
	IntOp $INST_LANTERN 0 + 0
	IntOp $INST_DCMODS 0 + 0
	IntOp $INST_SA1CHARS 0 + 0
	IntOp $INST_SNDOVERHAUL 0 + 0
	IntOp $INST_HDGUI 0 + 0
	IntOp $INST_TIMEOFDAY 0 + 0
	IntOp $INST_INPUTMOD 0 + 0
	IntOp $INST_SMOOTHCAM 0 + 0
	IntOp $INST_PAUSEHIDE 0 + 0
	IntOp $INST_FRAMELIMIT 0 + 0
	IntOp $INST_ONIONBLUR 0 + 0
	IntOp $INST_SADXWTR 0 + 0
	IntOp $INST_SA1CHARS 0 + 0
	IntOp $INST_DLCS 0 + 0
	IntOp $INST_STEAM 0 + 0
	IntOp $INST_SUPERSONIC 0 + 0
	IntOp $INST_ECMUSIC 0 + 0
	IntOp $INST_EEC 0 + 0
	IntOp $INST_CCEF 0 + 0
	IntOp $INST_IDLECHATTER 0 + 0
	IntOp $PreserveModSettings 1 + 0
	IntOp $GuideMode 1 + 0
FunctionEnd

Function EnableInstallIcon
	${NSD_SetText} $hCtl_TypeSel_TypeComment $(DESC_ICON)
	${If} $EnableCustomIcon != "1"
		StrCpy $EnableCustomIcon "1"
	${NSD_Check} $hCtl_TypeSel_CheckBox_InstallIcon
	${Else}
		${NSD_UnCheck} $hCtl_TypeSel_CheckBox_InstallIcon
		StrCpy $EnableCustomIcon "0"
	${EndIf}
FunctionEnd

; Set localized descriptions
Function SetDesc_Profiles
	IntOp $GuideMode 0 + 0
	${NSD_UnCheck} $hCtl_TypeSel_Option_Custom
	${NSD_UnCheck} $hCtl_TypeSel_Option_Guide
	${NSD_Check} $hCtl_TypeSel_Option_DC
	ShowWindow $hCtl_TypeSel_GroupBox_Presets ${SW_SHOW}
	ShowWindow $hCtl_TypeSel_Option_DC ${SW_SHOW}
	ShowWindow $hCtl_TypeSel_Option_Enhanced ${SW_SHOW}
	ShowWindow $hCtl_TypeSel_Option_Minimal ${SW_SHOW}
	${NSD_UnCheck} $hCtl_TypeSel_RadioButton_SettingsManual
	${NSD_Check} $hCtl_TypeSel_RadioButton_SettingsOptimal
	${NSD_UnCheck} $hCtl_TypeSel_RadioButton_SettingsFailsafe
	StrCpy $ModLoaderSettingMode "0"
	Call SetDesc_DC
FunctionEnd

Function SetDesc_DC
	IntOp $GuideMode 0 + 0
	${NSD_SetText} $hCtl_TypeSel_TypeComment $(DESC_DCMODS_ALL) 
	IntOp $InstallType 0 + 0
	SetCurInstType 0
	${NSD_UnCheck} $hCtl_TypeSel_Option_Enhanced
	${NSD_UnCheck} $hCtl_TypeSel_Option_Minimal
FunctionEnd

Function SetDesc_Manual
	${NSD_SetText} $hCtl_TypeSel_TypeComment $(DESC_MANUAL)
	StrCpy $ModLoaderSettingMode "1"
FunctionEnd

Function SetDesc_Optimal
	${NSD_SetText} $hCtl_TypeSel_TypeComment $(DESC_OPTIMAL)
	StrCpy $ModLoaderSettingMode "0"
FunctionEnd

Function SetDesc_FailSafe
	${NSD_SetText} $hCtl_TypeSel_TypeComment $(DESC_FAILSAFE)
	StrCpy $ModLoaderSettingMode "2"
FunctionEnd

Function SetDesc_WindowTitle
	${NSD_SetText} $hCtl_TypeSel_TypeComment $(DESC_WINDOWTITLE)
	${NSD_GetState} $hCtl_sel_WindowTitle $Whatev
	${If} $Whatev == ${BST_CHECKED}
		IntOp $EnableWindowTitle 0 + 1
	${Else}
		IntOp $EnableWindowTitle 0 + 0
	${EndIf}
FunctionEnd

Function SetDesc_Enhanced
	IntOp $GuideMode 0 + 0
	${NSD_SetText} $hCtl_TypeSel_TypeComment $(DESC_SADX_ALL)
	IntOp $InstallType 0 + 1
	SetCurInstType 1
	${NSD_UnCheck} $hCtl_TypeSel_Option_DC
	${NSD_UnCheck} $hCtl_TypeSel_Option_Minimal
FunctionEnd

Function SetDesc_Minimum
	IntOp $GuideMode 0 + 0
	${NSD_SetText} $hCtl_TypeSel_TypeComment $(DESC_MIN_ALL)
	IntOp $InstallType 0 + 2
	SetCurInstType 2
	${NSD_UnCheck} $hCtl_TypeSel_Option_DC
	${NSD_UnCheck} $hCtl_TypeSel_Option_Enhanced
FunctionEnd

Function SetDesc_Custom
	IntOp $GuideMode 0 + 0
	${NSD_SetText} $hCtl_TypeSel_TypeComment $(DESC_CUSTOM_ALL)
	IntOp $InstallType 0 + 3
	SetCurInstType 0
	${NSD_Check} $hCtl_TypeSel_RadioButton_SettingsManual
	${NSD_UnCheck} $hCtl_TypeSel_RadioButton_SettingsOptimal
	${NSD_UnCheck} $hCtl_TypeSel_RadioButton_SettingsFailsafe
	StrCpy $ModLoaderSettingMode "1"
	ShowWindow $hCtl_TypeSel_GroupBox_Presets ${SW_HIDE}
	ShowWindow $hCtl_TypeSel_Option_DC ${SW_HIDE}
	ShowWindow $hCtl_TypeSel_Option_Enhanced ${SW_HIDE}
	ShowWindow $hCtl_TypeSel_Option_Minimal ${SW_HIDE}
	${NSD_UnCheck} $hCtl_TypeSel_Option_Presets
	${NSD_UnCheck} $hCtl_TypeSel_Option_Guide
FunctionEnd

Function SetDesc_Guide
	IntOp $GuideMode 1 + 0
	IntOp $InstallType 0 + 0
	SetCurInstType 0
	${NSD_SetText} $hCtl_TypeSel_TypeComment $(DESC_GUIDE_ALL)
	; Hide profiles
	${NSD_UnCheck} $hCtl_TypeSel_RadioButton_SettingsManual
	${NSD_Check} $hCtl_TypeSel_RadioButton_SettingsOptimal
	${NSD_UnCheck} $hCtl_TypeSel_RadioButton_SettingsFailsafe
	StrCpy $ModLoaderSettingMode "0"
	ShowWindow $hCtl_TypeSel_GroupBox_Presets ${SW_HIDE}
	ShowWindow $hCtl_TypeSel_Option_DC ${SW_HIDE}
	ShowWindow $hCtl_TypeSel_Option_Enhanced ${SW_HIDE}
	ShowWindow $hCtl_TypeSel_Option_Minimal ${SW_HIDE}
	${NSD_UnCheck} $hCtl_TypeSel_Option_Custom
	${NSD_UnCheck} $hCtl_TypeSel_Option_Presets
FunctionEnd

; Show install type dialog
Function SelectType
	IntOp $InstallType 0 + 0
	Call fnc_TypeSel_Create
	nsDialogs::Show
FunctionEnd

; Check the "reset settings" checkbox
Function CheckReset
	${NSD_GetState} $hCtl_TypeSel_RadioButton_SettingsFailsafe $Whatev
	${If} $Whatev == ${BST_CHECKED}
		MessageBox MB_YESNO|MB_ICONINFORMATION $(MSG_DEFAULT) IDYES continue IDNO dontcontinue
	${EndIf}
	Pop $Whatev
	Goto continue
	dontcontinue:
		Abort
	continue:
FunctionEnd

; Check if Steam Achievements or ADX Audio are needed
Function CheckCustom
	IfFileExists "$INSTDIR\system\sounddata\bgm\wma\advamy.adx" checksteam 0
	IfFileExists "$INSTDIR\SoundData\bgm\wma\advamy.adx" checksteam addadx
	addadx:
		${If} $InstallType != "2"
			!insertmacro SelectSection ${SECTION_ADX}
		${EndIf}
		goto checksteam
	checksteam:
		IfFileExists "$INSTDIR\*.vdf" addsteamachievements endchk
	addsteamachievements:
		${If} $InstallType != "2"
			!insertmacro SelectSection ${SECTION_STEAM}
		${EndIf}
		goto endchk
	endchk:
		; Hide the components window if the Custom profile isn't selected
		${If} $InstallType != "3"
			Abort
		${EndIf}
FunctionEnd

; Desktop shortcuts
Function CreateShortcuts
	${If} $Final_Shortcuts <> 0
		SetOutPath "$INSTDIR"
		CreateShortcut "$Desktop\Sonic Adventure DX.lnk" "$INSTDIR\sonic.exe"
		CreateShortcut "$Desktop\SADX Mod Manager.lnk" "$INSTDIR\SADXModManager.exe"
	${EndIf}
	${NSD_GetState} $hCtl_FinishPage_CheckBox_RunSADX $0
	${If} $Final_SADX <> 0
		Call RunSADX
	${EndIf}
	${NSD_GetState} $hCtl_FinishPage_CheckBox_RunLauncher $0
	${If} $Final_Launcher <> 0
		Call RunLauncher
	${EndIf}
	Quit
FunctionEnd

; Find SADX folder
Function CheckDir
	StrCpy $DirTextThing $(MSG_FOLDER_FOUND)
	goto detectsteam

	notsteammaybe:
		SetRegView 32
		ReadRegStr $InstallPathTemp3 HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SEGA\Dreamcast Collection" "DisplayIcon"
		StrCmp $InstallPathTemp3 "" sadx2004 0
		StrCpy $InstallPathTemp2 $InstallPathTemp3 -13
		StrCpy $InstallPathTemp2 "$InstallPathTemp2\Sonic Adventure DX"
		StrCpy $InstallPath $InstallPathTemp2
	goto setpath

	sadx2004:
		SetRegView 32
		ReadRegStr $InstallPathTemp HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SONICADVDX" "UninstallString"
		StrCpy $InstallPath $InstallPathTemp -12
		StrCmp $InstallPath "" notfound setpath
		goto setpath
	
	detectsteam:
		${If} ${RunningX64}
			SetRegView 64
		${EndIf}
		ReadRegStr $InstallPath HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 71250" "InstallLocation"
		StrCmp $InstallPath "" 0 setpath
		SetRegView 32
		ReadRegStr $InstallPath HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 71250" "InstallLocation"
		StrCmp $InstallPath "" notsteammaybe setpath
		goto setpath

	notfound:
		StrCpy $DirTextThing $(MSG_FOLDER_NOTFOUND)
		StrCpy $InstallPath "C:\Games\SonicAdventureDX"
		goto setpath
	
	setpath:
		StrCpy $INSTDIR $InstallPath
FunctionEnd