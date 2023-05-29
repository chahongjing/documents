# 安装本地jar到本地仓库
~~~ bat
:: 如果bat和jar包在同一目录 -Dfile可以直接写包名，如-Dfile=ojdbc6.jar；如果写路径，注意路径中汉字，有可能会有乱码问题
:: jar包位置一般在oracle安装目录中dbhome/jdbc/lib/ojdbc6.jar
start "安装jar包" mvn install:install-file -Dpackaging=jar -DgroupId=com.oracle -DartifactId=ojdbc6 -Dfile=F:\MyWorkplace\JavaCode\ToolSiteMvc4J\lib\ojdbc6.jar -Dversion=11.2.0.3.0
:: 安装jar到私服
mvn deploy:deploy-file -DgroupId=com.zjy -DartifactId=zjy-wsnw-api -Dversion=0.0.1-SNAPSHOT -Dpackaging=jar -Dfile=D:\comWorkspace\projects\zjy-wsnw\zjy-wsnw-api\target\zjy-wsnw-api-0.0.1-SNAPSHOT.jar -DrepositoryId=snapshots -Durl=http://nexus.zjy.com:8081/nexus/content/repositories/snapshots/
~~~
### 如果是idea直接上传
1. 在settings.xml中servvers节点下配置用户名和密码
~~~ xml
<server>
    <id>snapshots</id>
    <username>yourusername</username>
    <password>yourpassword</password>
</server>
~~~
2. 在要发布的pom和父pom文件中的project节点下添加如下节点，其中id要对应上面的id
~~~ xml
<distributionManagement>
    <snapshotRepository>
        <id>snapshots</id>
        <name>Nexus Snapshot Repository</name>
        <url>http://nexus.zjy.com:8081/nexus/content/repositories/snapshots/</url>
    </snapshotRepository>
</distributionManagement>
~~~
3. 在不需要上传的模块中的pom文件中project-->build-->plugins节点下添加如下节点，表示此模块不上传到私服
~~~ xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-deploy-plugin</artifactId>
    <version>2.8.2</version>
    <configuration>
        <skip>true</skip>
    </configuration>
</plugin>
~~~
# 删除过期的文件
~~~ bat
echo off
title delete all maven lastUpdated files
rem maven repository directory: C:\Users\Administrator\.m2\repository
set REPOSITORY_PATH=F:\CompanyWorkplace\maven
echo searching lastUpdated files...
for /f "delims=" %%i in ('dir /b /s "%REPOSITORY_PATH%\*lastUpdated*"') do (
    del /s /q %%i
)
echo done
pause
~~~
# 引用本地jar包
~~~ xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-install-plugin</artifactId>
    <version>2.5.2</version>
    <executions>
        <execution>
            <phase>initialize</phase>
            <goals>
                <goal>install-file</goal>
            </goals>
            <configuration>
                <groupId>com.aspose</groupId>
                <artifactId>aspose-words</artifactId>
                <version>14.9.0</version>
                <packaging>jar</packaging>
                <file>${basedir}/src/main/lib/aspose-words-14.9.0-jdk16.jar</file>
            </configuration>
        </execution>
    </executions>
</plugin>

或者使用

<dependency>  
    <groupId>com.htmlparser</groupId>  
    <artifactId>htmlparser</artifactId>  
    <version>2.0</version>  
    <scope>system</scope>  
    <systemPath>${project.basedir}/lib/htmlparser.jar</systemPath>  
</dependency>  
~~~
# settings.xml
~~~ xml
<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
            http://maven.apache.org/xsd/settings-1.0.0.xsd">
    <localRepository>D:/soft_install/apache-maven-3.8.3/repository</localRepository>
    <servers>
        <!-- 唯一标识一个server，该id必须与后面的仓库id一致，否则连接不上 -->
        <server>
            <id>tomcat7</id>
            <username>admin</username>
            <password>admin</password>
        </server>
        <server>
            <id>mi-central</id>
            <username>zzz</username>
            <password>xxx</password>
        </server>
        <server>
            <id>mi-snapshots</id>
            <username>zzz</username>
            <password>xxx</password>
        </server>
    </servers>

    <mirrors>
        <mirror>
            <id>aliyun</id>
            <!-- profile为aliyun的仓库都走此镜像 -->
            <mirrorOf>aliyun</mirrorOf>
            <url>https://maven.aliyun.com/repository/public</url>
        </mirror>
        <mirror>
            <id>maven-default-http-blocker</id>
            <mirrorOf>external:dont-match-anything-mate:*</mirrorOf>
            <name>Pseudo repository to mirror external repositories initially using HTTP.</name>
            <url>http://0.0.0.0/</url>
            <blocked>false</blocked>
        </mirror>
    </mirrors>

    <activeProfiles>
        <activeProfile>artifactory</activeProfile>
    </activeProfiles>
    <profiles>
        <profile>  
            <id>jdk8</id>  
            <activation>  
                <activeByDefault>false</activeByDefault>  
                <jdk>1.8</jdk>  
            </activation>  
            <properties>  
                <maven.compiler.source>1.8</maven.compiler.source>  
                <maven.compiler.target>1.8</maven.compiler.target>  
                <maven.compiler.compilerVersion>1.8</maven.compiler.compilerVersion>  
            </properties>  
        </profile>
        <profile>
            <id>aliyun</id>
            <repositories>
                <repository>
                  <id>aliyun</id>
                  <url>https://maven.aliyun.com/repository/public</url>
                  <releases><enabled>true</enabled></releases>
                  <snapshots><enabled>true</enabled></snapshots>
                </repository>
                <repository>
                  <id>aliyun-spring</id>
                  <url>https://maven.aliyun.com/repository/spring</url>
                  <releases><enabled>true</enabled></releases>
                  <snapshots><enabled>true</enabled></snapshots>
                </repository>
            </repositories>
            <pluginRepositories>
                <pluginRepository>
                  <id>aliyun</id>
                  <url>https://maven.aliyun.com/repository/spring-plugin</url>
                  <releases><enabled>true</enabled></releases>
                  <snapshots><enabled>true</enabled></snapshots>
                </pluginRepository>
            </pluginRepositories>
        </profile>
        <profile>
            <id>artifactory</id>
            <repositories>
                <repository>
                  <id>mi-central</id>
                  <name>maven-release-virtual</name>
                  <url>xxx</url>
                  <snapshots><enabled>false</enabled></snapshots>
                </repository>
                <repository>
                  <id>mi-remote</id>
                  <name>maven-remote-virtual</name>
                  <url>xxx</url>
                  <snapshots><enabled>false</enabled></snapshots>
                </repository>
                <repository>
                  <id>mi-snapshots</id>
                  <name>maven-snapshot-virtual</name>
                  <url>xxx</url>
                  <snapshots />
                </repository>
            </repositories>
            <pluginRepositories>
                <pluginRepository>
                  <id>mi-central</id>
                  <name>maven-release-virtual</name>
                  <url>xxx</url>
                  <snapshots><enabled>false</enabled></snapshots>
                </pluginRepository>
                <pluginRepository>
                  <id>mi-remote</id>
                  <name>maven-remote-virtual</name>
                  <url>xxx</url>
                  <snapshots><enabled>false</enabled></snapshots>
                </pluginRepository>
                <pluginRepository>
                  <id>mi-snapshots</id>
                  <name>maven-snapshot-virtual</name>
                  <url>xxx</url>
                  <snapshots />
                </pluginRepository>
            </pluginRepositories>
        </profile>
    </profiles>
</settings>
~~~
### 多仓库切换
``` xml
<?xml version="1.0" encoding="UTF-8"?>
<settings xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.1.0 http://maven.apache.org/xsd/settings-1.1.0.xsd" xmlns="http://maven.apache.org/SETTINGS/1.1.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <localRepository>/Users/zjy/soft_install/apache-maven-3.8.6/repository</localRepository>
  <servers>
    <server>
      <username>username</username>
      <password>password</password>
      <id>central</id>
    </server>
    <server>
      <username>username</username>
      <password>password</password>
      <id>snapshots</id>
    </server>
  </servers>
  <mirrors>
    <!-- <mirror>
      <id>nexus-aliyun</id>
      <mirrorOf>central</mirrorOf>
      <name>Nexus aliyun</name>
      <url>http://maven.aliyun.com/nexus/content/groups/public</url>
    </mirror> -->
  </mirrors>
  <profiles>
    <profile>
      <repositories>
        <repository>
          <snapshots>
            <enabled>false</enabled>
          </snapshots>
          <id>central</id>
          <name>maven-release-virtual</name>
          <url>https://your.company.repository.com/artifactory/maven-release-virtual</url>
        </repository>
        <repository>
          <snapshots>
            <enabled>false</enabled>
          </snapshots>
          <id>miremote</id>
          <name>maven-remote-virtual</name>
          <url>https://your.company.repository.com/artifactory/maven-remote-virtual</url>
        </repository>
        <repository>
          <snapshots />
          <id>snapshots</id>
          <name>maven-snapshot-virtual</name>
          <url>https://your.company.repository.com/artifactory/maven-snapshot-virtual</url>
        </repository>
      </repositories>
      <pluginRepositories>
        <pluginRepository>
          <snapshots>
            <enabled>false</enabled>
          </snapshots>
          <id>central</id>
          <name>maven-release-virtual</name>
          <url>https://your.company.repository.com/artifactory/maven-release-virtual</url>
        </pluginRepository>
        <pluginRepository>
          <snapshots>
            <enabled>false</enabled>
          </snapshots>
          <id>miremote</id>
          <name>maven-remote-virtual</name>
          <url>https://your.company.repository.com/artifactory/maven-remote-virtual</url>
        </pluginRepository>
        <pluginRepository>
          <snapshots />
          <id>snapshots</id>
          <name>maven-snapshot-virtual</name>
          <url>https://your.company.repository.com/artifactory/maven-snapshot-virtual</url>
        </pluginRepository>
      </pluginRepositories>
      <id>artifactory</id>
    </profile>

    <profile>  
      <id>aliyun</id>  
      <repositories>  
        <repository>  
        <id>nexus</id>                                    
        <url>http://maven.aliyun.com/nexus/content/groups/public/</url>                        
        <releases>  
          <enabled>true</enabled>  
        </releases>  
        <snapshots>  
          <enabled>true</enabled>  
        </snapshots>  
        </repository>  
      </repositories>  
      <pluginRepositories>  
        <pluginRepository>  
        <id>nexus</id>  
        <url>http://maven.aliyun.com/nexus/content/groups/public/</url>  
        <releases>  
          <enabled>true</enabled>  
        </releases>  
        <snapshots>  
          <enabled>true</enabled>  
        </snapshots>  
        </pluginRepository>  
      </pluginRepositories>  
    </profile>
  </profiles>
</settings>
```
### 设置maven可以使用快照版本
~~~ xml
<!-- 在profiles节点下添加 -->
<profile>    
    <id>nexus</id>
    <repositories>
        <repository>
            <id>central</id>
            <name>Nexus</name>
            <url>http://192.168.1.253/nexus/content/groups/public/</url>
            <releases><enabled>true</enabled></releases>
            <snapshots><enabled>true</enabled></snapshots>
        </repository>
    </repositories>
    <pluginRepositories>
        <pluginRepository>
            <id>central</id>
            <name>Nexus</name>
            <url>http://192.168.1.253/nexus/content/groups/public/</url>
            <releases><enabled>true</enabled></releases>
            <snapshots><enabled>true</enabled> </snapshots>
        </pluginRepository>
    </pluginRepositories>
    </profile>
</profiles>
<activeProfiles>
    <activeProfile>nexus</activeProfile>
</activeProfiles>
~~~
