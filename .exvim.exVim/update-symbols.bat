@echo off
set DEST=.\.exvim.exVim
set TOOLS=C:\exVim\vimfiles\tools\
set TMP=%DEST%\_symbols
set TARGET=%DEST%\symbols
call %TOOLS%\shell\batch\update-symbols.bat
