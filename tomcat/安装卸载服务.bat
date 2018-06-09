@echo off
title tomcat service(install/uninstall)
set /p type=install(1),uninstall(0):
rem install
if %type%==1 (
set command=call service.bat install
set title=install tomcat service
goto hasCommand
)
rem uninstall
if %type%==0 (
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
echo error input. only 1 or 0

:end
pause;