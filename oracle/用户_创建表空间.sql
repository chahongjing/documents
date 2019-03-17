-- 当前用户表空间
select username,default_tablespace from user_users;
-- 创建表空间
create tablespace LIBRA_test
logging
datafile 'E:\db_home1\LIBRA_test.dbf'
size 32m
autoextend on
next 32m maxsize 2048m
extent management local;
-- 删除表空间
-- drop tablespace LIBRA_test;
-- 查询当前用户表空间
-- select username,default_tablespace from user_users;

-- 查询当前实例
show parameter instance
-- 查询当前实例名
select * from v$database
-- 当前用户表空间
select * from dba_users where upper(username) = upper('LIBRA2_DEV');
-- 所有表空间
select * from v$tablespace;