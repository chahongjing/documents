~~~ sql
sql server系统表详细说明 


sysaltfiles  主数据库 保存数据库的文件  
syscharsets  主数据库字符集与排序顺序

sysconfigures 主数据库 配置选项

syscurconfigs 主数据库当前配置选项

sysdatabases 主数据库服务器中的数据库

syslanguages 主数据库语言

syslogins 主数据库 登陆帐号信息

sysoledbusers 主数据库 链接服务器登陆信息

sysprocesses 主数据库进程

sysremotelogins主数据库 远程登录帐号

syscolumns 每个数据库 列

sysconstrains 每个数据库 限制

sysfilegroups 每个数据库 文件组

sysfiles 每个数据库 文件

sysforeignkeys 每个数据库 外部关键字

sysindexs 每个数据库 索引

sysmenbers 每个数据库角色成员

sysobjects 每个数据库所有数据库对象

syspermissions 每个数据库 权限

systypes 每个数据库 用户定义数据类型

sysusers 每个数据库 用户

sys.extended_properties

syscomments


sysaltfiles  页首

在特殊情况下，包含与数据库中的文件相对应的行。该表存储在 master 数据库中。




列名

数据类型

描述

fileid  smallint  每个数据库的唯一文件标识号。 
groupid  smallint  文件组标识号。 
size  int  文件大小（以 8 KB 页为单位）。 
maxsize  int  最大文件大小（以 8 KB 页为单位）。0 值表示不增长，–1 值表示文件应一直增长到磁盘已满。 
growth  int  数据库的增长大小。0 值表示不增长。根据状态的值，可以是页数或文件大小的百分比。如果 status 为 0x100000，则 growth 是文件大小的百分比；否则是页数。  
status  int  仅限内部使用。 
perf  int  保留。 
dbid  smallint  该文件所属数据库的数据库标识号。 
name  nchar(128)  文件的逻辑名称。 
filename  nchar(260)  物理设备的名称，包括文件的完整路径。 



>syscharsets 页首


每个字符集在表中各占一行，表中还包含定义供 Microsoft? SQL Server? 使用的排序次序。排序次序中的一个在 sysconfigures 中标记为默认排序次序，该次序是实际使用的唯一次序。 




列名

数据类型

描述

type  smallint  该行表示的实体类型。1001 是字符集；2001 是排序次序。 
id  tinyint  字符集或排序次序的唯一 ID。注意排序次序和字符集不能共享相同的 ID 号。保留从 1 到 240 的 ID 范围供 SQL Server 使用。 
csid  tinyint  如果该行表示字符集，则不使用该字段。如果该行表示排序次序，则该字段是在其上生成排序次序的字符集 ID。假设具有该 ID 的字符集行存在于该表中。 
status  smallint  内部系统状态信息位。 
name  sysname  字符集或排序次序的唯一名称。该字段必须只包含字母 A-Z 或 a-z、数字 0 – 9 和下划线 (_)。必须以字母开头。 
description  nvarchar(255)  字符集或排序次序功能的可选描述。 
binarydefinition  varbinary(255)  仅限内部使用。 
definition  image  字符集或排序次序的内部定义。该字段中的数据结构取决于类型。 


sysconfigures 页首


用户设置的每个配置选项在表中各占一行。 sysconfigures 包含最近启动 Microsoft? SQL Server? 前定义的配置选项，还包含最近启动后设置的所有动态配置选项。该表只位于 master 数据库中。


列名

数据类型

描述

value  int  变量的用户可修改值（仅在已执行 RECONFIGURE 后由 SQL Server 使用）。 
config  smallint  配置变量号。 
comment  nvarchar(255)  对配置选项的解释。 
status  smallint  表示选项状态的位图。可能的值包括： 
0 = 静态（该设置在服务器重新启动时生效）。
1 = 动态（该变量在 RECONFIGURE 语句执行时生效）。
2 = 高级（仅当设置了显示高级选项时才显示该变量）。
3 = 动态和高级。
 


syscurconfigs 页首


每个当前配置选项各占一项。另外，该表还包含四个描述配置结构的项。 syscurconfigs 在由用户查询时动态生成。有关更多信息，请参见 sysconfigures。


列名

数据类型

描述

value  int  用户可修改的变量值（仅在已执行 RECONFIGURE 的情况下由 Microsoft? SQL Server? 使用）。 
config  smallint  配置变量号。 
comment  nvarchar(255)  对配置选项的解释。 
status  smallint  表示选项状态的位图。可能的值包括： 
0 = 静态（该设置在服务器重新启动时生效）。
1 = 动态（该变量在 RECONFIGURE 语句执行时生效）。
2 = 高级（仅当设置了显示高级选项时才显示该变量）。
3 = 动态和高级。
 

 

sysdatabases 页首


Microsoft? SQL Server? 上的每个数据库在表中占一行。最初安装 SQL Server 时， sysdatabases 包含 master 、 model 、 msdb 、 mssqlweb 和 tempdb 数据库的项。该表只存储在 master 数据库中。




列名

数据类型

描述

name  sysname  数据库的名称。 
dbid  smallint  数据库 ID。 
sid  varbinary(85)  数据库创建者的系统 ID。 
mode  smallint  用于创建数据库时在内部锁定该数据库。 
status  int  状态位，其中某些状态位可由用户使用 sp_dboption （ read only 、 dbo use only 、 single user 等）进行设置： 
1 = autoclose ；使用 sp_dboption 设置。
4 = select into/bulkcopy ；使用 sp_dboption 设置。
8 = trunc. log on chkpt ；使用 sp_dboption 设置。
16 = torn page detection ，使用 sp_dboption 设置。
32 = loading 。
64 = pre recovery 。
128 = recovering 。
256 = not recovered 。
512 = offline ；使用 sp_dboption 设置。
1024 = read only ；使用 sp_dboption 设置。
2048 = dbo use only ；使用
sp_dboption 设置。
4096 = single user ；使用 sp_dboption 设置。
32768 = emergency mode 。 
4194304 = autoshrink 。 
1073741824 = cleanly shutdown 。

可以同时打开多个位。
 
status2  int  16384 = ANSI null default ；使用 sp_dboption 设置。
65536 = concat null yields null ，使用 sp_dboption 设置。
131072 = recursive triggers ，使用 sp_dboption 设置。
1048576 = default to local cursor ，使用 sp_dboption 设置。
8388608 = quoted identifier ，使用
sp_dboption 设置。
33554432 = cursor close on commit ，使用 sp_dboption 设置。
67108864 = ANSI nulls ，使用 sp_dboption 设置。
268435456 = ANSI warnings ，使用 sp_dboption 设置。
536870912 = full text enabled ，使用 
sp_fulltext_database 设置。 
crdate  datetime  创建日期。 
reserved  datetime  留作以后使用。 
category  int  包含用于复制的信息位图： 
1 = 已发布。
2 = 已订阅。
4 = 合并已发布。
8 = 合并已订阅。
 
cmptlevel  tinyint  数据库的兼容级别。有关更多信息，请参见 sp_dbcmptlevel。  
filename  nvarchar(260)  数据库主文件的操作系统路径和名称。 
version  smallint  创建数据库时使用的 SQL Server 代码内部版本号。仅供 SQL Server 工具在内部用于升级处理。 



syslanguages 页首


出现在 Microsoft? SQL Server? 中的每种语言在表中各占一行。虽然美国英语不在 syslanguages 内，但该表始终可由 SQL Server 使用。该表只存储在 master 数据库中。




列名

数据类型

描述

langid  smallint  唯一语言 ID。 
dateformat  nchar(3)  日期顺序（如 DMY）。 
datefirst  tinyint  一周的第一天：1 表示星期一，2 表示星期二，依此类推，直到 7 表示星期日。 
upgrade  int  留作系统使用。 
name  sysname  正式语言名称（例如，fran?ais）。 
alias  sysname  备用语言名称（如 French）。 
months  nvarchar(372)  按从一月到十二月的顺序排列的用逗号分隔的月份全称列表，每个名称最多包含 20 个字符。 
shortmonths  varchar(132)  按从一月到十二月的顺序排列的用逗号分隔的缩写月份名称列表，每个名称最多包含 9 个字符。 
days  nvarchar(217)  按从一月到十二月的顺序排列的用逗号分隔的天名称列表，每个名称最多包含 30 个字符。 
lcid  int  此种语言的 Microsoft Windows NT? 区域设置 ID。 
mslangid  smallint  SQL Server 消息组 ID。 



安装了 SQL Server 提供的三十三种语言。下面是语言列表。




用英语表示的名称

NT LCID

SQL Server 消息组 ID

English 1033 1033 
German 1031 1031 
French 1036 1036 
Japanese 1041 1041 
Danish 1030 1030 
Spanish 3082 3082 
Italian 1040 1040 
Dutch 1043 1043 
Norwegian 2068 2068 
Portuguese 2070 2070 
Finnish 1035 1035 
Swedish 1053 1053 
Czech 1029 1029 
Hungarian 1038 1038 
Polish 1045 1045 
Romanian 1048 1048 
Croatian 1050 1050 
Slovak 1051 1051 
Slovene 1060 1060 
Greek 1032 1032 
Bulgarian 1026 1026 
Russian 1049 1049 
Turkish 1055 1055 
British English 2057 1033 
Estonian 1061 1061 
Latvian 1062 1062 
Lithuanian 1063 1063 
Brazilian 1046 1046 
Traditional Chinese 1028 1028 
Korean 1042 1042 
Simplified Chinese 2052 2052 
Arabic 1025 1025 
Thai 1054 1054 


syslogins 页首


每个登录帐户在表中占一行。 


列名

数据类型

描述

sid  varbinary(85)  安全标识符。 
status  smallint  仅限内部使用。 
createdate  datetime  添加登录的日期。 
updatedate  datetime  更新登录的日期。 
accdate  datetime  仅限内部使用。 
totcpu  int  仅限内部使用。 
totio  int  仅限内部使用。 
spacelimit  int  仅限内部使用。 
timelimit  int  仅限内部使用。 
resultlimit  int  仅限内部使用。 
name  varchar(30)  用户的登录 ID。 
dbname  nvarchar(128)  建立连接时，用户的默认数据库名。 
password  nvarchar(128)  用户的加密密码（可以是 NULL）。 
language  nvarchar(128)  用户的默认语言。 
denylogin  int  如果登录是 Microsoft? Windows NT? 用户或组且已被拒绝访问，则为 1。 
hasaccess  int  如果已授权登录访问服务器，则为 1。 
isntname  int  如果登录是 Windows NT 用户或组，则为 1；如果登录是 Microsoft SQL Server? 登录，则为 0。 
isntgroup  int  如果登录是 Windows NT 组，则为 1。 
isntuser  int  如果登录是 Windows NT 用户，则为 1。 
sysadmin  int  如果登录是 sysadmin 服务器角色成员，则为 1。 
securityadmin  int  如果登录是 securityadmin 服务器角色成员，则为 1。 
serveradmin  int  如果登录是 serveradmin 固定服务器角色成员，则为 1。 
setupadmin  int  如果登录是 setupadmin 固定服务器角色成员，则为 1。 
processadmin  int  如果登录是 processadmin 固定服务器角色成员，则为 1。 
diskadmin  int  如果登录是 diskadmin 固定服务器角色成员，则为 1。 
dbcreator  int  如果登录是 dbcreator 固定服务器角色成员，则为 1。 
loginname  nvarchar(128)  登录的实际名称，该名称可能不同于 SQL Server 所使用的登录名。 

 
sysoledbusers 页首


每个指定的链接服务器的用户和密码映射在表中占一行。该表存储在 master 数据库中。




列名

数据类型

描述

rmtsrvid  smallint  服务器的 SID（安全标识号）。 
rmtloginame  nvarchar(128)  loginsid 映射到的链接 rmtservid 的远程登录名。 
rmtpassword  nvarchar(128)  链接 rmtsrvid 内的指定远程登录的加密密码。 
loginsid  varbinary(85)  要映射的本地登录 SID。 
status  smallint  如果该值为 1，映射应使用用户自己的凭据。 
changedate  datetime  上次更改映射信息的日期。 



sysprocesses  页首


sysprocesses 表中保存关于运行在 Microsoft? SQL Server? 上的进程的信息。这些进程可以是客户端进程或系统进程。 sysprocesses 只存储在 master 数据库中。


列名

数据类型

描述

spid  smallint  SQL Server 进程 ID。 
kpid  smallint  Microsoft Windows NT 4.0? 线程 ID。 
blocked  smallint  分块进程的进程 ID ( spid )。 
waittype  binary(2)  保留。 
waittime  int  当前等待时间（以毫秒为单位）。当进程不处于等待时，为 0。 
lastwaittype  nchar(32)  表示上次或当前等待类型名称的字符串。 
waitresource  nchar(32)  锁资源的文本化表示法。 
dbid  smallint  当前正由进程使用的数据库 ID。 
uid  smallint  执行命令的用户 ID。 
cpu  int  进程的累计 CPU 时间。无论 SET STATISTICS TIME ON 选项是 ON 还是 OFF，都为所有进程更新该条目。 
physical_io  int  进程的累计磁盘读取和写入。 
memusage  int  当前分配给该进程的过程高速缓存中的页数。一个负数，表示进程正在释放由另一个进程分配的内存。 
login_time  datetime  客户端进程登录到服务器的时间。对于系统进程，是存储 SQL Server 启动发生的时间。 
last_batch  datetime  客户端进程上次执行远程存储过程调用或 EXECUTE 语句的时间。对于系统进程，是存储 SQL Server 启动发生的时间。 
ecid  smallint  用于唯一标识代表单个进程进行操作的子线程的执行上下文 ID。 
open_tran  smallint  进程的打开事务数。 
status  nchar(30)  进程 ID 状态（如运行、休眠等）。 
sid  binary(85)  用户的全局唯一标识符 (GUID)。 
hostname  nchar(128)  工作站的名称。 
program_name  nchar(128)  应用程序的名称。 
hostprocess  nchar(8)  工作站进程 ID 号。 
cmd  nchar(16)  当前正在执行的命令。 
nt_domain  nchar(128)  客户端的 Windows NT 4.0 域（如果使用 Windows 身份验证）或信任连接的 Windows NT 4.0 域。 
nt_username  nchar(128)  进程的 Windows NT 4.0用户名（如果使用 Windows 身份验证）或信任连接的 Windows NT 4.0 用户名。 
net_address  nchar(12)  指派给每个用户工作站上的网络接口卡唯一标识符。当用户登录时，该标识符插入 net_address 列。 
net_library  nchar(12)  用于存储客户端网络库的列。每个客户端进程都在网络连接上进入。网络连接有一个与这些进程关联的网络库，该网络库使得这些进程可以建立连接。有关更多信息，请参见客户端和服务器 Net-Library。 
loginame  nchar(128)  登录名。 


sysremotelogins 页首


每个允许调用 Microsoft? SQL Server? 上的远程存储过程的远程用户占一行。


列名

数据类型

描述

remoteserverid  smallint  远程服务器标识。 
remoteusername  nvarchar(128)  远程服务器上的用户登录名。 
status  smallint  选项的位图。 
sid  varbinary(85)  Microsoft Windows NT? 用户安全 ID。 
changedate  datetime  添加远程用户的日期和时间。 


syscolumns 页首


每个表和视图中的每列在表中占一行，存储过程中的每个参数在表中也占一行。该表位于每个数据库中。


列名

数据类型

描述

name  sysname  列名或过程参数的名称。 
id  int  该列所属的表对象 ID，或与该参数关联的存储过程 ID。 
xtype  tinyint  systypes 中的物理存储类型。 
typestat  tinyint  仅限内部使用。 
xusertype  smallint  扩展的用户定义数据类型 ID。 
length  smallint  systypes 中的最大物理存储长度。 
xprec  tinyint  仅限内部使用。 
xscale  tinyint  仅限内部使用。 
colid  smallint  列或参数 ID。 
xoffset  smallint  仅限内部使用。 
bitpos  tinyint  仅限内部使用。 
reserved  tinyint  仅限内部使用。 
colstat  smallint  仅限内部使用。 
cdefault  int  该列的默认值 ID。 
domain  int  该列的规则或 CHECK 约束 ID。 
number  smallint  过程分组时（0 表示非过程项）的子过程号。 
colorder  smallint  仅限内部使用。 
autoval  varbinary(255)  仅限内部使用。 
offset  smallint  该列所在行的偏移量；如果为负，表示可变长度行。 
status  tinyint  用于描述列或参数属性的位图： 
0x08 = 列允许空值。
0x10 = 当添加 varchar 或 varbinary 列时，ANSI 填充生效。保留 varchar 列的尾随空格，保留 varbinary 列的尾随零。
0x40 = 参数为 OUTPUT 参数。
0x80 = 列为标识列。
 
type  tinyint  systypes 中的物理存储类型。 
usertype  smallint  systypes 中的用户定义数据类型 ID。 
printfmt  varchar(255)  仅限内部使用。 
prec  smallint  该列的精度级别。 
scale  int  该列的小数位数。 
iscomputed  int  表示是否已计算该列的标志： 
0 = 未计算。
1 = 已计算。
 
isoutparam  int  表示该过程参数是否是输出参数： 
1 = 真。
0 = 假。
 
isnullable  int  表示该列是否允许空值： 
1 = 真。
0 = 假。
 


sysconstraints 页首


包含约束映射，映射到拥有该约束的对象。该系统目录存储在每个数据库中。


列名

数据类型

描述

constid  int  约束号。 
id  int  拥有该约束的表 ID。 
colid  smallint  在其上定义约束的列 ID，如果是表约束则为 0。 
spare1  tinyint  保留。 
status  int  位图指示状态。可能的值包括： 
1 = PRIMARY KEY 约束。
2 = UNIQUE KEY 约束。
3 = FOREIGN KEY 约束。
4 = CHECK 约束。
5 = DEFAULT 约束。
16 = 列级约束。
32 = 表级约束。
 
actions  int  保留。 
error  int  保留。 


sysfilegroups 页首


数据库中的每个文件组在表中占一行。该表存储在每个数据库中。在该表中至少有一项用于主文件组。


列名

数据类型

描述

groupid  smallint  每个数据库的唯一组标识号。 
allocpolicy  smallint  保留。 
status  int  0x8 = READ ONLY
0x10 = DEFAULT 
groupname  sysname  文件组的名称。 


sysfiles 页首


数据库中的每个文件在表中占一行。该系统表是虚拟表，不能直接更新或修改。


列名

数据类型

描述

fileid  smallint  每个数据库的唯一文件标识号。 
groupid  smallint  文件组标识号。 
size  int  文件大小（以 8 KB 页为单位）。 
maxsize  int  最大文件大小（以 8 KB 页为单位）。0 值表示不增长，–1 值表示文件应一直增长到磁盘已满。 
growth  int  数据库的增长大小。0 值表示不增长。根据状态的值，可以是页数或文件大小的百分比。如果 status 包含 0x100000，则 growth 是文件大小的百分比；否则，它是页数。 
status  int  growth 值（以兆字节 (MB) 或千字节 (KB) 为单位）的状态位。 
0x1 = 默认设备。
0x2 = 磁盘文件。
0x40 = 日志设备。
0x80 = 自上次备份后已写入文件。
0x4000 = 由 CREATE DATABASE 语句
隐性创建的设备。
0x8000 = 在数据库创建过程中创建的设备。
0x100000 = 按百分比而不是按页数增长。 
 
perf  int  保留。 
name  nchar(128)  文件的逻辑名称。 
filename  nchar(260)  物理设备的名称，包括文件的完整路径。 


sysforeignkeys 页首


包含关于表定义中的 FOREIGN KEY 约束的信息。该表存储在每个数据库中。


列名

数据类型

描述

constid  int  FOREIGN KEY 约束的 ID。 
fkeyid  int  具有 FOREIGN KEY 约束的表对象 ID。 
rkeyid  int  在 FOREIGN KEY 约束中引用的表对象 ID。 
fkey  smallint  正在引用的列 ID。 
rkey  smallint  已引用的列 ID。 
keyno  smallint  该列在引用列列表中的位置。 


sysindexes 页首


数据库中的每个索引和表在表中各占一行。该表存储在每个数据库中。


列名

数据类型

描述

id  int  表 ID（如果 indid = 0 或 255）。否则为索引所属表的 ID。 
status  int  内部系统状态信息。 
first  binary(6)  指向第一页或根页的指针。 
indid  smallint  索引 ID： 
1 = 聚集索引
>1 = 非聚集
255 = 具有 text 或 image 数据的表条目
 
root  binary(6)  如果 indid >= 1 和 < 255， root 是指向根页的指针。如果 indid = 0 或 indid = 255， root 是指向最后一页的指针。  
minlen  smallint  最小行大小。 
keycnt  smallint  键的数目。 
groupid  smallint  在其上创建对象的文件组 ID。 
dpages  int  如果 indid = 0 或 indid = 1， dpages 是已用数据页的计数。如果 indid = 255，其设置为 0。否则是已用索引页的计数。 
reserved  int  如果 indid = 0 或 indid = 1， reserved 是分配给所有索引和表数据的页计数。如果 indid = 255， reserved 是分配给 text 或 image 数据的页计数。否则是分配给索引的页计数。 
used  int  如果 indid = 0 或 indid = 1， used 是用于所有索引和表数据的总页数。如果 indid = 255， used 是用于 text 或 image 数据的页计数。否则是用于索引的页计数。 
rowcnt  bigint  基于 indid = 0 和 indid = 1 的数据级行计数。如果 indid = 255， rowcnt 设置为 0。 
rowmodctr  int  对自上次更新表的统计后插入、删除或更新行的总数进行计数。 
xmaxlen  smallint  最大行大小。 
maxirow  smallint  最大非叶索引行大小。 
OrigFillFactor  tinyint  创建索引时使用的起始填充因子值。不保留该值；然而，如果需要重新创建索引但记不住当初使用的填充因子，则该值可能很有帮助。 
reserved1  tinyint  保留。 
reserved2  int  保留。 
FirstIAM  binary(6)  保留。 
impid  smallint  保留。索引实现标志。 
lockflags  smallint  用于约束经过考虑的索引锁粒度。例如，对于本质上是只读的查找表，可以将其设置为仅进行表级锁定以使锁定成本减到最小。 
pgmodctr  int  保留。 
keys  varbinary(816)  组成索引键的列 ID 列表。 
name  sysname  表名（如果 indid = 0 或 255）。否则为索引的名称。 
statblob  image  统计 BLOB。 
maxlen  int  保留。 
rows  int  基于 indid = 0 和 indid = 1的数据级行数，该值对于 indid >1 重复。如果 indid = 255， rows 设置为 0。提供该列是为了向后兼容。 


sysmembers  页首

每个数据库角色成员在表中占一行。该表存储在每个数据库中。


列名

数据类型

描述

memberuid  smallint  角色成员的用户 ID。 
groupuid  smallint  角色的用户 ID。 


sysobjects 页首

在数据库内创建的每个对象（约束、默认值、日志、规则、存储过程等）在表中占一行。只有在 tempdb 内，每个临时对象才在该表中占一行。


列名

数据类型

描述

name  sysname  对象名。 
Id  int  对象标识号。 
xtype  char(2)  对象类型。可以是下列对象类型中的一种： 
C = CHECK 约束
D = 默认值或 DEFAULT 约束
F = FOREIGN KEY 约束
L = 日志
FN = 标量函数
IF = 内嵌表函数
P = 存储过程
PK = PRIMARY KEY 约束（类型是 K）
RF = 复制筛选存储过程
S = 系统表
TF = 表函数
TR = 触发器
U = 用户表
UQ = UNIQUE 约束（类型是 K）
V = 视图
X = 扩展存储过程
 
uid  smallint  所有者对象的用户 ID。 
info  smallint  保留。仅限内部使用。 
status  int  保留。仅限内部使用。 
base_schema_
ver  int  保留。仅限内部使用。 
replinfo  int  保留。供复制使用。 
parent_obj  int  父对象的对象标识号（例如，对于触发器或约束，该标识号为表 ID）。 
crdate  datetime  对象的创建日期。 
ftcatid  smallint  为全文索引注册的所有用户表的全文目录标识符，对于没有注册的所有用户表则为 0。  
schema_ver  int  版本号，该版本号在每次表的架构更改时都增加。 
stats_schema_
ver  int  保留。仅限内部使用。 
type  char(2)  对象类型。可以是下列值之一： 
C = CHECK 约束 
D = 默认值或 DEFAULT 约束
F = FOREIGN KEY 约束 
FN = 标量函数
IF = 内嵌表函数
K = PRIMARY KEY 或 UNIQUE 约束 
L = 日志
P = 存储过程
R = 规则
RF = 复制筛选存储过程
S = 系统表 
TF = 表函数
TR = 触发器
U = 用户表
V = 视图
X = 扩展存储过程
 
userstat  smallint  保留。 
sysstat  smallint  内部状态信息。 
indexdel  smallint  保留。 
refdate  datetime  留作以后使用。 
version  int  留作以后使用。 
deltrig  int  保留。 
instrig  int  保留。 
updtrig  int  保留。 
seltrig  int  保留。 
category  int  用于发布、约束和标识。 
cache  smallint  保留。 


syspermissions  页首

包含有关对数据库内的用户、组和角色授予和拒绝的权限的信息。该表存储在每个数据库中。


列名

数据类型

描述

id  int  对象权限的对象 ID；0 表示语句权限。 
grantee  smallint  受权限影响的用户、组或角色的 ID。 
grantor  smallint  被授予或废除权限的用户、组或角色的 ID。 
actadd  smallint  仅限内部使用。 
actmod  smallint  仅限内部使用。 
seladd  varbinary(4000)  仅限内部使用。 
selmod  varbinary(4000)  仅限内部使用。 
updadd  varbinary(4000)  仅限内部使用。 
updmod  varbinary(4000)  仅限内部使用。 
refadd  varbinary(4000)  仅限内部使用。 
refmod  varbinary(4000)  仅限内部使用。 


systypes  页首

对于每种系统提供数据类型和用户定义数据类型，均包含一行信息。该表存储在每个数据库中。

这些是系统提供的数据类型及其 ID 号。


列名

数据类型

描述

name  sysname  数据类型名称。 
xtype  tinyint  物理存储类型。 
status  tinyint  仅限内部使用。 
xusertype  smallint  扩展用户类型。 
length  smallint  数据类型的物理长度。 
xprec  tinyint  服务器所使用的内部精度。（不能在查询中使用。） 
xscale  tinyint  服务器所使用的内部小数位数。（不能在查询中使用。） 
tdefault  int  对此数据类型进行完整性检查的存储过程的 ID。 
domain  int  对此数据类型进行完整性检查的存储过程的 ID。 
uid  smallint  数据类型创建者的用户 ID。 
reserved  smallint  仅限内部使用。 
usertype  smallint  用户类型 ID。 
variable  bit  可变长度数据类型为 1；否则为 0。 
allownulls  bit  指出此数据类型的默认为空性。如果 CREATE 或 ALTER TABLE 指定了为空性，那么该值将替代此数据类型的默认为空性。 
type  tinyint  物理存储数据类型。 
printfmt  varchar(255)  保留。 
prec  smallint  此数据类型的精度级别。 
scale  tinyint  此数据类型的小数位数（根据精度）。 


sysusers 页首

数据库中每个 Microsoft? Windows 用户、Windows 组、Microsoft SQL Server? 用户或 SQL Server 角色在表中占一行。


列名

数据类型

描述

uid  smallint  用户 ID，在此数据库中是唯一的。1 是数据库所有者。 
status  smallint  仅限内部使用。 
Name  sysname  用户名或组名，在此数据库中是唯一的。 
sid  varbinary(85)  此条目的安全性标识符。 
roles  varbinary(2048)  仅限内部使用。 
createdate  datetime  帐户的添加日期。 
updatedate  datetime  帐户的上次修改日期。 
altuid  smallint  仅限内部使用。 
password  varbinary(256)  仅限内部使用。 
gid  smallint  此用户所属的组 ID。如果 uid = gid ，那么此条目就定义一个组。 
environ  varchar(255)  保留。 
hasdbaccess  int  如果该帐户有数据库访问权限，则为 1。 
islogin  int  如果该帐户是有登录帐户的 Windows 组、Windows 用户或 SQL Server 用户，则为 1。 
isntname  int  如果该帐户是 Windows 组或 Windows 用户，则为 1。 
isntgroup  int  如果该帐户是 Windows 组，则为 1。 
isntuser  int  如果该帐户是 Windows 用户，则为 1。 
issqluser  int  如果该帐户是 SQL Server 用户，则为 1。 
isaliased  int  如果该帐户以另一个用户为别名，则为 1。 
issqlrole  int  如果该帐户是 SQL Server 角色，则为 1。 
isapprole  int  如果该帐户是应用程序角色，则为 1。 

~~~