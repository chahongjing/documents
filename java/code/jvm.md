#### cms
```ini
-Xms4g  
-Xmx4g  
-Xmn2g  
-Xss1m  
-XX:SurvivorRatio=8  
-XX:MaxTenuringThreshold=10  
-XX:+UseConcMarkSweepGC  
-XX:CMSInitiatingOccupancyFraction=70  
-XX:+UseCMSInitiatingOccupancyOnly  
-XX:+AlwaysPreTouch  
-XX:+HeapDumpOnOutOfMemoryError  
-verbose:gc  
-XX:+PrintGCDetails  
-XX:+PrintGCDateStamps  
-XX:+PrintGCTimeStamps  
-Xloggc:gc.log  
```

#### g1
```ini
-Xms8g  
-Xmx8g  
-Xss1m  
-XX:+UseG1GC  
-XX:MaxGCPauseMillis=150  
-XX:InitiatingHeapOccupancyPercent=40  
-XX:+HeapDumpOnOutOfMemoryError  
-verbose:gc  
-XX:+PrintGCDetails  
-XX:+PrintGCDateStamps  
-XX:+PrintGCTimeStamps  
-Xloggc:gc.log
```

#### g1
```ini
-Xms10g -Xmx10g -server -verbose:gc -Xloggc:/home/work/logs/applogs/gc_%t.log -XX:ErrorFile=vmerr.log -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/home/work/logs/applogs/ -XX:+DisableExplicitGC -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps -XX:+PrintHeapAtGC -XX:+PrintTenuringDistribution -XX:+PrintReferenceGC -XX:MetaspaceSize=512m -XX:MaxMetaspaceSize=512m -XX:ReservedCodeCacheSize=256m -XX:InitialCodeCacheSize=256m -XX:+PrintAdaptiveSizePolicy -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:G1LogLevel=finest -XX:NativeMemoryTracking=detail -Dmanagement.metrics.tags.application=operation-manage-service -XX:CompressedClassSpaceSize=128m -Djava.library.path=/opencv-3.4.3/build/lib -XX:+UseStringDeduplication -XX:ParallelGCThreads=4 -XX:+AlwaysPreTouch
```

#### g1
```ini
-Xmx3500m -Xms3500m -XX:+UseG1GC -XX:MaxGCPauseMillis=100
-XX:G1ReservePercent=10 -XX:ConcGCThreads=2 -XX:ParallelGCThreads=5
-XX:G1HeapRegionSize=16m -XX:MaxTenuringThreshold=14
-XX:SurvivorRatio=8
```

#### zgc
```ini
--add-opens=java.base/java.lang=ALL-UNNAMED \
-Xms1500m -Xmx1500m \
-XX:ReservedCodeCacheSize=256m \
-XX:InitialCodeCacheSize=256m \ 
-XX:+UnlockExperimentalVMOptions \
-XX:+UseZGC \
-XX:ConcGCThreads=1 -XX:ParallelGCThreads=2 \
-XX:ZCollectionInterval=30 -XX:ZAllocationSpikeTolerance=5 \
-XX:+UnlockDiagnosticVMOptions -XX:-ZProactive \
-Xlog:safepoint,classhisto*=trace,age*,gc*=info:file=/opt/gc-%t.log:time,tid,tags:filecount=5,filesize=50m \
-XX:+HeapDumpOnOutOfMemoryError \
-XX:HeapDumpPath=/opt/errorDump.hprof
```