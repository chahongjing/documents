1.	java –version查看jdk版本
2.	jar –cvf ToolSiteMvc4J.war *，会把当前目录下所有文件打包成ToolSiteMvc4J.war包
3.	运行jar包。java -jar target/downloadQuestion.jar
4.	查看war包下文件。jar -tf ch02.war
5.	替换war包中某个class文件。jar –uf ToolSiteMvc4J.war WEB-INF/classes/org/sunxin/ch02/servlet/LoginServlet. class
# [反编译](http://www.mamicode.com/info-detail-2279328.html)