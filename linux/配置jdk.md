配置java_home
1. 解压jdk.tar.gz文件。如/usr/java/jdk1.8.0_161。
2. vi打开 /etc/profile,在前面输入如下内容，然后保存退出<br>
![jdk](/imgs/linux/jdk1.png)<br>
~~~ shell
export JAVA_HOME=/home/zjy/software/jdk1.8.0_161
export PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin
# 配置生效
source /etc/profile
~~~
3. 保存后输入java –version，看到类似如下信息便安装成功。<br>
![jdk](/imgs/linux/jdk1.png)<br>
4. 启动tomcat
~~~ cmd
./startup.sh，关闭项目：./shutdown.sh
~~~
