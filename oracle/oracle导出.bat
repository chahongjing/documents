@echo off
title oracle export
set username=libra
set password=libra$20167
set host=127.0.0.1
set port=1521
set instance=orcl
set dmppath=d:\201803071715.dmp

rem no data use: rows=n compress=n
set command=exp %username%/%password%@%host%:%port%/%instance% file=%dmppath%

echo.
echo %command%
echo.
echo.
%command%
pause;