@echo off
rem echo on

setlocal

set platform=%1
set config=%2
set bUseDistribution=%3
set packagedir=%4
set logfile=%5
set bUseBuild=%6
set ATF=%7
set ResultLogFile=%8

rem Absolute path to the file of UE project
set projectfile="[PathWithProject]/YourProject.uproject"

if %bUseBuild%==0 exit /B 0

rem ## set UATfile

rem Absolute path to the UAT file of UE for Windows
set UATfile="C:/Program Files/Epic Games/UE_4.24/Engine/Build/BatchFiles/RunUAT.bat"
if %platform%==IOS goto SetUATfileForMac
if %platform%==Mac goto SetUATfileForMac
if %platform%==Linux goto SetUATfileForLinux

goto CuntinueAfterSetUATfile

:SetUATfileForMac
rem Absolute path to the UAT file of UE for iOS/Mac
rem (we run it from Windows, so we won 't change anything) set UATfile="C:/Program Files/Epic Games/UE_4.24/Engine/Build/BatchFiles/RunUAT.command"
goto CuntinueAfterSetUATfile

:SetUATfileForLinux
rem Absolute path to the UAT file of UE for Linux
set UATfile="C:/Program Files/Epic Games/UE_4.24/Engine/Build/BatchFiles/RunUAT.sh"
goto CuntinueAfterSetUATfile

:CuntinueAfterSetUATfile

rem ## set flag of Distribution

set argDistribution=
if %bUseDistribution%==1 set argDistribution= -distribution

rem ## set Android Texture Format

rem set TypeAndroidTextureFormat=ETC1
rem set ATF=
rem if %platform%==Android set ATF= -cookflavor=%TypeAndroidTextureFormat%

rem ## package

echo Build %platform% %config% %ATF% %argDistribution%
echo Build %platform% %config% %ATF% %argDistribution%>%logfile%
echo     Start %DATE% %TIME%
echo     Start %DATE% %TIME%>>%logfile%
echo ******************************>>%logfile%
@echo.>>%logfile%

if %ATF%==ATC goto AndroidATC
if %ATF%==DXT goto AndroidDXT
if %ATF%==ETC1 goto AndroidETC1
if %ATF%==ETC1a goto AndroidETC1a
if %ATF%==ETC2 goto AndroidETC2
if %ATF%==PVRTC goto AndroidPVRTC
if %ATF%==ASTC goto AndroidASTC
goto AndroidDefault

:AndroidDefault
call %UATfile% BuildCookRun -nocompile -nocompileeditor -installed -nop4 -project=%projectfile% -cook -stage -archive -archivedirectory=%packagedir% -package -clientconfig=%config% -ue4exe=UE4Editor-Cmd.exe -clean -compressed -SkipCookingEditorContent -pak -prereqs%argDistribution% -nodebuginfo -targetplatform=%platform% -build -utf8output>>%logfile%
if not errorlevel 0 goto Exit_Failure
goto Complete

:AndroidATC
call %UATfile% BuildCookRun -nocompile -nocompileeditor -installed -nop4 -project=%projectfile% -cook -stage -archive -archivedirectory=%packagedir% -package -clientconfig=%config% -ue4exe=UE4Editor-Cmd.exe -clean -compressed -SkipCookingEditorContent -pak -prereqs%argDistribution% -nodebuginfo -targetplatform=%platform% -cookflavor=ATC -build -utf8output>>%logfile%
if not errorlevel 0 goto Exit_Failure
goto Complete

:AndroidDXT
call %UATfile% BuildCookRun -nocompile -nocompileeditor -installed -nop4 -project=%projectfile% -cook -stage -archive -archivedirectory=%packagedir% -package -clientconfig=%config% -ue4exe=UE4Editor-Cmd.exe -clean -compressed -SkipCookingEditorContent -pak -prereqs%argDistribution% -nodebuginfo -targetplatform=%platform% -cookflavor=DXT -build -utf8output>>%logfile%
if not errorlevel 0 goto Exit_Failure
goto Complete

:AndroidETC1
call %UATfile% BuildCookRun -nocompile -nocompileeditor -installed -nop4 -project=%projectfile% -cook -stage -archive -archivedirectory=%packagedir% -package -clientconfig=%config% -ue4exe=UE4Editor-Cmd.exe -clean -compressed -SkipCookingEditorContent -pak -prereqs%argDistribution% -nodebuginfo -targetplatform=%platform% -cookflavor=ETC1 -build -utf8output>>%logfile%
if not errorlevel 0 goto Exit_Failure
goto Complete

:AndroidETC1a
call %UATfile% BuildCookRun -nocompile -nocompileeditor -installed -nop4 -project=%projectfile% -cook -stage -archive -archivedirectory=%packagedir% -package -clientconfig=%config% -ue4exe=UE4Editor-Cmd.exe -clean -compressed -SkipCookingEditorContent -pak -prereqs%argDistribution% -nodebuginfo -targetplatform=%platform% -cookflavor=ETC1a -build -utf8output>>%logfile%
if not errorlevel 0 goto Exit_Failure
goto Complete

:AndroidETC2
call %UATfile% BuildCookRun -nocompile -nocompileeditor -installed -nop4 -project=%projectfile% -cook -stage -archive -archivedirectory=%packagedir% -package -clientconfig=%config% -ue4exe=UE4Editor-Cmd.exe -clean -compressed -SkipCookingEditorContent -pak -prereqs%argDistribution% -nodebuginfo -targetplatform=%platform% -cookflavor=ETC2 -build -utf8output>>%logfile%
if not errorlevel 0 goto Exit_Failure
goto Complete

:AndroidPVRTC
call %UATfile% BuildCookRun -nocompile -nocompileeditor -installed -nop4 -project=%projectfile% -cook -stage -archive -archivedirectory=%packagedir% -package -clientconfig=%config% -ue4exe=UE4Editor-Cmd.exe -clean -compressed -SkipCookingEditorContent -pak -prereqs%argDistribution% -nodebuginfo -targetplatform=%platform% -cookflavor=PVRTC -build -utf8output>>%logfile%
if not errorlevel 0 goto Exit_Failure
goto Complete

:AndroidASTC
call %UATfile% BuildCookRun -nocompile -nocompileeditor -installed -nop4 -project=%projectfile% -cook -stage -archive -archivedirectory=%packagedir% -package -clientconfig=%config% -ue4exe=UE4Editor-Cmd.exe -clean -compressed -SkipCookingEditorContent -pak -prereqs%argDistribution% -nodebuginfo -targetplatform=%platform% -cookflavor=ASTC -build -utf8output>>%logfile%
if not errorlevel 0 goto Exit_Failure
goto Complete

:Complete
@echo.>>%logfile%
echo ******************************>>%logfile%
echo     End %DATE% %TIME%
echo     End %DATE% %TIME%>>%logfile%

goto Exit

:Exit_Failure
echo     %platform% %config% %ATF% %argDistribution% BUILD FAILED
echo     %platform% %config% %ATF% %argDistribution% BUILD FAILED>>%logfile%
echo     %platform% %config% %ATF% %argDistribution% BUILD FAILED>>%ResultLogFile%
rem type GameBuild_Full.log
rem pause
exit /B 1

:Exit
echo     %platform% %config% %ATF% %argDistribution% BUILD SUCCESSFUL
echo     %platform% %config% %ATF% %argDistribution% BUILD SUCCESSFUL>>%logfile%
echo     %platform% %config% %ATF% %argDistribution% BUILD SUCCESSFUL>>%ResultLogFile%
rem type GameBuild_Full.log
rem pause
exit /B 0
