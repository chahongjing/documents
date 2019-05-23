### 查看当前数据库信息
1. 数据库名。数据库在安装时候的名称。如ORCL。
~~~ sql
select name from v$database; 
-- 或
show parameter db;
~~~
2. 数据库实例名。如ORCL。
~~~ sql
select instance_name from v$instance;
-- 或
show parameter instance;
~~~
3. 数据库域名。如4.0.11。
~~~ sql
select value from v$parameter where name = 'db_domain';
-- 或
show parameter domain;
~~~
4. 全局数据库名=数据库名+数据库域名，ORCL.1.0.11;
5. 数据库服务名。
~~~ sql
select value from v$parameter where name = 'service_name';
-- 或
show parameter service_name;
~~~
6. 一般情况下我们开发中用到的数据库是单数据库实例，就是oracle中只有一个库。这个时候大部分都有：数据库服务名 = 全局数据库名 = 数据库名[+ 数据库域名] = SID

### 配置监听
1. 文件位置（product\11.2.0\dbhome_1\NETWORK\ADMIN）。
2. listener.ora和tnsnames.ora文件中的host改成oracle数据库服务器地址，如果是本地则为127.0.0.1。
3. listerner.ora中SID_LIST_LISTENER添加新的listener
~~~ ini
(SID_DESC =
  (GLOBAL_DBNAME = ORCL)
  (ORACLE_HOME = /app/oracle/oracle/product/10.2.0/db_1)
  (SID_NAME = ORCL)
)
~~~
修改后：<br>
![oracle](/imgs/oracle/oracle1.png)<br>
4. 重启监听服务。

### 使用net manager配置监听和服务
1. 打开net manager<br>
![oracle](/imgs/oracle/oracle2.png)<br>
2. 监听程序为监听服务，可添加或删除。
  - 添加监听<br>
![oracle](/imgs/oracle/oracle3.png)<br>
  - 添加地址<br>
![oracle](/imgs/oracle/oracle4.png)<br>
  - 输入主机和端口（如果其它电脑想通过ip访问oracle，则必须在此配置一个地址和端口）<br>
![oracle](/imgs/oracle/oracle5.png)<br>
  - 添加监听的数据库服务<br>
![oracle](/imgs/oracle/oracle6.png)<br>
  - Oracle主目录为oracle服务端安装目录下的目录，此目录下有个bin文件夹。SID为安装数据库时填写的全局实例名，如ORCL<br>
![oracle](/imgs/oracle/oracle7.png)<br>
  - 添加完成后保存配置<br>
![oracle](/imgs/oracle/oracle8.png)<br>
  - 打开服务，重启监听服务。<br>
![oracle](/imgs/oracle/oracle9.png)<br>
![oracle](/imgs/oracle/oracle10.png)<br>
3. 服务命名为所有服务名列表(service_name)，可添加和删除。
  - 添加服务名<br>
![oracle](/imgs/oracle/oracle11.png)<br>
  - 选择tcp/ip协议<br>
![oracle](/imgs/oracle/oracle12.png)<br>
  - 主机名为oracle数据库服务器地址，一般为本机，端口1521。<br>
![oracle](/imgs/oracle/oracle13.png)<br>
  - 服务名为安装数据库时添加的数据库实例名，如orcl。<br>
![oracle](/imgs/oracle/oracle14.png)<br>
  - 测试服务是否可用<br>
![oracle](/imgs/oracle/oracle15.png)<br>
  - 连接成功后点完成。<br>
![oracle](/imgs/oracle/oracle16.png)<br>
![oracle](/imgs/oracle/oracle17.png)<br>
  - 添加完成后保存配置<br>
![oracle](/imgs/oracle/oracle18.png)<br>
  - 重启数据库实例服务和监听服务<br>
![oracle](/imgs/oracle/oracle19.png)<br>
  - 测试连接<br>
![oracle](/imgs/oracle/oracle20.png)<br>

### 登录sqlplus
1. `sqlplus /nolog`进行本地登录，此时并没有真正登录，不能执行数据库相关操作。
2. `sqlplus / as sysdba`，本地计算机模式登录，超级管理员，若登录不上可考虑进入服务端目录打命令，因为很可能是安装了客户端导致环境变量被覆盖引起。
3. `sqlplus 用户名/密码 as sysdba`；使用管理员登录，普通人员登录不需要`as sysdba`。
4. `sqlplus sys/pwd@127.0.0.1:1521/orcl as sysdba`。
5. 使用管理员创建新用户：
~~~ sql
-- 创建新用户
CREATE USER newusername IDENTIFIED BY newuserpassword
DEFAULT TABLESPACE LIBRA
TEMPORARY TABLESPACE TEMP;
GRANT DBA TO newusername WITH ADMIN OPTION;
GRANT CONNECT TO newusername WITH ADMIN OPTION;
~~~
6. 修改用户密码。使用管理员登录后执行
~~~ sql
SQL> alter user username identified by newpassword。
~~~