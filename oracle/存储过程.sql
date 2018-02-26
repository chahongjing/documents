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