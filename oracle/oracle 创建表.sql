declare
  num number;
  tableName varchar2(50);
begin
  tableName := 'testtable';
  select count(1) into num from user_tables where upper(table_name) = upper(tableName) ;
  if num > 0 then
    execute immediate 'drop table ' || tableName;
  end if;
end;
/
create table testtable
(
  id int primary key,
  name varchar2(20)
);
/
comment on table testtable is '测试表名';
comment on column testtable.id is 'id';
comment on column testtable.name is '名称';
/
--  添加字段
DECLARE
  num NUMBER;
  tableName varchar2(50);
  fieldName varchar2(50);
BEGIN
  tableName := 'testtable';
  fieldName := 'name';
  SELECT COUNT(1) INTO num from cols
   where upper(table_name) = upper(tableName)
     and upper(column_name) = upper(fieldName);
  IF num > 0 THEN
    execute immediate 'alter table ' || tableName || ' drop column ' || fieldName;
    -- 添加：alter table tablename add (column datatype);
    -- 修改：alter table tablename modify (column datatype);
    -- 删除：alter table tablename drop (column);
  END IF;
END;
/
alter table testtable add(name varchar2(50));