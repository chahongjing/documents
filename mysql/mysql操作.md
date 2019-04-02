- [创建数据库](#创建数据库)
- [修改数据库编码](#修改数据库编码)
- [创建用户](#创建用户)
- [修改密码](#修改密码)
- [删除用户](#删除用户)
- [授权](#授权)
- [其它](#其它)
# 数据库
### 备份
- 备份表
~~~ sql
mysqldump -u root -p 1024 user > d:/user.sql
~~~
- 备份库
~~~ sql
mysqldump -u root -p 1024 --database mydatabase > d:/mydatabase.sql
~~~
- 备份全库
~~~ sql
mysqldump -u root -p 1024 --opt --all-databases > d:/alldatabase.sql
~~~
### 还原
- 还原表
~~~ sql
-- 将user表导到mydatabase库中
mysql -u root -p 1024 mydatabase < d:/user.sql
~~~
- 还原库
~~~ sql
-- 备份文件中已经包括完整的库信息，则导入操作时不需要指定库名
mysql -u root -p 1024 < d:/mydatabase.sql
~~~
### 创建数据库
~~~ sql
-- COLLATE utf8_general_ci不区分大小写；utf8_bin区分大小写
CREATE DATABASE db_name DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE db_name;
SHOW DATABASES;
~~~
### 修改数据库编码
~~~ sql
ALTER DATABASE db_name DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
~~~
### 创建用户
~~~ sql
CREATE USER 'dog'@'localhost' IDENTIFIED BY '123456';
~~~
### 修改密码
~~~ sql
SET PASSWORD FOR 'username'@'host' = PASSWORD('newpassword');
SET PASSWORD FOR 'pig'@'%' = PASSWORD("123456");
-- 如果是当前用户
SET PASSWORD = PASSWORD("newpassword");
~~~
### 删除用户
~~~ sql
DROP USER 'username'@'host';
~~~
### 授权
~~~ sql
GRANT privileges ON databasename.tablename TO 'username'@'host'
GRANT SELECT, INSERT ON test.user TO 'pig'@'%';
GRANT ALL ON *.* TO 'pig'@'%';
~~~
### 其它
- \g 的作用是分号和在sql语句中写’;’是等效的 
- \G 的作用是将查到的结构旋转90度变成纵向
### 日期
- 字符串转日期：SELECT DATE_FORMAT('2017-09-20 08:30:45', '%Y-%m-%d %H:%i:%S');
- 日期转字符串：SELECT DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i:%S');
[mysql日期操作](https://www.cnblogs.com/geaozhang/p/6740457.html)
### 常用数据类型
|类型|存储Bytes|最小|最大||
|-|-|-|-|-|
|bit||1|64|
|tinyint|1|-128|127|
|smallint|2|-32768|32767|
|mediumint|3|-8388608|8388607|
|int|4|-2147483648|2147483647|
|bigint|8|||
|DECIMAL和NUMERIC||||MySQL中视为相同|
|float|||
|double||
|char||||
|varchar|||||
|date||
|time|
|datetime||
|timestamp|
|year|