mongod.exe --logpath F:\software\mongodb3.6\bin\log\mongodb.log --logappend --dbpath F:\software\mongodb3.6\bin\data --directoryperdb --serviceName MongoDB --install

rem remove service
rem mongod.exe --remove --serviceName "MongoDB"
rem sc delete MongoDB