# 安装本地jar到本地仓库
~~~ bat
:: 如果bat和jar包在同一目录 -Dfile可以直接写包名，如-Dfile=ojdbc6.jar；如果写路径，注意路径中汉字，有可能会有乱码问题
:: jar包位置一般在oracle安装目录中dbhome/jdbc/lib/ojdbc6.jar
start "安装jar包" mvn install:install-file -Dpackaging=jar -DgroupId=com.oracle -DartifactId=ojdbc6 -Dfile=F:\MyWorkplace\JavaCode\ToolSiteMvc4J\lib\ojdbc6.jar -Dversion=11.2.0.3.0
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
    <localRepository>F:/Source/Java/maven/repository</localRepository>
    <mirrors>
        <mirror>
          <id>alimaven</id>
          <name>aliyun maven</name>
          <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
          <mirrorOf>central</mirrorOf>
        </mirror>
        <mirror>
            <id>jboss-public-repository-group</id>
            <mirrorOf>central</mirrorOf>
            <name>JBoss Public Repository Group</name>
            <url>http://repository.jboss.org/nexus/content/groups/public</url>
        </mirror>
        <mirror>
            <id>repo2</id>
            <name>Mirror from Maven Repo2</name>
            <url>http://repo2.maven.org/maven2/</url>
            <mirrorOf>central</mirrorOf>
        </mirror>
        <mirror>
            <id>ui</id>
            <name>Mirror from UK</name>
            <url>http://uk.maven.org/maven2/</url>
            <mirrorOf>central</mirrorOf>
        </mirror>
    </mirrors>
    <profiles>
        <profile>  
            <id>jdk-1.8</id>  
            <activation>  
                <activeByDefault>true</activeByDefault>  
                <jdk>1.8</jdk>  
            </activation>  
            <properties>  
                <maven.compiler.source>1.8</maven.compiler.source>  
                <maven.compiler.target>1.8</maven.compiler.target>  
                <maven.compiler.compilerVersion>1.8</maven.compiler.compilerVersion>  
            </properties>  
        </profile>

        <profile>
            <id>allow-snapshots</id>
            <activation><activeByDefault>true</activeByDefault></activation>
            <repositories>
                <repository>
                    <id>snapshots</id>
                    <url>http://nexus.dmall.com:8081/nexus/content/repositories/snapshots/</url>
                    <snapshots><enabled>true</enabled></snapshots>
                </repository>
            </repositories>
        </profile>
    </profiles>
    <servers>
        <server>
            <id>tomcat7</id>
            <username>admin</username>
            <password>admin</password>
        </server>
    </servers>
</settings>
~~~
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