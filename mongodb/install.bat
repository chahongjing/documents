mongod.exe --logpath F:\software\mongodb3.6\bin\log\mongodb.log --logappend --dbpath F:\software\mongodb3.6\bin\data --directoryperdb --serviceName MongoDB --install --bind_ip 0.0.0.0

rem remove service
rem mongod.exe --remove --serviceName "MongoDB"
rem sc delete MongoDB