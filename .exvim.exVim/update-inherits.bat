@echo off
set DEST=.\.exvim.exVim
set TOOLS=C:\exVim\vimfiles\tools\
set TMP=%DEST%\_inherits
set TARGET=%DEST%\inherits
call %TOOLS%\shell\batch\update-inherits.bat
