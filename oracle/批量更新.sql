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

merge into a using b on (a.id = b.id)
when matched then 
update  set a.name = b.name
;

drop table b