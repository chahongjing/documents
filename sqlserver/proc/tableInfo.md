~~~ sql
IF(OBJECT_ID('usp_GetTableDataSql', 'P')IS NOT NULL)
BEGIN
  DROP PROC usp_GetTableDataSql;
END
GO
CREATE PROC usp_GetTableDataSql
(
  @tableName NVARCHAR(100)
)
AS
BEGIN
  DECLARE @fields AS NVARCHAR(4000)
  DECLARE @values AS NVARCHAR(4000)

  SET @fields = ''
  SET @values = ''

  SELECT @fields = @fields + '[' + name + '], ', @values = @values + cols + ' + '', '' + '
    FROM (SELECT CASE WHEN xtype IN (48, 52, 56, 59, 60, 62, 104, 106, 108, 122, 127) -- 数字
                      THEN 'CASE WHEN ' + name + ' IS NULL THEN ''NULL'' ELSE CAST(' + name + ' AS NVARCHAR(100)) END'
                      WHEN xtype IN (36) -- uniqueidentifier
                      THEN 'CASE WHEN ' + name + ' IS NULL THEN ''NULL'' ELSE ''N'''''' + CAST(' + name + ' AS NVARCHAR(36)) + '''''''' END'
                      WHEN xtype IN (167) -- varchar
                      THEN 'CASE WHEN ' + name + ' IS NULL THEN ''NULL'' ELSE ''N'''''' + REPLACE(' + name + ', '''''''', '''''''''''') + '''''''' END'
                      WHEN xtype IN (231) -- sysname
                      THEN 'CASE WHEN ' + name + ' IS NULL THEN ''NULL'' ELSE ''N'''''' + REPLACE(' + name + ', '''''''', '''''''''''') + '''''''' END'
                      WHEN xtype IN (175) -- char
                      THEN 'CASE WHEN ' + name + ' IS NULL THEN ''NULL'' ELSE ''N'''''' + CAST(REPLACE(' + name + ', '''''''', '''''''''''') AS CHAR(' + CAST(length AS NVARCHAR) + ')) + '''''''' END'
                      WHEN xtype IN (239) -- nchar
                      THEN 'CASE WHEN ' + name + ' IS NULL THEN ''NULL'' ELSE ''N'''''' + CAST(REPLACE(' + name + ', '''''''', '''''''''''') AS CHAR(' + CAST(length AS NVARCHAR) + ')) + '''''''' END'
                      WHEN xtype IN (58, 61) -- smalldatetime, datetime
                      THEN 'CASE WHEN ' + name + ' IS NULL THEN ''NULL'' ELSE ''N'''''' + CONVERT(NVARCHAR(20), ' + name + ', 120) + '''''''' END'
                      ELSE '''NULL'''
                      END AS cols, name
            FROM syscolumns
           WHERE id = OBJECT_ID(@tablename)
          ) T
  SET @fields = 'SELECT ''TRUNCATE TABLE ['+ @tableName + '];'' UNION ALL SELECT ''INSERT INTO ['+ @tableName + '](' + LEFT(@fields, LEN(@fields) - 1) + ') VALUES ('' + ' +
                LEFT(@values, len(@values) - 5) + ');'' FROM ' + @tableName + ' UNION ALL SELECT ''GO'';'
  -- PRINT(@fields)
  EXEC(@fields)
END
-- EXEC usp_GetTableDataSql 'zjyuser'
GO
~~~