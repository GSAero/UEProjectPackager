# Project Packager for Unreal Engine 4

List of bat-files for project packaging without using Unreal Editor
Analog of Project Launcher in Unreal Editor.
Used UAT in command line with configurable params.

## Opportunities of package

* packaging for all platforms - Android, IOS, Win64, Win32, Mac, Linux, etc.
* packaging any configuration - Development, Shipping, Debug, DebugGame, Test.
* ability to use the value of the "For Distribution" flag" (see Project Settings -> Project -> Packaging -> Project - For Distribution).

## Limitations

* tested only on Windows;
* when packaging for macOS/iOS you need to select the certificate/provision you need in Project Setting;

## Settings

* copy all files and folders (without .gitignore/LICENSE/README.md files) into folder with your UE project;
* modify *.bat-file, line 14 - set absolute path to the folder with packaged games, wihtout quotation marks, there should be a slash at the end. Example: C:\PackagedGames\MyGame01\ (see Project Settings -> Project -> Packaging -> Project - Staging Directory);
* modify *.bat-file, line 16 - set relative path to the folder with log files, wihtout quotation marks, there should be a slash at the end. Or create folder "Logs" in yout project folder;
* modify Scripts/GameBuild_withParam.bat file, line 16 - set absolute path to the UE project file. Example: "C:\Users\UserName\Documents\Unreal Projects\MyGame01\MyGame01.uproject";
* if you have Windows - modify Scripts/GameBuild_withParam.bat file, line 23 - set absolute path to the UAT file of UE for Windows. If your package project on UE 4.24 - don't do anything;
* if you have macOS - modify Scripts/GameBuild_withParam.bat file, line 32 - uncomment and set absolute path to the UAT file of UE for MacOS;
* if you have Lunux - modify Scripts/GameBuild_withParam.bat file, line 37 - set absolute path to the UAT file of UE for Linux;
* for Windows: preferably use the slash " / " instead of the backslash"\";

## Usage

Run the desired bat-file and wait for the package to finish.

## Misc

see "Scripts/Info for Command LIne for Package Project.txt"
