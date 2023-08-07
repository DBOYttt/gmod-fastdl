@echo off
set "export_folder=%USERPROFILE%\Desktop\exports"
mkdir "%export_folder%"

for /d %%i in (*) do (
    echo Compressing folder: %%i
    "C:\Program Files\7-Zip\7z.exe" a -tbzip2 "%export_folder%\%%i.bz2" "%%i\*"
)

echo Compression complete! Exported files to the "%export_folder%" folder.
pause
