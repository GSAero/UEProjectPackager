# Project Packager for Unreal Engine 4

List of bat-files for project packaging without using Unreal Editor using command line.
Analog of Project Launcher in Unreal Editor.
Used UAT in command line with configurable params.
This batchfiles may be run manual, or run by timer using scheduler.

## Opportunities of package

* packaging for all platforms - Android, IOS, Win64, Win32, Mac, Linux, etc.
* packaging any configuration - Development, Shipping, Debug, DebugGame, Test.
* ability to use the value of the "For Distribution" flag" (see Project Settings -> Project -> Packaging -> Project - For Distribution).

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

## Installation

* copy all files and folders (without .gitignore/LICENSE/README.md files) into folder with your UE project;
* modify *.bat-file, line 14 - set absolute path to the folder with packaged games, wihtout quotation marks, there should be a slash at the end. Example: C:\PackagedGames\MyGame01\ (see Project Settings -> Project -> Packaging -> Project - Staging Directory);
* modify *.bat-file, line 16 - set relative path to the folder with log files, wihtout quotation marks, there should be a slash at the end. Or create folder "Logs" in yout project folder;
* modify "Scripts/GameBuild_withParam.bat" file, line 16 - set absolute path to the UE project file. Example: "C:\Users\UserName\Documents\Unreal Projects\MyGame01\MyGame01.uproject";
* if you have Windows - modify "/GameBuild_withParam.bat" file, line 23 - set absolute path to the UAT file of UE for Windows. If your package project on UE 4.24 - don't do anything;
* if you have macOS - modify "Scripts/GameBuild_withParam.bat" file, line 32 - uncomment and set absolute path to the UAT file of UE for MacOS;
* if you have Lunux - modify "Scripts/GameBuild_withParam.bat" file, line 37 - set absolute path to the UAT file of UE for Linux;
* for Windows: preferably use the slash " / " instead of the backslash"\";

## Usage

Run the desired bat-file and wait for the package to finish.

## Misc

see "Scripts/Info for Command LIne for Package Project.txt"
