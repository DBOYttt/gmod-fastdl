@echo off
setlocal enabledelayedexpansion

rem Check if folders/files were dragged onto the .bat script
if "%~1" == "" (
    echo Drag folders/files onto this script to compress them into .bz2 files.
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

rem Loop to process dragged folders/files
:process_item
if "%~1" == "" (
    goto :eof
)

rem Check if the dragged item is a folder
if exist "%~1\" (
    rem If the dragged item is a folder, call the script recursively for its contents
    pushd "%~1"
    call :process_folder
    popd
) else (
    rem If the dragged item is a file, compress it into a .bz2 file
    "%SzPath%" a -t7z "%~1.bz2" "%~1"
    rem Delete the uncompressed file
    del "%~1"
)

shift
goto process_item

:process_folder
rem Loop to process files in the folder
for %%F in (*) do (
    rem If the item in the folder is a file, compress it into a .bz2 file
    if exist "%%F" (
        "%SzPath%" a -t7z "%%F.bz2" "%%F"
        rem Delete the uncompressed file
        del "%%F"
    )
)

rem Call the script recursively for subfolders
for /d %%D in (*) do (
    pushd "%%D"
    call :process_folder
    popd
)

goto :eof

echo Conversion completed.
pause

