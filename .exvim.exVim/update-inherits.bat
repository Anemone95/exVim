@echo off
set DEST=.\.exvim.exVim
set TOOLS=C:\Users\Anemone\.vim\tools\
set TMP=%DEST%\_inherits
set TARGET=%DEST%\inherits
call %TOOLS%\shell\batch\update-inherits.bat
