:: ���bat��jar����ͬһĿ¼ -Dfile����ֱ��д��������-Dfile=ojdbc6.jar�����д·����ע��·���к��֣��п��ܻ�����������
:: jar��λ��һ����oracle��װĿ¼��dbhome/jdbc/lib/ojdbc6.jar
start "��װjar��" mvn install:install-file -Dpackaging=jar -DgroupId=com.oracle -DartifactId=ojdbc6 -Dfile=F:\Source\Java\ToolSiteMvc4J\trunk\lib\ojdbc6.jar -Dversion=11.2.0.3.0