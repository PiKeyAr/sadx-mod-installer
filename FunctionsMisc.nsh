; Custom functions and macros for various purposes

; The macro to split strings
!macro SPLIT_STRING INPUT PART
	Push $R0
	Push $R1
	StrCpy $R0 0
	StrCmp ${PART} 1 getpart1_loop_${PART}
	StrCmp ${PART} 2 getpart2_top_${PART}
	Goto error_${PART}

	getpart1_loop_${PART}:
		IntOp $R0 $R0 - 1
		StrCpy $R1 ${INPUT} 1 $R0
		StrCmp $R1 "" error_${PART}
		StrCmp $R1 "," 0 getpart1_loop_${PART}
		IntOp $R0 $R0 + 1
		StrCpy $R0 ${INPUT} "" $R0
		Goto done_${PART}

	getpart2_top_${PART}:
		StrLen $R0 ${INPUT}
	
	getpart2_loop_${PART}:
		IntOp $R0 $R0 - 1
		StrCpy $R1 ${INPUT} 1 -$R0
		StrCmp $R1 "" error_${PART}
		StrCmp $R1 "," 0 getpart2_loop_${PART}
		StrCpy $R0 ${INPUT} -$R0
		Goto done_${PART}

	error_${PART}:
		StrCpy $R0 error

	done_${PART}:
		Pop $R1
		Exch $R0
!macroend

!define SplitString '!insertmacro SPLIT_STRING'

; See if a specified installation folder has the SADX executable
Function CheckInstallFolder
	IfFileExists "$INSTDIR\sonic.exe" endcheck 0
	IfFileExists "$INSTDIR\Sonic Adventure DX.exe" endcheck 0
	MessageBox MB_OK $(ERR_FOLDER)
	abort
	endcheck:
FunctionEnd

; Get file size
Function FileSizeNew
	Exch $0
	Push $1
	FileOpen $1 $0 "r"
	FileSeek $1 0 END $0
	FileClose $1
	Pop $1
	Exch $0
FunctionEnd

; Functions to run executables
Function RunSADX
	IfFileExists "$INSTDIR\sonic.exe" +1 +2
	Exec "$INSTDIR\sonic.exe"
FunctionEnd

Function RunLauncher
	IfFileExists "$INSTDIR\AppLauncher.exe" +1 +2
	Exec "$INSTDIR\AppLauncher.exe"
FunctionEnd

; Callback for the Locate plugin
Function LocateCallback
	AccessControl::SetFileOwner "$R9" "(BU)"
	Pop $0
	DetailPrint $(DE_TAKEOWN)
	AccessControl::GrantOnFile "$R9" "(BU)" "FullAccess"
	Pop $0
	DetailPrint $(DE_PERMSET1)
	AccessControl::GrantOnFile "$R9" "(S-1-5-11)" "FullAccess"
	Pop $0
	DetailPrint $(DE_PERMSET2)
	AccessControl::GrantOnFile "$R9" "(S-1-5-32-544)" "FullAccess"
	Pop $0
	DetailPrint $(DE_PERMSET3)
	Push $8
FunctionEnd

; Write log
!define /IfNDef LVM_GETITEMCOUNT 0x1004
!define /IfNDef LVM_GETITEMTEXTA 0x102D
!define /IfNDef LVM_GETITEMTEXTW 0x1073
!if "${NSIS_CHAR_SIZE}" > 1
!define /IfNDef LVM_GETITEMTEXT ${LVM_GETITEMTEXTW}
!else
!define /IfNDef LVM_GETITEMTEXT ${LVM_GETITEMTEXTA}
!endif
!define DumpLog_As_UTF16LE

Function DumpLog
	Exch $5
	Push $0
	Push $1
	Push $2
	Push $3
	Push $4
	Push $6
	FindWindow $0 "#32770" "" $HWNDPARENT
	GetDlgItem $0 $0 1016
	StrCmp $0 0 exit
	FileOpen $5 $5 "w"
	StrCmp $5 "" exit
	SendMessage $0 ${LVM_GETITEMCOUNT} 0 0 $6
	System::Call '*(&t${NSIS_MAX_STRLEN})p.r3'
	StrCpy $2 0
	System::Call "*(i, i, i, i, i, p, i, i, i) i  (0, 0, 0, 0, 0, r3, ${NSIS_MAX_STRLEN}) .r1"
	loop: StrCmp $2 $6 done
	System::Call "User32::SendMessage(i, i, i, i) i ($0, ${LVM_GETITEMTEXT}, $2, r1)"
	System::Call "*$3(&t${NSIS_MAX_STRLEN} .r4)"

	!ifdef DumpLog_As_UTF16LE
		FileWriteUTF16LE ${DumpLog_As_UTF16LE} $5 "$4$\r$\n"
	!else
		FileWrite $5 "$4$\r$\n" ; Unicode will be translated to ANSI!
	!endif

	IntOp $2 $2 + 1
	Goto loop
	done:
		FileClose $5
		System::Free $1
		System::Free $3
	exit:
		Pop $6
		Pop $4
		Pop $3
		Pop $2
		Pop $1
		Pop $0
		Pop $5
FunctionEnd

; Functions to open URLs
Function OpenURL_Dreamcastify
	ExecShell open "https://dreamcastify.unreliable.network"
FunctionEnd

Function OpenURL_MoreMods
	ExecShell open "https://dcmods.unreliable.network/sadxmods"
FunctionEnd

Function OpenURL_Discord
	ExecShell open "https://discord.com/invite/n5W4ahd"
FunctionEnd

Function OpenModComparisonURL
	${If} $ModScreenNumber == "0"
		ExecShell open "https://dcmods.unreliable.network/owncloud/data/PiKeyAr/files/Setup/modcomparison/lantern.htm"
	${EndIf}
	${If} $ModScreenNumber == "1"
		ExecShell open "https://dcmods.unreliable.network/owncloud/data/PiKeyAr/files/Setup/modcomparison/dcmods.htm"
	${EndIf}
	${If} $ModScreenNumber == "2"
		ExecShell open "https://dcmods.unreliable.network/owncloud/data/PiKeyAr/files/Setup/modcomparison/sadxwtr.htm"
	${EndIf}
	${If} $ModScreenNumber == "3"
		ExecShell open "https://dcmods.unreliable.network/owncloud/data/PiKeyAr/files/Setup/modcomparison/sa1chars.htm"
	${EndIf}
	${If} $ModScreenNumber == "4"
		ExecShell open "https://dcmods.unreliable.network/owncloud/data/PiKeyAr/files/Setup/modcomparison/blur.png"
	${EndIf}
	${If} $ModScreenNumber == "5"
		ExecShell open "https://dcmods.unreliable.network/owncloud/data/PiKeyAr/files/Setup/modcomparison/hdgui.png"
	${EndIf}
FunctionEnd