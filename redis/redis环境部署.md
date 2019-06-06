# Redis环境部署
### 配置启动redis
- 下载解压redis，修改配置文件，打开redis.windows.conf文件：
  - 修改密码。搜索requirepass，修改requirepass后的内容；
  - 修改端口号。搜索port，修改port后的内容（如果系统中有多个redis实例或端口被占用就需要修改端口号，如果没有冲突则不需要修改）；
- 修改完成后保存退出，双击打开redis-server.exe，注意打开的窗口不能关闭。此时redis便正常启动。记住修改的密码和端口，后面程序中配置redis需要和此处一致；
- 如果想安装成服务，用管理员权限 打开cmd，进入redis根目录（有redis-server.exe文件的目录），执行redis-server --service-install redis.windows.conf --loglevel verbose，在看到success字样后则安装成功，服务安装好后可以去服务列表中查看（如果没有启动可以手动启动）。<br>
![redis](/imgs/redis/redis1.png)<br>
### 测试redis是否正常运行
- 双击打开redis-cli.exe。如果是远程服务器，则使用`redis-cli -h 172.16.16.21 -p yourpassword`<br>
![redis](/imgs/redis/redis2.png)<br>
- 先设置一个键值，如set testkey 'abc123'。如果提示未授权，则要使用auth命令先登录，如下图。看到ok字样说明设置成功。<br>
![redis](/imgs/redis/redis3.png)<br>
- 将刚才设置的值取出来，get testkey。如果返回了上面设置的值，说明redis正常运行。<br>
![redis](/imgs/redis/redis4.png)<br>