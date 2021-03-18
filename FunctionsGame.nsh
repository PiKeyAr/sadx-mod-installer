; Functions related to reading and writing game and Mod Loader settings

; Read sonicDX.ini and SADXModLoader.ini for the custom settings dialog
Function ModLoaderSettings
	${If} $ModLoaderSettingMode == "1"
		Call fnc_options_Create
	${EndIf}

	; Detect resolution
	System::Call 'user32::GetSystemMetrics(i 0) i .r0'
	System::Call 'user32::GetSystemMetrics(i 1) i .r1'
	StrCpy $Res_HZ $0
	StrCpy $Res_V $1

	; Create sonicDX.ini
	FileOpen $7 "$TEMP\sonicDX.ini" w
	FileClose $7

	; Write default settings
	WriteINIStr "$TEMP\sonicDX.ini" "sonicDX" "framerate" "1"
	WriteINIStr "$TEMP\sonicDX.ini" "sonicDX" "fogemulation" "0"
	WriteINIStr "$TEMP\sonicDX.ini" "sonicDX" "sound3d" "1"
	WriteINIStr "$TEMP\sonicDX.ini" "sonicDX" "screensize" "0"
	WriteINIStr "$TEMP\sonicDX.ini" "sonicDX" "cliplevel" "0"
	WriteINIStr "$TEMP\sonicDX.ini" "sonicDX" "sevoice" "1"
	WriteINIStr "$TEMP\sonicDX.ini" "sonicDX" "bgm" "1"
	WriteINIStr "$TEMP\sonicDX.ini" "sonicDX" "screen" "1"
	WriteINIStr "$TEMP\sonicDX.ini" "sonicDX" "bgmv" "100"
	WriteINIStr "$TEMP\sonicDX.ini" "sonicDX" "voicev" "100"

	; Create SADXModLoader.ini
	FileOpen $7 "$TEMP\SADXModLoader.ini" w
	FileClose $7

	; Default settings
	${ConfigWriteS} "$TEMP\SADXModLoader.ini" "HorizontalResolution=" "640" $3
	${ConfigWriteS} "$TEMP\SADXModLoader.ini" "VerticalResolution=" "480" $3
	${ConfigWriteS} "$TEMP\SADXModLoader.ini" "WindowedFullscreen=" "False" $3
	${ConfigWriteS} "$TEMP\SADXModLoader.ini" "EnableVsync=" "False" $3
	${ConfigWriteS} "$TEMP\SADXModLoader.ini" "StretchFullscreen=" "False" $3
	${ConfigWriteS} "$TEMP\SADXModLoader.ini" "ScaleHud=" "False" $3
	${ConfigWriteS} "$TEMP\SADXModLoader.ini" "PauseWhenInactive=" "False" $3
	${ConfigWriteS} "$TEMP\SADXModLoader.ini" "UpdateCheck=" "True" $3
	${ConfigWriteS} "$TEMP\SADXModLoader.ini" "ModUpdateCheck=" "True" $3
	${ConfigWriteS} "$TEMP\SADXModLoader.ini" "UpdateUnit=" "Days" $3
	${ConfigWriteS} "$TEMP\SADXModLoader.ini" "UpdateFrequency=" "1" $3
	${ConfigWriteS} "$TEMP\SADXModLoader.ini" "AutoMipmap=" "False" $3
	${ConfigWriteS} "$TEMP\SADXModLoader.ini" "TextureFilter=" "False" $3
	${ConfigWriteS} "$TEMP\SADXModLoader.ini" "BackgroundFillMode=" "0" $3
	${ConfigWriteS} "$TEMP\SADXModLoader.ini" "FmvFillMode=" "0" $3

	; Write language settings
	; Japanese
	${If} $LANGUAGE == 1041
		${ConfigWriteS} "$TEMP\SADXModLoader.ini" "TextLanguage=" "0" $3
		${ConfigWriteS} "$TEMP\SADXModLoader.ini" "VoiceLanguage=" "0" $3
	${EndIf}
	; English
	${If} $LANGUAGE == 1033
		${ConfigWriteS} "$TEMP\SADXModLoader.ini" "TextLanguage=" "1" $3
		${ConfigWriteS} "$TEMP\SADXModLoader.ini" "VoiceLanguage=" "1" $3
	${EndIf}
	; French
	${If} $LANGUAGE == 1036
		${ConfigWriteS} "$TEMP\SADXModLoader.ini" "TextLanguage=" "2" $3
		${ConfigWriteS} "$TEMP\SADXModLoader.ini" "VoiceLanguage=" "1" $3
	${EndIf}
	; Spanish
	${If} $LANGUAGE == 1034
		${ConfigWriteS} "$TEMP\SADXModLoader.ini" "TextLanguage=" "3" $3
		${ConfigWriteS} "$TEMP\SADXModLoader.ini" "VoiceLanguage=" "1" $3
	${EndIf}
	; German is missing because the installer doesn't have a German translation

	; Optimal settings
	${If} $ModLoaderSettingMode < "2"
		${ConfigWriteS} "$TEMP\SADXModLoader.ini" "HorizontalResolution=" "$Res_HZ" $3
		${ConfigWriteS} "$TEMP\SADXModLoader.ini" "VerticalResolution=" "$Res_V" $3
		${ConfigWriteS} "$TEMP\SADXModLoader.ini" "WindowedFullscreen=" "True" $3
		${ConfigWriteS} "$TEMP\SADXModLoader.ini" "EnableVsync=" "True" $3
		${ConfigWriteS} "$TEMP\SADXModLoader.ini" "StretchFullscreen=" "True" $3
		${ConfigWriteS} "$TEMP\SADXModLoader.ini" "ScaleHud=" "True" $3
		${ConfigWriteS} "$TEMP\SADXModLoader.ini" "PauseWhenInactive=" "True" $3
		${ConfigWriteS} "$TEMP\SADXModLoader.ini" "UpdateCheck=" "True" $3
		${ConfigWriteS} "$TEMP\SADXModLoader.ini" "ModUpdateCheck=" "True" $3
		${ConfigWriteS} "$TEMP\SADXModLoader.ini" "UpdateUnit=" "Days" $3
		${ConfigWriteS} "$TEMP\SADXModLoader.ini" "UpdateFrequency=" "1" $3
		${ConfigWriteS} "$TEMP\SADXModLoader.ini" "AutoMipmap=" "True" $3
		${ConfigWriteS} "$TEMP\SADXModLoader.ini" "TextureFilter=" "True" $3
		${ConfigWriteS} "$TEMP\SADXModLoader.ini" "BackgroundFillMode=" "2" $3
		${ConfigWriteS} "$TEMP\SADXModLoader.ini" "FmvFillMode=" "1" $3
	${EndIf}
	; Load settings and show dialog if using Manual mode
	${If} $ModLoaderSettingMode == "1"
		${NSD_SetText} $hCtl_options_XRes $Res_HZ
		${NSD_SetText} $hCtl_options_YRes $Res_V
		${NSD_CB_SelectString} $hCtl_options_FramerateBox "60 FPS"
		${NSD_CB_SelectString} $hCtl_options_ClippingBox $(SET_HIGH)
		${NSD_Check} $hCtl_options_VSyncCheckBox
		${NSD_CB_SelectString} $hCtl_options_ScreenModeBox $(SET_FULLSCREEN)
		${NSD_Check} $hCtl_options_ScaleCheckBox
		${NSD_Check} $hCtl_options_PauseCheckbox
		${NSD_Check} $hCtl_options_BorderlessCheckBox
		${NSD_Check} $hCtl_options_UIScalingCheckBox
		${NSD_Check} $hCtl_options_UpdatesCheckbox
		${NSD_Check} $hCtl_options_ModUpdatesCheckbox
		IfFileExists "$INSTDIR\sonicDX.ini" loadsonicdxini 0
		IfFileExists "$INSTDIR\mods\SADXModLoader.ini" loadmodloaderini showdialog
	${Else}
		Goto showdialog
	${EndIf}

	loadsonicdxini:
	DetailPrint $(DE_PREVIOUS_DX)
	${ConfigReadS} "$INSTDIR\sonicDX.ini" "screen=" $Whatev
	StrCmp $Whatev "0" 0 +2
	${NSD_CB_SelectString} $hCtl_options_ScreenModeBox $(SET_WINDOWED)
	StrCmp $Whatev "1" 0 +2
	${NSD_CB_SelectString} $hCtl_options_ScreenModeBox $(SET_FULLSCREEN)
	${ConfigReadS} "$INSTDIR\sonicDX.ini" "framerate=" $Whatev
	StrCmp $Whatev "2" 0 +2
	${NSD_CB_SelectString} $hCtl_options_FramerateBox "30 FPS"
	StrCmp $Whatev "3" 0 +2
	${NSD_CB_SelectString} $hCtl_options_FramerateBox "15 FPS"
	${ConfigReadS} "$INSTDIR\sonicDX.ini" "cliplevel=" $Whatev
	StrCmp $Whatev "1" 0 +2
	${NSD_CB_SelectString} $hCtl_options_ClippingBox $(SET_LOW)
	StrCmp $Whatev "2" 0 +2
	${NSD_CB_SelectString} $hCtl_options_ClippingBox $(SET_LOWEST)
	IfFileExists "$INSTDIR\mods\SADXModLoader.ini" loadmodloaderini showdialog

	loadmodloaderini:
	DetailPrint $(DE_PREVIOUS_ML)
	System::Call 'user32::GetSystemMetrics(i 0) i .r0'
	System::Call 'user32::GetSystemMetrics(i 1) i .r1'
	${NSD_SetText} $hCtl_options_XRes $0
	${NSD_SetText} $hCtl_options_YRes $1
	${NSD_GetText} $hCtl_options_ScreenModeBox $Whatev

	${If} $Whatev == $(SET_WINDOWED)
		${ConfigReadS} "$INSTDIR\mods\SADXModLoader.ini" "HorizontalResolution=" $Whatev
		${NSD_SetText} $hCtl_options_XRes $Whatev
		${ConfigReadS} "$INSTDIR\mods\SADXModLoader.ini" "VerticalResolution=" $Whatev
		${NSD_SetText} $hCtl_options_YRes $Whatev
	${EndIf}

	${ConfigReadS} "$INSTDIR\mods\SADXModLoader.ini" "WindowedFullscreen=" $Whatev
	${NSD_UnCheck} $hCtl_options_BorderlessCheckBox
	StrCmp $Whatev "True" 0 +2
	${NSD_Check} $hCtl_options_BorderlessCheckBox

	${ConfigReadS} "$INSTDIR\mods\SADXModLoader.ini" "EnableVsync=" $Whatev
	StrCmp $Whatev "False" 0 +2
	${NSD_Uncheck} $hCtl_options_VSyncCheckBox

	${ConfigReadS} "$INSTDIR\mods\SADXModLoader.ini" "StretchFullscreen=" $Whatev
	StrCmp $Whatev "False" 0 +2
	${NSD_Uncheck} $hCtl_options_ScaleCheckBox

	${ConfigReadS} "$INSTDIR\mods\SADXModLoader.ini" "ScaleHud=" $Whatev
	StrCmp $Whatev "True" 0 +2
	${NSD_Check} $hCtl_options_UIScalingCheckbox

	${ConfigReadS} "$INSTDIR\mods\SADXModLoader.ini" "PauseWhenInactive=" $Whatev
	StrCmp $Whatev "False" 0 +2
	${NSD_Uncheck} $hCtl_options_PauseCheckbox

	${ConfigReadS} "$INSTDIR\mods\SADXModLoader.ini" "UpdateCheck=" $Whatev
	StrCmp $Whatev "False" 0 +2
	${NSD_Uncheck} $hCtl_options_UpdatesCheckbox

	${ConfigReadS} "$INSTDIR\mods\SADXModLoader.ini" "ModUpdateCheck=" $Whatev
	StrCmp $Whatev "False" 0 +2
	${NSD_Uncheck} $hCtl_options_ModUpdatesCheckbox

	${ConfigReadS} "$INSTDIR\mods\SADXModLoader.ini" "UpdateUnit=" $Whatev
	${If} $Whatev == ""
		${NSD_SetText} $hCtl_options_UpdateBox $(SET_DAYS)
	${EndIf}
	${If} $Whatev == "Days"
		${NSD_SetText} $hCtl_options_UpdateBox $(SET_DAYS)
	${EndIf}
	${If} $Whatev == "Weeks"
		${NSD_SetText} $hCtl_options_UpdateBox $(SET_WEEKS)
	${EndIf}
	${If} $Whatev == "Hours"
		${NSD_SetText} $hCtl_options_UpdateBox $(SET_HOURS)
	${EndIf}
	${If} $Whatev == "Weeks"
		${NSD_SetText} $hCtl_options_UpdateBox $(SET_ALWAYS)
	${EndIf}

	${ConfigReadS} "$INSTDIR\mods\SADXModLoader.ini" "UpdateFrequency=" $Whatev
	${NSD_SetText} $hCtl_options_UpdateDaysCount $Whatev
	${If} $Whatev == ""
		${NSD_SetText} $hCtl_options_UpdateDaysCount "1"
	${EndIf}
	goto showdialog

	showdialog:
	${If} $ModLoaderSettingMode == "1"
		nsDialogs::Show
	${EndIf}
FunctionEnd

; Save sonicDX.ini and SADXModLoader.ini after the custom settings dialog
Function WriteSettings
	; Create sonicDX.ini
	FileOpen $7 "$TEMP\sonicDX.ini" w
	FileClose $7

	; Default settings
	WriteINIStr "$TEMP\sonicDX.ini" "sonicDX" "framerate" "1"
	WriteINIStr "$TEMP\sonicDX.ini" "sonicDX" "fogemulation" "0"
	WriteINIStr "$TEMP\sonicDX.ini" "sonicDX" "sound3d" "1"
	WriteINIStr "$TEMP\sonicDX.ini" "sonicDX" "screensize" "2"
	WriteINIStr "$TEMP\sonicDX.ini" "sonicDX" "cliplevel" "0"
	WriteINIStr "$TEMP\sonicDX.ini" "sonicDX" "sevoice" "1"
	WriteINIStr "$TEMP\sonicDX.ini" "sonicDX" "bgm" "1"
	WriteINIStr "$TEMP\sonicDX.ini" "sonicDX" "screen" "0"
	WriteINIStr "$TEMP\sonicDX.ini" "sonicDX" "bgmv" "100"
	WriteINIStr "$TEMP\sonicDX.ini" "sonicDX" "voicev" "100"

	; Custom settings
	${If} $ModLoaderSettingMode < 2
		${NSD_GetText} $hCtl_options_ScreenModeBox $Whatev
		${If} $Whatev == $(SET_FULLSCREEN)
			WriteINIStr "$TEMP\sonicDX.ini" "sonicDX" "screen" "1"
		${EndIf}

		${If} $Whatev == $(SET_WINDOWED)
			WriteINIStr "$TEMP\sonicDX.ini" "sonicDX" "screen" "0"
		${EndIf}
	
		${NSD_GetText} $hCtl_options_FramerateBox $Whatev
		${If} $Whatev == "60 FPS"
			WriteINIStr "$TEMP\sonicDX.ini" "sonicDX" "framerate" "1"
		${EndIf}
	
		${If} $Whatev == "30 FPS"
			WriteINIStr "$TEMP\sonicDX.ini" "sonicDX" "framerate" "2"
		${EndIf}
	
		${If} $Whatev == "15 FPS"
			WriteINIStr "$TEMP\sonicDX.ini" "sonicDX" "framerate" "3"
		${EndIf}
  
		${NSD_GetText} $hCtl_options_ClippingBox $Whatev
		${If} $Whatev == $(SET_HIGH)
			WriteINIStr "$TEMP\sonicDX.ini" "sonicDX" "cliplevel" "0"
		${EndIf}
  
		${If} $Whatev == $(SET_LOW)
			WriteINIStr "$TEMP\sonicDX.ini" "sonicDX" "cliplevel" "1"
		${EndIf}
  
		${If} $Whatev == $(SET_LOWEST)
			WriteINIStr "$TEMP\sonicDX.ini" "sonicDX" "cliplevel" "2"
		${EndIf}
	${EndIf}

	; Create SADXModLoader.ini
	FileOpen $9 "$TEMP\SADXModLoader.ini" w
	FileClose $9
	
	; Default settings
	${ConfigWriteS} "$TEMP\SADXModLoader.ini" "HorizontalResolution=" "640" $3
	${ConfigWriteS} "$TEMP\SADXModLoader.ini" "VerticalResolution=" "480" $3
	${ConfigWriteS} "$TEMP\SADXModLoader.ini" "WindowedFullscreen=" "False" $3
	${ConfigWriteS} "$TEMP\SADXModLoader.ini" "EnableVsync=" "False" $3
	${ConfigWriteS} "$TEMP\SADXModLoader.ini" "StretchFullscreen=" "False" $3
	${ConfigWriteS} "$TEMP\SADXModLoader.ini" "ScaleHud=" "False" $3
	${ConfigWriteS} "$TEMP\SADXModLoader.ini" "PauseWhenInactive=" "False" $3
	${ConfigWriteS} "$TEMP\SADXModLoader.ini" "UpdateCheck=" "True" $3
	${ConfigWriteS} "$TEMP\SADXModLoader.ini" "ModUpdateCheck=" "True" $3
	${ConfigWriteS} "$TEMP\SADXModLoader.ini" "UpdateUnit=" "Days" $3
	${ConfigWriteS} "$TEMP\SADXModLoader.ini" "UpdateFrequency=" "1" $3

; Custom settings
	${If} $ModLoaderSettingMode < 2
		; Width
		${NSD_GetText} $hCtl_options_XRes $Whatev
		${ConfigWriteS} "$TEMP\SADXModLoader.ini" "HorizontalResolution=" $Whatev $3
		IntOp $Whatev $Whatev + 1
		IntOp $Whatev $Whatev - 1
		${If} $Whatev < 640
			${ConfigWriteS} "$TEMP\SADXModLoader.ini" "HorizontalResolution=" "640" $3
		${EndIf}
		
		; Height
		${NSD_GetText} $hCtl_options_YRes $Whatev
		${ConfigWriteS} "$TEMP\SADXModLoader.ini" "VerticalResolution=" $Whatev $3
		IntOp $Whatev $Whatev + 1
		IntOp $Whatev $Whatev - 1
		${If} $Whatev < 480
			${ConfigWriteS} "$TEMP\SADXModLoader.ini" "VerticalResolution=" "480" $3
		${EndIf}
		
		; Borderless
		${NSD_GetState} $hCtl_options_BorderlessCheckBox $Whatev
		${If} $Whatev == ${BST_CHECKED}
			${ConfigWriteS} "$TEMP\SADXModLoader.ini" "WindowedFullscreen=" "True" $3
		${EndIf}
		${If} $Whatev == ${BST_UNCHECKED}
			${ConfigWriteS} "$TEMP\SADXModLoader.ini" "WindowedFullscreen=" "False" $3
		${EndIf}
  
		; VSync
		${NSD_GetState} $hCtl_options_VSyncCheckBox $Whatev
		${If} $Whatev == ${BST_CHECKED}
			${ConfigWriteS} "$TEMP\SADXModLoader.ini" "EnableVsync=" "True" $3
		${EndIf}
		${If} $Whatev == ${BST_UNCHECKED}
			${ConfigWriteS} "$TEMP\SADXModLoader.ini" "EnableVsync=" "False" $3
		${EndIf}
		
		; Scale to screen
		${NSD_GetState} $hCtl_options_ScaleCheckBox $Whatev
		${If} $Whatev == ${BST_CHECKED}
			${ConfigWriteS} "$TEMP\SADXModLoader.ini" "StretchFullscreen=" "True" $3
		${EndIf}
		${If} $Whatev == ${BST_UNCHECKED}
			${ConfigWriteS} "$TEMP\SADXModLoader.ini" "StretchFullscreen=" "False" $3
		${EndIf}

		; UI scaling
		${NSD_GetState} $hCtl_options_UIScalingCheckbox $Whatev
		${If} $Whatev == ${BST_CHECKED}
			${ConfigWriteS} "$TEMP\SADXModLoader.ini" "ScaleHud=" "True" $3
		${EndIf}
		${If} $Whatev == ${BST_UNCHECKED}
			${ConfigWriteS} "$TEMP\SADXModLoader.ini" "ScaleHud=" "False" $3
		${EndIf}

		; Pause when inactive
		${NSD_GetState} $hCtl_options_PauseCheckbox $Whatev
		${If} $Whatev == ${BST_CHECKED}
			${ConfigWriteS} "$TEMP\SADXModLoader.ini" "PauseWhenInactive=" "True" $3
		${EndIf}
		${If} $Whatev == ${BST_UNCHECKED}
			${ConfigWriteS} "$TEMP\SADXModLoader.ini" "PauseWhenInactive=" "False" $3
		${EndIf}

		; Check for updates
		${NSD_GetState} $hCtl_options_UpdatesCheckbox $Whatev
		${If} $Whatev == ${BST_CHECKED}
			${ConfigWriteS} "$TEMP\SADXModLoader.ini" "UpdateCheck=" "True" $3
		${EndIf}
		${If} $Whatev == ${BST_UNCHECKED}
			${ConfigWriteS} "$TEMP\SADXModLoader.ini" "UpdateCheck=" "False" $3
		${EndIf}

		; Check for mod updates
		${NSD_GetState} $hCtl_options_ModUpdatesCheckbox $Whatev
		${If} $Whatev == ${BST_CHECKED}
			${ConfigWriteS} "$TEMP\SADXModLoader.ini" "ModUpdateCheck=" "True" $3
		${EndIf}
		${If} $Whatev == ${BST_UNCHECKED}
			${ConfigWriteS} "$TEMP\SADXModLoader.ini" "ModUpdateCheck=" "False" $3
		${EndIf}

		; Update frequency
		${NSD_GetText} $hCtl_options_UpdateBox $Whatev

		${If} $Whatev == $(SET_DAYS)
			${ConfigWriteS} "$TEMP\SADXModLoader.ini" "UpdateUnit=" "Days" $3
		${EndIf}

		${If} $Whatev == $(SET_WEEKS)
			${ConfigWriteS} "$TEMP\SADXModLoader.ini" "UpdateUnit=" "Weeks" $3
		${EndIf}
  
		${If} $Whatev == $(SET_HOURS)
			${ConfigWriteS} "$TEMP\SADXModLoader.ini" "UpdateUnit=" "Hours" $3
		${EndIf}

		${If} $Whatev == $(SET_ALWAYS)
			${ConfigWriteS} "$TEMP\SADXModLoader.ini" "UpdateUnit=" "Always" $3
		${EndIf}
		
		; Update count
		${NSD_GetText} $hCtl_options_UpdateDaysCount $Whatev
		${ConfigWriteS} "$TEMP\SADXModLoader.ini" "UpdateFrequency=" $Whatev $3
		IntOp $Whatev $Whatev + 1
		IntOp $Whatev $Whatev - 1
		${If} $Whatev == "0"
			${ConfigWriteS} "$TEMP\SADXModLoader.ini" "UpdateFrequency=" "1" $3
		${EndIf}
	${EndIf}
	Pop $3
FunctionEnd