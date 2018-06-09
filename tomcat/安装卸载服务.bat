@echo off
title tomcat service(install/uninstall)
set /p type=install(i),uninstall(u):
rem install
if "%type%"=="i" (
set command=call service.bat install
set title=install tomcat service
goto hasCommand
)
rem uninstall
if "%type%"=="u" (
set command=call service.bat remove
set title=uninstall tomcat service
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