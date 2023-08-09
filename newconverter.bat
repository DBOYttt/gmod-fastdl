@echo off
setlocal enabledelayedexpansion

rem Ścieżka do folderu, który ma zostać przeszukany wraz z podfolderami
set "folderPath=%~dp0"

rem Ścieżka do pliku zasobów
set "outputFile=%folderPath%resources.txt"

rem Tworzymy nowy plik resources.txt lub nadpisujemy istniejący
echo. > "%outputFile%"

rem Funkcja rekurencyjna przetwarzająca foldery i pliki
:process_folder
for /r "%folderPath%" %%F in (*.bz2) do (
    rem Pobieramy pełną ścieżkę do pliku .bz2
    set "filePath=%%~fF"
    rem Usuwamy początkową część ścieżki, aby pozostała tylko względna ścieżka od folderPath
    set "relativePath=!filePath:%folderPath%=!"
    rem Dodajemy linie zasobu do pliku tekstowego
    echo resource.AddFile("!relativePath!") >> "%outputFile%"
)

rem Wywołujemy funkcję rekurencyjnie dla podfolderów
for /d %%D in ("%folderPath%*") do (
    set "folderPath=%%D"
    call :process_folder
)

goto :eof

echo Plik resources.txt został wygenerowany.
pause
