set serveroutput on;
DECLARE 
  v_table tabs.table_name%TYPE; 
  v_sql VARCHAR2(888); 
  sqltemp VARCHAR2(200); 
  tabC int;
  v_q NUMBER; 
  CURSOR c1 IS 
  SELECT table_name tn FROM user_tables; 
  TYPE c IS REF CURSOR; 
  c2 c; 
BEGIN 
  DBMS_OUTPUT.PUT_LINE('以下为空数据表的表名:');
  tabC := 0;
  FOR r1 IN c1 LOOP 
    v_table :=r1.tn; 
    v_sql :='SELECT COUNT(*) q FROM '||v_table; 
    OPEN c2 FOR v_sql; 
    LOOP 
      FETCH c2 INTO v_q; 
      EXIT WHEN c2%NOTFOUND; 
      IF v_q=0 THEN
        sqltemp := 'alter table ' || v_table || ' allocate extent';	  
        DBMS_OUTPUT.PUT_LINE(sqltemp || ';');
        EXECUTE IMMEDIATE (sqltemp); 
        tabC := tabC + 1;
      END IF; 
    END LOOP; 
    CLOSE c2; 
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('已成功执行' || tabC || '个空表。');
  EXCEPTION 
  WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error occurred'); 
END;
