@echo off
setlocal enabledelayedexpansion

rem Check if folders were dragged onto the .bat script
if "%~1" == "" (
    echo Drag a folder onto this script to compress it.
    pause
    exit /b
)

rem Path to the 7-Zip program
set "SzPath=C:\Program Files\7-Zip\7z.exe"

rem Check if 7-Zip exists at the specified path
if not exist "%SzPath%" (
    echo 7-Zip was not found at the specified path.
    pause
    exit /b
)

rem Loop to process dragged folders
:process_folder
if "%~1" == "" (
    goto :eof
)

rem Check if the dragged item is a folder
if exist "%~1\" (
    rem Get the folder name (without path) for the .bz2 file name
    set "folderName=%~nx1"
    rem Compress the folder into a .bz2 file
    "%SzPath%" a -t7z "%~dp1\!folderName!.bz2" "%~1\*"
)

shift
goto process_folder

echo Conversion completed.
pause
