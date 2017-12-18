create or replace PROCEDURE TestProc
(
  ret OUT SYS_REFCURSOR
)
AS
TYPE ref_cursor_type IS REF CURSOR;
myrow SYS_USER%rowType;
--cursor ret is select * from SYS_USER;
mc ref_cursor_type;
msql varchar2(200) := 'select * from SYS_USER where rownum < 2';
BEGIN

    open ret for select * from sys_user where rownum < 5;
    --open ret;
    fetch ret into myrow;

    while(ret%found)
    loop
      dbms_output.put_line(myrow.username);
      fetch ret into myrow ;
    end loop;
    close ret;
    
    dbms_output.put_line('--------');
    open mc for msql;
    fetch mc into myrow;
    while(mc%found)
    loop
      dbms_output.put_line(myrow.username);
      fetch mc into myrow ;
    end loop;
    close mc;
    
    execute immediate msql
    into myrow;
    
    dbms_output.put_line('--------');
    dbms_output.put_line(myrow.username);
end;
/
set serveroutput on;
declare
ret SYS_REFCURSOR;
begin
  TestProc(ret);
end;