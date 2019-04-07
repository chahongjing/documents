~~~ sql
IF(OBJECT_ID('FormatNumberToString')IS NOT NULL)
BEGIN
  DROP FUNCTION FormatNumberToString;
END
GO
CREATE FUNCTION FormatNumberToString
(
  -- 要处理的数字, 保留位数(0 - 15), 小数部分是否处理千分位
  @number DECIMAL(28, 15),
  @n INT,
  @flag TINYINT
)
RETURNS VARCHAR(100)
AS
BEGIN
  -- 返回数据, 整数部分, 小数部分
  DECLARE @strReturn VARCHAR(100)
  DECLARE @int VARCHAR(32)
  DECLARE @float VARCHAR(32)
  
  -- 处理小数部分临时变量
  DECLARE @strLeft AS VARCHAR(30)
  DECLARE @strTemp AS VARCHAR(50)
  
  -- 精度处理
  IF(@n > 15)
  BEGIN
    SET @N = 15
  END
  IF(@n < 0)
  BEGIN
    SET @n = 0
  END
  -- 是否处理小数千分位
  IF(@flag > 1 OR @flag < 0)
  BEGIN
    SET @flag = 0
  END
  
  -- 四舍五入, 取整数部分, 取小数部分, 小数部分保留n位
  -- PARSENAME 标记为1取小数部分, 标记为2取整数部分
  SET @number = (SELECT ROUND(@number, @n))
  SET @int = (SELECT PARSENAME(@number, 2))
  SET @float = (SELECT PARSENAME(@number, 1))
  SET @strLeft = SUBSTRING(@float, 1, @n)
  
  -- 整数部分添加千分位
  -- MONEY转字符串 标记位 1 添加千分位，保留两位小数
  SET @int = (SELECT PARSENAME(CONVERT(VARCHAR(32), CONVERT(MONEY, @int), 1), 2))
  
  -- 保留0位，直接返回整数位
  IF(@n = 0)
  BEGIN
    RETURN @int
  END
  
  -- 小数部分不处理千分位, 直接返回
  IF(@flag = 0)
  BEGIN
    RETURN @int + '.' + @strLeft
  END
  
  -- 循环添加小数部分的千分位
  SET @strTemp = ''
  WHILE(LEN(@strLeft) > 3)
  BEGIN
    SET @strTemp = @strTemp + ',' + SUBSTRING(@strLeft, 1, 3)
    SET @strLeft = SUBSTRING(@strLeft, 4, LEN(@strLeft))
  END
  -- 剩下3位或3位以内的数字处理
  IF(LEN(@strLeft) > 0)
  BEGIN
    SET @strTemp = @strTemp + ',' + SUBSTRING(@strLeft, 1, 3)
  END
  -- 删除第一位的逗号
  IF(LEN(@strTemp) > 0)
  BEGIN
    SET @strTemp = SUBSTRING(@strTemp, 2, LEN(@strTemp))
  END

  RETURN @int + '.' + @strTemp
END

~~~