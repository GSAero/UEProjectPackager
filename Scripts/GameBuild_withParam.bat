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

echo Build %platform% %config% ForDistribution=%argDistribution% ATF=%ATF%
echo Build %platform% %config% ForDistribution=%argDistribution% ATF=%ATF% >%logfile%
echo     Start %DATE% %TIME%
echo     Start %DATE% %TIME%>>%logfile%
rem echo ******************************>>%logfile%
rem @echo.>>%logfile%

if %ATF%==ATC goto AndroidATF
if %ATF%==DXT goto AndroidATF
if %ATF%==ETC1 goto AndroidATF
if %ATF%==ETC1a goto AndroidATF
if %ATF%==ETC2 goto AndroidATF
if %ATF%==PVRTC goto AndroidATF
if %ATF%==ASTC goto AndroidATF
goto Default

:Default
rem call %UATfile% BuildCookRun -nocompile -nocompileeditor -installed -nop4 -project=%projectfile% -cook -stage -archive -archivedirectory=%packagedir% -package -clientconfig=%config% -ue4exe=UE4Editor-Cmd.exe -clean -compressed -SkipCookingEditorContent -pak -prereqs%argDistribution% -nodebuginfo -targetplatform=%platform% -build -utf8output>>%logfile%
call %UATfile% BuildCookRun -nocompile -nocompileeditor -installed -nop4 -project=%projectfile% -cook -stage -archive -archivedirectory=%packagedir% -package -clientconfig=%config% -ue4exe=UE4Editor-Cmd.exe -clean -compressed -SkipCookingEditorContent -pak -prereqs%argDistribution% -nodebuginfo -targetplatform=%platform% -build -utf8output
if not errorlevel 0 goto Exit_Failure
goto Complete

:AndroidATF
rem call %UATfile% BuildCookRun -nocompile -nocompileeditor -installed -nop4 -project=%projectfile% -cook -stage -archive -archivedirectory=%packagedir% -package -clientconfig=%config% -ue4exe=UE4Editor-Cmd.exe -clean -compressed -SkipCookingEditorContent -pak -prereqs%argDistribution% -nodebuginfo -targetplatform=%platform% -cookflavor=%ATF% -build -utf8output>>%logfile%
call %UATfile% BuildCookRun -nocompile -nocompileeditor -installed -nop4 -project=%projectfile% -cook -stage -archive -archivedirectory=%packagedir% -package -clientconfig=%config% -ue4exe=UE4Editor-Cmd.exe -clean -compressed -SkipCookingEditorContent -pak -prereqs%argDistribution% -nodebuginfo -targetplatform=%platform% -cookflavor=%ATF% -build -utf8output
if not errorlevel 0 goto Exit_Failure
goto Complete

:Complete
rem @echo.>>%logfile%
rem echo ******************************>>%logfile%
echo     End %DATE% %TIME%
echo     End %DATE% %TIME%>>%logfile%

goto Exit

:Exit_Failure
echo     %platform% %config% ForDistribution=%argDistribution% ATF=%ATF% BUILD FAILED
echo     %platform% %config% ForDistribution=%argDistribution% ATF=%ATF% BUILD FAILED>>%logfile%
echo     %platform% %config% ForDistribution=%argDistribution% ATF=%ATF% BUILD FAILED>>%ResultLogFile%
echo     see log in "[AppData]/Unreal Engine/AutomationTool/Logs/">>%logfile%
rem type GameBuild_Full.log
rem pause
exit /B 1

:Exit
echo     %platform% %config% ForDistribution=%argDistribution% ATF=%ATF% BUILD SUCCESSFUL
echo     %platform% %config% ForDistribution=%argDistribution% ATF=%ATF% BUILD SUCCESSFUL>>%logfile%
echo     %platform% %config% ForDistribution=%argDistribution% ATF=%ATF% BUILD SUCCESSFUL>>%ResultLogFile%
echo     see log in "[AppData]/Unreal Engine/AutomationTool/Logs/">>%logfile%
rem type GameBuild_Full.log
rem pause
exit /B 0
