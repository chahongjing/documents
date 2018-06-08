@echo off
title oracle import
set username=libra
set password=libra$20167
set host=127.0.0.1
set port=1521
set instance=orcl
set dmppath=d:\201803071715.dmp

echo.
echo imp %username%/%password%@%host%:%port%/%instance% file=%dmppath% full=y
echo.
echo.
imp %username%/%password%@%host%:%port%/%instance% file=%dmppath% full=y
pause;