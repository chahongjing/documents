::1.�����ڹ�������MongoDB����ѹ��D��mongodbSet�ļ�����

::2.��D���½�MongoDB�ļ��У�������Ŀ¼���½�MongoDB\data\db��MongoDB\logs 

::����Ա����cmd

::MongoDbĿ¼�����mongo.config�ļ�
::����Ϊ
::##�����ļ�
::dbpath=C:\MongoDB\data
::
::##��־�ļ�
::logpath=C:\MongoDB\logs\mongo.log

cd C:\mongodbset\bin

mongod.exe --dbpath C:\mongodb\data\db

mongod.exe --config C:\MongoDB\mongo.config