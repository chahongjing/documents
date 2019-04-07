~~~ sql
DECLARE @tbl AS TABLE(Col1 NVARCHAR(10), Col2 NVARCHAR(10))
INSERT INTO @tbl(Col1, Col2)
SELECT 'a' AS [Col1], '1' AS [Col2]
UNION ALL
SELECT 'a' AS [Col1], '1' AS [Col2]
UNION ALL
SELECT 'a' AS [Col1], '1' AS [Col2]
UNION ALL
SELECT 'a' AS [Col1], '2' AS [Col2]
UNION ALL
SELECT 'a' AS [Col1], '2' AS [Col2]
UNION ALL
SELECT 'a' AS [Col1], '3' AS [Col2]
UNION ALL
SELECT 'b' AS [Col1], '1' AS [Col2]
UNION ALL
SELECT 'b' AS [Col1], '1' AS [Col2]
UNION ALL
SELECT 'b' AS [Col1], '1' AS [Col2]
UNION ALL
SELECT 'b' AS [Col1], '2' AS [Col2]
UNION ALL
SELECT 'b' AS [Col1], '3' AS [Col2]
UNION ALL
SELECT 'b' AS [Col1], '5' AS [Col2]

SELECT ROW_NUMBER() OVER (PARTITION BY Col1 ORDER BY Col1) AS [组内排序],
       DENSE_RANK() OVER (PARTITION BY Col1 ORDER BY Col2) AS [组内排名(连续)],
       RANK() OVER (PARTITION BY Col1 ORDER BY Col2) AS [组内排名(不连续)],
       *
  FROM @tbl
~~~