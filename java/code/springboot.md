### 打war包
[war](https://blog.csdn.net/rico_zhou/article/details/83415114)
- 将pom.xml中打包配置改成war
~~~ xml
<packaging>war</packaging>
~~~
- 去除springboot中自带的tomcat
~~~ xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
    <!-- war包部署移除嵌入式tomcat插件 -->
    <exclusions>
        <exclusion>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-tomcat</artifactId>
        </exclusion>
    </exclusions>
</dependency>
~~~
- 再添加依赖
~~~ xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-tomcat</artifactId>
    <!--打包的时候可以不用包进去，别的设施会提供。事实上该依赖理论上可以参与编译，测试，运行等周期。
        相当于compile，但是打包阶段做了exclude操作-->
    <scope>provided</scope>
</dependency>
<!-- 可以不用添加？ -->
<dependency>
    <groupId>javax.servlet</groupId>
    <artifactId>javax.servlet-api</artifactId>
    <version>3.1.0</version>
    <scope>provided</scope>
</dependency>
~~~
- 接下来会出现报错信息如果你的项目中使用了Tomcat相关的依赖，如：import org.apache.tomcat.util.http.fileupload.FileUploadBase.FileSizeLimitExceededException;
没关系，不用管
- 更改启动类，继承SpringBootServletInitializer ，覆盖configure()，把启动类Application注册进去
~~~ java
public class WarConfiguration extends SpringBootServletInitializer{
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application){
        return application.sources(WebApplication.class);
    }
}
~~~
### 启动springboot项目
~~~ bat
rem --server.port：指定运行时端口号
rem --spring.profiles.active：指定启动的profile
rem > E:/test.log &：不在控制台显示日志，日志输出到test.log文件中
rem linux下使用：nohup java -jar xxxxxxxxx &  即可后台运行服务
rem 若无法识别 --spring.xx参数，则改为-Dspring.xx
java -jar ./web/target/web-1.0.jar --server.port=8088 --spring.profiles.active=online > E:/test.log &
~~~

## 热部署
~~~ xml
<!-- 添加依赖 -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-devtools</artifactId>
    <optional>true</optional>
</dependency>
<!-- 添加插件 -->
<plugin>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-maven-plugin</artifactId>
    <configuration>
        <fork>true</fork>
    </configuration>
</plugin>
~~~
~~~ properties
#热部署生效
spring.devtools.restart.enabled: true
#设置重启的目录
#spring.devtools.restart.additional-paths: src/main/java
#classpath目录下的WEB-INF文件夹内容修改不重启
spring.devtools.restart.exclude: WEB-INF/**
~~~
- idea设置
  - File --> Settings --> Compiler --> 勾选Build Project automatically
  - ctrl + shift + alt + /, 选择Registry, 勾上 Compiler autoMake allow when app running
## 配置读取顺序
![配置](/imgs/java/1.png)
1. config/application.properties（项目根目录中config目录下）
2. config/application.yml
3. application.properties（项目根目录下）
4. application.yml
6. resources/config/application.yml
7. resources/application.properties（项目的resources目录下）
8. resources/application.yml
- 如果同一个目录下，有application.yml也有application.properties，默认先读取application.properties；如果同一个配置属性，在多个配置文件都配置了，默认使用第1个读取到的，后面读取的不覆盖前面读取到的。
### 属性规则
- 在Spring Boot 2.0中对配置属性加载的时候会除了像1.x版本时候那样移除特殊字符外，还会将配置均以全小写的方式进行匹配和加载。所以，下面的4种配置方式都是等价的：推荐使用全小写配合-分隔符的方式来配置，比如：spring.jpa.database-platform=mysql
~~~ yml
spring:
  jpa:
    databaseplatform: mysql
    database-platform: mysql
    databasePlatform: mysql
    database_platform: mysql
~~~
- List类型
~~~ yml
spring:
  my-example:
    url:
      - http://example.com
      - http://spring.io
# 也支持逗号分割的方式：
spring:
  my-example:
    url: http://example.com, http://spring.io
# 在Spring Boot 2.0中对于List类型的配置必须是连续的 如下配置是不允许的
foo[0]: a
foo[2]: b
# jvm指定参数
-D"spring.my-example.url[0]=http://example.com"
-D"spring.my-example.url[1]=http://spring.io"
# 也可以以逗号分隔
-Dspring.my-example.url=http://example.com,http://spring.io
~~~
- Map类型，使用和object一样，如果Map类型的key包含非字母数字和-的字符，需要用[]括起来，比如：
~~~ yml
spring:
  my-example:
    '[foo.baz]': bar
~~~
- 由于环境变量中无法使用[和]符号，所以使用_来替代。任何由下划线包围的数字都会被认为是[]的数组形式。比如：
~~~ yml
MY_FOO_1_: my.foo[1]
MY_FOO_1_BAR: my.foo[1].bar
MY_FOO_1_2_: my.foo[1][2]
# 另外如果最后环境变量最后是以数字和下划线结尾的话，最后的下划线可以省略
MY_FOO_1: my.foo[1]
MY_FOO_1_2: my.foo[1][2]
~~~
- 属性读取
  - 通过.分离各个元素
  - 最后一个.将前缀与属性名称分开
  - 必须是字母（a-z）和数字(0-9)
  - 必须是小写字母
  - 用连字符-来分隔单词
  - 唯一允许的其他字符是[和]，用于List的索引
  - 不能以数字开头
~~~ java
Binder binder = Binder.get(context.getEnvironment());
// 绑定List配置
List<String> post = binder.bind("com.didispace.post", Bindable.listOf(String.class)).get();
~~~
## springboot热部署
1. File -> Settings -> Default Settings -> Build -> Compiler 然后勾选 Build project automatically 
2. Ctrl + Shift + Alt + / 然后进入Registry.
3. ompiler.automake.allow.when.app.running -> 自动编译；compile.document.save.trigger.delay -> 自动更新文件；compile.automake.trigger.delay
4. Edit Configurations->SpringBoot插件->目标项目->勾选热更新
5. spring-boot-devtools，添加devtools配置
### springboot启动
~~~ shell
#!/bin/bash
appName=yourapp
PID=$(ps -ef | grep $appName | grep -v grep | awk '{ print $2 }')
if [ -z "$PID" ]
then
    echo ${appName}.jar is already stopped
else
    echo kill $PID
    kill $PID
fi
# nohup不挂断地运行命令,最后一个&表示后台运行
# 不输出日志：nohup java -jar xxx.jar >/dev/null &
nohup java -jar $appName.jar --server.port=8888 > catalina.out  2>&1 &
~~~
