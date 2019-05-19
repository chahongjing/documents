# java远程调试
1. Bat启动方式。在catalina.bat第一行添加如下代码，其中9999是调试端口号，不能和运行端口冲突
~~~ bat
SET CATALINA_OPTS=-server -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=9999
~~~
![debug](/imgs/java/remotedebug1.png)<br>
再在idea中添加远程调试服务，配置如下。然后就可以远程调试。<br>
![debug](/imgs/java/remotedebug2.png)<br>
2. Window服务启动添加方式<br>
![debug](/imgs/java/remotedebug3.png)<br>
~~~ bat
-Xdebug  
-Xrunjdwp:transport=dt_socket,address=9999,server=y,suspend=n
~~~