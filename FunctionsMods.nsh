; Functions related to mod installation/update

; Generate mod.version for GitHub-hosted mods
Function GenerateModVersion
	${GetTime} "$INSTDIR\mods\$ModFilename\mod.manifest" "MS" $0 $1 $2 $3 $4 $5 $6
	; $0="12"       day
	; $1="10"       month
	; $2="2004"     year
	; $3="Tuesday"  day of week name
	; $4="2"        hour
	; $5="32"       minute
	; $6="03"       seconds
	IfErrors 0 +2
	MessageBox MB_OK $(ERR_MODDATE) IDOK modversionend
	;Add 1 hour or set to 23:59:59
	IntOp $4 $4 + 1
	${If} $4 > "23"
		IntOp $4 23 + 0
		IntOp $5 59 + 0
		IntOp $6 59 + 0
	${EndIf}
	${If} $4 < "10"
		StrCpy $4 '0$4'
	${EndIf}
	DetailPrint $(DE_MANIFEST)
	IfFileExists "$INSTDIR\mods\$ModFilename\mod.version" 0 +2
	Delete "$INSTDIR\mods\$ModFilename\mod.version"
	FileOpen $7 "$INSTDIR\mods\$ModFilename\mod.version" w
	FileWrite $7 "$2-$1-$0T$4:$5:$6Z"
	FileClose $7
	goto modversionend
	modversionend:
FunctionEnd

; Check mod updates for all mods
Function CheckUpdates
	IntOp $UpdatesFound 0 + 0
	${NSD_GetState} $hCtl_sel_CheckUpdates $Whatev
	
	; Run the code if the checkbox is checked
	${If} $Whatev == ${BST_CHECKED}
		CreateDirectory "$EXEDIR\instdata"
		GetDlgItem $0 $HWNDPARENT 1
		EnableWindow $0 0
		GetDlgItem $0 $HWNDPARENT 2
		EnableWindow $0 0
		GetDlgItem $0 $HWNDPARENT 3
		EnableWindow $0 0

		EnableWindow $hCtl_sel_CheckUpdates 0
		EnableWindow $hCtl_sel_DontCheckUpdates 0
		${NSD_SetText} $hCtl_sel_OfflineText $(MSG_CHECKUPDATES)

		; Update Mod Loader
		${If} ${FileExists} "$EXEDIR\instdata\SADXModLoader.7z"
			SetOutPath "$TEMP"
			File "resources\7zr.exe"
			nsexec::ExecToStack '"$TEMP\7zr.exe" e "$EXEDIR\instdata\SADXModLoader.7z" sadxmlver.txt -o"$EXEDIR\instdata" -aoa'
			FileOpen $4 "$EXEDIR\instdata\sadxmlver.txt" r
			FileRead $4 $ModLoaderVersion 3
			FileClose $4
			IntOp $ModLoaderVersion $ModLoaderVersion + 0
			inetc::get /SILENT /WEAKSECURITY /RESUME $(ERR_DOWNLOAD_FILE) "http://mm.reimuhakurei.net/toolchangelog.php?tool=sadxml&rev=$ModLoaderVersion" "$EXEDIR\instdata\mlver.txt" /END
			FileOpen $4 "$EXEDIR\instdata\mlver.txt" r
			FileRead $4 $R1
			FileClose $4
			StrCmp $R1 "" EndMLUpdate YesUpdate
		
			YesUpdate:
				Delete "$EXEDIR\instdata\SADXModLoader.7z"
				IntOp $UpdatesFound $UpdatesFound + 1
				StrCpy $WhichUpdates "$WhichUpdates SADX Mod Loader $\r$\n"
				Goto EndMLUpdate
		
			EndMLUpdate:
				Delete "$EXEDIR\instdata\mlver.txt"
				Delete "$EXEDIR\instdata\sadxmlver.txt"
		${EndIf}

		; Download file list
		${NSD_SetText} $hCtl_sel_OfflineText $(D_FILELIST)
		inetc::get /SILENT /WEAKSECURITY /RESUME $(ERR_DOWNLOAD_FILE) "https://dcmods.unreliable.network/owncloud/data/PiKeyAr/files/Setup/filelist.lst" "$EXEDIR\instdata\filelist.lst" /END
		
		; Check mod updates
		${If} ${FileExists} "$EXEDIR\instdata\filelist.lst"
			StrCpy $UpdateFilename "ADXAudio.7z"
			Call CheckModUpdate
			
			StrCpy $UpdateFilename "CCEF.7z"
			Call CheckModUpdate

			StrCpy $UpdateFilename "d3d8.dll"
			Call CheckModUpdate

			StrCpy $UpdateFilename "DreamcastConversion.7z"
			Call CheckModUpdate

			StrCpy $UpdateFilename "DLCs.7z"
			Call CheckModUpdate

			StrCpy $UpdateFilename "HD_DCStyle.7z"
			Call CheckModUpdate

			StrCpy $UpdateFilename "idle-chatter.7z"
			Call CheckModUpdate

			StrCpy $UpdateFilename "pause-hide.7z"
			Call CheckModUpdate

			StrCpy $UpdateFilename "AppLauncher.7z"
			Call CheckModUpdate

			StrCpy $UpdateFilename "SA1_Chars.7z"
			Call CheckModUpdate

			StrCpy $UpdateFilename "sadx-dc-lighting.7z"
			Call CheckModUpdate

			StrCpy $UpdateFilename "sadx-onion-blur.7z"
			Call CheckModUpdate

			StrCpy $UpdateFilename "sadx-frame-limit.7z"
			Call CheckModUpdate

			StrCpy $UpdateFilename "sadx-input-mod.7z"
			Call CheckModUpdate

			StrCpy $UpdateFilename "sadx-keyboard-remap.7z"
			Call CheckModUpdate

			StrCpy $UpdateFilename "SADXFE.7z"
			Call CheckModUpdate

			StrCpy $UpdateFilename "smooth-cam.7z"
			Call CheckModUpdate

			StrCpy $UpdateFilename "SoundOverhaul.7z"
			Call CheckModUpdate

			StrCpy $UpdateFilename "steam_tools.7z"
			Call CheckModUpdate

			StrCpy $UpdateFilename "sadx-super-sonic.7z"
			Call CheckModUpdate

			StrCpy $UpdateFilename "TrainDaytime.7z"
			Call CheckModUpdate

			StrCpy $UpdateFilename "voices.7z"
			Call CheckModUpdate

			StrCpy $UpdateFilename "WaterEffect.7z"
			Call CheckModUpdate

			StrCpy $UpdateFilename "icondata.7z"
			Call CheckModUpdate

			${NSD_SetText} $hCtl_sel_OfflineText $(D_INSTCHK)
			Call CheckModUpdate_Installer
		${EndIf}
		
		Delete "$EXEDIR\instdata\filelist.lst"
	${EndIf}

	; Show update message
	${If} $UpdatesFound != "0"
		MessageBox MB_OK|MB_ICONINFORMATION $(MSG_FOUNDUPD)
		IntOp $UpdatesFound 0 + 0
	${EndIf}
FunctionEnd

Function ModInstall
	IntOp $ModInstallSuccess 0 + 0
	IfFileExists "$EXEDIR\instdata\$ModFilename.7z" check download
	check:
		; Delete 0-byte mods
		Push "$EXEDIR\instdata\$ModFilename.7z"
		Call FileSizeNew
		Pop $0
		${If} $0 == "0"
			Delete "$EXEDIR\instdata\$ModFilename.7z"
			goto download
		${Else}
			goto extract
		${EndIf}
	download:
		DetailPrint $(D_GENERIC)
		inetc::get /WEAKSECURITY /RESUME $(ERR_DOWNLOAD_FILE) /CAPTION $(D_GENERIC) /CANCELTEXT $(ERR_DOWNLOAD_CANCEL_A) /QUESTION $(ERR_DOWNLOAD_CANCEL_Q) /TRANSLATE $(INETC_DOWNLOADING) $(INETC_CONNECT) $(INETC_SECOND) $(INETC_MINUTE) $(INETC_HOUR) $(INETC_PLURAL) $(INETC_PROGRESS) $(INETC_REMAINING) "https://dcmods.unreliable.network/owncloud/data/PiKeyAr/files/Setup/data/$ModFilename.7z" "$EXEDIR\instdata\$ModFilename.7z" /END
		Pop $DownloadErrorCode
		StrCmp $DownloadErrorCode "OK" extract fail
	fail:
		MessageBox MB_YESNO $(ERR_MODDOWNLOAD) IDYES finish IDNO 0
		Quit
	extract:
		RmDir /r "$INSTDIR\mods\$ModFilename"
		DetailPrint $(DE_E_GENERIC)
		nsexec::ExecToStack '"$TEMP\7zr.exe" x "$EXEDIR\instdata\$ModFilename.7z" -o"$INSTDIR\mods" -aoa'
		IntOp $ModInstallSuccess 0 + 1
		goto finish
	finish:
FunctionEnd

; Check for mod updates (generic function)
Function CheckModUpdate
	${If} ${FileExists} "$EXEDIR\instdata\$UpdateFilename"
		${NSD_SetText} $hCtl_sel_OfflineText $(D_UPDATE)
		FileOpen $4 "$EXEDIR\instdata\filelist.lst" r
		Goto fileread
		; Read file
		fileread:
			FileRead $4 $1
			; Check if EOF has been reached
			${If} $1 == ""
				Goto readerror
			${EndIf}
			
			; Get filename from read line
			${SplitString} $1 2
			Pop $5
			
			; If filename is the same get its size
			${If} $5 == $UpdateFilename
				${SplitString} $1 1
				Pop $6
				IntOp $6 $6 + 0
				${locate::GetSize} "$EXEDIR\instdata" "/S=Bytes /M=$UpdateFilename" $R1 $R2 $R3
				${locate::Unload}
			
				${If} $6 != $R1
					IntOp $UpdatesFound $UpdatesFound + 1
					StrCpy $WhichUpdates "$WhichUpdates $UpdateFilename $\r$\n"
					;MessageBox MB_OK "$UpdateFilename : $6 vs $R1"
					Delete "$EXEDIR\instdata\$UpdateFilename"
				${EndIf}
			
			; If the size is the same, do nothing
			; If the filename is different, read again
			${Else}
				goto fileread
			${EndIf}
			
			goto finishread
			readerror:
				MessageBox MB_OK $(ERR_SIZE)
	${EndIf}
	finishread:
		FileClose $4
FunctionEnd

; Check for installer updates
Function CheckModUpdate_Installer
	StrCpy $UpdateFilename "sadx_setup.exe"
	FileOpen $4 "$EXEDIR\instdata\filelist.lst" r
	Goto fileread
	; Read file
	fileread:
		FileRead $4 $1
	; Check if EOF has been reached
	${If} $1 == ""
		Goto readerror
	${EndIf}
	; Get filename from read line
	${SplitString} $1 2
	Pop $5
	; If the filename is the same, get file size
	${If} $5 == $UpdateFilename
		${SplitString} $1 1
		Pop $6
		IntOp $6 $6 + 0
		${locate::GetSize} "$EXEDIR" "/S=Bytes /G=0 /M=sadx_setup.exe"  $R1 $R2 $R3
		${locate::Unload}
		${If} $6 != $R1
			MessageBox MB_ICONQUESTION|MB_YESNO $(MSG_INSTALLERUPDATE) IDYES downupd IDNO skipupd
			downupd:
				${NSD_SetText} $hCtl_sel_OfflineText $(D_INSTALLER)
				inetc::get /SILENT /WEAKSECURITY /RESUME $(ERR_DOWNLOAD_FILE) "https://dcmods.unreliable.network/owncloud/data/PiKeyAr/files/Setup/sadx_setup.exe" "$EXEDIR\sadx_setup2.exe" /END
				${NSD_SetText} $hCtl_sel_OfflineText $(D_INSTALLER_R)
				ExecShell "" "$EXEDIR\sadx_setup2.exe"
				Quit
			skipupd:
		${EndIf}
	; If the size is the same, do nothing
	; If the filename is different, read again
	${Else}
		goto fileread
	${EndIf}
	goto finishread
	readerror:
		MessageBox MB_OK $(ERR_SIZE)
	finishread:
		FileClose $4
FunctionEnd