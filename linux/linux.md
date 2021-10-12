### 目录说明
![dir](/imgs/linux/linux_dir.png)
- /usr：系统级的目录，可以理解为C:/Windows/
- /usr/lib理解为C:/Windows/System32。
- /usr/local：用户级的程序目录，可以理解为C:/Progrem Files/。用户自己编译的软件默认会安装到这个目录下。这里主要存放那些手动安装的软件，即不是通过apt-get安装的软件。它和/usr目录具有相类似的目录结构。让软件包管理器来管理/usr目录，而把自定义的脚本(scripts)放到/usr/local目录下面。
- /opt：用户级的程序目录，可以理解为D:/Software，opt有可选的意思，这里可以用于放置第三方大型软件（或games），当你不需要时，直接rm -rf掉即可。在硬盘容量不够时，也可将/opt单独挂载到其他磁盘上使用。这里主要存放那些可选的程序。你想尝试最新的firefox beta版吗?那就装到/opt目录下吧，这样，当你尝试完，想删掉firefox的时候，你就可以直接删除它，而不影响系统其他任何设置。安装到/opt目录下的程序，它所有的数据、库文件等等都是放在同一个目录下面。
- /usr/src：系统级的源码目录。
- /usr/local/src：用户级的源码目录。

$#：执行脚本时所有参数个数
$0：命令第一段，如./a.sh a b c，则表示./a.sh
$1~$n：表示第几个参数，如$1表示a
$@：表示所有参数，如上返回：a b c

编写脚本
`touch variable `，`vi variable `
脚本内容如下： 
``` shell
#!/bin/sh 
echo "number:$#" 
echo "scname:$0" 
echo "first :$1" 
echo "second:$2" 
echo "argume:$@" 
```
执行脚本
`chmod +x variable `，`./variable aa bb `

执行sh没有权限
1. `. test.sh`注意.和test.sh中间有个空格
2. `source test.sh`
3. `sh test.sh`
4. `bash test.sh`
5. `chmod 777 test.sh`再执行`./test.sh `