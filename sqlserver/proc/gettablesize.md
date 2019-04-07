~~~ sql
IF(OBJECT_ID('usp_GetDataBaseTableInfo', 'P')IS NOT NULL)
BEGIN
  DROP PROC usp_GetDataBaseTableInfo;
END
GO
CREATE PROC usp_GetDataBaseTableInfo
AS
BEGIN
  DECLARE @tblSpaceInfo AS TABLE(NameInfo VARCHAR(500), RowsInfo BIGINT, Reserved VARCHAR(20), DataInfo VARCHAR(20),
          IndexSize VARCHAR(20), UnUsed VARCHAR(20))
  DECLARE @tblTable AS TABLE(TableName VARCHAR(50), DataInfo BIGINT, RowsInfo BIGINT,
          SpacePerRow AS (CASE RowsInfo WHEN 0 THEN 0 ELSE CAST(DataInfo AS DECIMAL(18, 2)) / CAST(RowsInfo AS DECIMAL(18, 2)) END) PERSISTED)

  DECLARE @TableName VARCHAR(255);

  DECLARE Info_cursor CURSOR FOR SELECT '[' + [name] + ']' FROM sys.tables WHERE type = 'U';
  OPEN Info_cursor
  FETCH NEXT FROM Info_cursor INTO @TableName

  WHILE(@@FETCH_STATUS = 0)
  BEGIN
    INSERT INTO @tblSpaceInfo
    EXEC sp_spaceused @TableName
    FETCH NEXT FROM Info_cursor INTO @TableName
  END

  CLOSE Info_cursor
  DEALLOCATE Info_cursor

  -- 插入数据到临时表
  INSERT INTO @tblTable(TableName, DataInfo, RowsInfo)
  SELECT [NameInfo], CAST(REPLACE(DataInfo, 'KB', '') AS BIGINT) AS 'DataInfo', RowsInfo
    FROM @tblSpaceInfo
   ORDER BY CAST(REPLACE(Reserved, 'KB', '') AS INT) DESC

  -- 汇总记录
  SELECT A.NameInfo, A.RowsInfo, A.Reserved, A.DataInfo, A.IndexSize,
         A.UnUsed, B.SpacePerRow AS '每行记录大概占用空间（KB）'
    FROM @tblSpaceInfo AS A
   INNER JOIN @tblTable AS B ON A.NameInfo = B.TableName
   ORDER BY CAST(REPLACE(A.Reserved, 'KB', '') AS INT) DESC
END
-- EXEC usp_GetDataBaseTableInfo
GO
~~~