~~~ sql
--删除所有存储过程
IF OBJECT_ID('deleteAllProc') IS NOT NULL
BEGIN
  DROP PROC deleteAllProc
END
GO
CREATE PROC deleteAllProc
AS
BEGIN
  DECLARE @str VARCHAR(8000) 
  SELECT @str = ''
  SELECT @str = @str+ 'DORP PROC ' + name + ';' FROM SYSOBJECTS WHERE XTYPE IN('P') 
  --IN('P','V','FN','TF','U')存储过程，视图，函数，触发器,用户表
  PRINT @str -- 显示 
  EXEC(@str)
END
~~~