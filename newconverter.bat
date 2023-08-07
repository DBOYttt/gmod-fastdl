@echo off

rem Sprawdzenie, czy 7-Zip jest zainstalowany
set "Szip_path=%ProgramFiles%\7-Zip\7z.exe"
if not exist "%Szip_path%" (
    echo 7-Zip nie został znaleziony. Upewnij się, że jest zainstalowany.
    pause
    exit /b
)

rem Sprawdzenie, czy został przeciągnięty plik
if "%~1"=="" (
    echo Aby skompresować plik, przeciągnij go na ten plik wsadowy (.bat).
    pause
    exit /b
)

rem Ustawienie katalogu docelowego jako folder źródłowy pliku
set "destination_directory=%~dp1"

rem Upewnij się, że katalog docelowy istnieje
if not exist "%destination_directory%" mkdir "%destination_directory%"

rem Konwersja przeciągniętego pliku na .bz2
"%Szip_path%" a -t7z -mx=9 "%destination_directory%%~n1.7z" "%~1"

echo Konwersja zakończona pomyślnie.
pause
