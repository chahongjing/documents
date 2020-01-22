### apt
|apt 命令|取代的命令|命令的功能|
|---|---|---|
|apt install|apt-get install|安装软件包|
|apt remove|apt-get remove|移除软件包|
|apt purge|apt-get purge|移除软件包及配置文件|
|apt update|apt-get update|刷新存储库索引|
|apt upgrade|apt-get upgrade|升级所有可升级的软件包|
|apt autoremove|apt-get autoremove|自动删除不需要的包|
|apt full-upgrade|apt-get dist-upgrade|在升级软件包时自动处理依赖关系|
|apt search|apt-cache search|搜索应用程序|
|apt show|apt-cache show|显示装细节|
|apt list|/|列出包含条件的包（已安装，可升级等）|
|apt edit-sources|/|编辑源列表|

### 服务自启动
1. 复制启动脚本到指定目录：`sudo cp mystart.sh /etc/init.d`
2. 修改文件名称：`mv mystart.sh myservice`
1. 修改启动文件权限：`sudo chmod 755 myservice`
2. 启动服务命令：`service myservice start`
3. 添加到自启服务命令：`update-rc.d -f myservice defaults`
4. 关闭服务命令：`service myservice stop`
5. 删除到自启服务命令：`update-rc.d -f myservice remove`