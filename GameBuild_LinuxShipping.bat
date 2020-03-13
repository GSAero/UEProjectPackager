@echo off
rem echo on

setlocal

rem ## see "Scripts/Info for Command LIne for Package Project.txt"
rem ## change only:
rem ##     - bUseBuild {0, 1}
rem ##     - platform {Android, IOS, Win64, Win32, Mac, Linux, ...}
rem ##     - config {Development, Shipping, Debug, DebugGame, Test}
rem ##     - bUseDistribution {0, 1}

rem Absolute path to the folder with packed games
set pakdir=C:/Games/
rem Relative path to the folder with log files
set logdir=Logs/

set ResultLogFile="%logdir%Result.log"

echo Package of game
echo Package of game>%ResultLogFile%

rem ## Build settings:

set bUseBuild=1
set platform=Linux
set config=Shipping
set bUseDistribution=1
set ATF=0
set packagedir="%pakdir%%platform%_%config%/"
set logfile="%logdir%GameBuild_%platform%_%config%.log"
call Scripts/GameBuild_withParam.bat %platform% %config% %bUseDistribution% %packagedir% %logfile% %bUseBuild% %ATF% %ResultLogFile%

exit /B 0
