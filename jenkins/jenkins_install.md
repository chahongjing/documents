### 安装jenkins
``` shell
# 我们将存储库密钥添加到系统，添加密钥后，系统将返回OK
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
# 将Debian包存储库地址附加到服务器的sources.list
echo deb http://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list
# 更新软件库
sudo apt-get update
# 安装jenkins，如果提示--allow-unauthenticated，则把此项添加到-y 后面，注意要添加空格，如果报错，看是不是java没有配置软链接到/usr/bin中
sudo apt-get install -y jenkins
# 报错，其中/opt/jdk1.8.0_231/bin/java是我本地java执行文件目录，或者检查8080端口是否被占用
sudo ln -s /opt/jdk1.8.0_231/bin/java /usr/bin/java
```

### 官网安装
```shell script
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins
```

### 启动jenkins
```shell script
# 启动服务
service jenkins start
# 停止
service jenkins stop
# 重启
service jenkins restart
# 配置jenkins
cat /var/lib/jenkins/secrets/initialAdminPassword
```

### maven插件设置
```shell script
manage jenkins-->manage plugins-->可选插件-->Maven Integration
# 调整maven，在具体构建项目实例里配置
build-->高级，填写settings.xml路径


如果不是在jenkins的工作目录，则需要把构建相关的目录权限授权jenkins，不然构建会报错
jenkins添加到root
gpasswd -a jenkins root
修改配置文件sudo vim /etc/default/jenkins， 或/etc/sysconfig/jenkins
NAME=root

修改仓库目录权限组为jenkins，不然下包时会报错
sudo chown -R jenkins:jenkins /opt/apache-maven-3.6.3/repository

```
### 执行脚本
```shell script

echo "buid_id:${BUILD_ID}"
echo "workspace:${WORKSPACE}"
echo "jenkins_home:${JENKINS_HOME}"
echo "job_name:${JOB_NAME}"
echo "java_home:${JAVA_HOME}"
my_jar_name=testdocker-0.0.1-SNAPSHOT

pid=$(ps -aef | grep -v grep | grep java | grep "${my_jar_name}" | awk '{print $2}')
if [ $pid ]; then
  kill -9 ${pid}
fi

# ps -aef | grep -v grep | grep java | grep "${my_jar_name}" | awk '{print $2}' | xargs kill -9
# ps -aef | grep -v grep | grep java | grep "${my_jar_name}" | sed 's/[ ]*/:/g'| cut -d: -f2 | xargs kill -9
# PID=$(ps -aef | grep -v grep | grep java | grep "${my_jar_name}" | awk '{ print $2 }')
# pid=$(cat /var/jenkins_pid.pid)
# echo $! > /var/jenkins_pid.pid

# 判断端口号是否占用
# pr=$(/usr/sbin/lsof -i:$conn_port | awk '{print $2}')
# if[ -n "$pr"]

# cp /var/lib/jenkins/jobs/testdocker/builds/${BUILD_ID}/com.zjy$testdocker/archive/com.zjy/testdocker/0.0.1-SNAPSHOT/testdocker-0.0.1-SNAPSHOT.jar /var/tmp/testdocker.jar
# 这一句很重要，这样指定了，项目启动之后才不会被Jenkins杀掉。
# export BUILD_ID=dontKillMe
nohup java -jar ${WORKSPACE}/target/${my_jar_name}.jar > /var/tmp/nohup.log 2>&1 &
```

- 全局配置maven和jdk
![a](../imgs/jenkins/jenkins_maven.png)
![a](../imgs/jenkins/jenkins_maven2.png)
- 填写maven信息，点击高级
![a](../imgs/jenkins/jenkins_maven3.png)
![a](../imgs/jenkins/jenkins_maven4.png)
![a](../imgs/jenkins/jenkins5.png)
- 本地构建
![a](../imgs/jenkins/jenkins6.png)

![a](../imgs/jenkins/jenkins7.png)
- github构建
![a](../imgs/jenkins/jenkins8.png)

![a](../imgs/jenkins/jenkins9.png)