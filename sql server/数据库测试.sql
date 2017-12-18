-- 运行的IO情况
DBCC DROPCLEANBUFFERS;
SET STATISTICS IO ON;
SELECT orderid, custid, empid, shipperid, orderdate, filler
FROM Orders
WHERE orderdate >= '20060101'
AND orderdate < '20060201';
SET STATISTICS IO OFF;

-- 查询的纯CPU时间和实际经过时间
DBCC DROPCLEANBUFFERS;
DBCC FREEPROCCACHE;
SET STATISTICS TIME ON;
SELECT orderid, custid, empid, shipperid, orderdate, filler
FROM Orders
WHERE orderdate >= '20060101'
AND orderdate < '20060201';
SET STATISTICS TIME OFF;