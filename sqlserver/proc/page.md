~~~ sql
-- 翻页存储过程
IF(OBJECT_ID('usp_Page', 'P')IS NOT NULL)
BEGIN
  DROP PROC usp_Page;
END
GO
CREATE PROC usp_Page
(
  @PK NVARCHAR(50),
  @Fields NVARCHAR(2000),
  @Tables NVARCHAR(500),
  @Filter NVARCHAR(1000),
  @OrderBy NVARCHAR(100),
  @Page INT,
  @PageSize INT
)
AS
BEGIN
  DECLARE @Sql AS NVARCHAR(MAX)
  
  IF(@PK = '' OR @Fields = '' OR @Tables = '')
  BEGIN
    RETURN
  END
  
  IF(@Filter = '')
  BEGIN
    SET @Filter = '1 = 1'
  END
  
  IF(@OrderBy = '')
  BEGIN
    SET @OrderBy = @PK
  END
  
  IF(@Page < 1)
  BEGIN
    SET @Page = 1
  END
  IF(@PageSize < 1)
  BEGIN
    SET @PageSize = 1
  END
  
  SET @Sql = '' +
'SELECT TOP (' + CAST(@Page * @PageSize AS NVARCHAR(10))+ ') * 
   FROM (SELECT ' + @Fields + ' FROM ' + @Tables + ') AS A 
  WHERE ' + @Filter + ' 
    AND ' + @PK + ' NOT IN(SELECT TOP (' + CAST((@Page - 1) * @PageSize AS NVARCHAR(10)) + ') ' + @PK + ' 
                             FROM (SELECT ' + @Fields + ' FROM ' + @Tables + ') AS B 
                            WHERE ' + @Filter + ' 
                            ORDER BY ' + @OrderBy + ') 
  ORDER BY ' + @OrderBy
  
  PRINT(@sql)
  EXEC(@Sql)
END
-- EXEC usp_Page 'SecondDiscussGuid', 'A.BlogGuid, B.FirstDiscussGuid, C.SecondDiscussGuid, C.Content', 'dbo.MicroBlog AS A INNER JOIN dbo.FirstDiscuss AS B ON A.BlogGuid = B.BlogGuid INNER JOIN dbo.SecondDiscuss AS C ON B.FirstDiscussGuid = C.FirstDiscussGuid', 'Content LIKE ''%a%''', 'CAST(Content AS VARCHAR(8000))', 2, 4
GO
~~~