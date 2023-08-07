@echo off
setlocal enabledelayedexpansion

rem Określ ścieżkę do katalogu skryptu
set "scriptDir=%~dp0"

rem Utwórz plik tekstowy z danymi zgodnie z formułą
(
    echo if (SERVER^) then
    echo   -- EXAMPLE
    rem Pętla przetwarzająca przeciągnięte foldery/pliki
    for %%I in (%*) do (
        rem Sprawdzamy, czy przeciągnięty element to plik
        if exist "%%~I" (
            rem Pobieramy nazwę pliku (bez ścieżki i rozszerzenia)
            set "fileName=%%~nxI"
            rem Dodajemy wpis do pliku tekstowego dla nieskompresowanego pliku
            echo   resource.AddFile("%%~I") -- Uncompressed >> "%scriptDir%resources.txt"
            rem Dodajemy wpis do pliku tekstowego dla skompresowanego pliku (o ile jeszcze nie jest skompresowany)
            echo   resource.AddFile("%%~dpnI.bz2") -- Compressed ( smaller filesize ) >> "%scriptDir%resources.txt"
        )
    )
    echo end
) > "%scriptDir%resources.txt"

echo Plik tekstowy "resources.txt" został utworzony w katalogu skryptu .bat.
pause

