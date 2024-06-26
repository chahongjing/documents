- [连接更新](#连接更新)
- [创建表](#创建表)
- [创建索引](#创建索引)
- [删除重复行只保留一行](#删除重复行只保留一行)
- [多字段in](#多字段in)
- [函数](#函数)
- [临时表](#临时表)
- [排名函数](#排名函数)
### 连接更新
``` sql
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
```
### 创建表
``` sql
CREATE TABLE IF NOT EXISTS mytable(
  id bigint unsigned auto_increment primary key not null comment '主键',
  name varchar(20) not null default '' comment '名称',
  unique index idx_thread_quote(thread_id, quote_thread_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='表的注释';
-- 注释
ALTER TABLE tableName COMMENT '修改后的表的注释';
-- 修改字段的注释
ALTER TABLE test1 MODIFY COLUMN field_name INT COMMENT '修改后的字段注释';
-- 查看表注释
SELECT * FROM TABLES WHERE TABLE_SCHEMA='my_db' AND TABLE_NAME='test1';
-- 查看字段注释的方法
SELECT * FROM COLUMNS WHERE TABLE_SCHEMA='my_db' AND TABLE_NAME='test1';
```
### 创建索引
``` sql
ALTER TABLE table_name ADD INDEX index_name (column_list);
CREATE INDEX index_name ON table_name (column_list);
ALTER TABLE rp_work_order_meta ADD UNIQUE uk_workordernum(work_order_num);
```
### 删除重复行只保留一行
``` sql
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
```
### json & 虚拟列
```sql
create table abc(
  id int primary key,
  age int,
  extra json,
  v_n varchar(20) generated always as (json_unquote(json_extract(extra, '$.name'))),
  v_t int generated always as (json_unquote(json_extract(extra, '$.address.t'))),
  index idx_v_n(v_n)
);

insert into abc(id,age,extra)values(1,1,'{"name":"zjy","address":{"a":12, "t":34}}');

select abc.*, extra -> '$.address.t' from abc where extra -> '$.name' = 'zjy';
```
### 多字段in
``` sql
-- 多字段in
select * from test where (id, name) in ((1, 'zjy'));
```
### 函数
``` sql
-- 查找字符串中的位置，以逗号隔开，返回值从1开始
SELECT find_in_set(3, '1,2,3,4,5');
```
### 临时表
``` sql
-- 临时表
create temporary table tt as select * from test;
drop table tt;
```
### 排名函数
``` sql
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
```
### 插入或更新
``` sql
INSERT INTO table (a,b,c) VALUES (1,2,3)  
  ON DUPLICATE KEY UPDATE c = c + 1;  
-- a是唯一索引，如果已有一条值为1的数据，效果相当于如下语句
UPDATE table SET c = c + 1 WHERE a = 1;

-- 1. 如果发现表中已经有此行数据（根据主键或者唯一索引判断）则先删除此行数据，然后插入新的数据。 2. 否则，直接插入新数据。
-- 要注意的是：插入数据的表必须有主键或者是唯一索引！否则的话，replace into 会直接插入数据，这将导致表中出现重复的数据。
REPLACE INTO test(title,uid) VALUES ('1234657','1001');有可能主从切换后主键冲突。尽量使用on duplicate key update代替
```
### 其它
``` sql
-- 可以连接多个参数
select CONCAT(str1, str2, str3);
select CONCAT_WS(separator, str1, str2, str3);
```
### 表中的数据导出成sql
```sql
导出insert语句
mysqldump -h$host -P$port -u$user --add-locks --no-create-info --single-transaction  --set-gtid-purged=OFF db1 t --where="a>900" --result-file=/client_tmp/t.sql
如果你希望生成的文件中一条INSERT语句只插入一行数据的话，可以在执行mysqldump命令时，加上参数–skip-extended-insert。
导入sql：mysql -h127.0.0.1 -P13000  -uroot db2 -e "source /client_tmp/t.sql"
导出csv文件
select * from db1.t where a>900 into outfile '/server_tmp/t.csv';
导入csv
load data infile '/server_tmp/t.csv' into table db2.t;
```