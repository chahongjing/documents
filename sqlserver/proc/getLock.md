~~~ sql
IF(OBJECT_ID('usp_WhoLock', 'P')IS NOT NULL)
BEGIN
  DROP PROC [DBO].[usp_WhoLock];
END
GO
CREATE PROC [DBO].[usp_WhoLock]
AS
BEGIN
  DECLARE @spid INT, @blk INT, @count INT, @index INT, @lock TINYINT
  SET @lock = 0
  
  CREATE TABLE #temp_who_lock(id INT IDENTITY(1, 1), spid INT, blk INT)
  
  IF(@@ERROR <> 0) RETURN @@ERROR
  
  INSERT INTO #temp_who_lock(spid, blk)
  SELECT 0, blocked
    FROM (SELECT * FROM MASTER.DBO.sysprocesses WHERE blocked > 0) AS A
   WHERE NOT EXISTS (SELECT * FROM MASTER.DBO.sysprocesses WHERE A.blocked = spid AND blocked > 0)
  UNION
  SELECT spid, blocked FROM MASTER.DBO.sysprocesses WHERE blocked > 0
  
  IF(@@ERROR <> 0) RETURN @@ERROR
  SELECT @count = COUNT(*), @index = 1 FROM #temp_who_lock
  IF(@@ERROR <> 0) RETURN @@ERROR
  
  IF(@count = 0)
  BEGIN
    SELECT '没有阻塞和死锁信息'
    RETURN 0
  END
  WHILE(@index <= @count)
  BEGIN
    IF EXISTS(SELECT 1 FROM #temp_who_lock AS A WHERE id > @index AND EXISTS (SELECT 1 FROM #temp_who_lock WHERE id <= @index AND a.blk = spid))
    BEGIN
      SET @lock = 1
      SELECT @spid = spid, @blk = blk FROM #temp_who_lock WHERE id = @index
      SELECT '引起数据库死锁的是: ' + CAST(@spid AS VARCHAR(10)) + '进程号,其执行的SQL语法如下'
      SELECT @spid, @blk
      DBCC INPUTBUFFER(@spid)
      DBCC INPUTBUFFER(@blk)
    END
    SET @index = @index + 1
  END
  
  IF(@lock = 0)
  BEGIN
    SET @index = 1
    WHILE @index <= @count
    BEGIN
      SELECT @spid = spid, @blk = blk FROM #temp_who_lock WHERE id = @index
      IF @spid = 0
        SELECT '引起阻塞的是:' + CAST(@blk AS VARCHAR(10)) + '进程号,其执行的SQL语法如下'
      ELSE
        SELECT '进程号SPID：' + CAST(@spid AS VARCHAR(10)) + '被进程号SPID：' + CAST(@blk AS VARCHAR(10)) + '阻塞,其当前进程执行的SQL语法如下'
      DBCC INPUTBUFFER(@spid)
      DBCC INPUTBUFFER(@blk)
      SET @index=@index + 1
    END
  END
  DROP TABLE #temp_who_lock
  RETURN 0
END
~~~