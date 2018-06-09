rem first create data and log folders in bin folder
rem second run with admin cmd, and goto into bin folder, then run this bat
@echo off
title MongoDB service(install/uninstall)
set /p type=install(i),uninstall(u):
rem install
if "%type%"=="i" (
set command=mongod.exe --logpath %cd%\log\mongodb.log --logappend --dbpath %cd%\data --directoryperdb --serviceName MongoDB --install --bind_ip 0.0.0.0
set title=install MongoDB service
goto hasCommand
)
rem uninstall
rem sc delete MongoDB
if "%type%"=="u" (
set command=mongod.exe --remove --serviceName "MongoDB"
set title=uninstall MongoDB service
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