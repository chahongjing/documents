@echo off 

cd C:\WINDOWS\Microsoft.NET\Framework\v4.0.30319
cd C:\WINDOWS\Microsoft.NET\Framework\v2.0.50727

rem ж�� ע��·��Ҫ������ţ������п��ܰ�װ����
InstallUtil /u "E:\TDDOWNLOAD\FileMonitorService\bin\Debug\FileMonitorService.exe"
rem ��װ ע��·��Ҫ������ţ������п��ܰ�װ����
InstallUtil "E:\TDDOWNLOAD\FileMonitorService\bin\Debug\FileMonitorService.exe"

