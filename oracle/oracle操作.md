- [oracle](#oracle)
  - [导出](#导出)
  - [导入](#导入)
- [用户](#用户)
  - [创建用户](#创建用户)
  - [创建表空间](#创建表空间)
- [查询表和字段](#查询表和字段)
- [oracle查询锁](#oracle查询锁)
- [修改数据库编码](#修改数据库编码)
- [导出前空表处理](#导出前空表处理)
# oracle
### 导出
~~~ bat
@echo off
title oracle export
set username=libra
set password=libra$20167
set host=127.0.0.1
set port=1521
set instance=orcl
set dmppath=d:\201803071715.dmp

rem set NLS_LANG=SIMPLIFIED CHINESE_CHINA.AL32UTF8
rem no data use: rows=n compress=n
set command=exp %username%/%password%@%host%:%port%/%instance% file=%dmppath%

echo.
echo %command%
echo.
echo.
%command%
pause;
~~~
### 导入
~~~ bat
@echo off
title oracle import
set username=libra
set password=libra$20167
set host=127.0.0.1
set port=1521
set instance=orcl
set dmppath=d:\201803071715.dmp

set command=imp %username%/%password%@%host%:%port%/%instance% file=%dmppath% full=y

echo.
echo %command%
echo.
echo.
%command%
pause;
~~~
# 用户
### 创建用户
~~~ sql
-- 创建用户
CREATE USER zjy IDENTIFIED BY 1024  DEFAULT TABLESPACE USERS  TEMPORARY TABLESPACE TEMP;
-- 授权
GRANT DBA TO zjy WITH ADMIN OPTION;
GRANT CONNECT TO zjy WITH ADMIN OPTION;

-- 关闭用户连接(用户名大写)
SELECT username, sid, serial# FROM v$session WHERE username = 'LIBRA';
ALTER system kill SESSION '133,8028';

-- 删除用户
DROP USER LIBRA_PRODUCTION CASCADE;
~~~
### 修改用户密码解锁用户
~~~ sql
-- 
SELECT username,profile FROM dba_users;
-- 查询profile信息，如profile为default
SELECT * FROM dba_profiles WHERE profile='DEFAULT' AND resource_name='PASSWORD_LIFE_TIME';
-- 修改为无限制
ALTER PROFILE DEFAULT LIMIT PASSWORD_LIFE_TIME UNLIMITED;

-- 解锁用户
ALTER USER 用户名 IDENTIFIED BY 原来的密码 ACCOUNT UNLOCK;
~~~
### 创建表空间
~~~ sql
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
~~~
# 查询表和字段
~~~ sql
-- 列名
SELECT LISTAGG('' || UPPER(A.COLUMN_NAME) || '', ', ') WITHIN GROUP(ORDER BY A.COLUMN_ID) AS columnNames
       -- wm_concat(LOWER(A.COLUMN_NAME)) as b
  FROM USER_TAB_COLS A
  JOIN USER_COL_COMMENTS B ON A.TABLE_NAME = B.TABLE_NAME AND A.COLUMN_NAME = B.COLUMN_NAME
 WHERE A.TABLE_NAME = UPPER('Tk_ShiTi')
 ORDER BY A.COLUMN_ID;

-- 查询包含字段的表
SELECT A.TABLE_NAME, B.Comments
  FROM USER_TAB_COLS A
  JOIN USER_TAB_COMMENTS B ON A.TABLE_NAME = B.TABLE_NAME
 WHERE UPPER(A.COLUMN_NAME) = UPPER('xuekeid');

-- 查询表信息
SELECT TABLE_NAME
  FROM USER_TABLES
 WHERE UPPER(TABLE_NAME) LIKE '%' || UPPER('ym_') || '%'
 ORDER BY TABLE_NAME;
~~~
# oracle查询锁
~~~ sql
-- 查询锁
select ('alter system kill session''' || temp.sid || ',' || temp.serial || ''';') as killSql, sid, serial, username, schemaname, osuser, process, machine, terminal, logon_time, type
  from (
        SELECT sess.sid, sess.serial# as serial, sess.username, sess.schemaname, sess.osuser, sess.process, sess.machine, sess.terminal, sess.logon_time, loc.type
          FROM v$session sess
         inner join v$lock loc on sess.sid = loc.sid
         inner join v$locked_object locObj on sess.sid = locObj.session_id 
         WHERE sess.username IS NOT NULL
       ) temp
 ORDER BY temp.sid;

-- 查某session 正在执行的sql语句，从而可以快速定位到哪些操作或者代码导致事务一直进行没有结束等.
SELECT /*+ ORDERED */ 
       sql_text
  FROM v$sqltext a
 WHERE (a.hash_value, a.address) IN
       (SELECT DECODE(sql_hash_value, 0, prev_hash_value, sql_hash_value),
               DECODE(sql_hash_value, 0, prev_sql_addr, sql_address)
          FROM v$session b
         WHERE b.sid = 71)  /* 此处67 为SID*/
 ORDER BY piece ASC;
~~~
# 修改数据库编码
~~~ sql
-- SELECT value$ FROM SYS.props$ WHERE NAME = 'NLS_CHARACTERSET';
SHUTDOWN IMMEDIATE; 
STARTUP MOUNT EXCLUSIVE; 
ALTER SYSTEM ENABLE RESTRICTED SESSION;
ALTER SYSTEM SET JOB_QUEUE_PROCESSES=0;
ALTER SYSTEM SET AQ_TM_PROCESSES=0;
ALTER DATABASE OPEN;
ALTER DATABASE CHARACTER SET INTERNAL_USE AL32UTF8;
-- 如果报错使用如下（AL32UTF8, ZHS16GBK）
-- ALTER DATABASE CHARACTER SET INTERNAL_USE ZHS16GBK;
SHUTDOWN IMMEDIATE;
STARTUP;
~~~
# 导出前空表处理
~~~ sql
set serveroutput on;
DECLARE 
  v_table tabs.table_name%TYPE; 
  v_sql VARCHAR2(888); 
  sqltemp VARCHAR2(200); 
  tabC int;
  v_q NUMBER; 
  CURSOR c1 IS 
  SELECT table_name tn FROM user_tables; 
  TYPE c IS REF CURSOR; 
  c2 c; 
BEGIN 
  DBMS_OUTPUT.PUT_LINE('以下为空数据表的表名:');
  tabC := 0;
  FOR r1 IN c1 LOOP 
    v_table :=r1.tn; 
    v_sql :='SELECT COUNT(*) q FROM '||v_table; 
    OPEN c2 FOR v_sql; 
    LOOP 
      FETCH c2 INTO v_q; 
      EXIT WHEN c2%NOTFOUND; 
      IF v_q=0 THEN
        sqltemp := 'alter table ' || v_table || ' allocate extent';	  
        DBMS_OUTPUT.PUT_LINE(sqltemp || ';');
        EXECUTE IMMEDIATE (sqltemp); 
        tabC := tabC + 1;
      END IF; 
    END LOOP; 
    CLOSE c2; 
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('已成功执行' || tabC || '个空表。');
  EXCEPTION 
  WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error occurred'); 
END;
~~~
#### 日期
- sql developer：工具-》首选项-》数据库-》NLS：日期格式（YYYY-MM-DD HH24:MI:SS）和时间戳格式（YYYY-MM-DD HH24:MI:SS.FF6）和时间戳时区格式
- select to_char(systimestamp,'YYYY-MM-DD HH24:MI:SS.FF6') as t, to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS') as m from dual;