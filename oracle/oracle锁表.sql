-- 查询锁
select ('alter system kill session''' || temp.sid || ',' || temp.serial || ''';') as killSql, sid, serial, username, schemaname, osuser, process, machine, terminal, logon_time, type
  from (
        SELECT sess.sid, sess.serial# as serial, sess.username, sess.schemaname, sess.osuser, sess.process, sess.machine, sess.terminal, sess.logon_time, loc.type
          FROM v$session sess
         inner join v$lock loc on sess.sid = loc.sid
         inner join v$locked_object locObj on sess.sid = locObj.session_id 
         WHERE sess.username IS NOT NULL
       ) temp
 ORDER BY temp.sid;

-- 查某session 正在执行的sql语句，从而可以快速定位到哪些操作或者代码导致事务一直进行没有结束等.
SELECT /*+ ORDERED */ 
       sql_text
  FROM v$sqltext a
 WHERE (a.hash_value, a.address) IN
       (SELECT DECODE(sql_hash_value, 0, prev_hash_value, sql_hash_value),
               DECODE(sql_hash_value, 0, prev_sql_addr, sql_address)
          FROM v$session b
         WHERE b.sid = 71)  /* 此处67 为SID*/
 ORDER BY piece ASC;