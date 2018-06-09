@echo off
title redis service(install/uninstall)
set /p type=install(1),uninstall(0):
rem install
if %type%==1 (
set command=redis-server --service-install redis.windows.conf --loglevel verbose
set title=install redis service
goto hasCommand
)
rem uninstall
if %type%==0 (
set command=redis-server.exe --service-uninstall
set title=uninstall redis service
goto hasCommand
)
rem error
goto errorInput

:hasCommand
title %title%
echo.
echo %command%
%command%
goto end

:errorInput
echo error input. only 1 or 0

:end
pause;