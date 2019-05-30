- 基础
  - 使用表字段类型: 表名.字段名%type
  - 使用表行类型: 表名%rowtype
- Merge
  - `Merge into T2 using T1 on (T1.id = T2.id) when matched then update set T2.name = T1.name when not matched then insert values(T1.XXX, T1.XXX);`  还可以有deleted子句
  - 9i必须出现update insert子句, 10i及以后可以只出现其一
- Insert all
- NULL
  - NVL(exp1, exp2), 1为null, 则为2, 不为null, 则为1; 
  - NVL2(exp1, exp2, exp3),1为null则为3, 不为null, 则为2.  
  - NULLIF(exp1, exp2), 如果1=2则为null, 不等则为1
  - COALESCE(exp1, exp2, exp3, ……), 从左至右找一个不为NULL的值.全为null,则为NULL
  - Decode(条件, 值1, 返回值1, 值2, 返回值2, ……..)
- Pivot进行行转列(11g)
- Group by 
  - Rollup
  - Cube
  - Grouping, Grouping(group field)小计合计返回1, 普通返回0
  - grouping_id, 对分组的列进行按位排, 然后计算值
  - group_id,
  - keep
- 格式化
  - TO_DATE(SYSDATE, ‘yyyy-MM-dd HH:mm:ss’)
- 递归
~~~ sql
select * from table 
start with org_id = 'HBHqfWGWPy' 
connect by prior org_id = parent_id;   level
~~~
- 字符串
  - `TRANSLATE(string,from_str,to_str)`
- 前一条记录lag, 后一条记录lead, row_number()
- 在sqlplus中使用@执行sql文件，使用spool “d:\a.txt”; your sql; spool off;
- select 'a' || tablefield || 'c', concat(concat('a', tablefield), 'c') from mytable;// concat只能拼接两个参数