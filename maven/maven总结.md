# Maven总结
### Maven安装配置
1. 去官网下载最新版本maven<br>
![maven](/imgs/java/maven1.png)<br>
2. 配置maven_home<br>
![maven](/imgs/java/maven2.png)<br>
3. 配置完成后打开一个新的cmd窗口，输入mvn –version，看到如下信息表示配置成功<br>
![maven](/imgs/java/maven3.png)<br>
4. 配置本地maven仓库，配置好后，后续项目中用到的包就会保存在此处，其它新项目使用包时会优先从这里下载。<br>
![maven](/imgs/java/maven4.png)<br>
5. 配置远程仓库镜像，主要配置阿里巴巴，提高依赖包下载速度。局域网的地址也可以配置在里<br>面。
![maven](/imgs/java/maven5.png)<br>
### Maven依赖
1. Maven主要处理项目中包的依赖，版本控制，对所有依赖的包进行统一管理
  - 新建项目时会优先从本地仓库中下载依赖包，速度最快。
  - 如果本地仓库没有，会从局域网中下载依赖包到本地仓库，速度很快。
  - 如果局域网仓库没有，会从远程仓库下载依赖包到本地仓库，速度一般。
2. 安装本地jar包
~~~ bat
mvn install:install-file -Dpackaging=jar -DgroupId=com.oracle -DartifactId=ojdbc6 -Dfile=F:\Source\Java\ToolSiteMvc4J\trunk\lib\ojdbc6.jar -Dversion=11.2.0.3.0
~~~
  - 安装好后，此包就在我们本地仓库中了，就可以正常使用<br>
![maven](/imgs/java/maven6.png)<br>
  - 直接引用本地包，直接在pom插件中添加如下<br>
![maven](/imgs/java/maven7.png)<br>
或者<br>
![maven](/imgs/java/maven8.png)<br>
### Maven构建
1. Web程序打包
~~~ bat
mvn install
mvn clean install -DskipTests -P development
~~~
2. Jar包程序打包，配置main函数入口和lib依赖包
  - 配置main函数入口<br>
![maven](/imgs/java/maven9.png)<br>
  - 将依赖包放入lib文件夹中<br>
![maven](/imgs/java/maven10.png)<br>
### 相关命令
~~~ bat
mvn clean install -DskipTests –P development
clean 先清理，如target
install安装jar包。将项目的jar包安装到本地仓库。
–DskipTests不执行测试用例，但编译测试用例类生成相应的class文件至target/test-classes下。
-Dmaven.test.skip=true，不执行测试用例，也不编译测试用例类。
–P development使用development配置文件
~~~