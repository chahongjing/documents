# 从官网下载solr6.3.0文件
1. solr6.3发布版本本身就有一个可以运行的web版本，在solr-webapp下，如下图：<br>
![solr](/imgs/java/solr1.png)<br>
2. 将webapp拷贝出来，我这里是放到E:\kingdom\solr下面，并重命名为solr_web。
3. 在solr_web下面新建一个目录solrhome，并将E:\kingdom\solr\solr-6.3.0\server\solr下面的配置文件全部拷贝到solrhome下面,如图：<br>
![solr](/imgs/java/solr2.png)<br>
复制后的solrhome目录：<br>
![solr](/imgs/java/solr3.png)<br>
4. 将E:\kingdom\solr\solr-6.3.0\server\lib\ext下面的jar包拷贝到solr_web/WEB-INF/lib下面。
5. 复制server/resources下的log4j.properties到solr_web/WEB-INF/classes下面，如果没有classes目录，就新建classes目录。
6. 修改web.xml文件，关联到solr配置文件，这样在tomcat容器启动后，再启动solr服务器框架时，就会去读取这些配置文件，初始化solr框架。在web.xml中找到节点<env-entry>，默认是注释的，去掉注释。节点配置如下：节点名称solr/home，对应的值为:E:\kingdom\solr\solr_web\solrhome，这个值就是你的solr配置文件的存放路径。可自定义。修改后的web.xml如下：<br>
![solr](/imgs/java/solr4.png)<br>
7. 修改tomcat的配置文件server.xml，关联web工程<br>
![solr](/imgs/java/solr5.png)<br>
8. ok，一切就绪。输入http://127.0.0.1:8080/solr/index.html来访问看看。我的天，居然报错了，贴出来看看：<br>
![solr](/imgs/java/solr6.png)<br>
9. 报403错误，403一般都是没有权限。真是奇怪，为什么会报这个错误呢，我也是折腾了好一会。最后发现在web.xml中有这么一段配置：<br>
![solr](/imgs/java/solr7.png)<br>
10. 有个节点<auth-constraint />，这个配置表示拒绝所有对这个资源的访问。原来如此，把这段代码注释掉。将solrhome/configsets下的sample_techproducts_configs目录copy到solrhome文件夹中，并将拷出来的文件夹sample_techproducts_configs命名为cores,这时就可以在web页面上添加cores核心使用系统了。其中 核心/conf/managed-schema文件是查询字段配置文件<br>
![solr](/imgs/java/solr8.png)<br>
11. 重新运行看看。终于可以了。<br>
![solr](/imgs/java/solr9.png)<br>