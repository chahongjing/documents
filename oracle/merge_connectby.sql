create table a(id int, name varchar2(20));
insert into a(id, name)
values(1, 'aname1');
insert into a(id, name)
values(2, 'aname2');
insert into a(id, name)
values(3, 'aname3');

create table b(id int, name varchar2(20));
insert into b(id, name)
values(1, 'bname1');
insert into b(id, name)
values(2, 'bname2');
insert into b(id, name)
values(4, 'bname3');

select * from a;
select * from b;

select a.id, a.name, b.name
  from a
 inner join b on a.id = b.id;

-- merge into
merge into a
using b
on (a.id = b.id)
when matched then 
update set a.name = b.name
;

drop table b



-- 递归
SELECT connect_by_isleaf, connect_by_root a.mingcheng as root, sys_connect_by_path(a.mingcheng, '-->'),a.mingcheng  ,b.MINGCHENG as nenglimingcheng,c.MINGCHENG as zhishidianmingcheng,d.MINGCHENG as tixingmingcheng
FROM RW_ZHENGTILANTUMINGXI a
LEFT JOIN XK_NENGLICENGJI b on a.nengliid = b.nengliid
LEFT JOIN XK_ZHISHIDIAN c on a.zhishidianid = c.zhishidianid
LEFT JOIN XK_TIXING d on a.tixingid = d.tixingid
WHERE a.LANTUID = 91
START WITH a.SHANGCENGID is NULL or a.SHANGCENGID = 0
CONNECT BY PRIOR a.LANTUDUIXIANGID = a.SHANGCENGID
order siblings by a.xuhao