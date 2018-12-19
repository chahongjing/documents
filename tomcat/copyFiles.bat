@echo off
title deploy ToolSiteMvc4J and myvue

set javaDir=F:\MyWorkplace\JavaCode\ToolSiteMvc4J\trunk\web\target\ToolSiteMvc4J\
set vueDir=D:\webvue\
set targetDir=F:\CompanyWorkplace\apache-tomcat-9.0.8_service\webapps\ToolSiteMvc4J\
set configDir=F:\CompanyWorkplace\apache-tomcat-9.0.8_service\webapps\static\

set /p type=deploy type: all(1), java(2), vue(3):
if "%type%"=="1" (
goto copyJava
)
if "%type%"=="2" (
goto copyJava
)
if "%type%"=="3" (
goto copyVue
)
echo.
echo wrong type
goto end

:copyJava
echo.
echo delete ToolSiteMvc4J
rmdir /s/q %targetDir%
echo.
echo copy ToolSiteMvc4J
xcopy %javaDir%*.* %targetDir% /s/e/y
if "%type%"=="1" (
goto copyVue
)
goto end

:copyVue
echo.
echo delete static
rmdir /s/q %targetDir%static
echo.
echo copy myvue
xcopy %vueDir%*.* %targetDir% /s/e/y
echo.
echo copy config
xcopy %configDir%*.* %targetDir%static\ /s/e/y

:end
echo.
pause;