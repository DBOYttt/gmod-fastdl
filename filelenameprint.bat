@echo off
setlocal enabledelayedexpansion

rem Path to the folder to be searched along with subfolders
set "folderPath=%~dp0"

rem Path to the resources file
set "outputFile=%folderPath%resources.txt"

rem Create a new resources.txt file or overwrite an existing one
echo. > "%outputFile%"

rem Recursive function to process folders and files
:process_folder
for /r "%folderPath%" %%F in (*.bz2) do (
    rem Get the full path to the .bz2 file
    set "filePath=%%~fF"
    rem Remove the initial part of the path, leaving only the relative path from folderPath
    set "relativePath=!filePath:%folderPath%=!"
    rem Add resource lines to the text file
    echo resource.AddFile("!relativePath!") >> "%outputFile%"
)

rem Call the recursive function for subfolders
for /d %%D in ("%folderPath%*") do (
    set "folderPath=%%D"
    call :process_folder
)

goto :eof

echo File resources.txt has been generated.
pause
