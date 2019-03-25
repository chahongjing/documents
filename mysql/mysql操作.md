- [创建数据库](#创建数据库)
- [修改数据库编码](#修改数据库编码)
- [创建用户](#创建用户)
- [修改密码](#修改密码)
- [删除用户](#删除用户)
- [授权](#授权)
- [其它](#其它)
# 数据库
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