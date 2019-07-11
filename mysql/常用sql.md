- [连接更新](#连接更新)
- [创建表](#创建表)
- [创建索引](#创建索引)
- [删除重复行只保留一行](#删除重复行只保留一行)
- [多字段in](#多字段in)
- [函数](#函数)
- [临时表](#临时表)
- [排名函数](#排名函数)
### 连接更新
~~~ sql
UPDATE T1, T2,
 INNER JOIN T1 ON T1.C1 = T2. C1
   SET T1.C2 = T2.C2, T2.C3 = expr
 WHERE condition;

-- 分页选取第6条到第15条，5表示偏移量，索引从0开始，10表示10条记录
SELECT * FROM table LIMIT 5,10
-- 特殊字段
SELECT * FROM MYTABLE WHERE `MY-ID` = 1;
-- 插入多条记录
insert into mytable(id, name) values (1, 'a'), (2, 'b'), (3, 'c');
~~~
### 创建表
~~~ sql
CREATE TABLE IF NOT EXISTS mytable(id INT, name VARCHAR(100)) COMMENT='表的注释';
-- 注释
ALTER TABLE COMMENT '修改后的表的注释';
-- 修改字段的注释
ALTER TABLE test1 MODIFY COLUMN field_name INT COMMENT '修改后的字段注释';
-- 查看表注释
SELECT * FROM TABLES WHERE TABLE_SCHEMA='my_db' AND TABLE_NAME='test1';
-- 查看字段注释的方法
SELECT * FROM COLUMNS WHERE TABLE_SCHEMA='my_db' AND TABLE_NAME='test1';
~~~
### 创建索引
~~~ sql
ALTER TABLE table_name ADD INDEX index_name (column_list);
CREATE INDEX index_name ON table_name (column_list);
~~~
### 删除重复行只保留一行
~~~ sql
create table test(id int, name varchar(100));

insert into test values(1, 'zjy');
insert into test values(2, 'zjy');
insert into test values(3, 'zjy');
insert into test values(4, 'aa');
insert into test values(5, 'aa');
-- 删除重复行，只保留一行
delete 
  from test
 where name in (select name from (select name from test group by name having count(*) > 1) tr)
   and id not in (select id from (select min(id) as id from test group by name having count(*) > 1) ti);
~~~
### 多字段in
~~~ sql
-- 多字段in
select * from test where (id, name) in ((1, 'zjy'));
~~~
### 函数
~~~ sql
-- 查找字符串中的位置，以逗号隔开，返回值从1开始
SELECT find_in_set(3, '1,2,3,4,5');
~~~
### 临时表
~~~ sql
-- 临时表
create temporary table tt as select * from test;
drop table tt;
~~~
### 排名函数
~~~ sql
-- mysql8新增特性
select pid, name, age,
       row_number() over (order by age) as rn,
       rank() over (order by age) as r,
       dense_rank() over (order by age) as dr
  from players
 order by age;

-- rownumber，序号
SET @curRank := 0;
SELECT pid, name, age, 
       curRank := @curRank + 1 AS myrank
  FROM players p, (SELECT @curRank := 0) q
 ORDER BY age;

-- rank，排名，同名序号相同，序号不连续，如1，1，3
SELECT pid, name, age, 
       CASE WHEN @prevRank = age THEN @curRank
			WHEN @prevRank := age THEN @curRank := @curRank + 1 END AS myrank
  FROM players p, (SELECT @curRank :=0, @prevRank := NULL) r
 ORDER BY age;
 
-- dense_rank，同名序号相同，序号连续，如1，1，2
SELECT pid, name, age, myrank
  FROM (SELECT pid, name, age, @curRank := IF(@prevRank = age, @curRank, @incRank) AS myrank,
               @incRank := @incRank + 1, @prevRank := age
          FROM players p, (SELECT @curRank :=0, @prevRank := NULL, @incRank := 1) r 
		ORDER BY age) s;

~~~
### 其它
~~~ sql
-- 可以连接多个参数
select CONCAT(str1, str2, str3);
select CONCAT_WS(separator, str1, str2, str3);
~~~