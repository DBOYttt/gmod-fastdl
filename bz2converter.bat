@echo off
setlocal enabledelayedexpansion

rem Sprawdzamy, czy przeciągnięto foldery na skrypt .bat
if "%~1" == "" (
    echo Przeciągnij folder na ten skrypt, aby go skompresować.
    pause
    exit /b
)

rem Ścieżka do programu 7-Zip
set "SzPath=C:\Program Files\7-Zip\7z.exe"

rem Sprawdzamy, czy 7-Zip istnieje w podanej ścieżce
if not exist "%SzPath%" (
    echo Nie znaleziono 7-Zip w podanej ścieżce.
    pause
    exit /b
)

rem Pętla przetwarzająca przeciągnięte foldery
:process_folder
if "%~1" == "" (
    goto :eof
)

rem Sprawdzamy, czy przeciągnięty element to folder
if exist "%~1\" (
    rem Pobieramy nazwę folderu (bez ścieżki) dla nazwy pliku .bz2
    set "folderName=%~nx1"
    rem Kompresujemy folder do pliku .bz2
    "%SzPath%" a -t7z "%~dp1\!folderName!.bz2" "%~1\*"
)

shift
goto process_folder

echo Konwersja zakończona.
pause

