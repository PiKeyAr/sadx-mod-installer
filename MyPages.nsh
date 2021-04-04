; This file contains code for all custom dialogs

; Additional mods
Function fnc_Additional_Create
	; === Additional (type: Dialog) ===
	nsDialogs::Create 1018
	Pop $hCtl_Additional
	${If} $hCtl_Additional == error
		Abort
	${EndIf}
	${NSD_AddExStyle} $hCtl_Additional ${WS_EX_ACCEPTFILES}

	!insertmacro MUI_HEADER_TEXT $(HEADER_ADD_TITLE) $(HEADER_ADD_TEXT)

	; === ModsDesc (type: Label) ===
	${NSD_CreateLabel} 0u 0u 390.99u 31.38u $(DESC_ADD_ALL)
	Pop $hCtl_Additional_ModsDesc

	; === CheckBox_SoundOverhaul (type: Checkbox) ===
	${NSD_CreateCheckbox} 0u 85.54u 400.86u 14.77u $(DESC_ADD_SND)
	Pop $hCtl_Additional_CheckBox_SoundOverhaul
	GetFunctionAddress $0 SndToggle
	nsDialogs::OnClick $hCtl_Additional_CheckBox_SoundOverhaul $0
	${NSD_Check} $hCtl_Additional_CheckBox_SoundOverhaul
	!insertmacro SelectSection ${SECTION_SNDOVERHAUL}

	; === CheckBox_DLCs (type: Checkbox) ===
	${NSD_CreateCheckbox} 0u 122.46u 400.86u 14.77u $(DESC_ADD_DLCS)
	Pop $hCtl_Additional_CheckBox_DLCs
	GetFunctionAddress $0 DLCToggle
	nsDialogs::OnClick $hCtl_Additional_CheckBox_DLCs $0
	!insertmacro UnselectSection ${SECTION_DLCS}

	; === CheckBox_SuperSonic (type: Checkbox) ===
	${NSD_CreateCheckbox} 0u 104u 400.86u 14.77u $(DESC_ADD_SUPER)
	Pop $hCtl_Additional_CheckBox_SuperSonic
	GetFunctionAddress $0 SuperSonicToggle
	nsDialogs::OnClick $hCtl_Additional_CheckBox_SuperSonic $0
	!insertmacro UnselectSection ${SECTION_SUPERSONIC}
FunctionEnd

; Dialog show function
Function fnc_Additional_Show
	${If} $GuideMode == "1"
		Call fnc_Additional_Create
		nsDialogs::Show
	${EndIf}
FunctionEnd

; Screen compare
Function fnc_ScreenCompare_Create
	; Load files
	File "/oname=$PLUGINSDIR\0_0.jpg" "resources\compare\0_0.jpg"
	File "/oname=$PLUGINSDIR\0_1.jpg" "resources\compare\0_1.jpg"
	File "/oname=$PLUGINSDIR\1_0.jpg" "resources\compare\1_0.jpg"
	File "/oname=$PLUGINSDIR\1_1.jpg" "resources\compare\1_1.jpg"
	File "/oname=$PLUGINSDIR\2_0.jpg" "resources\compare\2_0.jpg"
	File "/oname=$PLUGINSDIR\2_1.jpg" "resources\compare\2_1.jpg"
	File "/oname=$PLUGINSDIR\3_0.jpg" "resources\compare\3_0.jpg"
	File "/oname=$PLUGINSDIR\3_1.jpg" "resources\compare\3_1.jpg"
	File "/oname=$PLUGINSDIR\4_0.jpg" "resources\compare\4_0.jpg"
	File "/oname=$PLUGINSDIR\4_1.jpg" "resources\compare\4_1.jpg"
	File "/oname=$PLUGINSDIR\5_0.jpg" "resources\compare\5_0.jpg"
	File "/oname=$PLUGINSDIR\5_1.jpg" "resources\compare\5_1.jpg"
	
	; === ScreenCompare (type: Dialog) ===
	nsDialogs::Create 1018
	Pop $hCtl_ScreenCompare
	${If} $hCtl_ScreenCompare == error
		Abort
	${EndIf}
	!insertmacro MUI_HEADER_TEXT $(HEADER_GUIDE_TITLE) $(HEADER_GUIDE_TEXT)

	; === CheckBox1 (type: Checkbox) ===
	${NSD_CreateCheckbox} 0u 179.69u 288.91u 14.77u $(GUIDE_INST_LANTERN)
	Pop $hCtl_ScreenCompare_CheckBox1
	${If} $ModScreenNumber == "2"
		${NSD_UnCheck} $hCtl_ScreenCompare_CheckBox1
	${Else}
		${NSD_Check} $hCtl_ScreenCompare_CheckBox1
	${EndIf}
	GetFunctionAddress $0 ReloadModImage
	nsDialogs::OnClick $hCtl_ScreenCompare_CheckBox1 $0
	
	; === ModDescription (type: Label) ===
	${NSD_CreateLabel} 0u 0u 394.94u 24.0u $(GUIDE_INFO_LANTERN)
	Pop $hCtl_ScreenCompare_ModDescription
	
	; === Bitmap1 (type: Bitmap) ===
	${NSD_CreateBitmap} 0u 24.0u 394.94u 146.54u ""
	Pop $hCtl_ScreenCompare_Bitmap1
	GetFunctionAddress $0 OpenModComparisonURL
	nsDialogs::OnClick $hCtl_ScreenCompare_Bitmap1 $0
	Call ReloadModImage
FunctionEnd

; Dialog show function
Function fnc_ScreenCompare_Show
	Call fnc_ScreenCompare_Create
	nsDialogs::Show
FunctionEnd

; Check for updates
Function fnc_sel_Create
	; === sel (type: Dialog) ===
	nsDialogs::Create 1018
	Pop $hCtl_sel
	${If} $hCtl_sel == error
		Abort
	${EndIf}
	!insertmacro MUI_HEADER_TEXT $(HEADER_UPDATES_TITLE) $(HEADER_UPDATES_TEXT)

	; === UpdatesText (type: Label) ===
	${NSD_CreateLabel} 0u 0u 385.72u 88u $(MSG_UPDATES)
	Pop $hCtl_sel_UpdatesText

	; === CheckUpdates (type: RadioButton) ===
	${NSD_CreateRadioButton} 0u 104.62u 286.99u 14.77u $(OPTIONNAME_UPDATES)
	Pop $hCtl_sel_CheckUpdates
	${NSD_Check} $hCtl_sel_CheckUpdates

	; === DontCheckUpdates (type: RadioButton) ===
	${NSD_CreateRadioButton} 0u 123.08u 320.99u 14.77u $(OPTIONNAME_NOUPDATES)
	Pop $hCtl_sel_DontCheckUpdates
	${NSD_AddStyle} $hCtl_sel_DontCheckUpdates ${WS_GROUP}

	; === OfflineText (type: Label) ===
	${NSD_CreateLabel} 0u 176.62u 325.82u 14.77u $(MSG_OFFLINE)
	Pop $hCtl_sel_OfflineText
FunctionEnd

; Options
Function fnc_options_Create
	; === options (type: Dialog) ===
	nsDialogs::Create 1018
	Pop $hCtl_options
	${If} $hCtl_options == error
		Abort
	${EndIf}
	!insertmacro MUI_HEADER_TEXT $(HEADER_SET_TITLE) $(HEADER_SET_TEXT)

	; === GroupBox3 (type: GroupBox) ===
	${NSD_CreateGroupBox} 236.96u 0u 153.37u 61.54u $(SET_OTHER)
	Pop $hCtl_options_GroupBox3

	; === PauseCheckbox (type: Checkbox) ===
	${NSD_CreateCheckbox} 247.49u 38.15u 119.14u 15.77u $(SET_PAUSE)
	Pop $hCtl_options_PauseCheckbox

	; === UIScalingCheckbox (type: Checkbox) ===
	${NSD_CreateCheckbox} 247.49u 17.85u 119.14u 15.77u $(SET_UI)
	Pop $hCtl_options_UIScalingCheckbox

	; === GroupBox2 (type: GroupBox) ===
	${NSD_CreateGroupBox} 236.96u 61.54u 153.37u 110.77u $(SET_UPD)
	Pop $hCtl_options_GroupBox2

	; === UpdateDaysCount (type: Text) ===
	${NSD_CreateText} 331.09u 136.62u 44.76u 12.31u "1"
	Pop $hCtl_options_UpdateDaysCount
	${NSD_SetTextLimit} $hCtl_options_UpdateDaysCount 3

	; === ModUpdatesCheckbox (type: Checkbox) ===
	${NSD_CreateCheckbox} 246.18u 98.46u 129.67u 14.77u $(SET_CHECKMODUPD)
	Pop $hCtl_options_ModUpdatesCheckbox

	; === UpdatesCheckbox (type: Checkbox) ===
	${NSD_CreateCheckbox} 246.18u 80u 98.08u 14.77u $(SET_CHECKUPD)
	Pop $hCtl_options_UpdatesCheckbox

	; === UpdateBox (type: ComboBox) ===
	${NSD_CreateComboBox} 246.18u 136.62u 79.65u 12.92u ""
	Pop $hCtl_options_UpdateBox
	${NSD_CB_AddString} $hCtl_options_UpdateBox $(SET_ALWAYS)
	${NSD_CB_AddString} $hCtl_options_UpdateBox $(SET_HOURS)
	${NSD_CB_AddString} $hCtl_options_UpdateBox $(SET_DAYS)
	${NSD_CB_AddString} $hCtl_options_UpdateBox $(SET_WEEKS)

	; === Label1 (type: Label) ===
	${NSD_CreateLabel} 246.18u 123.08u 101.37u 11.08u $(SET_FREQ)
	Pop $hCtl_options_Label1

	; === GroupBox1 (type: GroupBox) ===
	${NSD_CreateGroupBox} 0u 0u 210.63u 172.31u $(SET_DISP)
	Pop $hCtl_options_GroupBox1

	; === ClippingBox (type: ComboBox) ===
	${NSD_CreateComboBox} 118.48u 136.62u 79.65u 12.92u ""
	Pop $hCtl_options_ClippingBox
	${NSD_CB_AddString} $hCtl_options_ClippingBox $(SET_HIGH)
	${NSD_CB_AddString} $hCtl_options_ClippingBox $(SET_LOW)
	${NSD_CB_AddString} $hCtl_options_ClippingBox $(SET_LOWEST)

	; === Label3v (type: Label) ===
	${NSD_CreateLabel} 118.48u 123.08u 84.25u 11.08u $(SET_DETAIL)
	Pop $hCtl_options_Label3v

	; === FramerateBox (type: ComboBox) ===
	${NSD_CreateComboBox} 13.16u 136.62u 79.65u 12.92u ""
	Pop $hCtl_options_FramerateBox
	${NSD_CB_AddString} $hCtl_options_FramerateBox "60 FPS"
	${NSD_CB_AddString} $hCtl_options_FramerateBox "30 FPS"
	${NSD_CB_AddString} $hCtl_options_FramerateBox "15 FPS"

	; === Label2 (type: Label) ===
	${NSD_CreateLabel} 13.16u 123.08u 65.82u 11.08u $(SET_FRAMERATE)
	Pop $hCtl_options_Label2

	; === xLabel (type: Label) ===
	${NSD_CreateLabel} 48.71u 35.08u 8.56u 14.15u "x"
	Pop $hCtl_options_xLabel

	; === ScreenModeLabel (type: Label) ===
	${NSD_CreateLabel} 118.48u 18.46u 65.82u 11.08u $(SET_SCREEN)
	Pop $hCtl_options_ScreenModeLabel

	; === YRes (type: Text) ===
	${NSD_CreateText} 59.24u 33.23u 31.59u 12.31u ""
	Pop $hCtl_options_YRes

	; === ResolutionLabel (type: Label) ===
	${NSD_CreateLabel} 13.16u 18.46u 65.82u 11.08u $(SET_RES)
	Pop $hCtl_options_ResolutionLabel

	; === ScaleCheckBox (type: Checkbox) ===
	${NSD_CreateCheckbox} 13.16u 80.62u 191.01u 14.77u $(SET_SCALE)
	Pop $hCtl_options_ScaleCheckBox

	; === ScreenModeBox (type: ComboBox) ===
	${NSD_CreateComboBox} 118.48u 32u 79.65u 12.92u ""
	Pop $hCtl_options_ScreenModeBox
	${NSD_CB_AddString} $hCtl_options_ScreenModeBox $(SET_WINDOWED)
	${NSD_CB_AddString} $hCtl_options_ScreenModeBox $(SET_FULLSCREEN)

	; === XRes (type: Text) ===
	${NSD_CreateText} 13.16u 33.23u 31.59u 12.31u ""
	Pop $hCtl_options_XRes
	${NSD_SetTextLimit} $hCtl_options_XRes 4

	; === VSyncCheckBox (type: Checkbox) ===
	${NSD_CreateCheckbox} 13.16u 99.08u 120.44u 14.77u $(SET_VSYNC)
	Pop $hCtl_options_VSyncCheckBox

	; === BorderlessCheckBox (type: Checkbox) ===
	${NSD_CreateCheckbox} 13.16u 62.15u 117.16u 14.77u $(SET_BORDERLESS)
	Pop $hCtl_options_BorderlessCheckBox
	${NSD_Check} $hCtl_options_BorderlessCheckBox
FunctionEnd

; Updates 2
Function SelectUpdates
	EnableWindow $hCtl_sel_CheckUpdates 0
	EnableWindow $hCtl_sel_DontCheckUpdates 0
	IntOp $UpdatesFound 0 + 0
	StrCpy $WhichUpdates ""
	Call fnc_sel_Create
	nsDialogs::Show
FunctionEnd

Function fnc_iconselect_Create
	; === iconselect (type: Dialog) ===
	nsDialogs::Create /NOUNLOAD 1018
	Pop $hCtl_iconselect
	${If} $hCtl_iconselect == error
		Abort
	${EndIf}
	!insertmacro MUI_HEADER_TEXT $(HEADER_ICON_TITLE) $(HEADER_ICON_TEXT)

	${NSD_CreateLabel} 0 0 209.03u 10.82u $(OPTIONNAME_ICONSEL)
	Pop $hCtl_iconselect_Label1

	; Bitmaps
	
	; === Bitmap_SADXPC (type: Bitmap) ===
	${NSD_CreateBitmap} 31.88u 146.35u 32.39u 30.12u ""
	Pop $hCtl_iconselect_Bitmap_SADXPC
	File "/oname=$PLUGINSDIR\icon_pc.bmp" "resources\icon_pc.bmp"
	${NSD_SetImage} $hCtl_iconselect_Bitmap_SADXPC "$PLUGINSDIR\icon_pc.bmp" $hCtl_iconselect_Bitmap_SADXPC_hImage
	GetFunctionAddress $0 IconSelect_4
	nsDialogs::OnClick $hCtl_iconselect_Bitmap_SADXPC $0

	; === Bitmap_SADXGC (type: Bitmap) ===
	${NSD_CreateBitmap} 31.88u 106.35u 32.39u 30.12u ""
	Pop $hCtl_iconselect_Bitmap_SADXGC
	File "/oname=$PLUGINSDIR\icon_gc.bmp" "resources\icon_gc.bmp"
	${NSD_SetImage} $hCtl_iconselect_Bitmap_SADXGC "$PLUGINSDIR\icon_gc.bmp" $hCtl_iconselect_Bitmap_SADXGC_hImage
	GetFunctionAddress $0 IconSelect_3
	nsDialogs::OnClick $hCtl_iconselect_Bitmap_SADXGC $0

	; === Bitmap_SA1Box (type: Bitmap) ===
	${NSD_CreateBitmap} 31.88u 66.82u 32.39u 30.12u ""
	Pop $hCtl_iconselect_Bitmap_SA1Box
	File "/oname=$PLUGINSDIR\icon_box.bmp" "resources\icon_box.bmp"
	${NSD_SetImage} $hCtl_iconselect_Bitmap_SA1Box "$PLUGINSDIR\icon_box.bmp" $hCtl_iconselect_Bitmap_SA1Box_hImage
	GetFunctionAddress $0 IconSelect_2
	nsDialogs::OnClick $hCtl_iconselect_Bitmap_SA1Box $0

	; === Bitmap_SA1SAVE (type: Bitmap) ===
	${NSD_CreateBitmap} 31.88u 25.88u 32.39u 30.12u ""
	Pop $hCtl_iconselect_Bitmap_SA1Save
	File "/oname=$PLUGINSDIR\icon_sa.bmp" "resources\icon_sa.bmp"
	${NSD_SetImage} $hCtl_iconselect_Bitmap_SA1Save "$PLUGINSDIR\icon_sa.bmp" $hCtl_iconselect_Bitmap_SA1Save_hImage
	GetFunctionAddress $0 IconSelect_1
	nsDialogs::OnClick $hCtl_iconselect_Bitmap_SA1Save $0

	; Buttons
	
	; === Button_SADXPC (type: RadioButton) ===
	${NSD_CreateRadioButton} 79.45u 157.18u 284.62u 11.29u $(OPTIONNAME_ICON_HD)
	Pop $hCtl_iconselect_Button_SADXPC
	GetFunctionAddress $0 IconSelect_4
	nsDialogs::OnClick $hCtl_iconselect_Button_SADXPC $0

	; === Button_SADXGC (type: RadioButton) ===
	${NSD_CreateRadioButton} 79.45u 116.71u 284.62u 11.29u $(OPTIONNAME_ICON_DX)
	Pop $hCtl_iconselect_Button_SADXGC
	GetFunctionAddress $0 IconSelect_3
	nsDialogs::OnClick $hCtl_iconselect_Button_SADXGC $0

	; === Button_SA1Box (type: RadioButton) ===
	${NSD_CreateRadioButton} 79.45u 76.71u 284.62u 11.29u $(OPTIONNAME_ICON_SA1)
	Pop $hCtl_iconselect_Button_SA1Box
	GetFunctionAddress $0 IconSelect_2
	nsDialogs::OnClick $hCtl_iconselect_Button_SA1Box $0

	; === Button_SA1Save (type: RadioButton) ===
	${NSD_CreateRadioButton} 79.45u 34.82u 284.62u 12.71u $(OPTIONNAME_ICON_VM)
	Pop $hCtl_iconselect_Button_SA1Save
	${NSD_Check} $hCtl_iconselect_Button_SA1Save
	GetFunctionAddress $0 IconSelect_1
	nsDialogs::OnClick $hCtl_iconselect_Button_SA1Save $0
	StrCpy $CustomIconNumber "1"
FunctionEnd

Function IconSelect_1
	Pop $hCtl_iconselect_Button_SA1Save
	StrCpy $CustomIconNumber "1"
FunctionEnd

Function IconSelect_2
	Pop $hCtl_iconselect_Button_SA1Box
	StrCpy $CustomIconNumber "2"
FunctionEnd

Function IconSelect_3
	Pop $hCtl_iconselect_Button_SADXGC
	StrCpy $CustomIconNumber "3"
FunctionEnd

Function IconSelect_4
	Pop $hCtl_iconselect_Button_SADXPC
	StrCpy $CustomIconNumber "4"
FunctionEnd

; Dialog show function
Function fnc_iconselect_Show
	${If} $EnableCustomIcon == "1"
		Call fnc_iconselect_Create
		nsDialogs::Show
	${EndIf}
FunctionEnd

Function fnc_TypeSel_Create
	; Custom font definitions
	CreateFont $hCtl_TypeSel_Font1 "Microsoft Sans Serif" "8.25" "700"
	; === TypeSel (type: Dialog) ===
	nsDialogs::Create 1018
	Pop $hCtl_TypeSel
	${If} $hCtl_TypeSel == error
		Abort
	${EndIf}

	!insertmacro MUI_HEADER_TEXT $(HEADER_TYPE_TITLE) $(HEADER_TYPE_TEXT)
	; === CheckBox_ShowAdvanced (type: Checkbox) ===
	${NSD_CreateCheckbox} 3.95u 128u 190.04u 14.77u $(OPTIONNAME_ADVANCED)
	Pop $hCtl_TypeSel_CheckBox_ShowAdvanced
	GetFunctionAddress $0 ShowAdvancedOptions
	nsDialogs::OnClick $hCtl_TypeSel_CheckBox_ShowAdvanced $0

	; === GroupBox_InstallerMode (type: GroupBox) ===
	${NSD_CreateGroupBox} 0u 14.15u 227.47u 59.08u $(OPTIONNAME_INSTMODE)
	Pop $hCtl_TypeSel_GroupBox_InstallerMode

	; === GroupBox_Presets (type: GroupBox) ===
	${NSD_CreateGroupBox} 232.73u 14.15u 197.47u 59.08u $(OPTIONNAME_PRESETS)
	Pop $hCtl_TypeSel_GroupBox_Presets

	; === Option_Guide (type: RadioButton) ===
	${NSD_CreateRadioButton} 3.95u 25.85u 222.86u 14.77u $(OPTIONNAME_GUIDE)
	Pop $hCtl_TypeSel_Option_Guide
	${NSD_AddStyle} $hCtl_TypeSel_Option_Guide ${WS_GROUP}
	SendMessage $hCtl_TypeSel_Option_Guide ${WM_SETFONT} $hCtl_TypeSel_Font1 0
	${NSD_Check} $hCtl_TypeSel_Option_Guide
	GetFunctionAddress $0 SetDesc_Guide
	nsDialogs::OnClick $hCtl_TypeSel_Option_Guide $0

	; === Option_Preset (type: RadioButton) ===
	${NSD_CreateRadioButton} 3.95u 41.23u 97.42u 14.77u $(OPTIONNAME_PRESET)
	Pop $hCtl_TypeSel_Option_Preset
	GetFunctionAddress $0 SetDesc_Profiles
	nsDialogs::OnClick $hCtl_TypeSel_Option_Preset $0

	; === CheckBox_InstallIcon (type: Checkbox) ===
	${NSD_CreateCheckbox} 3.95u 183.38u 210.63u 14.77u $(OPTIONNAME_ICON)
	Pop $hCtl_TypeSel_CheckBox_InstallIcon
	GetFunctionAddress $0 EnableInstallIcon
	nsDialogs::OnClick $hCtl_TypeSel_CheckBox_InstallIcon $0
	${If} $EnableCustomIcon == "1"
		${NSD_Check} $hCtl_TypeSel_CheckBox_InstallIcon
	${Else}
		${NSD_UnCheck} $hCtl_TypeSel_CheckBox_InstallIcon
	${EndIf}

	; === CheckBox_WindowTitle (type: Checkbox) ===
	${NSD_CreateCheckbox} 3.95u 146.46u 179.04u 14.77u $(OPTIONNAME_WTITLE)
	Pop $hCtl_TypeSel_CheckBox_WindowTitle
	GetFunctionAddress $0 SetDesc_WindowTitle
	nsDialogs::OnClick $hCtl_TypeSel_CheckBox_WindowTitle $0

	; === RadioButton_SettingsFailsafe (type: RadioButton) ===
	${NSD_CreateRadioButton} 216.68u 164.92u 212.71u 14.77u $(OPTIONNAME_FAILSAFE)
	Pop $hCtl_TypeSel_RadioButton_SettingsFailsafe
	${NSD_AddStyle} $hCtl_TypeSel_RadioButton_SettingsFailsafe ${WS_GROUP}
	GetFunctionAddress $0 SetDesc_Failsafe
	nsDialogs::OnClick $hCtl_TypeSel_RadioButton_SettingsFailsafe $0

	; === RadioButton_SettingsManual (type: RadioButton) ===
	${NSD_CreateRadioButton} 216.68u 146.46u 212.71u 14.77u $(OPTIONNAME_MANUAL)
	Pop $hCtl_TypeSel_RadioButton_SettingsManual
	GetFunctionAddress $0 SetDesc_Manual
	nsDialogs::OnClick $hCtl_TypeSel_RadioButton_SettingsManual $0

	; === RadioButton_SettingsOptimal (type: RadioButton) ===
	${NSD_CreateRadioButton} 216.68u 128u 212.71u 14.77u $(OPTIONNAME_OPTIMAL)
	Pop $hCtl_TypeSel_RadioButton_SettingsOptimal
	${NSD_Check} $hCtl_TypeSel_RadioButton_SettingsOptimal
	GetFunctionAddress $0 SetDesc_Optimal
	nsDialogs::OnClick $hCtl_TypeSel_RadioButton_SettingsOptimal $0

	; === Option_Custom (type: RadioButton) ===
	${NSD_CreateRadioButton} 3.95u 56.62u 97.42u 14.77u $(PROFILENAME_CUSTOM)
	Pop $hCtl_TypeSel_Option_Custom
	${NSD_AddStyle} $hCtl_TypeSel_Option_Custom ${WS_GROUP}
	GetFunctionAddress $0 SetDesc_Custom
	nsDialogs::OnClick $hCtl_TypeSel_Option_Custom $0

	; === Option_Minimal (type: RadioButton) ===
	${NSD_CreateRadioButton} 236.68u 56.62u 127.42u 14.77u $(PROFILENAME_MIN)
	Pop $hCtl_TypeSel_Option_Minimal
	GetFunctionAddress $0 SetDesc_Minimum
	nsDialogs::OnClick $hCtl_TypeSel_Option_Minimal $0

	; === CheckBox_Preserve (type: Checkbox) ===
	${NSD_CreateCheckbox} 3.95u 164.92u 199.04u 14.77u $(OPTIONNAME_PRESERVE)
	Pop $hCtl_TypeSel_CheckBox_Preserve
	GetFunctionAddress $0 PreserveToggle
	nsDialogs::OnClick $hCtl_TypeSel_CheckBox_Preserve $0
	${NSD_Check} $hCtl_TypeSel_CheckBox_Preserve
	IntOp $PreserveModSettings 1 + 0

	; === GroupBox_TypeDesc (type: GroupBox) ===
	${NSD_CreateGroupBox} 0u 76.92u 400.2u 49.85u $(DESC_DESC)
	Pop $hCtl_TypeSel_GroupBox_TypeDesc

	; === TypeComment (type: Label) ===
	${NSD_CreateLabel} 3.95u 88u 392.3u 36.92u $(DESC_DCMODS_ALL)
	Pop $hCtl_TypeSel_TypeComment

	; === SelectTypeText (type: Label) ===
	${NSD_CreateLabel} 0u 0u 400.82u 14.15u $(MSG_PROFILE)
	Pop $hCtl_TypeSel_SelectTypeText

	; === Option_Enhanced (type: RadioButton) ===
	${NSD_CreateRadioButton} 236.68u 41.23u 127.42u 14.15u $(PROFILENAME_SADX)
	Pop $hCtl_TypeSel_Option_Enhanced
	GetFunctionAddress $0 SetDesc_Enhanced
	nsDialogs::OnClick $hCtl_TypeSel_Option_Enhanced $0

	; === Option_DC (type: RadioButton) ===
	${NSD_CreateRadioButton} 236.68u 25.85u 127.42u 14.15u $(PROFILENAME_DC)
	Pop $hCtl_TypeSel_Option_DC
	${NSD_AddStyle} $hCtl_TypeSel_Option_DC ${WS_GROUP}
	${NSD_Check} $hCtl_TypeSel_Option_DC
	GetFunctionAddress $0 SetDesc_DC
	nsDialogs::OnClick $hCtl_TypeSel_Option_DC $0
	Call ShowAdvancedOptions
	Call SetDesc_Guide
FunctionEnd

; Welcome page
Function fnc_WelcomePage_Create
	; Custom font definitions
	CreateFont $hCtl_WelcomePage_Font1 "Microsoft Sans Serif" "14.25" "700"
	; === WelcomePage (type: Dialog) ===
	nsDialogs::Create 1044
	Pop $hCtl_WelcomePage
	${If} $hCtl_WelcomePage == error
		Abort
	${EndIf}
	SetCtlColors $hCtl_WelcomePage 0x000000 0xFFFFFF
	!insertmacro MUI_HEADER_TEXT $(HEADER_GUIDE_TITLE) $(HEADER_GUIDE_TEXT)

	; === Welcome (type: Label) ===
	${NSD_CreateLabel} 117u 35u 289u 40u $(MSG_START)
	Pop $hCtl_WelcomePage_Welcome
	SendMessage $hCtl_WelcomePage_Welcome ${WM_SETFONT} $hCtl_WelcomePage_Font1 0
	SetCtlColors $hCtl_WelcomePage_Welcome 0x000000 0xFFFFFF

	; === WelcomeText (type: Label) ===
	${NSD_CreateLabel} 118u 91u 285u 87u $(MSG_WELCOME)
	Pop $hCtl_WelcomePage_WelcomeText
	SetCtlColors $hCtl_WelcomePage_WelcomeText 0x000000 0xFFFFFF

	; === Version (type: Label) ===
	${NSD_CreateLabel} 398u 232u 32u 16u "$BuildNumber"
	Pop $hCtl_WelcomePage_Version
	SetCtlColors $hCtl_WelcomePage_Version 0x000000 0xFFFFFF

	; === Banner (type: Bitmap) ===
	${NSD_CreateBitmap} 0u 0u 108u 193u ""
	Pop $hCtl_WelcomePage_Banner
	SetCtlColors $hCtl_WelcomePage_Banner 0x000000 0xFFFFFF
	File "/oname=$PLUGINSDIR\banner.jpg" "resources\banner.jpg"
	${NSD_SetStretchedImageOLE} $hCtl_WelcomePage_Banner "$PLUGINSDIR\banner.jpg" $hCtl_WelcomePage_Banner_hImage
	${NSD_FreeImage} $hCtl_WelcomePage_Banner
FunctionEnd

Function fnc_WelcomePage_Show
	Call fnc_WelcomePage_Create
	nsDialogs::Show
FunctionEnd

Function ChangeLauncher
	${If} $Final_Launcher == "0"
		StrCpy $Final_Launcher "1"
	${Else}
		StrCpy $Final_Launcher "0"
	${EndIf}
FunctionEnd

Function ChangeShortcuts
	${If} $Final_Shortcuts == "0"
		StrCpy $Final_Shortcuts "1"
	${Else}
		StrCpy $Final_Shortcuts "0"
	${EndIf}
FunctionEnd

Function ChangeSADX
	${If} $Final_SADX == "0"
		StrCpy $Final_SADX "1"
	${Else}
		StrCpy $Final_SADX "0"
	${EndIf}
FunctionEnd

; Finish page
Function fnc_FinishPage_Create
	CreateFont $hCtl_FinishPage_Font1 "Microsoft Sans Serif" "14.25" "700"
	nsDialogs::Create 1044
	Pop $hCtl_FinishPage
	${If} $hCtl_FinishPage == error
		Abort
	${EndIf}
	SetCtlColors $hCtl_FinishPage 0x000000 0xFFFFFF

	${NSD_CreateLink} 120u 160u 100% 10u $(DESC_MOREMODS)
	Pop $hCtl_FinishPage_LinkMoreMods
	GetFunctionAddress $0 OpenURL_MoreMods
	nsDialogs::OnClick $hCtl_FinishPage_LinkMoreMods $0
	SetCtlColors $hCtl_FinishPage_LinkMoreMods 0x0066CC transparent

	${NSD_CreateLink} 120u 175u 100% 10u $(DESC_DREAMCASTIFY)
	Pop $hCtl_FinishPage_LinkDreamcastify
	GetFunctionAddress $0 OpenURL_Dreamcastify
	nsDialogs::OnClick $hCtl_FinishPage_LinkDreamcastify $0
	SetCtlColors $hCtl_FinishPage_LinkDreamcastify 0x0066CC transparent

	${NSD_CreateLink} 120u 190u 100% 10u $(DESC_DISCORD)
	Pop $hCtl_FinishPage_LinkDiscord
	GetFunctionAddress $0 OpenURL_Discord
	nsDialogs::OnClick $hCtl_FinishPage_LinkDiscord $0
	SetCtlColors $hCtl_FinishPage_LinkDiscord 0x0066CC transparent

	; === CheckBox_CreateShortcuts (type: Checkbox) ===

	${NSD_CreateCheckbox} 118u 129u 253u 13u $(DESC_SHORTCUTS)
	Pop $hCtl_FinishPage_CheckBox_CreateShortcuts
	SetCtlColors $hCtl_FinishPage_CheckBox_CreateShortcuts 0xFF0000 0xFFFFFFFF
	${NSD_OnClick} $hCtl_FinishPage_CheckBox_CreateShortcuts ChangeShortcuts

	; === CheckBox_RunLauncher (type: Checkbox) ===
	${NSD_CreateCheckbox} 118u 113u 253u 13u $(DESC_RUNLAUNCHER)
	Pop $hCtl_FinishPage_CheckBox_RunLauncher
	SetCtlColors $hCtl_FinishPage_CheckBox_RunLauncher 0x000000 0xFFFFFF
	${NSD_OnClick} $hCtl_FinishPage_CheckBox_RunLauncher ChangeLauncher

	; === CheckBox_RunSADX (type: Checkbox) ===
	${NSD_CreateCheckbox} 118u 96u 253u 13u $(DESC_RUNSADX)
	Pop $hCtl_FinishPage_CheckBox_RunSADX
	SetCtlColors $hCtl_FinishPage_CheckBox_RunSADX 0x000000 0xFFFFFF
	${NSD_OnClick} $hCtl_FinishPage_CheckBox_RunSADX ChangeSADX

	; === FinishTitle (type: Label) ===
	${NSD_CreateLabel} 118u 14u 279u 20u $(MSG_COMPLETE)
	Pop $hCtl_FinishPage_FinishTitle
	SendMessage $hCtl_FinishPage_FinishTitle ${WM_SETFONT} $hCtl_FinishPage_Font1 0
	SetCtlColors $hCtl_FinishPage_FinishTitle 0x000000 0xFFFFFF

	; === FinishMessage (type: Label) ===
	${NSD_CreateLabel} 118u 42u 279u 45u $(MSG_FINISH)
	Pop $hCtl_FinishPage_FinishMessage
	SetCtlColors $hCtl_FinishPage_FinishMessage 0x000000 0xFFFFFF

	; === Banner (type: Bitmap) ===
	${NSD_CreateBitmap} 0u 0u 108u 193u ""
	Pop $hCtl_FinishPage_Banner
	SetCtlColors $hCtl_FinishPage_Banner 0x000000 0xFFFFFF
	File "/oname=$PLUGINSDIR\banner.jpg" "resources\banner.jpg"
	${NSD_SetStretchedImageOLE} $hCtl_FinishPage_Banner "$PLUGINSDIR\banner.jpg" $hCtl_FinishPage_Banner_hImage
FunctionEnd

; Dialog show function
Function fnc_FinishPage_Show
	StrCpy $0 "$INSTDIR\SADX Mod Installer.log"
	Push $0
	Call DumpLog
	Pop $0
	DetailPrint "Cit"
	GetDlgItem $R0 $HWNDPARENT 1
	SendMessage $R0 ${WM_SETTEXT} 0 `STR:$(MUI_BUTTONTEXT_FINISH)`
	GetDlgItem $R0 $HWNDPARENT 2
	ShowWindow $R0 ${SW_HIDE}
	GetDlgItem $R0 $HWNDPARENT 3
	ShowWindow $R0 ${SW_HIDE}
	Call fnc_FinishPage_Create
	nsDialogs::Show
FunctionEnd

Function SuperSonicToggle
	${NSD_GetState} $hCtl_Additional_CheckBox_SuperSonic $Whatev
	${If} $Whatev == ${BST_CHECKED}
		!insertmacro SelectSection ${SECTION_SUPERSONIC}
	${Else}
		!insertmacro UnselectSection ${SECTION_SUPERSONIC}
	${EndIf}
FunctionEnd

Function PreserveToggle
	${NSD_SetText} $hCtl_TypeSel_TypeComment $(DESC_PRESERVE)
	${NSD_GetState} $hCtl_TypeSel_CheckBox_Preserve $Whatev
	${If} $Whatev == ${BST_CHECKED}
		IntOp $PreserveModSettings 1 + 0
	${Else}
		IntOp $PreserveModSettings 0 + 0
	${EndIf}
FunctionEnd

Function DLCToggle
	${NSD_GetState} $hCtl_Additional_CheckBox_DLCs $Whatev
	${If} $Whatev == ${BST_CHECKED}
		!insertmacro SelectSection ${SECTION_DLCS}
	${Else}
		!insertmacro UnselectSection ${SECTION_DLCS}
	${EndIf}
FunctionEnd

Function SndToggle
	${NSD_GetState} $hCtl_Additional_CheckBox_SoundOverhaul $Whatev
	${If} $Whatev == ${BST_CHECKED}
		!insertmacro SelectSection ${SECTION_SNDOVERHAUL}
	${Else}
		!insertmacro UnselectSection ${SECTION_SNDOVERHAUL}
	${EndIf}
FunctionEnd