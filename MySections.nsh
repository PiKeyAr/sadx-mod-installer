; This file contains code for all sections

Section -SetupTools
SectionIn 1 2 3
DetailPrint $(DE_INSTDATA)
DetailPrint "Language: $LANGUAGE"
CreateDirectory "$EXEDIR\instdata"
DetailPrint $(DE_7Z)
SetOutPath "$TEMP"
File "resources\7zr.exe"
AccessControl::SetFileOwner "$INSTDIR" "(BU)"
Pop $Permission1
DetailPrint $(DE_OWNER)
AccessControl::GrantOnFile "$INSTDIR" "(BU)" "FullAccess"
Pop $Permission2
DetailPrint $(DE_PERM)
SectionEnd

Section /o $(SECTIONNAME_REMOVEMODS) SECTION_REMOVEMODS
DetailPrint $(DE_REALL)
RmDir /r "$INSTDIR\mods"
SectionEnd

Section /o $(SECTIONNAME_PERMISSIONS) SECTION_PERMISSIONS
SectionIn 1 2 3
DetailPrint $(DE_PRGFILES)
StrCpy $0 $PROGRAMFILES
StrLen $2 $0
StrCpy $1 $INSTDIR $2
${If} $0 == $1
	DetailPrint $(DE_RECU)
	${Locate} "$INSTDIR" "/L=FD /M=*.*" "LocateCallback"
	IfErrors 0 +2
	MessageBox MB_OK $(ERR_PERMISSION)
${EndIf}
SectionEnd

SectionGroup $(SECTIONNAME_DEPENDENCIES) SECTIONGROUP_MODLOADER
Section ".NET Framework" SECTION_NET
SectionIn 1 2 3
DetailPrint $(DE_CHECKNET)
${If} ${RunningX64}
	SetRegView 64
${Else}
	SetRegView 32
${EndIf}
ReadRegDWORD $NetFrameworkVersion HKLM "SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" "Release"
${If} $NetFrameworkVersion > "528040"
	goto skipnet
${EndIf}
DetailPrint $(DE_E_NET)
IfFileExists "$EXEDIR\instdata\ndp48-x86-x64-allos-enu.exe" installnet
DetailPrint $(D_NET)
inetc::get /WEAKSECURITY /RESUME $(ERR_DOWNLOAD_RETRY) /CAPTION $(D_NET) /CANCELTEXT $(ERR_DOWNLOAD_CANCEL_A) /QUESTION $(ERR_DOWNLOAD_CANCEL_Q) /TRANSLATE $(INETC_DOWNLOADING) $(INETC_CONNECT) $(INETC_SECOND) $(INETC_MINUTE) $(INETC_HOUR) $(INETC_PLURAL) $(INETC_PROGRESS) $(INETC_REMAINING) "https://dcmods.unreliable.network/owncloud/data/PiKeyAr/files/Setup/data/ndp48-x86-x64-allos-enu.exe" "$EXEDIR\instdata\ndp48-x86-x64-allos-enu.exe" /END
Pop $DownloadErrorCode
StrCmp $DownloadErrorCode "OK" installnet 0
MessageBox MB_OK $(ERR_D_NET)
Goto netend
installnet:
	ExecWait '"$EXEDIR\instdata\ndp48-x86-x64-allos-enu.exe" /q /norestart /ChainingPackage sadx_setup' "$DirectXSetupError"
	goto netend
skipnet:
	DetailPrint $(DE_NETPRESENT)
	goto netend
netend:
SectionEnd

Section $(SECTIONNAME_VCC) SECTION_VCC
SectionIn 1 2 3
DetailPrint $(DE_C_VCC)
SetOutPath "$INSTDIR"
Var /Global VC2010Installed
Var /Global VC2012Installed
Var /Global VC2013Installed
Var /Global VC2019Installed
SetRegView 32
ReadRegDWORD $VC2010Installed HKLM "SOFTWARE\Microsoft\VisualStudio\10.0\VC\VCRedist\x86" "Installed"
ReadRegDWORD $VC2012Installed HKLM "SOFTWARE\Microsoft\VisualStudio\11.0\VC\Runtimes\x86" "Installed"
ReadRegDWORD $VC2013Installed HKLM "SOFTWARE\Microsoft\VisualStudio\12.0\VC\Runtimes\x86" "Installed"
ReadRegDWORD $VC2019Installed HKLM "SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x86" "Installed"
goto check2010

check2010:
	StrCmp $VC2010Installed "" install2010 0
	goto check2012

check2012:
	StrCmp $VC2012Installed "" install2012 0
	goto check2013

check2013:
	StrCmp $VC2013Installed "" install2013 0
	goto check2019

check2019:
	StrCmp $VC2019Installed "" install2019 0
	goto finishedvs

install2010:
	IfFileExists "$EXEDIR\instdata\vs2010.7z" extract2010 download2010

download2010:
	DetailPrint $(D_VC2010)
	inetc::get /WEAKSECURITY /RESUME $(ERR_DOWNLOAD_RETRY) /CAPTION $(D_VC2010) /CANCELTEXT $(ERR_DOWNLOAD_CANCEL_A) /QUESTION $(ERR_DOWNLOAD_CANCEL_Q) /TRANSLATE $(INETC_DOWNLOADING) $(INETC_CONNECT) $(INETC_SECOND) $(INETC_MINUTE) $(INETC_HOUR) $(INETC_PLURAL) $(INETC_PROGRESS) $(INETC_REMAINING) "https://dcmods.unreliable.network/owncloud/data/PiKeyAr/files/Setup/data/vs2010.7z" "$EXEDIR\instdata\vs2010.7z" /END
	Pop $DownloadErrorCode
	StrCmp $DownloadErrorCode "OK" extract2010 0
	MessageBox MB_OK $(ERR_D_VC2010)
	Goto check2012

extract2010:
	DetailPrint $(DE_E_VC2010)
	nsexec::ExecToStack '"$TEMP\7zr.exe" x "$EXEDIR\instdata\vs2010.7z" -o"$INSTDIR" -aoa'
	DetailPrint $(DE_I_VC2010)
	ExecWait '"$INSTDIR\redist\vcredist_2010.exe" /q /norestart' "$DirectXSetupError"
	goto check2012

install2012:
	IfFileExists "$EXEDIR\instdata\vs2012.7z" extract2012 download2012
	
download2012:
	DetailPrint $(D_VC2012)
	inetc::get /WEAKSECURITY /RESUME $(ERR_DOWNLOAD_RETRY) /CAPTION $(D_VC2012) /CANCELTEXT $(ERR_DOWNLOAD_CANCEL_A) /QUESTION $(ERR_DOWNLOAD_CANCEL_Q) /TRANSLATE $(INETC_DOWNLOADING) $(INETC_CONNECT) $(INETC_SECOND) $(INETC_MINUTE) $(INETC_HOUR) $(INETC_PLURAL) $(INETC_PROGRESS) $(INETC_REMAINING) "https://dcmods.unreliable.network/owncloud/data/PiKeyAr/files/Setup/data/vs2012.7z" "$EXEDIR\instdata\vs2012.7z" /END
	Pop $DownloadErrorCode
	StrCmp $DownloadErrorCode "OK" extract2012 0
	MessageBox MB_OK $(ERR_D_VC2012)
	Goto check2013
	
extract2012:
	DetailPrint $(DE_E_VC2012)
	nsexec::ExecToStack '"$TEMP\7zr.exe" x "$EXEDIR\instdata\vs2012.7z" -o"$INSTDIR" -aoa'
	DetailPrint $(DE_I_VC2012)
	ExecWait '"$INSTDIR\redist\vcredist_2012.exe" /q /norestart' "$DirectXSetupError"
	goto check2013
	
install2013:
	IfFileExists "$EXEDIR\instdata\vs2013.7z" extract2013 download2013
	
download2013:
	DetailPrint $(D_VC2013)
	inetc::get /WEAKSECURITY /RESUME $(ERR_DOWNLOAD_RETRY) /CAPTION $(D_VC2013) /CANCELTEXT $(ERR_DOWNLOAD_CANCEL_A) /QUESTION $(ERR_DOWNLOAD_CANCEL_Q) /TRANSLATE $(INETC_DOWNLOADING) $(INETC_CONNECT) $(INETC_SECOND) $(INETC_MINUTE) $(INETC_HOUR) $(INETC_PLURAL) $(INETC_PROGRESS) $(INETC_REMAINING) "https://dcmods.unreliable.network/owncloud/data/PiKeyAr/files/Setup/data/vs2013.7z" "$EXEDIR\instdata\vs2013.7z" /END
	Pop $DownloadErrorCode
	StrCmp $DownloadErrorCode "OK" extract2013 0
	MessageBox MB_OK $(ERR_D_VC2013)
	Goto check2019
	
extract2013:
	DetailPrint $(DE_E_VC2013)
	nsexec::ExecToStack '"$TEMP\7zr.exe" x "$EXEDIR\instdata\vs2013.7z" -o"$INSTDIR" -aoa'
	DetailPrint $(DE_I_VC2013)
	ExecWait '"$INSTDIR\redist\vcredist_2013.exe" /q /norestart' "$DirectXSetupError"
	goto check2019

install2019:
	IfFileExists "$EXEDIR\instdata\vs2019.7z" extract2019 download2019
	download2019:
	DetailPrint $(D_VC2019)
	inetc::get /WEAKSECURITY /RESUME $(ERR_DOWNLOAD_RETRY) /CAPTION $(D_VC2019) /CANCELTEXT $(ERR_DOWNLOAD_CANCEL_A) /QUESTION $(ERR_DOWNLOAD_CANCEL_Q) /TRANSLATE $(INETC_DOWNLOADING) $(INETC_CONNECT) $(INETC_SECOND) $(INETC_MINUTE) $(INETC_HOUR) $(INETC_PLURAL) $(INETC_PROGRESS) $(INETC_REMAINING) "https://dcmods.unreliable.network/owncloud/data/PiKeyAr/files/Setup/data/vs2019.7z" "$EXEDIR\instdata\vs2019.7z" /END
	Pop $DownloadErrorCode
	StrCmp $DownloadErrorCode "OK" extract2019 0
	MessageBox MB_OK $(ERR_D_VC2019)
	Goto finishedvs

extract2019:
	DetailPrint $(DE_E_VC2019)
	nsexec::ExecToStack '"$TEMP\7zr.exe" x "$EXEDIR\instdata\vs2019.7z" -o"$INSTDIR" -aoa'
	DetailPrint $(DE_I_VC2019)
	ExecWait '"$INSTDIR\redist\vcredist_2019.exe" /q /norestart' "$DirectXSetupError"
	goto finishedvs

finishedvs:
SectionEnd

Section $(SECTIONNAME_DX9) SECTION_DIRECTX
SectionIn 1 2 3
DetailPrint $(DE_C_DX9)
IfFileExists $WINDIR\system32\D3DX9_43.dll donedx installdx

installdx:
	IfFileExists "$EXEDIR\instdata\directx_Jun2010_redist.exe" rundxsetup downloaddx

downloaddx:
	DetailPrint $(D_DX9)
	inetc::get /WEAKSECURITY /RESUME $(ERR_DOWNLOAD_RETRY) /CAPTION $(D_DX9) /CANCELTEXT $(ERR_DOWNLOAD_CANCEL_A) /QUESTION $(ERR_DOWNLOAD_CANCEL_Q) /TRANSLATE $(INETC_DOWNLOADING) $(INETC_CONNECT) $(INETC_SECOND) $(INETC_MINUTE) $(INETC_HOUR) $(INETC_PLURAL) $(INETC_PROGRESS) $(INETC_REMAINING) "https://dcmods.unreliable.network/owncloud/data/PiKeyAr/files/Setup/data/directx_Jun2010_redist.exe" "$EXEDIR\instdata\directx_Jun2010_redist.exe" /END
	Pop $DownloadErrorCode
	StrCmp $DownloadErrorCode "OK" rundxsetup 0
	MessageBox MB_OK $(ERR_D_DX9)
	Goto donedx

rundxsetup:
	DetailPrint $(DE_I_DX9_1)
	RmDir /r "$EXEDIR\instdata\DX"
	CreateDirectory "$EXEDIR\instdata\DX"
	ExecWait '"$EXEDIR\instdata\directx_Jun2010_redist.exe" /Q /T:"$EXEDIR\instdata\DX"' $DirectXSetupError
	DetailPrint $(DE_I_DX9_2)
	ExecWait '"$EXEDIR\instdata\DX\dxsetup.exe" /silent' $DirectXSetupError
	RmDir /r "$EXEDIR\instdata\DX"
	goto donedx
donedx:
SectionEnd

SectionGroupEnd

Section $(SECTIONNAME_MODLOADER) SECTION_MODLOADER
SectionIn 1 2 3
${nsProcess::KillProcess} "sonic.exe" $R0
${nsProcess::KillProcess} "sadx.exe" $R0
${nsProcess::KillProcess} "Sonic Adventure DX.exe" $R0
${nsProcess::KillProcess} "SADXModManager.exe" $R0
${nsProcess::KillProcess} "AppLauncher.exe" $R0
goto install

sadx2004check:
DetailPrint $(DE_2004FOUND)
IfFileExists "$INSTDIR\system\CHRMODELS_orig.dll" sonicexecheck 0
IfFileExists "$INSTDIR\system\CHRMODELS.dll" 0 missingfiles
DetailPrint $(DE_CHRM)
md5dll::GetMD5File "$INSTDIR\system\CHRMODELS.dll"
Pop $chrmodelsmd5
StrCmp $chrmodelsmd5 "ae1637538679588fd96905113e8bddbd" sonicexecheck chrmodelsbad
goto sonicexecheck
 
chrmodelserror:
	MessageBox MB_OK $(ERR_CHRMODELS)
	Quit

chrmodelsbad:
	MessageBox MB_OK $(ERR_CHRMODELSBAD)
	Delete "$INSTDIR\system\CHRMODELS.bak"
	DetailPrint $(DE_B_CHR)
	CopyFiles /SILENT "$INSTDIR\system\CHRMODELS.DLL" "$INSTDIR\system\CHRMODELS.bak"
	IfFileExists "$EXEDIR\instdata\CHRMODELS.7z" extractchr downloadchr
downloadchr:
	DetailPrint $(DE_D_CHR)
	inetc::get /WEAKSECURITY /RESUME $(ERR_DOWNLOAD_RETRY) /CAPTION $(D_CHRMODELS) /CANCELTEXT $(ERR_DOWNLOAD_CANCEL_A) /QUESTION $(ERR_DOWNLOAD_CANCEL_Q) /TRANSLATE $(INETC_DOWNLOADING) $(INETC_CONNECT) $(INETC_SECOND) $(INETC_MINUTE) $(INETC_HOUR) $(INETC_PLURAL) $(INETC_PROGRESS) $(INETC_REMAINING) "https://dcmods.unreliable.network/owncloud/data/PiKeyAr/files/Setup/data/CHRMODELS.7z" "$EXEDIR\instdata\CHRMODELS.7z" /END
	Pop $DownloadErrorCode
	StrCmp $DownloadErrorCode "OK" extractchr 0
	MessageBox MB_OK $(ERR_CHRMODELS)
	Quit
extractchr:
	DetailPrint $(DE_E_CHR)
	nsexec::ExecToStack '"$TEMP\7zr.exe" x "$EXEDIR\instdata\CHRMODELS.7z" -o"$INSTDIR" -aoa'
	DetailPrint $(DE_C_CHR)
	md5dll::GetMD5File "$INSTDIR\system\CHRMODELS.dll"
	Pop $chrmodelsmd5
	StrCmp $chrmodelsmd5 "ae1637538679588fd96905113e8bddbd" sonicexecheck chrmodelserror

sonicexecheck:
	DetailPrint $(DE_C_EXE)
	md5dll::GetMD5File "$INSTDIR\sonic.exe"
	Pop $sonicexemd5
	StrCmp $sonicexemd5 "c6d65712475602252bfce53d0d8b7d6f" sonicexegood 0 ;Original (without manifest)
	StrCmp $sonicexemd5 "4d9b59aea4ee361e4f25475df1447bfd" sonicexegood 0 ;Original (with manifest)
	StrCmp $sonicexemd5 "e46580fc390285174acae895a90c5c84" sonicexegood 0 ;SA1 save (with manifest)
	StrCmp $sonicexemd5 "b215d5dfc16514c0cc354449c101c7d0" sonicexegood 0 ;SA1 box (with manifest)
	StrCmp $sonicexemd5 "f8c0b356519d7c459f7b726d63462791" sonicexegood 0 ;SADX HD (with manifest)
	StrCmp $sonicexemd5 "a35eb183684e3eb964351de391db82e8" sonicexegood sonicexebad ;SADX save (with manifest)

sonicexegood:
	DetailPrint $(DE_EXEFOUND)
	goto install_min
	
sonicexebad:
	DetailPrint $(DE_EXEUNK)
	goto install_eu
	
missingfiles:
	MessageBox MB_OK $(ERR_MISSINGFILES)
	Quit

install:
	SetOutPath "$INSTDIR"
	DetailPrint $(DE_DETECT)
	IfFileExists "$INSTDIR\Sonic Adventure DX.exe" steamcheck 0
	IfFileExists "$INSTDIR\sonic.exe" sadx2004check_pre missingfiles
	
; Check for an incomplete conversion (sonic.exe but Steam data)
sadx2004check_pre:
	; Check SFD/MPG
	IfFileExists "$INSTDIR\system\SA1.SFD" 0 +2
	IfFileExists "$INSTDIR\system\SA1.MPG" 0 checkdownload1
	; Check SFD/MPG (intro)
	IfFileExists "$INSTDIR\DLC\re-us2.sfd" 0 +2
	IfFileExists "$INSTDIR\system\RE-US.mpg" 0 checkdownload1
	; Check DAT soundbanks
	IfFileExists "$INSTDIR\SoundData\SE\WINDY_VALLEY_BANK05.dat" 0 +2
	IfFileExists "$INSTDIR\system\SoundData\SE\WINDY_VALLEY_BANK05.dat" 0 checkdownload1
	; Check ADX/WMA music
	IfFileExists "$INSTDIR\SoundData\bgm\wma\option.adx" 0 +2
	IfFileExists "$INSTDIR\system\SoundData\bgm\wma\option.adx" 0 checkdownload1
	; Check ADX/WMA voices
	IfFileExists "$INSTDIR\SoundData\voice_us\wma\0000.adx" 0 +2
	IfFileExists "$INSTDIR\system\SoundData\voice_us\wma\0000.adx" 0 checkdownload1
goto sadx2004check

steamcheck:
	DetailPrint $(DE_2010FOUND)
	DetailPrint $(DE_C_2010)
	; Check if certain files from either 2004 or Steam exist. If the file from either version isn't there, it's a fatal error.
	; Check SFD/MPG
	IfFileExists "$INSTDIR\system\SA1.SFD" +2 0
	IfFileExists "$INSTDIR\system\SA1.MPG" 0 missingfiles
	; Check SFD/MPG (intro)
	IfFileExists "$INSTDIR\DLC\re-us2.sfd" +2 0
	IfFileExists "$INSTDIR\system\RE-US.mpg" 0 missingfiles
	; Check DAT soundbanks
	IfFileExists "$INSTDIR\SoundData\SE\WINDY_VALLEY_BANK05.dat" +2 0
	IfFileExists "$INSTDIR\system\SoundData\SE\WINDY_VALLEY_BANK05.dat" 0 missingfiles
	; Check ADX/WMA music
	IfFileExists "$INSTDIR\SoundData\bgm\wma\option.adx" +3 0
	IfFileExists "$INSTDIR\system\SoundData\bgm\wma\option.wma" +2 0
	IfFileExists "$INSTDIR\system\SoundData\bgm\wma\option.adx" 0 missingfiles
	; Check ADX/WMA voices
	IfFileExists "$INSTDIR\SoundData\voice_us\wma\0000.adx" +3 0
	IfFileExists "$INSTDIR\system\SoundData\voice_us\wma\0000.wma" +2 0
	IfFileExists "$INSTDIR\system\SoundData\voice_us\wma\0000.adx" 0 missingfiles
goto checkdownload1
	
checkdownload1:
	IfFileExists "$EXEDIR\instdata\steam_tools.7z" extracttools downloadtools

downloadtools:
	DetailPrint $(D_STEAMTOOLS)
	inetc::get /WEAKSECURITY /RESUME $(ERR_DOWNLOAD_RETRY) /CAPTION $(D_STEAMTOOLS) /CANCELTEXT $(ERR_DOWNLOAD_CANCEL_A) /QUESTION $(ERR_DOWNLOAD_CANCEL_Q) /TRANSLATE $(INETC_DOWNLOADING) $(INETC_CONNECT) $(INETC_SECOND) $(INETC_MINUTE) $(INETC_HOUR) $(INETC_PLURAL) $(INETC_PROGRESS) $(INETC_REMAINING) "https://dcmods.unreliable.network/owncloud/data/PiKeyAr/files/Setup/data/steam_tools.7z" "$EXEDIR\instdata\steam_tools.7z" /END
	Pop $DownloadErrorCode
	StrCmp $DownloadErrorCode "OK" extracttools 0
	MessageBox MB_OK $(ERR_DOWNLOAD_FATAL)
	Quit

extracttools:
	DetailPrint $(DE_E_TOOLS)
	nsexec::ExecToStack '"$TEMP\7zr.exe" x "$EXEDIR\instdata\steam_tools.7z" -o"$INSTDIR" -aoa'
	DetailPrint $(DE_C_TOOLS)
	IfFileExists "$INSTDIR\ffmpeg.exe" 0 toolerror
	IfFileExists "$INSTDIR\SteamHelper.exe" 0 toolerror
	IfFileExists "$INSTDIR\lame.exe" 0 toolerror
	IfFileExists "$INSTDIR\VGAudio.dll" 0 toolerror
	IfFileExists "$INSTDIR\VGAudio.xml" 0 toolerror
	IfFileExists "$INSTDIR\sfd2mpg.exe" 0 toolerror
	IfFileExists "$INSTDIR\sfk.exe" 0 toolerror
	IfFileExists "$EXEDIR\instdata\sadx2004.7z" extract2004 download2004

download2004:
	DetailPrint $(D_2004BIN)
	inetc::get /WEAKSECURITY /RESUME $(ERR_DOWNLOAD_RETRY) /CAPTION $(D_2004BIN) /CANCELTEXT $(ERR_DOWNLOAD_CANCEL_A) /QUESTION $(ERR_DOWNLOAD_CANCEL_Q) /TRANSLATE $(INETC_DOWNLOADING) $(INETC_CONNECT) $(INETC_SECOND) $(INETC_MINUTE) $(INETC_HOUR) $(INETC_PLURAL) $(INETC_PROGRESS) $(INETC_REMAINING) "https://dcmods.unreliable.network/owncloud/data/PiKeyAr/files/Setup/data/sadx2004.7z" "$EXEDIR\instdata\sadx2004.7z" /END
	Pop $DownloadErrorCode
	StrCmp $DownloadErrorCode "OK" extract2004 0
	MessageBox MB_OK $(ERR_DOWNLOAD_FATAL)
	Quit

extract2004:
	DetailPrint $(DE_E_BIN)
	nsexec::ExecToStack '"$TEMP\7zr.exe" x "$EXEDIR\instdata\sadx2004.7z" -o"$INSTDIR" -aoa'
	goto verify2004

verify2004:
	DetailPrint $(DE_C_BIN)
	IfFileExists "$INSTDIR\sonic.exe" 0 sadx2004error
	IfFileExists "$INSTDIR\system\chrmodels.dll" 0 sadx2004error
	IfFileExists "$INSTDIR\system\adv00models.dll" 0 sadx2004error
	IfFileExists "$INSTDIR\system\adv01models.dll" 0 sadx2004error
	IfFileExists "$INSTDIR\system\adv01cmodels.dll" 0 sadx2004error
	IfFileExists "$INSTDIR\system\adv02models.dll" 0 sadx2004error
	IfFileExists "$INSTDIR\system\adv03models.dll" 0 sadx2004error
	IfFileExists "$INSTDIR\system\bosschaos0models.dll" 0 sadx2004error
	goto install_steam

toolerror:
	MessageBox MB_OK $(ERR_DOWNLOAD_TOOLS)
	Quit

sadx2004error:
	MessageBox MB_OK $(ERR_DOWNLOAD_2004BIN)
	Quit

install_steam:
	DetailPrint $(DE_SND)
	${If} ${RunningX64}
		SetRegView 64
	${Else}
		SetRegView 32
	${EndIf}
	ReadRegDWORD $NetFrameworkVersion HKLM "SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" "Release"
	${If} $NetFrameworkVersion < "378389"
		MessageBox MB_OK $(ERR_NET_MISSING)
		Quit
	${EndIf}
	SetOutPath "$INSTDIR"
	nsexec::ExecToLog '"$INSTDIR\SteamHelper.exe"'
	IfFileExists "$EXEDIR\instdata\voices.7z" extractvoices downloadvoices

downloadvoices:
	DetailPrint $(DE_VOICES)
	inetc::get /WEAKSECURITY /RESUME $(ERR_DOWNLOAD_RETRY) /CAPTION $(D_VOICES) /CANCELTEXT $(ERR_DOWNLOAD_CANCEL_A) /QUESTION $(ERR_DOWNLOAD_CANCEL_Q) /TRANSLATE $(INETC_DOWNLOADING) $(INETC_CONNECT) $(INETC_SECOND) $(INETC_MINUTE) $(INETC_HOUR) $(INETC_PLURAL) $(INETC_PROGRESS) $(INETC_REMAINING) "https://dcmods.unreliable.network/owncloud/data/PiKeyAr/files/Setup/data/voices.7z" "$EXEDIR\instdata\voices.7z" /END
	Pop $DownloadErrorCode
	StrCmp $DownloadErrorCode "OK" extractvoices 0
	MessageBox MB_OK $(ERR_DOWNLOAD_FATAL)
	Quit

extractvoices:
	DetailPrint $(DE_E_VOICES)
	nsexec::ExecToStack '"$TEMP\7zr.exe" x "$EXEDIR\instdata\voices.7z" -o"$INSTDIR" -aoa'
	goto modloader

install_eu:
	SetOutPath "$INSTDIR"
	goto sadx2004exe

install_min:
	SetOutPath "$INSTDIR"
	goto modloader

sadx2004exe:
	IfFileExists "$EXEDIR\instdata\sonic-U-crack.7z" extractsonicexe downloadsonicexe

downloadsonicexe:
	DetailPrint $(D_2004EXE)
	inetc::get /WEAKSECURITY /RESUME $(ERR_DOWNLOAD_RETRY) /CAPTION $(D_2004EXE) /CANCELTEXT $(ERR_DOWNLOAD_CANCEL_A) /QUESTION $(ERR_DOWNLOAD_CANCEL_Q) /TRANSLATE $(INETC_DOWNLOADING) $(INETC_CONNECT) $(INETC_SECOND) $(INETC_MINUTE) $(INETC_HOUR) $(INETC_PLURAL) $(INETC_PROGRESS) $(INETC_REMAINING) "http://mm.reimuhakurei.net/misc/sonic-U-crack.7z" "$EXEDIR\instdata\sonic-U-crack.7z" /END
	Pop $DownloadErrorCode
	StrCmp $DownloadErrorCode "OK" extractsonicexe 0
	MessageBox MB_OK $(ERR_DOWNLOAD_FATAL)
	Quit

extractsonicexe:
	DetailPrint $(DE_E_EXE)
	nsexec::ExecToStack '"$TEMP\7zr.exe" x "$EXEDIR\instdata\sonic-U-crack.7z" -o"$INSTDIR" -aoa'
	Delete "$INSTDIR\sonic_exe.bak"
	DetailPrint $(DE_B_EXE)
	Rename "$INSTDIR\sonic.exe" "$INSTDIR\sonic_exe.bak"
	Rename "$INSTDIR\sonic-U-crack.exe" "$INSTDIR\sonic.exe"
	DetailPrint $(DE_C_EXE)
	IfFileExists "$INSTDIR\sonic.exe" 0 exeerror
	md5dll::GetMD5File "$INSTDIR\sonic.exe"
	Pop $sonicexemd5
	StrCmp $sonicexemd5 "c6d65712475602252bfce53d0d8b7d6f" 0 exeerror
	goto modloader

modloader:
	IfFileExists "$EXEDIR\instdata\SADXModLoader.7z" extractmodloader downloadmodloader

downloadmodloader:
	DetailPrint $(D_MODLOADER)
	inetc::get /WEAKSECURITY /RESUME $(ERR_DOWNLOAD_RETRY) /CAPTION $(D_MODLOADER) /CANCELTEXT $(ERR_DOWNLOAD_CANCEL_A) /QUESTION $(ERR_DOWNLOAD_CANCEL_Q) /TRANSLATE $(INETC_DOWNLOADING) $(INETC_CONNECT) $(INETC_SECOND) $(INETC_MINUTE) $(INETC_HOUR) $(INETC_PLURAL) $(INETC_PROGRESS) $(INETC_REMAINING) "https://mm.reimuhakurei.net/sadxmods/SADXModLoader.7z" "$EXEDIR\instdata\SADXModLoader.7z" /END
	Pop $DownloadErrorCode
	StrCmp $DownloadErrorCode "OK" extractmodloader 0
	MessageBox MB_OK $(ERR_DOWNLOAD_FATAL)
	Quit

extractmodloader:
	DetailPrint $(DE_E_ML)
	nsexec::ExecToStack '"$TEMP\7zr.exe" x "$EXEDIR\instdata\SADXModLoader.7z" -o"$INSTDIR" -aoa'
	IfFileExists "$INSTDIR\SADXModManager.exe" 0 modloadererror
	DetailPrint $(DE_I_ML)
	IfFileExists system\CHRMODELS_orig.dll +2 0
	CopyFiles /SILENT "$INSTDIR\system\CHRMODELS.dll" "$INSTDIR\system\CHRMODELS_orig.dll"
	Delete "$INSTDIR\system\CHRMODELS.dll"
	CopyFiles /SILENT "$INSTDIR\mods\SADXModLoader.dll" "$INSTDIR\system\CHRMODELS.dll"
	IfFileExists "$INSTDIR\system\sounddata\voice_us\wma\*.wma" finished 0
	IfFileExists "$INSTDIR\system\sounddata\voice_us\wma\2048.adx" finished instvoices

instvoices:
	${If} $INST_ADX == "0"
		IfFileExists "$EXEDIR\instdata\voices.7z" extractvoices2 downloadvoices2
		downloadvoices2:
		DetailPrint $(D_VOICES)
		inetc::get /WEAKSECURITY /RESUME $(ERR_DOWNLOAD_RETRY) /CAPTION $(D_VOICES) /CANCELTEXT $(ERR_DOWNLOAD_CANCEL_A) /QUESTION $(ERR_DOWNLOAD_CANCEL_Q) /TRANSLATE $(INETC_DOWNLOADING) $(INETC_CONNECT) $(INETC_SECOND) $(INETC_MINUTE) $(INETC_HOUR) $(INETC_PLURAL) $(INETC_PROGRESS) $(INETC_REMAINING) "https://dcmods.unreliable.network/owncloud/data/PiKeyAr/files/Setup/data/voices.7z" "$EXEDIR\instdata\voices.7z" /END
		Pop $DownloadErrorCode
		StrCmp $DownloadErrorCode "OK" extractvoices2 0
		MessageBox MB_OK $(ERR_DOWNLOAD_FATAL)
		Quit

		extractvoices2:
		DetailPrint $(DE_E_VOICES)
		nsexec::ExecToStack '"$TEMP\7zr.exe" x "$EXEDIR\instdata\voices.7z" -o"$INSTDIR" -aoa'
	${EndIf}
	goto finished

exeerror:
	MessageBox MB_OK $(ERR_2004CHECK)
	Quit

modloadererror:
	MessageBox MB_OK $(ERR_MODLOADER)
	Quit

finished:
	DetailPrint $(DE_DPI)
	ReadRegStr $0 HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion" "CurrentBuild"
	${If} ${Errors}
		goto nofullscreenopt
	${Else}
		${If} $0 >= "15063"
			DetailPrint $(DE_FSOPT)
			WriteRegStr HKCU "SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" '$INSTDIR\sonic.exe' '~ DISABLEDXMAXIMIZEDWINDOWEDMODE HIGHDPIAWARE'
			goto fullscreendone
		${Else}
			goto nofullscreenopt
		${EndIf}
	${EndIf}
	
nofullscreenopt:
	DetailPrint $(DE_FSOPTNOTFOUND)
	WriteRegStr HKCU "SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" '$INSTDIR\sonic.exe' '~ HIGHDPIAWARE'
	goto fullscreendone

fullscreendone:
	DetailPrint $(DE_CLEANUP)
	SetOutPath "$INSTDIR"
	Delete "$INSTDIR\system\AL_STG_KINDER_AD_TEX_R.pvm"
	Delete "$INSTDIR\system\AL_TEX_ODEKAKE_MENU_EN_R.pvm"
	Delete "$INSTDIR\system\AL_TEX_ODEKAKE_MENU_JP_R.pvm"
	Delete "$INSTDIR\system\AVA_DLG_F.pvm AVA_DLG_G.pvm"
	Delete "$INSTDIR\system\AVA_DLG_I.pvm AVA_DLG_S.pvm"
	Delete "$INSTDIR\system\AVA_FILESEL_F.pvm"
	Delete "$INSTDIR\system\AVA_FILESEL_G.pvm"
	Delete "$INSTDIR\system\AVA_FILESEL_I.pvm"
	Delete "$INSTDIR\system\AVA_FILESEL_S.pvm"
	Delete "$INSTDIR\system\AVA_GTITLE0_DC.pvm"
	Delete "$INSTDIR\system\AVA_GTITLE0_F.pvm"
	Delete "$INSTDIR\system\AVA_GTITLE0_G.pvm"
	Delete "$INSTDIR\system\AVA_GTITLE0_I.pvm"
	Delete "$INSTDIR\system\AVA_GTITLE0_S.pvm"
	Delete "$INSTDIR\system\ava_help_options.pvm"
	Delete "$INSTDIR\system\ava_how2play.pvm"
	Delete "$INSTDIR\system\ava_LB_MENU.pvm"
	Delete "$INSTDIR\system\AVA_SNDTEST_E_R.pvm"
	Delete "$INSTDIR\system\AVA_SNDTEST_R.pvm"
	Delete "$INSTDIR\system\AVA_TITLE_CMN2.pvm"
	Delete "$INSTDIR\system\AVA_TITLE_F.pvm"
	Delete "$INSTDIR\system\AVA_TITLE_G.pvm"
	Delete "$INSTDIR\system\AVA_TITLE_I.pvm"
	Delete "$INSTDIR\system\AVA_TITLE_S.pvm"
	Delete "$INSTDIR\system\ava_tool_tips.pvm"
	Delete "$INSTDIR\system\AVA_VMSSEL_F.pvm"
	Delete "$INSTDIR\system\AVA_VMSSEL_G.pvm"
	Delete "$INSTDIR\system\AVA_VMSSEL_I.pvm"
	Delete "$INSTDIR\system\AVA_VMSSEL_S.pvm"
	Delete "$INSTDIR\system\CON_REGULAR_F.pvm"
	Delete "$INSTDIR\system\CON_REGULAR_G.pvm"
	Delete "$INSTDIR\system\CON_REGULAR_I.pvm"
	Delete "$INSTDIR\system\CON_REGULAR_S.pvm"
	Delete "$INSTDIR\system\DC_HELP_OPTIONS_F.pvm"
	Delete "$INSTDIR\system\DC_HELP_OPTIONS_G.pvm"
	Delete "$INSTDIR\system\DC_HELP_OPTIONS_I.pvm"
	Delete "$INSTDIR\system\DC_HELP_OPTIONS_J.pvm"
	Delete "$INSTDIR\system\DC_HELP_OPTIONS_S.pvm"
	Delete "$INSTDIR\system\DC_HOW_PLAY_F.pvm"
	Delete "$INSTDIR\system\DC_HOW_PLAY_G.pvm"
	Delete "$INSTDIR\system\DC_HOW_PLAY_I.pvm"
	Delete "$INSTDIR\system\DC_HOW_PLAY_J.pvm"
	Delete "$INSTDIR\system\DC_HOW_PLAY_S.pvm"
	Delete "$INSTDIR\system\DC_LEADER_MENU.pvm"
	Delete "$INSTDIR\system\DC_LEADER_MENU_F.pvm"
	Delete "$INSTDIR\system\DC_LEADER_MENU_G.pvm"
	Delete "$INSTDIR\system\DC_LEADER_MENU_I.pvm"
	Delete "$INSTDIR\system\DC_LEADER_MENU_J.pvm"
	Delete "$INSTDIR\system\DC_LEADER_MENU_S.pvm"
	Delete "$INSTDIR\system\DC_MAIN_MENU.pvm"
	Delete "$INSTDIR\system\DC_MAIN_MENU_F.pvm"
	Delete "$INSTDIR\system\DC_MAIN_MENU_G.pvm"
	Delete "$INSTDIR\system\DC_MAIN_MENU_I.pvm"
	Delete "$INSTDIR\system\DC_MAIN_MENU_J.pvm"
	Delete "$INSTDIR\system\DC_MAIN_MENU_S.pvm"
	Delete "$INSTDIR\system\GAMEOVER_F.pvm"
	Delete "$INSTDIR\system\GAMEOVER_G.pvm"
	Delete "$INSTDIR\system\GAMEOVER_I.pvm"
	Delete "$INSTDIR\system\GAMEOVER_S.pvm"
	Delete "$INSTDIR\system\MAP_EC_A_R.pvm"
	Delete "$INSTDIR\system\MAP_EC_B_R.pvm"
	Delete "$INSTDIR\system\MAP_EC_H_R.pvm"
	Delete "$INSTDIR\system\MAP_MR_A_R.pvm"
	Delete "$INSTDIR\system\MAP_MR_J_R.pvm"
	Delete "$INSTDIR\system\MAP_MR_S_R.pvm"
	Delete "$INSTDIR\system\MAP_PAST_E_R.pvm"
	Delete "$INSTDIR\system\MAP_PAST_S_R.pvm"
	Delete "$INSTDIR\system\MAP_SS_R.pvm"
	Delete "$INSTDIR\system\MIS_C_EN_R.pvm"
	Delete "$INSTDIR\system\MIS_C_J_R.pvm"
	Delete "$INSTDIR\system\PRESSSTART_DC.pvm"
	Delete "$INSTDIR\system\PRESSSTART_DC_F.pvm"
	Delete "$INSTDIR\system\PRESSSTART_DC_G.pvm"
	Delete "$INSTDIR\system\PRESSSTART_DC_I.pvm"
	Delete "$INSTDIR\system\PRESSSTART_DC_J.pvm"
	Delete "$INSTDIR\system\PRESSSTART_DC_S.pvm"
	Delete "$INSTDIR\system\PRESSSTART_F.pvm"
	Delete "$INSTDIR\system\PRESSSTART_G.pvm"
	Delete "$INSTDIR\system\PRESSSTART_I.pvm"
	Delete "$INSTDIR\system\PRESSSTART_J.pvm"
	Delete "$INSTDIR\system\PRESSSTART_S.pvm"
	Delete "$INSTDIR\system\SOC_fontdata0.bin"
	Delete "$INSTDIR\system\SOC_fontdata1.bin"
	Delete "$INSTDIR\system\SonicADV_Socstaff.bin"
	Delete "$INSTDIR\system\TUTO_CMN_E_R.pvm"
	Delete "$INSTDIR\system\TUTO_CMN_F.pvm"
	Delete "$INSTDIR\system\TUTO_CMN_F_R.pvm"
	Delete "$INSTDIR\system\TUTO_CMN_G.pvm"
	Delete "$INSTDIR\system\TUTO_CMN_G_R.pvm"
	Delete "$INSTDIR\system\TUTO_CMN_I.pvm"
	Delete "$INSTDIR\system\TUTO_CMN_I_R.pvm"
	Delete "$INSTDIR\system\TUTO_CMN_R.pvm"
	Delete "$INSTDIR\system\TUTO_CMN_S.pvm"
	Delete "$INSTDIR\system\TUTO_CMN_S_R.pvm"
	Delete "$INSTDIR\install.vdf"
	RmDir /r "$INSTDIR\system\BackGround"
	RmDir /r "$INSTDIR\system\BigEndian"
	RmDir /r "$INSTDIR\system\CreateNewFile"
	RmDir /r "$INSTDIR\system\DC"
	RmDir /r "$INSTDIR\system\Leaderboards"
	RmDir /r "$INSTDIR\system\LittleEndian"
	RmDir /r "$INSTDIR\system\Logo"
	RmDir /r "$INSTDIR\system\NowLoading"
	RmDir /r "$INSTDIR\system\Option"
	RmDir /r "$INSTDIR\system\Tips_DDS"
	RmDir /r "$INSTDIR\system\tips_exit"
	RmDir /r "$INSTDIR\system\texture_replace"
	RmDir /r "$INSTDIR\system\texture_repalce"
	RmDir /r "$INSTDIR\system\TUTO"
	RmDir /r "$INSTDIR\system\TUTO_Texture"
	RmDir /r "$INSTDIR\system\Water"
	RmDir /r "$INSTDIR\linux32"
	RmDir /r "$INSTDIR\linux64"
	RmDir /r "$INSTDIR\osx32"
	RmDir /r "$INSTDIR\win64"
	RmDir /r "$INSTDIR\tools"
	RmDir /r "$INSTDIR\Font"
	RmDir /r "$INSTDIR\Shader"
	Delete "$INSTDIR\Sonic Adventure DX.exe"
	Delete "$INSTDIR\SEGA*.*"
	Delete "$INSTDIR\sadx_snd.cmd"
	Delete "$INSTDIR\sadx_bgm.bat"
	Delete "$INSTDIR\sadx_saves.bat"
	Delete "$INSTDIR\modloader.bat"
	Delete "$INSTDIR\sadxconvert_eu.bat"
	Delete "$INSTDIR\sadxconvert_min.bat"
	Delete "$INSTDIR\D3DX9_43.dll"
	Delete "$INSTDIR\xinput9_1_0.dll"
	IfFileExists "$INSTDIR\system\RE-US.mpg" 0 +2
	RmDir /r "$INSTDIR\DLC"
	IfFileExists "$INSTDIR\system\SoundData\bgm\wma\option.adx" 0 +2
	RmDir /r "$INSTDIR\SoundData"
	IfFileExists "$INSTDIR\system\SA1.mpg" 0 +2
	Delete "$INSTDIR\system\SA*.sfd"
SectionEnd

Section $(SECTIONNAME_LAUNCHER) SECTION_LAUNCHER
SectionIn 1 2 3
IfFileExists "$EXEDIR\instdata\AppLauncher.7z" extractlauncher downloadlauncher

downloadlauncher:
	DetailPrint $(D_LAUNCHER)
	inetc::get /WEAKSECURITY /RESUME $(ERR_DOWNLOAD_RETRY) /CAPTION $(D_LAUNCHER) /CANCELTEXT $(ERR_DOWNLOAD_CANCEL_A) /QUESTION $(ERR_DOWNLOAD_CANCEL_Q) /TRANSLATE $(INETC_DOWNLOADING) $(INETC_CONNECT) $(INETC_SECOND) $(INETC_MINUTE) $(INETC_HOUR) $(INETC_PLURAL) $(INETC_PROGRESS) $(INETC_REMAINING) "https://dcmods.unreliable.network/owncloud/data/PiKeyAr/files/Setup/data/AppLauncher.7z" "$EXEDIR\instdata\AppLauncher.7z" /END
	Pop $DownloadErrorCode
	StrCmp $DownloadErrorCode "OK" extractlauncher 0
	MessageBox MB_OK $(ERR_D_LAUNCHER)
	Goto finished

extractlauncher:
	DetailPrint $(DE_E_LAUNCHER)
	RmDir /r "$INSTDIR\AppLauncher"
	nsexec::ExecToStack '"$TEMP\7zr.exe" x "$EXEDIR\instdata\AppLauncher.7z" -o"$INSTDIR" -aoa'
	goto finished
finished:
SectionEnd

SectionGroup $(SECTIONNAME_BUGFIXES) SECTIONGROUP_BUGFIXES

Section $(SECTIONNAME_SADXFE) SECTION_SADXFE
SectionIn 1 2
${If} $PreserveModSettings == "1"
	IfFileExists "$INSTDIR\mods\SADXFE\config.ini" backupconfig nobackup
${Else}
	goto nobackup
${EndIf}

backupconfig:
	DetailPrint $(DE_B_SADXFE)
	CopyFiles /SILENT "$INSTDIR\mods\SADXFE\config.ini" "$EXEDIR\instdata\sadxfe.ini"
	goto nobackup

nobackup:
	StrCpy $Modname $(MOD_SADXFE)
	StrCpy $ModFilename "SADXFE"
	Call ModInstall
	${If} $ModInstallSuccess == "1"
		IntOp $INST_SADXFE 0 + 1
	${EndIf}
	IfFileExists "$EXEDIR\instdata\sadxfe.ini" restoreconfig finish

restoreconfig:
	DetailPrint $(DE_R_SADXFE)
	CopyFiles /SILENT "$EXEDIR\instdata\sadxfe.ini" "$INSTDIR\mods\SADXFE\config.ini"
	Delete "$EXEDIR\instdata\sadxfe.ini"
	goto finish

finish:
	RmDir /r "$INSTDIR\mods\ECGardenOceanFix"
	RmDir /r "$INSTDIR\mods\MR_FinalEggFix"
SectionEnd

Section $(SECTIONNAME_INPUTMOD) SECTION_INPUTMOD
SectionIn 1 2
${If} $PreserveModSettings == "1"
	IfFileExists "$INSTDIR\mods\sadx-input-mod\config.ini" backupconfig1 0
	IfFileExists "$INSTDIR\mods\sadx-input-mod\gamecontrollerdb.txt" backupconfig2 0
${Else}
	goto nobackup
${EndIf}

backupconfig1:
	DetailPrint $(DE_B_INPUT)
	CopyFiles /SILENT "$INSTDIR\mods\sadx-input-mod\config.ini" "$EXEDIR\instdata\inputmod.ini"
	IfFileExists "$INSTDIR\mods\sadx-input-mod\gamecontrollerdb.txt" backupconfig2 nobackup

backupconfig2:
	DetailPrint $(DE_B_GAMEC)
	CopyFiles /SILENT "$INSTDIR\mods\sadx-input-mod\gamecontrollerdb.txt" "$EXEDIR\instdata\gamecontrollerdb_bk.txt"
	goto nobackup

nobackup:
	StrCpy $Modname $(MOD_INPUT)
	StrCpy $ModFilename "sadx-input-mod"
	Call ModInstall
	${If} $ModInstallSuccess == "1"
		IntOp $INST_INPUTMOD 0 + 1
		Call GenerateModVersion
		RmDir /r "$INSTDIR\mods\xinputfix"
		RmDir /r "$INSTDIR\mods\input-mod"
	${EndIf}
IfFileExists "$EXEDIR\instdata\inputmod.ini" restoreconfig continue

restoreconfig:
	DetailPrint $(DE_R_INPUT)
	CopyFiles /SILENT "$EXEDIR\instdata\inputmod.ini" "$INSTDIR\mods\sadx-input-mod\config.ini"
	Delete "$EXEDIR\instdata\inputmod.ini"

continue:
	IfFileExists "$EXEDIR\instdata\gamecontrollerdb_bk.txt" restoredb finish

restoredb:
	DetailPrint $(DE_R_GAMEC)
	CopyFiles /SILENT "$EXEDIR\instdata\gamecontrollerdb_bk.txt" "$INSTDIR\mods\sadx-input-mod\gamecontrollerdb.txt"
	Delete "$EXEDIR\instdata\gamecontrollerdb_bk.txt"
	goto finish
	
finish:
SectionEnd

Section $(SECTIONNAME_FRAMELIMIT) SECTION_FRAMELIMIT
SectionIn 1 2 3
StrCpy $Modname $(MOD_FRAME)
StrCpy $ModFilename "sadx-frame-limit"
Call ModInstall
${If} $ModInstallSuccess == "1"
	IntOp $INST_FRAMELIMIT 0 + 1
	Call GenerateModVersion
	RmDir /r "$INSTDIR\mods\frame-limit"
${EndIf}
SectionEnd

Section $(SECTIONNAME_CCEF) SECTION_CCEF
SectionIn 3
StrCpy $Modname $(MOD_CCEF)
StrCpy $ModFilename "CCEF"
Call ModInstall
${If} $ModInstallSuccess == "1"
	IntOp $INST_CCEF 0 + 1
${EndIf}
SectionEnd

SectionGroupEnd

SectionGroup $(SECTIONNAME_DCMODS) SECTIONGROUP_DCCONV

Section $(SECTIONNAME_DCCONV) SECTION_DCMODS
SectionIn 1
${If} $PreserveModSettings == "1"
	IfFileExists "$INSTDIR\mods\DreamcastConversion\config.ini" backupconfig nobackup
${Else}
	goto nobackup
${EndIf}

backupconfig:
	DetailPrint $(DE_B_DCCONV)
	CopyFiles /SILENT "$INSTDIR\mods\DreamcastConversion\config.ini" "$EXEDIR\instdata\dcconv.ini"
	goto nobackup

nobackup:
	IfFileExists "$EXEDIR\instdata\DreamcastConversion.7z" extract download

download:
	DetailPrint $(D_DCCONV)
	inetc::get /WEAKSECURITY /RESUME $(ERR_DOWNLOAD_RETRY) /CAPTION $(D_DCCONV) /CANCELTEXT $(ERR_DOWNLOAD_CANCEL_A) /QUESTION $(ERR_DOWNLOAD_CANCEL_Q) /TRANSLATE $(INETC_DOWNLOADING) $(INETC_CONNECT) $(INETC_SECOND) $(INETC_MINUTE) $(INETC_HOUR) $(INETC_PLURAL) $(INETC_PROGRESS) $(INETC_REMAINING) "https://dcmods.unreliable.network/owncloud/data/PiKeyAr/files/Setup/data/DreamcastConversion.7z" "$EXEDIR\instdata\DreamcastConversion.7z" /END
	Pop $DownloadErrorCode
	StrCmp $DownloadErrorCode "OK" extract 0
	MessageBox MB_YESNO $(ERR_D_DCCONV) IDYES finish IDNO 0
	Quit

extract:
	RmDir /r "$INSTDIR\mods\MR_FinalEggFix"
	RmDir /r "$INSTDIR\mods\DreamcastConversion"
	RmDir /r "$INSTDIR\mods\DC Conversion"
	RmDir /r "$INSTDIR\mods\DC_Mods"
	RmDir /r "$INSTDIR\mods\DC_Edition"
	RmDir /r "$INSTDIR\mods\DC_Camera"
	RmDir /r "$INSTDIR\mods\DC_EnvMaps"
	RmDir /r "$INSTDIR\mods\waterfix"
	RmDir /r "$INSTDIR\mods\DC_Bosses"
	RmDir /r "$INSTDIR\mods\DC_Casinopolis"
	RmDir /r "$INSTDIR\mods\DC_ChaoGardens"
	RmDir /r "$INSTDIR\mods\DC_EggCarrier"
	RmDir /r "$INSTDIR\mods\DC_EmeraldCoast"
	RmDir /r "$INSTDIR\mods\DC_FinalEgg"
	RmDir /r "$INSTDIR\mods\DC_General"
	RmDir /r "$INSTDIR\mods\DC_HotShelter"
	RmDir /r "$INSTDIR\mods\DC_IceCap"
	RmDir /r "$INSTDIR\mods\DC_LostWorld"
	RmDir /r "$INSTDIR\mods\DC_MysticRuins"
	RmDir /r "$INSTDIR\mods\DC_Past"
	RmDir /r "$INSTDIR\mods\DC_RedMountain"
	RmDir /r "$INSTDIR\mods\DC_SkyDeck"
	RmDir /r "$INSTDIR\mods\DC_SpeedHighway"
	RmDir /r "$INSTDIR\mods\DC_StationSquare"
	RmDir /r "$INSTDIR\mods\DC_SubGames"
	RmDir /r "$INSTDIR\mods\DC_TwinklePark"
	RmDir /r "$INSTDIR\mods\DC_WindyValley"
	RmDir /r "$INSTDIR\mods\OptionalMods\SADXStyleWater"
	RmDir /r "$INSTDIR\mods\OptionalMods\RevertECDrawDistance"
	DetailPrint $(DE_E_DCCONV)
	nsexec::ExecToStack '"$TEMP\7zr.exe" x "$EXEDIR\instdata\DreamcastConversion.7z" -o"$INSTDIR\mods\DreamcastConversion" -aoa'
	IntOp $INST_DCMODS 0 + 1
	IfFileExists "$EXEDIR\instdata\dcconv.ini" restoreconfig finish

restoreconfig:
	DetailPrint $(DE_R_DCCONV)
	CopyFiles /SILENT "$EXEDIR\instdata\dcconv.ini" "$INSTDIR\mods\DreamcastConversion\config.ini"

finish:
	Delete "$EXEDIR\instdata\dcconv.ini"

; Enable/Disable custom window title
${If} $EnableWindowTitle == "1"
	DetailPrint $(DE_DCTITLE_ON)
	WriteINIStr "$INSTDIR\mods\DreamcastConversion\config.ini" "General" "EnableWindowTitle" "True"
${Else}
	DetailPrint $(DE_DCTITLE_OFF)
	WriteINIStr "$INSTDIR\mods\DreamcastConversion\config.ini" "General" "EnableWindowTitle" "False"
${EndIf}

; Enable/Disable SADX Style Water in Guide Mode
${If} $GuideMode == "1"
	${If} $INST_SADXWTR == "1"
	DetailPrint $(DE_WTR_ON)
	WriteINIStr "$INSTDIR\mods\DreamcastConversion\config.ini" "SADX Style Water" "EmeraldCoast" "True"
	WriteINIStr "$INSTDIR\mods\DreamcastConversion\config.ini" "SADX Style Water" "StationSquare" "True"
	WriteINIStr "$INSTDIR\mods\DreamcastConversion\config.ini" "SADX Style Water" "MysticRuins" "True"
	WriteINIStr "$INSTDIR\mods\DreamcastConversion\config.ini" "SADX Style Water" "EggCarrier" "True"
	WriteINIStr "$INSTDIR\mods\DreamcastConversion\config.ini" "SADX Style Water" "Past" "True"
	${Else}
	DetailPrint $(DE_WTR_OFF)
	WriteINIStr "$INSTDIR\mods\DreamcastConversion\config.ini" "SADX Style Water" "EmeraldCoast" "False"
	WriteINIStr "$INSTDIR\mods\DreamcastConversion\config.ini" "SADX Style Water" "StationSquare" "False"
	WriteINIStr "$INSTDIR\mods\DreamcastConversion\config.ini" "SADX Style Water" "MysticRuins" "False"
	WriteINIStr "$INSTDIR\mods\DreamcastConversion\config.ini" "SADX Style Water" "EggCarrier" "False"
	WriteINIStr "$INSTDIR\mods\DreamcastConversion\config.ini" "SADX Style Water" "Past" "False"
	${EndIf}
${EndIf}
SectionEnd

Section $(SECTIONNAME_SA1CHARS) SECTION_SA1CHARS
SectionIn 1
${If} $PreserveModSettings == "1"
	IfFileExists "$INSTDIR\mods\SA1_Chars\config.ini" backupconfig nobackup
${Else}
	goto nobackup
${EndIf}

backupconfig:
	DetailPrint $(DE_B_SA1CHARS)
	CopyFiles /SILENT "$INSTDIR\mods\SA1_Chars\config.ini" "$EXEDIR\instdata\sa1chars.ini"
	goto nobackup

nobackup:
	StrCpy $Modname $(MOD_SA1CHARS)
	StrCpy $ModFilename "SA1_Chars"
	Call ModInstall
	${If} $ModInstallSuccess == "1"
		IntOp $INST_SA1CHARS 0 + 1
		Call GenerateModVersion
	${EndIf}
	IfFileExists "$EXEDIR\instdata\sa1chars.ini" restoreconfig finish

restoreconfig:
	DetailPrint $(DE_R_SA1CHARS)
	CopyFiles /SILENT "$EXEDIR\instdata\sa1chars.ini" "$INSTDIR\mods\SA1_Chars\config.ini"
	Delete "$EXEDIR\instdata\sa1chars.ini"
	goto finish

finish:
SectionEnd

Section $(SECTIONNAME_LANTERN) SECTION_LANTERN
SectionIn 1
StrCpy $Modname $(MOD_LANTERN)
StrCpy $ModFilename "sadx-dc-lighting"
Call ModInstall
${If} $ModInstallSuccess == "1"
	IfFileExists "$EXEDIR\instdata\d3d8.dll" ok
	DetailPrint $(D_D3D8)
	inetc::get /WEAKSECURITY /RESUME $(ERR_DOWNLOAD_RETRY) /CAPTION $(D_D3D8) /CANCELTEXT $(ERR_DOWNLOAD_CANCEL_A) /QUESTION $(ERR_DOWNLOAD_CANCEL_Q) /TRANSLATE $(INETC_DOWNLOADING) $(INETC_CONNECT) $(INETC_SECOND) $(INETC_MINUTE) $(INETC_HOUR) $(INETC_PLURAL) $(INETC_PROGRESS) $(INETC_REMAINING) "https://dcmods.unreliable.network/owncloud/data/PiKeyAr/files/Setup/data/d3d8.dll" "$EXEDIR\instdata\d3d8.dll" /END
	Pop $DownloadErrorCode
	StrCmp $DownloadErrorCode "OK" ok fail

fail:
	MessageBox MB_OK $(ERR_D_D3D8)
	goto end

ok:
	CopyFiles /SILENT "$EXEDIR\instdata\d3d8.dll" "$INSTDIR\d3d8.dll"
	IntOp $INST_LANTERN 0 + 1
	Call GenerateModVersion
	goto end

end:
${EndIf}
SectionEnd

Section $(SECTIONNAME_DLCS) SECTION_DLCS
SectionIn 1
${If} $PreserveModSettings == "1"
	IfFileExists "$INSTDIR\mods\DLC\config.ini" backupconfig nobackup
${Else}
	goto nobackup
${EndIf}

backupconfig:
	DetailPrint $(DE_B_DLCS)
	CopyFiles /SILENT "$INSTDIR\mods\DLC\config.ini" "$EXEDIR\instdata\dlcs.ini"
	goto nobackup

nobackup:
	IfFileExists "$EXEDIR\instdata\DLCs.7z" extract download

download:
	DetailPrint $(D_DLCS)
	inetc::get /WEAKSECURITY /RESUME $(ERR_DOWNLOAD_RETRY) /CAPTION $(D_DLCS) /CANCELTEXT $(ERR_DOWNLOAD_CANCEL_A) /QUESTION $(ERR_DOWNLOAD_CANCEL_Q) /TRANSLATE $(INETC_DOWNLOADING) $(INETC_CONNECT) $(INETC_SECOND) $(INETC_MINUTE) $(INETC_HOUR) $(INETC_PLURAL) $(INETC_PROGRESS) $(INETC_REMAINING) "https://dcmods.unreliable.network/owncloud/data/PiKeyAr/files/Setup/data/DLCs.7z" "$EXEDIR\instdata\DLCs.7z" /END
	Pop $DownloadErrorCode
	StrCmp $DownloadErrorCode "OK" extract 0
	MessageBox MB_YESNO $(ERR_D_DLCS) IDYES finish IDNO 0
	Quit

extract:
	DetailPrint $(DE_E_DLCS)
	RmDir /r "$INSTDIR\mods\DLCs"
	RmDir /r "$INSTDIR\mods\DLC"
	RmDir /r "$INSTDIR\mods\DLC_ATT1"
	RmDir /r "$INSTDIR\mods\DLC_ATT2"
	RmDir /r "$INSTDIR\mods\DLC_ATT3"
	RmDir /r "$INSTDIR\mods\DLC_ATT"
	RmDir /r "$INSTDIR\mods\DLC_Famitsu"
	RmDir /r "$INSTDIR\mods\DLC_QUO"
	RmDir /r "$INSTDIR\mods\DLC_LaunchParty"
	RmDir /r "$INSTDIR\mods\DLC_Reebok"
	RmDir /r "$INSTDIR\mods\DLC_SambaGP"
	RmDir /r "$INSTDIR\mods\DLC_Y2K"
	RmDir /r "$INSTDIR\mods\DLC_Halloween"
	RmDir /r "$INSTDIR\mods\DLC_Christmas98"
	RmDir /r "$INSTDIR\mods\DLC_Christmas99"
	CreateDirectory "$INSTDIR\mods\DLC"
	nsexec::ExecToStack '"$TEMP\7zr.exe" x "$EXEDIR\instdata\DLCs.7z" -o"$INSTDIR\mods\DLC" -aoa'
	IntOp $INST_DLCS 0 + 1
	IfFileExists "$EXEDIR\instdata\dlcs.ini" restoreconfig finish

restoreconfig:
	DetailPrint $(DE_R_DLCS)
	CopyFiles /SILENT "$EXEDIR\instdata\dlcs.ini" "$INSTDIR\mods\DLC\config.ini"
	Delete "$EXEDIR\instdata\dlcs.ini"
	goto finish

finish:
SectionEnd

SectionGroupEnd

SectionGroup $(SECTIONNAME_ENH) SECTIONGROUP_ENHANCEMENTS

Section $(SECTIONNAME_SMOOTH) SECTION_SMOOTHCAM
SectionIn 1 2
StrCpy $Modname $(MOD_SMOOTHCAM)
StrCpy $ModFilename "smooth-cam"
Call ModInstall
${If} $ModInstallSuccess == "1"
	IntOp $INST_SMOOTHCAM 0 + 1
${EndIf}
SectionEnd

Section $(SECTIONNAME_ONION) SECTION_ONIONBLUR
SectionIn 1 2
StrCpy $Modname $(MOD_ONION)
StrCpy $ModFilename "sadx-onion-blur"
Call ModInstall
${If} $ModInstallSuccess == "1"
	IntOp $INST_ONIONBLUR 0 + 1
	Call GenerateModVersion
${EndIf}
SectionEnd

Section $(SECTIONNAME_IDLE) SECTION_IDLECHATTER
SectionIn 1 2
StrCpy $Modname $(MOD_IDLE)
StrCpy $ModFilename "idle-chatter"
Call ModInstall
${If} $ModInstallSuccess == "1"
	IntOp $INST_IDLECHATTER 0 + 1
${EndIf}
SectionEnd

Section $(SECTIONNAME_PAUSE) SECTION_PAUSEHIDE
SectionIn 2
StrCpy $Modname $(MOD_PAUSE)
StrCpy $ModFilename "pause-hide"
Call ModInstall
${If} $ModInstallSuccess == "1"
	IntOp $INST_PAUSEHIDE 0 + 1
${EndIf}
SectionEnd

Section /o $(SECTIONNAME_STEAM) SECTION_STEAM
IfFileExists "$EXEDIR\instdata\SteamAchievements.7z" extract download

download:
	DetailPrint $(D_STEAM)
	inetc::get /WEAKSECURITY /RESUME $(ERR_DOWNLOAD_RETRY) /CAPTION $(D_STEAM) /CANCELTEXT $(ERR_DOWNLOAD_CANCEL_A) /QUESTION $(ERR_DOWNLOAD_CANCEL_Q) /TRANSLATE $(INETC_DOWNLOADING) $(INETC_CONNECT) $(INETC_SECOND) $(INETC_MINUTE) $(INETC_HOUR) $(INETC_PLURAL) $(INETC_PROGRESS) $(INETC_REMAINING) "https://mm.reimuhakurei.net/sadxmods/SteamAchievements.7z" "$EXEDIR\instdata\SteamAchievements.7z" /END
	Pop $DownloadErrorCode
	StrCmp $DownloadErrorCode "OK" extract 0
	MessageBox MB_YESNO $(ERR_D_STEAM) IDYES finish IDNO 0
	Quit

extract:
	RmDir /r "$INSTDIR\mods\SteamAchievements"
	DetailPrint $(DE_E_STEAM)
	nsexec::ExecToStack '"$TEMP\7zr.exe" x "$EXEDIR\instdata\SteamAchievements.7z" -o"$INSTDIR" -aoa'
	IntOp $INST_STEAM 0 + 1

finish:
SectionEnd

Section $(SECTIONNAME_SUPER) SECTION_SUPERSONIC
SectionIn 1 2
StrCpy $Modname $(MOD_SUPER)
StrCpy $ModFilename "sadx-super-sonic"
Call ModInstall
${If} $ModInstallSuccess == "1"
	IntOp $INST_SUPERSONIC 0 + 1
	Call GenerateModVersion
${EndIf}
SectionEnd

Section $(SECTIONNAME_EEC) SECTION_EEC
SectionIn 2
StrCpy $Modname $(MOD_EEC)
StrCpy $ModFilename "WaterEffect"
Call ModInstall
${If} $ModInstallSuccess == "1"
	IntOp $INST_EEC 0 + 1
	Call GenerateModVersion
${EndIf}
SectionEnd

Section $(SECTIONNAME_TIME) SECTION_TIMEOFDAY
SectionIn 1 2
StrCpy $Modname $(MOD_TIME)
StrCpy $ModFilename "TrainDaytime"
Call ModInstall
${If} $ModInstallSuccess == "1"
	RmDir /r "$INSTDIR\mods\OptionalMods\TrainDaytime"
	RmDir /r "$INSTDIR\mods\DC Conversion\OptionalMods\TrainDaytime"
	IntOp $INST_TIMEOFDAY 0 + 1
	Call GenerateModVersion
${EndIf}
SectionEnd

SectionGroupEnd

Section /o $(SECTIONNAME_ADX) SECTION_ADX
IfFileExists "$INSTDIR\mods\ADXAudio\system\sounddata\voice_us\wma\0000.adx" finishadxaudio 0
IfFileExists "$INSTDIR\mods\ADX Music\system\sounddata\bgm\wma\advamy.adx" 0 getadxaudio
IfFileExists "$INSTDIR\mods\ADX Voices\system\sounddata\voice_us\wma\0000.adx" oldadxaudio getadxaudio

getadxaudio:
	StrCpy $Modname $(MOD_ADX)
	StrCpy $ModFilename "ADXAudio"
	Call ModInstall
	${If} $ModInstallSuccess == "1"
		goto finishadxaudio
	${Else}
	goto endadxaudio
	${EndIf}

finishadxaudio:
	RmDir /r "$INSTDIR\mods\adxmusic"
	RmDir /r "$INSTDIR\mods\ADX Music"
	RmDir /r "$INSTDIR\mods\ADX Voices"
	IntOp $INST_ADX 0 + 1
	goto endadxaudio

oldadxaudio:
	IntOp $INST_ADX 0 + 0
	goto endadxaudio

endadxaudio:
SectionEnd

Section $(SECTIONNAME_SND) SECTION_SNDOVERHAUL
SectionIn 1 2
StrCpy $Modname $(MOD_SND)
StrCpy $ModFilename "SoundOverhaul"
Call ModInstall
${If} $ModInstallSuccess == "1"
	DetailPrint $(DE_E_DSOUND)
	IfFileExists "$EXEDIR\instdata\dsound.dll" ok
	DetailPrint $(D_DSOUND)
	inetc::get /WEAKSECURITY /RESUME $(ERR_DOWNLOAD_RETRY) /CAPTION $(D_DSOUND) /CANCELTEXT $(ERR_DOWNLOAD_CANCEL_A) /QUESTION $(ERR_DOWNLOAD_CANCEL_Q) /TRANSLATE $(INETC_DOWNLOADING) $(INETC_CONNECT) $(INETC_SECOND) $(INETC_MINUTE) $(INETC_HOUR) $(INETC_PLURAL) $(INETC_PROGRESS) $(INETC_REMAINING) "https://dcmods.unreliable.network/owncloud/data/PiKeyAr/files/Setup/data/dsound.dll" "$EXEDIR\instdata\dsound.dll" /END
	Pop $DownloadErrorCode
	StrCmp $DownloadErrorCode "OK" ok fail
	
fail:
	MessageBox MB_OK $(ERR_D_DSOUND)
goto end

ok:
	CopyFiles /SILENT "$EXEDIR\instdata\dsound.dll" "$INSTDIR\dsound.dll"
	DetailPrint $(DE_I_DSOUNDINI)
	FileOpen $2 "$INSTDIR\dsound.ini" w
	FileSeek $2 0 SET
	FileWrite $2 "Buffers=4"
	FileWrite $2 "$\r$\n"
	FileWrite $2 "Duration=25"
	FileWrite $2 "$\r$\n"
	FileWrite $2 "MaxVoiceCount=128"
	FileWrite $2 "$\r$\n"
	FileWrite $2 "DisableDirectMusic=0"
	FileWrite $2 "$\r$\n"
	FileClose $2
	IntOp $INST_SNDOVERHAUL 0 + 1
${Else}
goto end
${EndIf}

end:
SectionEnd

Section $(SECTIONNAME_HDGUI) SECTION_HDGUI
SectionIn 1 2
StrCpy $Modname $(MOD_HDGUI)
StrCpy $ModFilename "HD_DCStyle"
Call ModInstall
${If} $ModInstallSuccess == "1"
	IntOp $INST_HDGUI 0 + 1
${EndIf}
RmDir /r "$INSTDIR\mods\xinput-prompts"
SectionEnd

Section -ModOrder
SectionIn 1 2 3
DetailPrint $(DE_MODORDER)
FileOpen $2 "$TEMP\SADXModLoader.ini" a
FileSeek $2 0 END

StrCmp $INST_SADXFE "0" +4 0
IntOp $ModIndex $ModIndex + 1
FileWrite $2 "$\r$\n"
FileWrite $2 "Mod$ModIndex=SADXFE"

IfFileExists "$INSTDIR\mods\ADXAudio\system\sounddata\bgm\wma\ADVAMY.ADX" 0 +5
IntOp $ModIndex $ModIndex + 1
FileWrite $2 "$\r$\n"
FileWrite $2 "Mod$ModIndex=ADXAudio"
Goto +9
IfFileExists "$INSTDIR\mods\ADX Music\system\sounddata\bgm\wma\ADVAMY.ADX" 0 +4
IntOp $ModIndex $ModIndex + 1
FileWrite $2 "$\r$\n"
FileWrite $2 "Mod$ModIndex=ADX Music"
IfFileExists "$INSTDIR\mods\ADX Voices\system\sounddata\voice_us\wma\0000.ADX" 0 +4
IntOp $ModIndex $ModIndex + 1
FileWrite $2 "$\r$\n"
FileWrite $2 "Mod$ModIndex=ADX Voices"

StrCmp $INST_INPUTMOD "0" +4 0
IntOp $ModIndex $ModIndex + 1
FileWrite $2 "$\r$\n"
FileWrite $2 "Mod$ModIndex=sadx-input-mod"

StrCmp $INST_SMOOTHCAM "0" +4 0
IntOp $ModIndex $ModIndex + 1
FileWrite $2 "$\r$\n"
FileWrite $2 "Mod$ModIndex=smooth-cam"

StrCmp $INST_CCEF "0" +4 0
IntOp $ModIndex $ModIndex + 1
FileWrite $2 "$\r$\n"
FileWrite $2 "Mod$ModIndex=CCEF"

StrCmp $INST_PAUSEHIDE "0" +4 0
IntOp $ModIndex $ModIndex + 1
FileWrite $2 "$\r$\n"
FileWrite $2 "Mod$ModIndex=pause-hide"

StrCmp $INST_FRAMELIMIT "0" +4 0
IntOp $ModIndex $ModIndex + 1
FileWrite $2 "$\r$\n"
FileWrite $2 "Mod$ModIndex=sadx-frame-limit"

StrCmp $INST_ONIONBLUR "0" +4 0
IntOp $ModIndex $ModIndex + 1
FileWrite $2 "$\r$\n"
FileWrite $2 "Mod$ModIndex=sadx-onion-blur"

StrCmp $INST_IDLECHATTER "0" +4 0
IntOp $ModIndex $ModIndex + 1
FileWrite $2 "$\r$\n"
FileWrite $2 "Mod$ModIndex=idle-chatter"

StrCmp $INST_STEAM "0" +4 0
IntOp $ModIndex $ModIndex + 1
FileWrite $2 "$\r$\n"
FileWrite $2 "Mod$ModIndex=SteamAchievements"

StrCmp $INST_SUPERSONIC "0" +4 0
IntOp $ModIndex $ModIndex + 1
FileWrite $2 "$\r$\n"
FileWrite $2 "Mod$ModIndex=sadx-super-sonic"

StrCmp $INST_LANTERN "0" +4 0
IntOp $ModIndex $ModIndex + 1
FileWrite $2 "$\r$\n"
FileWrite $2 "Mod$ModIndex=sadx-dc-lighting"

StrCmp $INST_DCMODS "0" +4 0
IntOp $ModIndex $ModIndex + 1
FileWrite $2 "$\r$\n"
FileWrite $2 "Mod$ModIndex=DreamcastConversion"

StrCmp $INST_DLCs "0" +4 0
IntOp $ModIndex $ModIndex + 1
FileWrite $2 "$\r$\n"
FileWrite $2 "Mod$ModIndex=DLC"

${If} $INST_DCMODS == "0"
StrCmp $INST_EEC "0" +4 0
IntOp $ModIndex $ModIndex + 1
FileWrite $2 "$\r$\n"
FileWrite $2 "Mod$ModIndex=WaterEffect"
${EndIf}

StrCmp $INST_SNDOVERHAUL "0" +4 0
IntOp $ModIndex $ModIndex + 1
FileWrite $2 "$\r$\n"
FileWrite $2 "Mod$ModIndex=SoundOverhaul"

StrCmp $INST_TIMEOFDAY "0" +4 0
IntOp $ModIndex $ModIndex + 1
FileWrite $2 "$\r$\n"
FileWrite $2 "Mod$ModIndex=TrainDaytime"

StrCmp $INST_SA1CHARS "0" +4 0
IntOp $ModIndex $ModIndex + 1
FileWrite $2 "$\r$\n"
FileWrite $2 "Mod$ModIndex=SA1_Chars"

StrCmp $INST_HDGUI "0" +4 0
IntOp $ModIndex $ModIndex + 1
FileWrite $2 "$\r$\n"
FileWrite $2 "Mod$ModIndex=HD_DCStyle"

FileWrite $2 "$\r$\n"
FileWrite $2 "Code1=Use Tornado 2 Health Bar in Sky Chase Act 2"
FileWrite $2 "$\r$\n"
FileWrite $2 "Code2=Egg Carrier Ocean Music"
FileClose $2
IfFileExists "$INSTDIR\mods\SADXModLoader.ini" 0 +4
Delete "$INSTDIR\mods\SADXModLoader.bak"
DetailPrint $(DE_B_MLINI)
Rename "$INSTDIR\mods\SADXModLoader.ini" "$INSTDIR\mods\SADXModLoader.bak"
DetailPrint $(DE_I_MLINI)
CopyFiles /SILENT "$TEMP\SADXModLoader.ini" "$INSTDIR\mods\SADXModLoader.ini"
IfFileExists "$INSTDIR\sonicDX.ini" 0 +4
Delete "$INSTDIR\sonicDX.bak"
DetailPrint $(DE_B_SADXINI)
Rename "$INSTDIR\sonicDX.ini" "$INSTDIR\sonicDX.bak"
DetailPrint $(DE_I_SADXINI)
CopyFiles /SILENT "$TEMP\sonicDX.ini" "$INSTDIR\sonicDX.ini"
Delete "$TEMP\SADXModLoader.ini"
Delete "$TEMP\sonicDX.ini"
SectionEnd

Section -SECTION_CUSTOMICON
md5dll::GetMD5File "$INSTDIR\sonic.exe"
Pop $sonicexemd5

${If} $EnableCustomIcon == "0"
	StrCpy $CustomIconNumber "0"
	StrCmp $sonicexemd5 "4d9b59aea4ee361e4f25475df1447bfd" finish 0 ;Original (with manifest)
${EndIf}

${If} $CustomIconNumber == "0"
	StrCmp $sonicexemd5 "4d9b59aea4ee361e4f25475df1447bfd" finish 0 ;Original (with manifest)
${EndIf}
${If} $CustomIconNumber == "1"
	StrCmp $sonicexemd5 "e46580fc390285174acae895a90c5c84" finish 0 ;SA1 save (with manifest)
${EndIf}
${If} $CustomIconNumber == "2"
	StrCmp $sonicexemd5 "b215d5dfc16514c0cc354449c101c7d0" finish 0 ;SA1 box (with manifest)
${EndIf}
${If} $CustomIconNumber == "3"
	StrCmp $sonicexemd5 "a35eb183684e3eb964351de391db82e8" finish 0 ;SADX save (with manifest)
${EndIf}
${If} $CustomIconNumber == "4"
	StrCmp $sonicexemd5 "f8c0b356519d7c459f7b726d63462791" finish 0 ;SADX HD (with manifest)
${EndIf}

StrCmp $sonicexemd5 "4d9b59aea4ee361e4f25475df1447bfd" resources 0 ;Original (with manifest)
StrCmp $sonicexemd5 "e46580fc390285174acae895a90c5c84" resources 0 ;SA1 save (with manifest)
StrCmp $sonicexemd5 "b215d5dfc16514c0cc354449c101c7d0" resources 0 ;SA1 box (with manifest)
StrCmp $sonicexemd5 "a35eb183684e3eb964351de391db82e8" resources 0 ;SADX save (with manifest)
StrCmp $sonicexemd5 "f8c0b356519d7c459f7b726d63462791" resources 0 ;SADX HD (with manifest)
StrCmp $sonicexemd5 "c6d65712475602252bfce53d0d8b7d6f" resources 0 ;Original (without manifest)

IfFileExists "$EXEDIR\instdata\sonic-U-crack.7z" extractsonicexe2 downloadsonicexe2

downloadsonicexe2:
	DetailPrint $(D_2004EXE)
	inetc::get /WEAKSECURITY /RESUME $(ERR_DOWNLOAD_RETRY) /CAPTION $(D_RESOURCES) /CANCELTEXT $(ERR_DOWNLOAD_CANCEL_A) /QUESTION $(ERR_DOWNLOAD_CANCEL_Q) /TRANSLATE $(INETC_DOWNLOADING) $(INETC_CONNECT) $(INETC_SECOND) $(INETC_MINUTE) $(INETC_HOUR) $(INETC_PLURAL) $(INETC_PROGRESS) $(INETC_REMAINING) "http://mm.reimuhakurei.net/misc/sonic-U-crack.7z" "$EXEDIR\instdata\sonic-U-crack.7z" /END
	Pop $DownloadErrorCode
	StrCmp $DownloadErrorCode "OK" extractsonicexe2 skipmani

extractsonicexe2:
	DetailPrint $(DE_E_EXE)
	nsexec::ExecToStack '"$TEMP\7zr.exe" x "$EXEDIR\instdata\sonic-U-crack.7z" -o"$INSTDIR" -aoa'
	Delete "$INSTDIR\sonic.exe"
	Rename "$INSTDIR\sonic-U-crack.exe" "$INSTDIR\sonic.exe"
	Delete "$INSTDIR\sonic_original.exe"
	DetailPrint $(DE_C_EXE)
	md5dll::GetMD5File "$INSTDIR\sonic.exe"
	Pop $sonicexemd5
	StrCmp $sonicexemd5 "c6d65712475602252bfce53d0d8b7d6f" resources 0
	MessageBox MB_OK $(ERR_EXEMD5)
	goto finish

resources:
	IfFileExists "$EXEDIR\instdata\icondata.7z" extract_icon download_icon
	
download_icon:
	DetailPrint $(D_RESOURCES)
	inetc::get /WEAKSECURITY /RESUME $(ERR_DOWNLOAD_RETRY) /CAPTION $(D_RESOURCES) /CANCELTEXT $(ERR_DOWNLOAD_CANCEL_A) /QUESTION $(ERR_DOWNLOAD_CANCEL_Q) /TRANSLATE $(INETC_DOWNLOADING) $(INETC_CONNECT) $(INETC_SECOND) $(INETC_MINUTE) $(INETC_HOUR) $(INETC_PLURAL) $(INETC_PROGRESS) $(INETC_REMAINING) "https://dcmods.unreliable.network/owncloud/data/PiKeyAr/files/Setup/data/icondata.7z" "$EXEDIR\instdata\icondata.7z" /END
	Pop $DownloadErrorCode
	StrCmp $DownloadErrorCode "OK" extract_icon 0
	MessageBox MB_OK $(ERR_D_RESOURCES)
	goto finish

extract_icon:
	Delete "$INSTDIR\sonic.exe.manifest"
	Delete "$INSTDIR\addmanifest.bat"
	Delete "$INSTDIR\replaceicon*.bat"
	Delete "$INSTDIR\rcedit.exe"
	Delete "$INSTDIR\*.ico"
	DetailPrint $(DE_E_RESOURCES)
	nsexec::ExecToStack '"$TEMP\7zr.exe" x "$EXEDIR\instdata\icondata.7z" -o"$INSTDIR" -aoa'
	DetailPrint $(DE_I_RESOURCES)
	SetOutPath "$INSTDIR"
	CopyFiles "$INSTDIR\sonic.exe" "$INSTDIR\sonic_original.exe"
	
	${If} $CustomIconNumber == "0"
		nsexec::ExecToLog '"rcedit sonic.exe --application-manifest sonic.exe.manifest"'
	${EndIf}
	
	${If} $CustomIconNumber == "1"
		nsexec::ExecToLog 'rcedit sonic.exe --set-icon sa1.ico --application-manifest sonic.exe.manifest"'
	${EndIf}
	
	${If} $CustomIconNumber == "2"
		nsexec::ExecToLog 'rcedit sonic.exe --set-icon sa1alt.ico --application-manifest sonic.exe.manifest"'
	${EndIf}
	
	${If} $CustomIconNumber == "3"
		nsexec::ExecToLog '"rcedit sonic.exe --set-icon sadxicon.ico --application-manifest sonic.exe.manifest"'
	${EndIf}
	
	${If} $CustomIconNumber == "4"
		nsexec::ExecToLog 'rcedit sonic.exe --set-icon sadxhd.ico --application-manifest sonic.exe.manifest"'
	${EndIf}
	
	goto finish

skipmani:
	MessageBox MB_OK $(ERR_DOWNLOAD_FATAL)
	goto finish

finish:
SectionEnd

Section -Cleanup
SectionIn 1 2 3
Delete "$INSTDIR\replaceicon*.bat"
Delete "$INSTDIR\sonic.exe.manifest"
Delete "$INSTDIR\addmanifest.bat"
Delete "$INSTDIR\rcedit.exe"
Delete "$INSTDIR\SteamHelper.*"
Delete "$INSTDIR\VGAudio.*"
Delete "$INSTDIR\sfk.exe"
Delete "$INSTDIR\ffmpeg.exe"
Delete "$INSTDIR\lame.exe"
Delete "$INSTDIR\sfd2mpg.exe"
Delete "$INSTDIR\*.ico"
Delete "$INSTDIR\*.7z"
Delete "$INSTDIR\mods\DC Conversion\*.7z"
Delete "$INSTDIR\mods\*.7z"
Delete "$INSTDIR\redist\*.*"
Delete "$INSTDIR\mods\Issues and differences from DC.txt"
Delete "$INSTDIR\mods\Changelog.txt"
Delete "$INSTDIR\mods\Credits.txt"
Delete "$INSTDIR\config.exe"
Delete "$INSTDIR\config2.exe"
Delete "$INSTDIR\BetterSADX Readme.lnk"
RMDir /r "$INSTDIR\redist"
RMDir /r "$INSTDIR\Data"
;Remove old or redundant mods
Delete "$INSTDIR\mods\mod.ini"
RmDir /r "$INSTDIR\mods\Improved Voice Clips"
RmDir /r "$INSTDIR\mods\BetterSADX"
RmDir /r "$INSTDIR\mods\BetterSADX Core"
RmDir /r "$INSTDIR\mods\BetterSADX_Version"
RmDir /r "$INSTDIR\mods\MetalSonic_Sounds"
RmDir /r "$INSTDIR\mods\Cowgirl"
RmDir /r "$INSTDIR\mods\SADX99Edition"
RmDir /r "$INSTDIR\mods\HDDC_Unscale"
RmDir /r "$INSTDIR\mods\DC_EnvMaps"
RmDir /r "$INSTDIR\mods\KillCream"
RmDir /r "$INSTDIR\mods\DisableSA1TitleScreen"
RmDir /r "$INSTDIR\mods\OptionalMods\DisableSA1TitleScreen"
RmDir /r "$INSTDIR\mods\OptionalMods\KillCream"
RmDir /r "$INSTDIR\mods\OptionalMods\Cowgirl"
RmDir /r "$INSTDIR\mods\OptionalMods\TitlescreenRipples"
RmDir /r "$INSTDIR\mods\DC Conversion\DC_EnvMaps"
RmDir /r "$INSTDIR\mods\DC Conversion\OptionalMods\Cowgirl"
RmDir /r "$INSTDIR\mods\DC Conversion\OptionalMods\TitlescreenRipples"
RmDir /r "$INSTDIR\mods\DC Conversion\OptionalMods\DisableSA1TitleScreen"
Delete "$TEMP\dxwebsetup.exe"
Delete "$INSTDIR\redist\*.*"
RMDir /r "$INSTDIR\redist"
Delete "$TEMP\7zr.exe"
IfFileExists "$INSTDIR\mods\ADXAudio\system\sounddata\voice_us\wma\0000.adx" 0 +4
RMDir /r "$INSTDIR\mods\ADX Music"
RMDir /r "$INSTDIR\mods\ADX Voices"
RMDir /r "$INSTDIR\mods\adxmusic"
SectionEnd


Function Guide1
${If} $GuideMode == "1"
	StrCpy $ModScreenNumber "0"
	Call fnc_ScreenCompare_Show
${EndIf}
FunctionEnd

Function Guide2
${If} ${SectionIsSelected} ${SECTION_LANTERN}
	${If} $GuideMode == "1"
		StrCpy $ModScreenNumber "1"
		Call fnc_ScreenCompare_Show
	${EndIf}
${EndIf}
FunctionEnd

Function Guide3
${If} ${SectionIsSelected} ${SECTION_DCMODS}
	${If} $GuideMode == "1"
		StrCpy $ModScreenNumber "2"
		Call fnc_ScreenCompare_Show
	${EndIf}
${EndIf}
FunctionEnd

Function Guide4
${If} $GuideMode == "1"
	StrCpy $ModScreenNumber "3"
	Call fnc_ScreenCompare_Show
${EndIf}
FunctionEnd

Function Guide5
${If} $GuideMode == "1"
	StrCpy $ModScreenNumber "4"
	Call fnc_ScreenCompare_Show
${EndIf}
FunctionEnd

Function Guide6
${If} $GuideMode == "1"
	StrCpy $ModScreenNumber "5"
	Call fnc_ScreenCompare_Show
${EndIf}
FunctionEnd

Function ReloadModImage
${If} $GuideMode == "1"
	; Set image ID
	${NSD_GetState} $hCtl_ScreenCompare_CheckBox1 $Whatev
	${If} $Whatev == ${BST_CHECKED}
		IntOp $ModScreenOff 0 + 0
	${Else}
		IntOp $ModScreenOff 0 + 1
	${EndIf}
	; Lantern Engine
	${If} $ModScreenNumber == "0"
		${NSD_SetText} $hCtl_ScreenCompare_ModDescription $(GUIDE_INFO_LANTERN)
		${NSD_SetText} $hCtl_ScreenCompare_CheckBox1 $(GUIDE_INST_LANTERN)
		; Check install
		${NSD_GetState} $hCtl_ScreenCompare_CheckBox1 $Whatev
		${If} $Whatev == ${BST_CHECKED}
			!insertmacro SelectSection ${SECTION_LANTERN}
			!insertmacro SelectSection ${SECTION_DCMODS}
		${Else}
			!insertmacro UnselectSection ${SECTION_LANTERN}
			!insertmacro UnselectSection ${SECTION_DCMODS}
		${EndIf}
	; End
	${EndIf}

; Dreamcast Conversion
${If} $ModScreenNumber == "1"
	${NSD_SetText} $hCtl_ScreenCompare_ModDescription $(GUIDE_INFO_DCCONV)
	${NSD_SetText} $hCtl_ScreenCompare_CheckBox1 $(GUIDE_INST_DCCONV)
	; Check install
	${NSD_GetState} $hCtl_ScreenCompare_CheckBox1 $Whatev
	${If} $Whatev == ${BST_CHECKED}
		!insertmacro SelectSection ${SECTION_DCMODS}
		!insertmacro UnselectSection ${SECTION_EEC}
	${Else}
		!insertmacro UnselectSection ${SECTION_DCMODS}
		!insertmacro SelectSection ${SECTION_EEC}
	${EndIf}
	; End
${EndIf}

; SADX Style Water
${If} $ModScreenNumber == "2"
	${NSD_SetText} $hCtl_ScreenCompare_ModDescription $(GUIDE_INFO_DXWTR)
	${NSD_SetText} $hCtl_ScreenCompare_CheckBox1 $(GUIDE_INST_DXWTR)
	; Check install
	${NSD_GetState} $hCtl_ScreenCompare_CheckBox1 $Whatev
	${If} $Whatev == ${BST_CHECKED}
		IntOp $INST_SADXWTR 0 + 1
	${Else}
		IntOp $INST_SADXWTR 0 + 0
	${EndIf}
	; End
${EndIf}

; Dreamcast Characters
${If} $ModScreenNumber == "3"
	${NSD_SetText} $hCtl_ScreenCompare_ModDescription $(GUIDE_INFO_SA1CHARS)
	${NSD_SetText} $hCtl_ScreenCompare_CheckBox1 $(GUIDE_INST_SA1CHARS)
	; Check install
	${NSD_GetState} $hCtl_ScreenCompare_CheckBox1 $Whatev
	${If} $Whatev == ${BST_CHECKED}
		!insertmacro SelectSection ${SECTION_SA1CHARS}
	${Else}
		!insertmacro UnselectSection ${SECTION_SA1CHARS}
	${EndIf}
; End
${EndIf}

; Onion Blur
${If} $ModScreenNumber == "4"
	${NSD_SetText} $hCtl_ScreenCompare_ModDescription $(GUIDE_INFO_ONION)
	${NSD_SetText} $hCtl_ScreenCompare_CheckBox1 $(GUIDE_INST_ONION)
	; Check install
	${NSD_GetState} $hCtl_ScreenCompare_CheckBox1 $Whatev
	${If} $Whatev == ${BST_CHECKED}
		!insertmacro SelectSection ${SECTION_ONIONBLUR}
	${Else}
		!insertmacro UnselectSection ${SECTION_ONIONBLUR}
	${EndIf}
	; End
${EndIf}

; HD GUI 2
${If} $ModScreenNumber == "5"
	${NSD_SetText} $hCtl_ScreenCompare_ModDescription $(GUIDE_INFO_HDGUI)
	${NSD_SetText} $hCtl_ScreenCompare_CheckBox1 $(GUIDE_INST_HDGUI)
	; Check install
	${NSD_GetState} $hCtl_ScreenCompare_CheckBox1 $Whatev
	${If} $Whatev == ${BST_CHECKED}
		!insertmacro SelectSection ${SECTION_HDGUI}
	${Else}
		!insertmacro UnselectSection ${SECTION_HDGUI}
	${EndIf}
	; End
${EndIf}

; Set up screen
${NSD_SetStretchedImageOLE} $hCtl_ScreenCompare_Bitmap1 "$PLUGINSDIR\$ModScreenNumber_$ModScreenOff.jpg" $hCtl_ScreenCompare_Bitmap1_hImage
${NSD_FreeImage} $hCtl_ScreenCompare_Bitmap1
${EndIf}
FunctionEnd

Function ShowAdvancedOptions
${NSD_GetState} $hCtl_TypeSel_CheckBox_ShowAdvanced $Whatev
${If} $Whatev == ${BST_CHECKED}
	ShowWindow $hCtl_TypeSel_CheckBox_InstallIcon ${SW_SHOW}
	ShowWindow $hCtl_TypeSel_CheckBox_Preserve ${SW_SHOW}
	ShowWindow $hCtl_TypeSel_CheckBox_WindowTitle ${SW_SHOW}
	ShowWindow $hCtl_TypeSel_RadioButton_SettingsOptimal ${SW_SHOW}
	ShowWindow $hCtl_TypeSel_RadioButton_SettingsFailsafe ${SW_SHOW}
	ShowWindow $hCtl_TypeSel_RadioButton_SettingsManual ${SW_SHOW}
${Else}
	ShowWindow $hCtl_TypeSel_CheckBox_InstallIcon ${SW_HIDE}
	ShowWindow $hCtl_TypeSel_CheckBox_Preserve ${SW_HIDE}
	ShowWindow $hCtl_TypeSel_CheckBox_WindowTitle ${SW_HIDE}
	ShowWindow $hCtl_TypeSel_RadioButton_SettingsOptimal ${SW_HIDE}
	ShowWindow $hCtl_TypeSel_RadioButton_SettingsFailsafe ${SW_HIDE}
	ShowWindow $hCtl_TypeSel_RadioButton_SettingsManual ${SW_HIDE}
${EndIf}
FunctionEnd