### 表备份和还原
~~~ sql
-- 要求目标表Table2必须存在，并且字段field,field2...也必须存在, 注意Table2的主键约束，如果Table2有主键而且不为空，则 field1， field2...中必须包括主键,注意语法，不要加values，和插入一条数据的sql混了
Insert into Table2(field1,field2,...) select value1,value2,... from Table1
-- 要求目标表Table2不存在，因为在插入时会自动创建表Table2，并将Table1中指定字段数据复制到Table2中。
SELECT vale1, value2 into Table2 from Table1
~~~
# 常用操作
~~~ sql
ALTER TABLE dbo.UserInfo ADD column1 NVARCHAR(20)
ALTER TABLE dbo.UserInfo ALTER COLUMN column1 INT
ALTER TABLE dbo.UserInfo DROP COLUMN column1

DECLARE @cur CURSOR FOR SELECT UserName FROM dbo.UserInfo
OPEN @cur
FETCH NEXT FROM @cur INTO @UserName

SELECT CAST(123.456 AS DECIMAL(18, 2))
~~~
# split
~~~ sql
CREATE FUNCTION fn_split(@strInput VARCHAR(200), @charMark VARCHAR(1))
RETURNS @tab TABLE(resultItem VARCHAR(200))
AS
BEGIN

    DECLARE @subStr VARCHAR(200)
    DECLARE @tempStr VARCHAR(200)

    SET @subStr = @strInput

    WHILE CHARINDEX(@charMark, @subStr) > 0
    BEGIN
        SET @tempStr = SUBSTRING(@subStr, 1, CHARINDEX(@charMark, @subStr) - 1)
        IF @tempStr <> ''
        BEGIN
            INSERT INTO @tab VALUES(@tempStr)
        END
        SET @subStr = SUBSTRING(@subStr, CHARINDEX(@charMark, @subStr) + 1, LEN(@subStr))
    END

    IF @subStr <> ''
    BEGIN
        INSERT INTO @tab VALUES(@subStr)
    END

    RETURN
END
~~~
# 基本
~~~ sql
SELECT ROW_NUMBER() OVER(ORDER BY '字段') AS id
-- 建表  Id INT IDENTITY(1, 1)

select nullif(1, 1)

SELECT COLUMN_NAME as 标识 FROM INFORMATION_SCHEMA.columns 
WHERE TABLE_NAME='bug2' AND COLUMNPROPERTY(OBJECT_ID('bug2'),COLUMN_NAME,'IsIdentity')=1 

SELECT (SELECT TOP 10 '>' + username from myuser FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(2000)')


-- #TABLE 本地临时表
-- ##TABLE  全局临时表

IF(NOT EXISTS(SELECT * FROM dbo.syscolumns WHERE name = 'UserName' AND id = OBJECT_ID('myUser', 'V')))
BEGIN
    ALTER TABLE myUser ADD 'e' VARCHAR(20)
END

-- 添加索引
IF(NOT EXISTS(SELECT * FROM sys.indexes WHERE name = N'ind_Khinfo'))
BEGIN
  CREATE NONCLUSTERED INDEX ind_Khinfo ON [dbo].[yx_KhInfo] ([BuGUID])
  INCLUDE ([KHGUID],[FullName],[ZbSortItemGUID],[YZbSortItemGUID],[QySortItemGUID],[YQySortItemGUID],[ForDelete])
END

SELECT B.name
  FROM syscolumns AS A
 INNER JOIN sysobjects AS B ON A.cdefault = B.Id
 WHERE A.id = OBJECT_ID('temp')--表名
   AND A.name = 'columns_A'--字段名
   AND B.name LIKE 'DF%'

--查找含有字段、表 的视图，函数，存储过程
SELECT *
  FROM sys.sysobjects AS A 
  LEFT JOIN sys.sql_modules AS B ON A.id = B.object_id 
 WHERE definition LIKE '%nk_Customer%'
   --AND a.type = 'V'

SELECT 'DELETE FROM dotnet_erp252.dbo.' + name + ';
'
  FROM sys.sysobjects AS A 
  LEFT JOIN sys.sql_modules AS B ON A.id = B.object_id 
 WHERE name LIKE 'p_cwjk%' FOR XML PATH('')

-- 查询包含字段的表
SELECT A.[name]
  FROM sysobjects AS A
 INNER JOIN syscolumns AS B ON A.id = B.id
 WHERE B.name = 'UserName'
 ORDER BY A.[name]

-- 表中的所有字段
SELECT CASE WHEN LEN(A.ColumnNames) > 0 THEN SUBSTRING(A.ColumnNames, 1, LEN(A.ColumnNames) - 1) ELSE '' END AS ColumnNames
  FROM (SELECT '[' + B.Name + '], '
          FROM sysobjects AS A
         INNER JOIN syscolumns AS B ON A.id = B.id
         WHERE A.Name = 'ZjyUser'
           FOR XML PATH('')) AS A(ColumnNames)
-- exec sp_tables
-- select * from sys.tables

EXEC sp_addlinkedserver 'ItsmTest', '', 'SQLOLEDB', '10.5.34.2'
EXEC sp_addlinkedsrvlogin 'ItsmTest', false, null, 'myerpuser', 'ErpUser132546'

-- 查询表的触发器
SELECT TB.name AS TableName, TR.name AS TriggerName
  FROM Sysobjects AS TR
 INNER JOIN Sysobjects AS TB ON TR.parent_obj = TB.id
 WHERE TR.type = 'TR'
   AND TB.name = 'XQ'

-- 获取当前连接的IP
IF(OBJECT_ID('GetCurrentIP')IS NOT NULL)
BEGIN
  DROP FUNCTION GetCurrentIP;
END
GO
CREATE FUNCTION [dbo].[GetCurrentIP]
()
RETURNS VARCHAR(255)
AS
BEGIN
  DECLARE @IP AS VARCHAR(255);
  
  SELECT @IP = client_net_address
    FROM sys.dm_exec_connections
   WHERE Session_id = @@SPID;
   
  Return @IP;
END

CREATE TRIGGER 触发器名字 
ON 表名 FOR INSERT 
AS 

DECLARE @isMember VARCHAR(20), @Price MONEY, @ID INT 

SELECT @isMember = 是否是会员, @Id = 编号 FROM INSERTED 
IF (@isMember='是') 
UPDATE 表名 SET 金额=500 WHERE 编号=@ID 
ELSE 
UPDATE 表名 SET 金额=1000 WHERE 编号=@ID
GO

SELECT RowNumber, Code
  FROM (SELECT ROW_NUMBER() OVER (ORDER BY Code) AS RowNumber, CONVERT(INT, SUBSTRING(Code, LEN(Code) - 3, 4)) AS Code
          FROM np_SDBaseInfo) AS A
 WHERE RowNumber <> A.Code
 ORDER BY RowNumber, Code
~~~
# 运行的IO情况
~~~ sql
DBCC DROPCLEANBUFFERS;
SET STATISTICS IO ON;
SELECT orderid, custid, empid, shipperid, orderdate, filler
FROM Orders
WHERE orderdate >= '20060101'
AND orderdate < '20060201';
SET STATISTICS IO OFF;
~~~
# 查询的纯CPU时间和实际经过时间
~~~ sql
DBCC DROPCLEANBUFFERS;
DBCC FREEPROCCACHE;
SET STATISTICS TIME ON;
SELECT orderid, custid, empid, shipperid, orderdate, filler
FROM Orders
WHERE orderdate >= '20060101'
AND orderdate < '20060201';
SET STATISTICS TIME OFF;
~~~