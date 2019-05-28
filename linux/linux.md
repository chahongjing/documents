### 目录说明
![dir](/imgs/linux/linux_dir.png)
- /usr：系统级的目录，可以理解为C:/Windows/
- /usr/lib理解为C:/Windows/System32。
- /usr/local：用户级的程序目录，可以理解为C:/Progrem Files/。用户自己编译的软件默认会安装到这个目录下。这里主要存放那些手动安装的软件，即不是通过apt-get安装的软件。它和/usr目录具有相类似的目录结构。让软件包管理器来管理/usr目录，而把自定义的脚本(scripts)放到/usr/local目录下面。
- /opt：用户级的程序目录，可以理解为D:/Software，opt有可选的意思，这里可以用于放置第三方大型软件（或games），当你不需要时，直接rm -rf掉即可。在硬盘容量不够时，也可将/opt单独挂载到其他磁盘上使用。这里主要存放那些可选的程序。你想尝试最新的firefox beta版吗?那就装到/opt目录下吧，这样，当你尝试完，想删掉firefox的时候，你就可以直接删除它，而不影响系统其他任何设置。安装到/opt目录下的程序，它所有的数据、库文件等等都是放在同一个目录下面。
- /usr/src：系统级的源码目录。
- /usr/local/src：用户级的源码目录。