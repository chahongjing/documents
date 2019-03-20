@echo off
title redis service(install/uninstall)
set /p type=install(i),uninstall(u):
rem install
if "%type%"=="i" (
set command=redis-server --service-install redis.windows.conf --loglevel verbose
set title=install redis service
goto hasCommand
)
rem uninstall
if "%type%"=="u" (
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
echo error input. only i or u

:end
pause;
