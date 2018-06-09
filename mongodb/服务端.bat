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