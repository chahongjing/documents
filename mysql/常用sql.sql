-- 分页选取第6条到第15条，5表示偏移量，索引从0开始，10表示10条记录
SELECT * FROM table LIMIT 5,10
-- 特殊字段
SELECT * FROM MYTABLE WHERE `MY-ID` = 1;