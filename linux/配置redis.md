# 配置redis
1. 下载源码，解压缩后编译源码。
~~~ cmd
$ wget http://download.redis.io/releases/redis-2.8.3.tar.gz
$ tar xzf redis-2.8.3.tar.gz
$ cd redis-2.8.3
$ make
~~~
2. 编译完成后，在Src目录下，有四个可执行文件redis-server、redis-benchmark、redis-cli和redis.conf(redis.config文件和src同级)。然后拷贝到一个目录下。
~~~ cmd
$ mkdir /home/zjy/redis
$ cp redis-server /home/zjy/redis
$ cp redis-benchmark /home/zjy/redis
$ cp redis-cli /home/zjy/redis
$ cp ../redis.conf /home/zjy/redis
$ cd /home/zjy/redis
~~~
3. 启动Redis服务。
~~~ cmd
$ ./redis-server redis.conf
~~~
4. 然后用客户端测试一下是否启动成功。
~~~ cmd
$ ./redis-cli
redis> set foo bar
OK
redis> get foo
"bar"
~~~