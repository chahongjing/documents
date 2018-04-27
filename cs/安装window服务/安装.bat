@echo off 

cd C:\WINDOWS\Microsoft.NET\Framework\v4.0.30319
cd C:\WINDOWS\Microsoft.NET\Framework\v2.0.50727

rem 卸载 注意路径要添加引号，否则有可能安装报错
InstallUtil /u "E:\TDDOWNLOAD\FileMonitorService\bin\Debug\FileMonitorService.exe"
rem 安装 注意路径要添加引号，否则有可能安装报错
InstallUtil "E:\TDDOWNLOAD\FileMonitorService\bin\Debug\FileMonitorService.exe"

