# Java配置
### 配置jdk
1. 去官网下载jdk 1.8（如jdk-8u151-windows-x64.exe）并安装，记住安装目录，如下
![jdk](/imgs/java/java_env1.png)
2. 在环境变量中配置JAVA_HOME，如果有，则要修改，值为jdk的安装目录。
![jdk](/imgs/java/java_env2.png)
3. 在环境变量中添加PATH变量，如果没有PATH变量新增一个即可。在已有的值后面追加;%JAVA_HOME%\bin;注意与前面的值要有分隔, 故有一个分号。<br>
![jdk](/imgs/java/java_env3.png)
4. 添加CLASSPATH变量（jdk1.5以后可以不用添加）。如果没有CLASSPATH变量新增一个即可。在值中追加.;%JAVA_HOME%\lib;%JAVA_HOME%\lib\tools.jar 注意最前面的点号。
5. 测试是否安装成功。在cmd中运行java –version。安装成功则会输出java版本号。
![jdk](/imgs/java/java_env4.png)
### 配置tomcat
1. 安装apache-tomcat服务器（如apache-tomcat-9.0.2-windows-x64.zip）, 官网下载解压后，管理员权限运行cmd，进入到tomcat解压目录中，安装服务执行 bin\service.bat install
![jdk](/imgs/java/java_env5.png)
2. 安装成功后，直接进入到tomcat根目录/bin文件夹，运行startup.bat直接启动或运行tomcat8w.exe, 然后点启动。