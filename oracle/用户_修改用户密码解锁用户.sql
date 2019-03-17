-- 
SELECT username,profile FROM dba_users;
-- 查询profile信息，如profile为default
SELECT * FROM dba_profiles WHERE profile='DEFAULT' AND resource_name='PASSWORD_LIFE_TIME';
-- 修改为无限制
ALTER PROFILE DEFAULT LIMIT PASSWORD_LIFE_TIME UNLIMITED;

-- 解锁用户
ALTER USER "用户名" IDENTIFIED BY "原来的密码" ACCOUNT UNLOCK;