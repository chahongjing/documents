# mysql
- 打开cmd，输入“mysql -u root -p”回车，然后输入mysql安装时设置的root账号的密码（123456），若提示“Welcome to the MySQL monitor.”说明配置成功了。如果提示命令错误，则要把mysql/bin添加到环境变量中，在path路径中添加C:\Program Files\MySQL\MySQL Server 5.7\bin
- 启动mysql服务。net start mysqlzzz1。其中mysqlzzz1为mysql服务名。然后就可以在任务管理器的进程里看到“mysqld.exe”的进程。若执行命令时提示：服务名无效。请键入 NET HELPMSG 2185 以获得更多的帮助。
- 解决办法： 在 mysql bin目录下 以管理员的权限 执行 mysqld -install命令
- 附卸载mysql服务的方法。
  - 以管理员的权限 net stop mysql ，关闭mysql服务
  - 以管理员的权限 mysqld -remove ，卸载mysql服务
