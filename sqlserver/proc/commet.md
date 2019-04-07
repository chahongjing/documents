~~~ sql
IF(OBJECT_ID('usp_SetTableReference', 'P')IS NOT NULL)
BEGIN
  DROP PROC [DBO].[usp_SetTableReference];
END
GO
CREATE PROC [DBO].[usp_SetTableReference]
(
  @TableName NVARCHAR(200), 
  @Reference NVARCHAR(500)
)
AS
BEGIN
  SELECT *
    FROM sys.objects AS A
    LEFT JOIN sys.extended_properties AS B ON A.object_id = B.major_id AND B.minor_id = 0 AND B.class = 1
   WHERE A.object_id = OBJECT_ID(@TableName, 'U')
 
  IF(@@ROWCOUNT > 0)
  BEGIN
    EXEC sys.sp_updateextendedproperty @name = N'MS_Description', @value = @Reference, @level0type = N'SCHEMA', @level0name = N'dbo', 
         @level1type = N'TABLE', @level1name = @TableName
  END
  ELSE
  BEGIN
    EXEC sys.sp_addextendedproperty @name = N'MS_Description', @value = @Reference, @level0type = N'SCHEMA', @level0name = N'dbo', 
         @level1type = N'TABLE', @level1name = @TableName
  END
  
END
-- EXEC [DBO].[usp_SetTableReference]
GO
IF(OBJECT_ID('usp_SetColumnReference', 'P')IS NOT NULL)
BEGIN
  DROP PROC [DBO].[usp_SetColumnReference];
END
GO
CREATE PROC [DBO].[usp_SetColumnReference]
(
  @TableName NVARCHAR(200), 
  @FieldName NVARCHAR(200), 
  @Reference NVARCHAR(500)
)
AS
BEGIN
  SELECT *
    FROM sys.objects AS A
    LEFT JOIN sys.columns AS B ON A.object_id = B.object_id
    LEFT JOIN sys.extended_properties AS C ON A.object_id = C.major_id AND B.column_id = C.minor_id
   WHERE A.object_id = OBJECT_ID(@TableName, 'U')
     AND B.Name = @FieldName

  IF(@@ROWCOUNT > 0)
  BEGIN
    EXEC sys.sp_updateextendedproperty @name = N'MS_Description', @value = @Reference, @level0type = N'SCHEMA', @level0name = N'dbo',
         @level1type = N'TABLE', @level1name = @TableName, @level2type = N'COLUMN', @level2name = @FieldName
  END
  ELSE
  BEGIN
    EXEC sys.sp_addextendedproperty @name = N'MS_Description', @value = @Reference, @level0type = N'SCHEMA', @level0name = N'dbo',
         @level1type = N'TABLE', @level1name = @TableName, @level2type = N'COLUMN', @level2name = @FieldName
  END
  
END
-- EXEC [DBO].[usp_SetColumnReference]
GO

~~~