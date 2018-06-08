@echo off
title find port in use
set port=21
echo.
echo find processes which use port %port%
echo.
echo.
netstat -aon|findstr %port%
pause;