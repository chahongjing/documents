~~~ sql
-- 生成class类
SELECT LISTAGG('
/**
* ' || B.COMMENTS || '
*/
private ' || 
       CASE a.DATA_TYPE WHEN 'CHAR' THEN 'String' WHEN 'VARCHAR2' THEN 'String' WHEN 'LONG' THEN 'String' WHEN 'DATE' THEN 'Date' WHEN 'BLOB' THEN 'String'
                        WHEN 'CLOB' THEN 'String' WHEN 'RAW' THEN 'byte[]' WHEN 'NUMBER' THEN 
                        (
                          CASE WHEN A.DATA_PRECISION = 1 THEN 'boolean' WHEN A.DATA_PRECISION < 5 AND A.DATA_SCALE = 0 THEN 'short'
                               WHEN A.DATA_PRECISION < 5 AND A.DATA_SCALE > 0 THEN 'float' WHEN A.DATA_PRECISION < 10 THEN 'Integer'
                               WHEN A.DATA_PRECISION > 10 AND A.DATA_SCALE = 0 THEN 'long' WHEN A.DATA_PRECISION > 10 AND A.DATA_SCALE > 0 THEN 'double' 
                               ELSE 'Integer' END
                        )
       ELSE 'String' END || ' ' || LOWER(A.COLUMN_NAME) || ';', '') WITHIN GROUP (ORDER BY A.COLUMN_ID) AS PROP
  FROM USER_TAB_COLS A
  JOIN USER_COL_COMMENTS B ON A.TABLE_NAME = B.TABLE_NAME AND A.COLUMN_NAME = B.COLUMN_NAME
 WHERE A.TABLE_NAME = UPPER('XT_YONGHU')
 ORDER BY A.COLUMN_ID;

-- insert
SELECT wm_concat(LOWER(A.COLUMN_NAME)) AS "Column", 
       wm_concat('#{' || LOWER(A.COLUMN_NAME) || ', jdbcType=' || 
       CASE a.DATA_TYPE WHEN 'CHAR' THEN 'VARCHAR' WHEN 'VARCHAR2' THEN 'VARCHAR' WHEN 'LONG' THEN 'VARCHAR' WHEN 'DATE' THEN 'DATE' WHEN 'BLOB' THEN 'VARCHAR'
                        WHEN 'CLOB' THEN 'VARCHAR' WHEN 'RAW' THEN 'byte[]' WHEN 'NUMBER' THEN 
                        (
                          CASE WHEN A.DATA_PRECISION = 1 THEN 'boolean' WHEN A.DATA_PRECISION < 5 AND A.DATA_SCALE = 0 THEN 'short'
                               WHEN A.DATA_PRECISION < 5 AND A.DATA_SCALE > 0 THEN 'float' WHEN A.DATA_PRECISION < 10 THEN 'INTEGER'
                               WHEN A.DATA_PRECISION > 10 AND A.DATA_SCALE = 0 THEN 'long' WHEN A.DATA_PRECISION > 10 AND A.DATA_SCALE > 0 THEN 'double' 
                               ELSE 'INTEGER' END
                        )
       ELSE 'String' END || '}') AS "Value"
  FROM USER_TAB_COLS A
  JOIN USER_COL_COMMENTS B ON A.TABLE_NAME = B.TABLE_NAME AND A.COLUMN_NAME = B.COLUMN_NAME
 WHERE A.TABLE_NAME = UPPER('XT_YONGHU')
 ORDER BY A.COLUMN_ID;

-- update
SELECT wm_concat(LOWER(A.COLUMN_NAME) || ' = ' || '#{' || LOWER(A.COLUMN_NAME) || ', jdbcType=' || 
       CASE a.DATA_TYPE WHEN 'CHAR' THEN 'VARCHAR' WHEN 'VARCHAR2' THEN 'VARCHAR' WHEN 'LONG' THEN 'VARCHAR' WHEN 'DATE' THEN 'DATE' WHEN 'BLOB' THEN 'VARCHAR'
                        WHEN 'CLOB' THEN 'VARCHAR' WHEN 'RAW' THEN 'byte[]' WHEN 'NUMBER' THEN 
                        (
                          CASE WHEN A.DATA_PRECISION = 1 THEN 'boolean' WHEN A.DATA_PRECISION < 5 AND A.DATA_SCALE = 0 THEN 'short'
                               WHEN A.DATA_PRECISION < 5 AND A.DATA_SCALE > 0 THEN 'float' WHEN A.DATA_PRECISION < 10 THEN 'INTEGER'
                               WHEN A.DATA_PRECISION > 10 AND A.DATA_SCALE = 0 THEN 'long' WHEN A.DATA_PRECISION > 10 AND A.DATA_SCALE > 0 THEN 'double' 
                               ELSE 'INTEGER' END
                        )
       ELSE 'String' END || '}') AS "Value"
  FROM USER_TAB_COLS A
  JOIN USER_COL_COMMENTS B ON A.TABLE_NAME = B.TABLE_NAME AND A.COLUMN_NAME = B.COLUMN_NAME
 WHERE A.TABLE_NAME = UPPER('XT_YONGHU')
 ORDER BY A.COLUMN_ID;

-- 列名
SELECT  wm_concat(LOWER(A.COLUMN_NAME))
  FROM USER_TAB_COLS A
  JOIN USER_COL_COMMENTS B ON A.TABLE_NAME = B.TABLE_NAME AND A.COLUMN_NAME = B.COLUMN_NAME
 WHERE A.TABLE_NAME = UPPER('XT_YONGHU')
 ORDER BY A.COLUMN_ID;

-- 递归
SELECT Level
  FROM DUAL
CONNECT BY Level < 5;

-- 查询约束
select a.constraint_name,a.constraint_type,b.column_name 
from user_constraints a,user_cons_columns b
where a.table_name=b.table_name
 and a.constraint_name = 'SYS_C0013673'

-- 查询包含字段的表
SELECT A.TABLE_NAME, B.Comments
  FROM USER_TAB_COLS A
  JOIN USER_TAB_COMMENTS B ON A.TABLE_NAME = B.TABLE_NAME
 WHERE UPPER(A.COLUMN_NAME) = UPPER('xuekeid')

-- 修改sqlplus中日期格式
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';

-- 分隔字符串
select substr(inlist, instr(inlist, ',', 1, level) + 1,
       instr(inlist, ',', 1, level + 1) - instr(inlist, ',', 1, level) - 1) as value_str
  from (select ',' || 'ab,cd,efg' || ',' as inlist from dual)
connect by level <= length('ab,cd,efg') - length(replace('ab,cd,efg', ',', '')) + 1;

select regexp_substr('ab,cd,efg,hi', '[^,]+', 1, level) as value_str
  from dual
connect by level <= length('ab,cd,efg.hi') - length(replace('ab,cd,efg.hi', ',', '')) + 1;

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


~~~
# 日期处理
~~~ sql
select Extract(year from sysdate) as year, Extract(month from sysdate) as month, Extract(day from sysdate) as day,
      Extract(hour from cast(sysdate as timestamp)) as hour, Extract(minute from cast(sysdate as timestamp)) as minute,
      Extract(second from cast(sysdate as timestamp)) as second
  from dual;

select sysdate, add_months(sysdate, -12) as beforenextyear, sysdate + 1/24 as nexthour, sysdate - 2 * interval '3' hour as hourbefor6
  from dual;
-- interval 可用于年月日时分秒
-- + - 用于天，可以用小数来处理时分秒，也可以用倍数处理天，月，年，月年还可以用add_months(sysdate,12)
-- numtodsinterval处理时 分 秒sysdate+numtodsinterval(3,'hour'), numtoyminterval处理年月sysdate+numtoyminterval(3,'year')

-- 获取两个时间之间的秒数
select ROUND(TO_NUMBER((sysdate + 25 / (60 * 60 * 24)) - sysdate) * 24 * 60 * 60) as second from dual;
select months_between(sysdate, date'1971-05-18') from dual;
-- 获取时间差
select extract(hour from cast(SYSDATE + 2 / 24 as timestamp) - SYSDATE) AS HOUR
  from dual;

-- 没有秒
select timestamp'2017-02-12 15:18:23.365478', date'2017-02-12',
       trunc(sysdate,'year'), trunc(sysdate,'month'), trunc(sysdate), trunc(sysdate,'hh24'),
	   trunc(sysdate,'mi') from dual;
~~~

# 远程数据库
~~~ sql
drop public database link testlibra;
create public database link testlibra
connect to libra2 identified by libra2
using '(DESCRIPTION =
(ADDRESS_LIST =
(ADDRESS = (PROTOCOL = TCP)(HOST = 172.16.16.202)(PORT = 1521))
)
(CONNECT_DATA =
(ORACLE_SID=libra)
)
)';

seLect * from tk_shijuan@TESTLIBRA
~~~

# 生成批量sql
~~~ sql
Set pagesize 0;
set linesize 8000;
set feedBack off;
set heading off;
set HEADS off;
set echo off;
set VERIFY OFF;
spool "d:\\export.sql";
select 
'
select ZhuanYeBianMa as 专业编码, XueKeBianMa as 学科编码, XueKeMingCheng as 学科名称, ShiJuanMingCheng as 试卷名称,
       ShiJuanBianMa as 试卷编码, ShiJuanShiTiXuHao as 试卷试题序号, ShiTiBianMa as 试题编码, NanDuBianMa as 难度编码, NanDuMingCheng as 难度名称, ZhiShiDianBianMa as 知识点编码,
       ZhiShiDianMingCheng as 知识点名称, KaoShiYaoQiuBianMa as 考试要求编码, KaoShiYaoQiuMingCheng as 考试要求名称, TiXingBianMa as 题型编码, TiXingMingCheng as 题型名称
  from (
    select p.parentcode as ZhuanYeBianMa, p.subjectcode as XueKeBianMa, p.subjectname as XueKeMingCheng, p.name as ShiJuanMingCheng, p.papercode as ShiJuanBianMa,
           row_number() over(Partition By p.paperid order by instr(p.papercontent, pq.paperquestionid, 1, 1)) as ShiJuanShiTiXuHao, q.questioncode as ShiTiBianMa,
           q.Difficultycode as NanDuBianMa, Q.Difficultyname as NanDuMingCheng, q.knowledgecode as ZhiShiDianBianMa, q.knowledgecontent as ZhiShiDianMingCheng, q.abilitycode as KaoShiYaoQiuBianMa,
           q.abilityname as KaoShiYaoQiuMingCheng, q.sectioncode as TiXingBianMa, q.sectionname as TiXingMingCheng, pq.sectioncode, pq.createtime
      from ibm_paper p
     inner join ibm_paperquestion pq on p.paperid = pq.paperid
     inner join ibm_formalquestion q on pq.formalquestionid = q.formalquestionid
     where p.subjectcode = ''' || ibm_major.majorcode || '''
  )
 order by ZhuanYeBianMa, XueKeBianMa, ShiJuanMingCheng, ShiJuanBianMa, ShiJuanShiTiXuHao' || ';' || '-' || '-'
|| '第' || to_char(rownum) || '条数据：' || ibm_major.majorname || 
(case when mod(rownum, 10) = 0 then '
' || '
' || '
' || '
' || '
' || '
' || '
' || '
' || '
' || '' else '' end) as text
from ibm_major
where majorcode in (select subjectcode from ibm_paper where status > 1);
spool off;
~~~
# 存储过程
~~~ sql
DECLARE 
v_table tabs.table_name%TYPE; 
v_sql VARCHAR2(888); 
v_q NUMBER; 
CURSOR c1 IS 
SELECT table_name tn FROM tabs; 
TYPE c IS REF CURSOR; 
c2 c; 
BEGIN 
DBMS_OUTPUT.PUT_LINE('以下为空数据表的表名:'); 
FOR r1 IN c1 LOOP 
v_table :=r1.tn; 
v_sql :='SELECT COUNT(*) q FROM '||v_table; 
OPEN c2 FOR v_sql; 
LOOP 
FETCH c2 INTO v_q; 
EXIT WHEN c2%NOTFOUND; 
IF v_q=0 THEN 
DBMS_OUTPUT.PUT_LINE(v_table); 
END IF; 
END LOOP; 
CLOSE c2; 
END LOOP; 
EXCEPTION 
WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error occurred'); 
END;
~~~