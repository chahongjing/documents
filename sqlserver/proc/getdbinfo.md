~~~ sql
 DECLARE @ParaDateLimited AS DATETIME
 SET @ParaDateLimited = '2013-6-22 0:00:00'
 IF EXISTS ( SELECT *
             FROM   tempdb..sysobjects
             WHERE  id = OBJECT_ID('tempdb..#DBAccessInfo') ) 
    DROP TABLE [#DBAccessInfo] ;
 IF EXISTS ( SELECT *
             FROM   tempdb..sysobjects
             WHERE  id = OBJECT_ID('tempdb..#DBFileInfo') ) 
    DROP TABLE [#DBFileInfo] ;
 IF EXISTS ( SELECT *
             FROM   tempdb..sysobjects
             WHERE  id = OBJECT_ID('tempdb..#DBInfo') ) 
    DROP TABLE [#DBInfo] ;
 CREATE TABLE tempdb..#DBAccessInfo
    (
      [DBID] INT ,
      [数据库名称] SYSNAME ,
      [最近访问时间] DATETIME
    )
 CREATE TABLE tempdb..#DBFileInfo
    (
      [DBID] INT ,
      [文件路径] NVARCHAR(300) ,
      [大小] NVARCHAR(50) ,
      [文件类型] NVARCHAR(50)
    )
 CREATE TABLE tempdb..#DBInfo
    (
      [SortNo] INT ,
      [database_id] INT ,
      [name] NVARCHAR(300)
    )
 SET NOCOUNT ON
 DECLARE @dbName SYSNAME ,
    @DBID INT ,
    @count AS INTEGER ,
    @index AS INT
 DECLARE @sql NVARCHAR(4000)
 INSERT INTO tempdb..#DBInfo
        SELECT  ROW_NUMBER() OVER ( ORDER BY name ) AS [SortNo] ,
                [database_id] ,
                [name]
        FROM    sys.databases
        WHERE   [name] NOT IN ( 'master', 'tempdb', 'model', 'msdb' )
                AND state = 0
                AND source_database_id IS NULL
        ORDER BY name
 SELECT @count = COUNT(*)
 FROM   #DBInfo
 SET @index = 1
 WHILE @index <= @count 
    BEGIN
        SELECT  @dbName = name ,
                @DBID = [database_id]
        FROM    tempdb..#DBInfo
        WHERE   SortNo = @index
        SET @sql = N'USE [' + @dbName
            + ']; SET NOCOUNT ON DECLARE @LastAccessTime AS DATETIME SELECT @LastAccessTime = MAX([LastAccessTime]) FROM ( SELECT MAX(modify_date) AS [LastAccessTime] FROM sys.objects UNION ALL SELECT MAX(last_user_seek) AS [LastAccessTime] FROM sys.dm_db_index_usage_stats WHERE DATABASE_ID=DB_ID('''
            + @dbName
            + ''') UNION ALL SELECT MAX(last_user_scan) AS [LastAccessTime] FROM sys.dm_db_index_usage_stats WHERE DATABASE_ID=DB_ID('''
            + @dbName
            + ''') UNION ALL SELECT MAX(last_user_lookup) AS [LastAccessTime] FROM sys.dm_db_index_usage_stats WHERE DATABASE_ID=DB_ID('''
            + @dbName
            + ''') UNION ALL SELECT MAX(last_user_update) AS [LastAccessTime] FROM sys.dm_db_index_usage_stats WHERE DATABASE_ID=DB_ID('''
            + @dbName + ''')) T INSERT INTO tempdb..#DBAccessInfo VALUES('
            + CAST(@DBID AS NVARCHAR(50)) + ',''' + @dbName
            + ''',@LastAccessTime);	 INSERT INTO tempdb..#DBFileInfo SELECT DB_ID(),physical_name AS [文件路径],CAST(CEILING(size*8/1024.0) AS VARCHAR(50)) + ''MB'' AS [大小], CASE type_desc WHEN ''ROWS'' THEN ''数据'' WHEN ''LOG'' THEN ''日志'' WHEN ''FULLTEXT'' THEN ''全文索引'' ELSE ''未知'' END AS [文件类型] FROM SYS.database_files ORDER BY NAME'
        EXEC (@sql)
        SET @index = @index + 1
    END
 IF @ParaDateLimited IS NULL 
    SELECT  a.数据库名称 ,
            CONVERT(VARCHAR(10), a.最近访问时间, 120) AS '最近访问时间' ,
            b.文件路径 ,
            b.大小
    FROM    tempdb..#DBAccessInfo a
            LEFT JOIN tempdb..#DBFileInfo b ON a.DBID = b.DBID
                                               AND b.文件类型 = '数据'
    WHERE   b.文件路径 IS NOT NULL
    ORDER BY a.最近访问时间 ASC
 ELSE 
    SELECT  a.数据库名称 ,
            CONVERT(VARCHAR(10), a.最近访问时间, 120) AS '最近访问时间' ,
            b.文件路径 ,
            b.大小
    FROM    tempdb..#DBAccessInfo a
            LEFT JOIN tempdb..#DBFileInfo b ON a.DBID = b.DBID
                                               AND b.文件类型 = '数据'
    WHERE   a.最近访问时间 <= @ParaDateLimited
            AND b.文件路径 IS NOT NULL
    ORDER BY a.最近访问时间 ASC
~~~