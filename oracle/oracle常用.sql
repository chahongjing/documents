-- 备份mytable表为Ϊmybaktable
create table mybaktable as
select id, name from mytable;
-- merge into
merge into a
using (select * from bbb) b
   on (a.id = b.id)
 when matched then 
update set a.name = b.name
;
-- 递归
SELECT connect_by_isleaf, connect_by_root a.mingcheng as root, sys_connect_by_path(a.mingcheng, '-->'),a.mingcheng
  FROM RW_ZHENGTILANTUMINGXI a
 WHERE a.LANTUID = 91
 START WITH a.SHANGCENGID is NULL or a.SHANGCENGID = 0
CONNECT BY PRIOR a.LANTUDUIXIANGID = a.SHANGCENGID
 order siblings by a.xuhao