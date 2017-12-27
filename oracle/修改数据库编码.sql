-- SELECT value$ FROM SYS.props$ WHERE NAME = 'NLS_CHARACTERSET';
SHUTDOWN IMMEDIATE; 
STARTUP MOUNT EXCLUSIVE; 
ALTER SYSTEM ENABLE RESTRICTED SESSION;
ALTER SYSTEM SET JOB_QUEUE_PROCESSES=0;
ALTER SYSTEM SET AQ_TM_PROCESSES=0;
ALTER DATABASE OPEN;
ALTER DATABASE CHARACTER SET INTERNAL_USE AL32UTF8;
-- 如果报错使用如下（AL32UTF8, ZHS16GBK）
-- ALTER DATABASE CHARACTER SET INTERNAL_USE ZHS16GBK;
SHUTDOWN IMMEDIATE;
STARTUP;