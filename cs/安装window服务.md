# 安装
~~~ bat
@echo off
title your service(install/uninstall)
set /p type=install(i),uninstall(u):
set /p netVer=.net framework version(2.0 or 4.0):
set /p servicePath=yourService.exe path:

rem path error
if not exist "%servicePath%" goto pathError

C:
if "%netVer%"=="4.0" (
cd C:\WINDOWS\Microsoft.NET\Framework\v4.0.30319
goto install
)
rem other 2.0
cd C:\WINDOWS\Microsoft.NET\Framework\v2.0.50727

:install
rem install
if "%type%"=="i" (
set command=InstallUtil "%servicePath%"
set title=install your service
goto hasCommand
)
rem uninstall
if "%type%"=="u" (
set command=InstallUtil /u "%servicePath%"
set title=uninstall your service
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
goto end

:pathError
echo no service.exe file:%servicePath%
goto end

:end
pause;
~~~
# 安装服务
~~~ bat
sc create MysoftWindowServices binpath= "C:\Users\simm\Desktop\MysoftWindowServices\MysoftWindowServices\MysoftWindowServices\bin\Debug\MysoftWindowServices.exe" displayname= "MysoftWindowServices" start= auto

pause
~~~
# 缷载服务
~~~ bat
sc delete MysoftWindowServices

pause
~~~