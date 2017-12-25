-- 生成class类
SELECT  wm_concat('
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
       ELSE 'String' END || ' ' || LOWER(A.COLUMN_NAME) || ';')
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