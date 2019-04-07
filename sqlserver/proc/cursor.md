~~~ sql
--使用
-- EXEC usp_Fkxt_UpdateWtCode

IF(OBJECT_ID('usp_Fkxt_UpdateWtCode') IS NOT NULL)
BEGIN
    DROP PROC usp_Fkxt_UpdateWtCode
END
GO
CREATE PROC usp_Fkxt_UpdateWtCode
AS
BEGIN
    DECLARE @guid AS UNIQUEIDENTIFIER
    DECLARE @WtCode AS VARCHAR(100)
    DECLARE @WtDate AS DATETIME
    DECLARE @intYear AS INT
    DECLARE @WtCodeMax AS VARCHAR(100)
    DECLARE @WtCodeTemp AS VARCHAR(100)
    DECLARE @strCpCode AS VARCHAR(100)
    DECLARE @intCode AS INT
    
    SELECT A.WtGUID,
           B.CpCode,
           A.WtDate
      INTO #tblQuestion
      FROM n_question AS A
      LEFT JOIN n_ProductType AS B ON A.TypeName = B.TypeName
     WHERE (WtCode IS NULL
            OR WtCode = ''
           )
           AND NOT (CpCode IS NULL
           OR CpCode = '')

    DECLARE MyCursor CURSOR	FOR SELECT WtGUID, CpCode, WtDate FROM #tblQuestion ORDER BY WtDate
    OPEN MyCursor
    FETCH NEXT FROM MyCursor INTO @guid, @strCpCode, @WtDate
    
    WHILE @@FETCH_STATUS = 0
	BEGIN
	    IF(@WtDate IS NULL)
	    BEGIN
	        @intYear = DATEPART(YEAR, GETDATE())
	    END
	    ELSE
	    BEGIN
	        @intYear = DATEPART(YEAR, @WtDate)
	    END
	    SET @WtCodeTemp = @strCpCode + CAST(@intYear AS VARCHAR(10))
		SELECT @WtCodeMax = ISNULL(MAX(WtCode), '') FROM n_question WHERE WtCode LIKE @WtCodeTemp + '%'
		
		IF(@WtCodeMax = '')
		BEGIN
		    SET @WtCode = @WtCodeTemp + '0001'
		END
		ELSE
		BEGIN
		    SET @WtCodeMax = REPLACE(@WtCodeMax, @WtCodeTemp, '')
		
		    IF(@WtCodeMax = '')
		    BEGIN
		        SET @WtCode = @WtCodeTemp + '0001'
		    END
		    ELSE
		    BEGIN
		        SET @intCode = CAST(@WtCodeMax AS INT) + 1
		        SET @WtCode = @WtCodeTemp + RIGHT('0000' + CAST(@intCode AS VARCHAR(10)), 4)
		    END
		END
		
		UPDATE n_question SET WtCode = @WtCode WHERE WtGUID = @guid
		FETCH NEXT FROM MyCursor INTO @guid, @strCpCode, @WtDate
	END
	
	CLOSE MyCursor
    DEALLOCATE MyCursor

END
~~~