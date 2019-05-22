配置java_home
1. 解压jdk.tar.gz文件。如/usr/java/jdk1.8.0_161。
2. vi打开 /etc/profile,在前面输入如下内容，然后保存退出<br>
![jdk](/imgs/linux/jdk1.png)<br>
~~~ ini
JAVA_HOME=/home/zjy/software/jdk1.8.0_161
JRE_HOME=/home/zjy/software/jdk1.8.0_161/jre
CLASS_PATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib
PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin
export JAVA_HOME JRE_HOME CLASS_PATH PATH
~~~
3. 保存后输入java –version，看到类似如下信息便安装成功。<br>
![jdk](/imgs/linux/jdk1.png)<br>
4. 启动tomcat
~~~ cmd
./startup.sh，关闭项目：./shutdown.sh
~~~
