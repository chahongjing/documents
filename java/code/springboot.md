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
- 再添加servlet依赖
~~~ xml
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
public class RZSpiderServletInitializer extends SpringBootServletInitializer{
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application){
        return application.sources(RZSpiderApplication.class);
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