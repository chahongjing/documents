-- 备份mytable表为Ϊmybaktable
create table mybaktable as
select id, name from mytable;

-- merge into
merge into a
using (select * from bbb) b
   on (a.id = b.id)
 when matched then 
update set a.name = b.name
 when not matched then
 insert (name) values(b.name)
 delete where a.id = b.id

-- 递归
SELECT connect_by_isleaf, connect_by_root a.mingcheng as root, sys_connect_by_path(a.mingcheng, '-->'),a.mingcheng
  FROM RW_ZHENGTILANTUMINGXI a
 WHERE a.LANTUID = 91
 START WITH a.SHANGCENGID is NULL or a.SHANGCENGID = 0
CONNECT BY PRIOR a.LANTUDUIXIANGID = a.SHANGCENGID
 order siblings by a.xuhao;

-- 使用块，注意定义的变量不能和字段重名，否则会把所有的数据都更新了
declare
  myxuekeid number(19, 0);
begin
  myxuekeid := 1014783074325630976;
  delete from ym_renwuzu where renwuzuid in (
      select renwuzu.renwuzuid from ym_renwuzu renwuzu where renwuzu.xuekeid = myxuekeid
  );
end;
-- commit;