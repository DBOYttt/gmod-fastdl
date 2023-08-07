@echo off
setlocal enabledelayedexpansion

rem Sprawdzamy, czy przeciągnięto foldery na skrypt .bat
if "%~1" == "" (
    echo Przeciągnij folder na ten skrypt, aby konwertować pliki wewnątrz folderów.
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
    rem Przechodzimy do podfolderu i wywołujemy skrypt rekurencyjnie
    pushd "%~1"
    call :process_folder *
    popd
) else (
    rem Pobieramy ścieżkę do katalogu nadrzędnego i nazwę pliku (bez rozszerzenia)
    for %%F in ("%~1\..") do (
        set "parentDir=%%~dpF"
        set "fileName=%%~nxF"
    )
    rem Kompresujemy plik do pliku .bz2
    "%SzPath%" a -t7z "%parentDir%!fileName!.bz2" "%~1"
)

shift
goto process_folder

echo Konwersja zakończona.
pause
