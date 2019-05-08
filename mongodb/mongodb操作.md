# 修改用户密码
~~~ bat
mongo.exe
use admin
-- 创建用户
db.createUser({user: "libra", pwd: "libra",roles: [{role: "userAdminAnyDatabase", db: "admin"}]});


-- 修改用户密码
db.changeUserPassword('libra', 'libra$20167')
~~~
# 安装服务
~~~ bat
rem first create data and log folders in bin folder
rem second run with admin cmd, and goto into bin folder, then run this bat
@echo off
title MongoDB service(install/uninstall)
set /p type=install(i),uninstall(u):
rem install
if "%type%"=="i" (
    set command=mongod.exe --logpath %cd%\log\mongodb.log --logappend --dbpath %cd%\data --directoryperdb --serviceName MongoDB --install --bind_ip 0.0.0.0
    set title=install MongoDB service
    goto hasCommand
)
rem uninstall
rem sc delete MongoDB
if "%type%"=="u" (
    set command=mongod.exe --remove --serviceName "MongoDB"
    set title=uninstall MongoDB service
    goto hasCommand
)
rem error
goto errorInput

:hasCommand
title %title%
echo.
echo %command%
%command%
goto end

:errorInput
echo error input. only i or u

:end
pause;
~~~
# 服务端
~~~ bat
::1.首先在官网下载MongoDB，解压至D盘mongodbSet文件夹中

::2.在D盘新建MongoDB文件夹，并在其目录下新建MongoDB\data\db和MongoDB\logs 

::管理员运行cmd

::MongoDb目录下添加mongo.config文件
::内容为
::##数据文件
::dbpath=C:\MongoDB\data
::
::##日志文件
::logpath=C:\MongoDB\logs\mongo.log

cd C:\mongodbset\bin

mongod.exe --dbpath C:\mongodb\data\db

mongod.exe --config C:\MongoDB\mongo.config
~~~
# 客户端
~~~ bat
cd C:\mongodbset\bin
mongo
~~~
# 数据库操作
~~~ bat
use test

db.user.insert({"name":"曾军毅","age":25})

db.user.update({"name":"曾军毅"},{"$set":{"sex":"male"}}, true, true)
db.user.update({"name":"曾军毅"},{"$unset":{"sex":"male"}}, true, true)

::和insert一样, 只不过如果里面传的有_id值则会先根据_id值进行更新, 若未找到数据, 则插入
db.user.save({"_id":ObjectId("558e3d2748f5f451deaf0938"), "name":"张三","age":22, "birthday":ISODate("1990-11-02 07:58:51.718")})

db.user.save({"_id":ObjectId("558e3d2748f5f451deaf0938"),"age":32, "birthday":ISODate("1977-11-02 07:58:51.718")})


db.user.insert({"name":"即将删除","age":22})
db.user.find()
db.user.remove({"name":"即将删除"})

~~~
# [下载](http://dl.mongodb.org/dl/win32/x86_64)
- 客户端：RoboMongo