~~~ sql
DECLARE @count INT  
  DECLARE @date VARCHAR(24)  
  SET @date = getdate()  
  SET @count = 0  
    
  BEGIN TRANSACTION  
  BEGIN  
    ---插入数据到处理过程  
    INSERT INTO Itsm_ProcessReport(ProcessGUID, EventGUID, ProcessTime, ProcessContent, Hander,  
                                   Receiver, Remarks)  
    VALUES(NEWID(), @EventGUID, @date, @remarks, @Hb,  
           '', '')  
    SET @count = @count + @@ERROR  
  END  
  
  IF @count <> 0  
  BEGIN  
    ROLLBACK TRANSACTION  
    SELECT 'FAILED'  
  END  
  ELSE  
  BEGIN  
    COMMIT TRANSACTION  
    SELECT 'SUCCESS'  
  END  


CREATE TABLE #tbl(A INT)

BEGIN TRANSACTION
BEGIN
  INSERT INTO #tbl(A) VALUES(1)
END
INSERT INTO #tbl(A) VALUES(2)

COMMIT TRANSACTION

ROLLBACK TRANSACTION

SELECT * FROM #tbl

DELETE FROM #tbl
~~~