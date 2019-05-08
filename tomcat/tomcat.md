# 复制文件
~~~ bat
@echo off
title deploy ToolSiteMvc4J and webvue

set javaDir=F:\MyWorkplace\JavaCode\ToolSiteMvc4J\web\target\ToolSiteMvc4J\
set vueDir=D:\webvue\
set targetDir=F:\CompanyWorkplace\apache-tomcat-9.0.8_service\webapps\ToolSiteMvc4J\
set configDir=F:\CompanyWorkplace\apache-tomcat-9.0.8_service\webapps\static\

echo.
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
echo stop tomcat service
net stop tomcat9
echo.
echo delete ToolSiteMvc4J
rmdir /s/q %targetDir%
echo.
echo copy ToolSiteMvc4J
xcopy %javaDir%*.* %targetDir% /s/e/y

echo.
echo start tomcat service
net start tomcat9
if "%type%"=="1" (
  goto copyVue
)
goto end

:copyVue
echo.
echo delete static
rmdir /s/q %targetDir%static
echo.
echo copy webvue
xcopy %vueDir%*.* %targetDir% /s/e/y
echo.
echo copy config
xcopy %configDir%*.* %targetDir%static\ /s/e/y

:end
echo.
~~~
# 安装tomcat服务
~~~ bat
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
~~~
# 设置tomcat窗口标题
- 打开catalina.bat文件，搜索%TITLE%，修改后面的值即可
# 添加context
- 1. 在conf文件夹下添加Catalina/localhost/你的虚拟目录名.xml, 如Catalina/localhost/MyJspWeb.xml, 添加如下内容。注意Context节点名称大小写, 
此时可以刷新tomcat后台管理程序, 可以看到程序已启动, http://localhost:8080/MyJspWeb/MyJsp.jsp, 注意jsp路径区分大小写
~~~ xml
<?xml version="1.0" encoding="utf-8"?><Context docBase="C:\\Users\\zengjunyi\\workspace\\TestWeb\\WebContent" reloadable="true" />
~~~
