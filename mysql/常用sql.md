- [连接更新](#连接更新)
- [创建表](#创建表)
# 连接更新
~~~ sql
UPDATE T1, T2,
 INNER JOIN T1 ON T1.C1 = T2. C1
   SET T1.C2 = T2.C2, T2.C3 = expr
 WHERE condition;

-- 分页选取第6条到第15条，5表示偏移量，索引从0开始，10表示10条记录
SELECT * FROM table LIMIT 5,10
-- 特殊字段
SELECT * FROM MYTABLE WHERE `MY-ID` = 1;
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
