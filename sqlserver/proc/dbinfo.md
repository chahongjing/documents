~~~ sql
IF(OBJECT_ID('usp_getDatabaseInfo', 'P')IS NOT NULL)
BEGIN
  DROP PROC usp_getDatabaseInfo;
END
GO
CREATE PROC usp_getDatabaseInfo
AS
BEGIN
  DECLARE @index AS INT, @count AS INT, @DbId INT
  DECLARE @DbName AS VARCHAR(500), @sql AS VARCHAR(MAX)
  
  CREATE TABLE #DbFileInfo
  (
    database_id INT,
    filePath NVARCHAR(300),
    fileSize NVARCHAR(50),
    fileType NVARCHAR(50)
  )
  
  SELECT ROW_NUMBER() OVER (ORDER BY name) AS [SortNo], [database_id], [name]
    INTO #tblDB
    FROM sys.databases
   WHERE [name] NOT IN ('master', 'tempdb', 'model', 'msdb')
     AND state = 0
     AND source_database_id IS NULL
   ORDER BY name

  SELECT @count = COUNT(*)
    FROM #tblDB
  SET @index = 1

  SET @sql = ''
  WHILE(@index <= @count)
  BEGIN
    SELECT @DbName = name,
           @DbId = [database_id]
      FROM #tblDB
     WHERE SortNo = @index
    
    SET @sql = N'USE [' + @dbName + ']; SET NOCOUNT ON;' + 
'INSERT INTO #DbFileInfo(database_id, filePath, fileSize, fileType)
 SELECT DB_ID() AS database_id, physical_name AS filePath,
        CAST(CEILING(size * 8 / 1024.0) AS VARCHAR(50)) + ''MB'' AS fileSize,
        CASE type_desc WHEN ''ROWS'' THEN ''数据''
                       WHEN ''LOG'' THEN ''日志''
                       WHEN ''FULLTEXT'' THEN ''全文索引''
                       ELSE ''未知'' END AS fileType
   FROM SYS.database_files
  ORDER BY NAME;'
    EXEC(@sql)
    SET @index = @index + 1
  END

  SELECT A.database_id, A.filePath, A.fileSize, A.fileType, B.name
    FROM #DbFileInfo AS A
   INNER JOIN #tblDB AS B ON A.database_id = B.database_id
   WHERE A.fileType = '数据'
   ORDER BY B.name

  DROP TABLE #tblDB;
  DROP TABLE #DbFileInfo;
END
-- EXEC usp_getDatabaseInfo
GO
~~~