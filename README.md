# Project Packager for Unreal Engine 4

List of batch files for project packaging without using Unreal Editor using command line.
Analog of Project Launcher in Unreal Editor.
Used UAT in command line with configurable params.
This batch files may be run manual, or run by timer using scheduler.

## Opportunities of package

* packaging for all platforms - Android, IOS, Win64, Win32, Mac, Linux, etc.
* packaging any configuration - Development, Shipping, Debug, DebugGame, Test.
* ability to use the value of the "For Distribution" flag" (see Project Settings -> Project -> Packaging -> Project - For Distribution).
* for Android builds you can optionally specify the Android Texture Format.

## Limitations

* tested only on Windows;
* when packaging for macOS/iOS you need to select the certificate/provision you need in Project Setting;

## Project build settings by default

* Full rebuild, option "-clean";
* Creating compressed coocked packages, option "-compressed";
* Does not cook editor content, option "-SkipCookingEditorContent";
* Used pack files, option "-pak";
* Packaging without crash reporter, if you need include crash reporter in game, add option "-CrashReporter" in line 73 after option "-build" in "Scripts/GameBuild_withParam.bat" file;
* Packaging without debug files, if you need include debug files in game, remove option "-nodebuginfo" from line 73 in "Scripts/GameBuild_withParam.bat" file;

Other options, see https://docs.unrealengine.com/en-US/Engine/Deployment/BuildOperations/index.html
* -cook (This stage cooks content by executing the Editor in a special mode);
* -stage (This stage copies the executables and content to a staging area; a standalone directory outside of the development directory);
* -package (This stage packages the project into a platform's native distribution format);
* -build (This stage compiles the executeables for the selected platform);

All options in "[EngineFolder]/Source/Programs/AutomationTool/AutomationUtils/ProjectParams.cs" (for UE 4.24 start from line 1103).

## Installation

* copy all files and folders (without .gitignore/LICENSE/README.md files) into folder with your UE project;
* modify GameBuild_*.bat-file, line 14 - set absolute path to the folder with packaged games, wihtout quotation marks, there should be a slash at the end. Example: C:\PackagedGames\MyGame01\;
* modify GameBuild_*.bat-file, line 16 - set relative path to the folder with log files, wihtout quotation marks, there should be a slash at the end. Or create folder "Logs" in yout project folder;
* modify "Scripts/GameBuild_withParam.bat" file, line 18 - set absolute path to the UE project file. Example: "C:\Users\UserName\Documents\Unreal Projects\MyGame01\MyGame01.uproject";
* modify "Scripts/GameBuild_withParam.bat" file, line 21 - set absolute path to the UAT log files. Attention: necessarily use backslash "\", wihtout quotation marks, there should be a slash at the end. Example: C:\Users\UserName\AppData\Roaming\Unreal Engine\AutomationTool\Logs\C+Program+Files+Epic+Games+UE_4.24\;
* if you have Windows - modify "/GameBuild_withParam.bat" file, line 28 - set absolute path to the UAT file of UE for Windows. If your package project on Windows/UE4.24 - don't do anything;
* if you have macOS - modify "Scripts/GameBuild_withParam.bat" file, line 37 - uncomment and set absolute path to the UAT file of UE for MacOS;
* if you have Lunux - modify "Scripts/GameBuild_withParam.bat" file, line 42 - set absolute path to the UAT file of UE for Linux;

## Usage

Run the desired batch file and wait for the package to finish.

## Misc

see "Scripts/Info for Command LIne for Package Project.txt"
