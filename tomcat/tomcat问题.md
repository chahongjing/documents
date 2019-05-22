## Tomcat部署项目后访问html文件乱码
#### 解决方法:
1. 直接启动startup.bat运行，则需要在catalina.bat中设置
~~~ cmd
set JAVA_OPTS=-Xms256m -Xmx2048m -Dfile.encoding=UTF-8
~~~
2. windows服务运行tomcat，则需要执行tomcatw.exe进行配置，增加
~~~ cmd
-Dfile.encoding=UTF-8
~~~
![tomcat](/imgs/java/tomcat1.png)
## 设置tomcat上传文件大小限制设置
- maxPostSize未设置默认为2MB，当maxPostSize<=0时，POST方式上传的文件大小不会被限制。（设置20MB：maxPostSize="20971520"）
~~~ xml
<Connector port="20000" protocol="HTTP/1.1" connectionTimeout="20000" URIEncoding="UTF-8" useBodyEncodingForURI="true" maxPostSize="102400" redirectPort="8443" />
~~~
- 设置url请求参数可以为中文。URIEncoding="UTF-8"，设置请求编码类型为utf-8。useBodyEncodingForURI="true"
~~~ xml
<Connector port="20000" protocol="HTTP/1.1" connectionTimeout="20000" URIEncoding="UTF-8" useBodyEncodingForURI="true" maxPostSize="102400" redirectPort="8443" />
~~~