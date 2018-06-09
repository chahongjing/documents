rem first create data and log folders in bin folder
rem second run with admin cmd, and goto into bin folder, then run this bat
@echo off
title MongoDB service(install/uninstall)
set /p type=install(1),uninstall(0):
rem install
if %type%==1 (
set command=mongod.exe --logpath %cd%\log\mongodb.log --logappend --dbpath %cd%\data --directoryperdb --serviceName MongoDB --install --bind_ip 0.0.0.0
set title=install MongoDB service
goto hasCommand
)
rem uninstall
rem sc delete MongoDB
if %type%==0 (
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
echo error input. only 1 or 0

:end
pause;