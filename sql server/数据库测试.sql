-- ���е�IO���
DBCC DROPCLEANBUFFERS;
SET STATISTICS IO ON;
SELECT orderid, custid, empid, shipperid, orderdate, filler
FROM Orders
WHERE orderdate >= '20060101'
AND orderdate < '20060201';
SET STATISTICS IO OFF;

-- ��ѯ�Ĵ�CPUʱ���ʵ�ʾ���ʱ��
DBCC DROPCLEANBUFFERS;
DBCC FREEPROCCACHE;
SET STATISTICS TIME ON;
SELECT orderid, custid, empid, shipperid, orderdate, filler
FROM Orders
WHERE orderdate >= '20060101'
AND orderdate < '20060201';
SET STATISTICS TIME OFF;