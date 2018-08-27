drop public database link testlibra;
create public database link testlibra
connect to libra2 identified by libra2
using '(DESCRIPTION =
(ADDRESS_LIST =
(ADDRESS = (PROTOCOL = TCP)(HOST = 172.16.16.202)(PORT = 1521))
)
(CONNECT_DATA =
(ORACLE_SID=libra)
)
)';

seLect * from tk_shijuan@TESTLIBRA