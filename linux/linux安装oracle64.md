# 在linux环境下安装oracle
### 安装oracle包依赖
~~~ cmd
yum -y install binutils compat-libstdc++-33 compat-libstdc++-33.i686 elfutils-libelf elfutils-libelf-devel gcc gcc-c++ glibc glibc.i686 glibc-common glibc-devel glibc-devel.i686 glibc-headers ksh libaio libaio.i686 libaio-devel libaio-devel.i686 libgcc libgcc.i686 libstdc++ libstdc++.i686 libstdc++-devel make sysstat unixODBC unixODBC-devel

yum -y install binutils glibc-static-2.17
yum install compat-libstdc++-33
rpm -Uvh --force binutils-2.15.92.0.2-13.i386.rpm

yum install -y binutils compat-gcc* compat-glibc* compat-libcap1 compat-libstd* compat-libstdc++-33 compat-libstdc++-33.i686 compat-libstdc++-33*.i686 elfutils-libelf elfutils-libelf-devel gcc gcc-c++ glibc glibc-common glibc-devel glibc-devel.i686 glibc-devel*.i686 glibc-headers glibc.i686 glibc*.i686 ksh libaio libaio-devel libaio-devel.i686 libaio-devel*.i686 libaio.i686 libaio*.i686 libgcc libgcc.i686 libgcc*.i686 libstdc++ libstdc++-devel libstdc++-devel*.i686 libstdc++.i686 libstdc++*.i686 libXp make numactl sysstat unixODBC unixODBC-devel unixODBC-devel*.i686 unixODBC*.i686

yum -y install binutils compat-libcap1 compat-libstdc++ gcc gcc-c++ glibc glibc-devel libgcc libstdc++ libstdc++-devel libaio sysstat libaio-devel elfutils-libelf-devel unixODBC unixODBC-devel

yum install -y binutils compat-gcc* compat-glibc* compat-libcap1 compat-libstd* compat-libstdc++-33 compat-libstdc++-33.i686 compat-libstdc++-33*.i686 elfutils-libelf elfutils-libelf-devel gcc gcc-c++ glibc glibc-common glibc-devel glibc-devel.i686 glibc-devel*.i686 glibc-headers glibc.i686 glibc*.i686 ksh libaio libaio-devel libaio-devel.i686 libaio-devel*.i686 libaio.i686 libaio*.i686 libgcc libgcc.i686 libgcc*.i686 libstdc++ libstdc++-devel libstdc++-devel*.i686 libstdc++.i686 libstdc++*.i686 libXp make numactl sysstat unixODBC unixODBC-devel unixODBC-devel*.i686 unixODBC*.i686

yum -y install compat-libstdc++-33-3.2.3-62.i386,compat-libstdc++-33-3.2.3-72.el7.x86_64,glibc-2.3.4-2.41.i686,glibc-devel-2.3.4-2.41.i386,libaio-0.3.105-2.i386,libaio-devel-0.3.105-2.i386,libgcc-3.4.6-3.i386,libstdc++-3.4.6-11.i386,pdksh-5.2.14-37.el5_8.1.x86_64,,unixODBC-2.2.11-7.1.i386,unixODBC-devel-2.2.11-7.1.i386
~~~
### 配置环境变量
1. 在用户目录下，如/home/zjy打开.bash_profile文件，通过ls可以看到些文件。添加如下配置，然后保存。
~~~ ini
export ORACLE_SID=orcl
export ORACLE_HOME=/home/zjy/app/zjy/product/11.2.0/dbhome_1
export PATH=$PATH:$ORACLE_HOME/bin
~~~
2. 保存完毕退出后执行命令 source .bash_profile重新加载配置。最好是重启下系统。以免不生效。
### 配置监听
- 在oracle_home/network/admin下找到listener.ora和tnsnames.ora文件修改配置。如下图<br>
![oracle](/imgs/linux/oracle1.png)<br>
![oracle](/imgs/linux/oracle2.png)<br>
### 启动服务
1. 在终端下输入sqlplus / as sysdba便可直接登录，如果提示命令未找到，则是环境变量未配置好或未生效。检查第二步。登录后执行startup便可正常启动数据库实例。
2. 然后启动监听，使用lsnrctl start来启动监听（stop停止）启动时可能会提示实例unknow，可以忽略。看到最后成功字样，则监听启动成功，便可用普通用户登录了。如sqlplus zjy/1024@127.0.0.1:1521/orcl来登录。