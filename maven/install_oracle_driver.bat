:: 如果bat和jar包在同一目录 -Dfile可以直接写包名，如-Dfile=ojdbc6.jar；如果写路径，注意路径中汉字，有可能会有乱码问题
:: jar包位置一般在oracle安装目录中dbhome/jdbc/lib/ojdbc6.jar
start "安装jar包" mvn install:install-file -Dpackaging=jar -DgroupId=com.oracle -DartifactId=ojdbc6 -Dfile=F:\Source\Java\ToolSiteMvc4J\trunk\lib\ojdbc6.jar -Dversion=11.2.0.3.0