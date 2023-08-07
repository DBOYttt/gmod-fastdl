@echo off
setlocal enabledelayedexpansion

rem Sprawdzamy, czy przeciągnięto foldery/pliki na skrypt .bat
if "%~1" == "" (
    echo Przeciągnij foldery/pliki na ten skrypt, aby je skompresować do .bz2.
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

rem Pętla przetwarzająca przeciągnięte foldery/pliki
:process_item
if "%~1" == "" (
    goto :eof
)

rem Sprawdzamy, czy przeciągnięty element to folder
if exist "%~1\" (
    rem Jeśli przeciągnięty element to folder, wywołujemy skrypt rekurencyjnie dla jego zawartości
    pushd "%~1"
    call :process_folder
    popd
) else (
    rem Jeśli przeciągnięty element to plik, kompresujemy go do pliku .bz2
    "%SzPath%" a -t7z "%~1.bz2" "%~1"
)

shift
goto process_item

:process_folder
rem Pętla przetwarzająca pliki w folderze
for %%F in (*) do (
    rem Jeśli element w folderze to plik, kompresujemy go do pliku .bz2
    if exist "%%F" (
        "%SzPath%" a -t7z "%%F.bz2" "%%F"
    )
)

goto :eof

echo Konwersja zakończona.
pause
