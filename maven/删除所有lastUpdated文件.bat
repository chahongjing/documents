echo off
title delete all maven lastUpdated files
rem maven repository directory: C:\Users\Administrator\.m2\repository
set REPOSITORY_PATH=F:\CompanyWorkplace\maven
echo searching lastUpdated files...
for /f "delims=" %%i in ('dir /b /s "%REPOSITORY_PATH%\*lastUpdated*"') do (
    del /s /q %%i
)
echo done
pause