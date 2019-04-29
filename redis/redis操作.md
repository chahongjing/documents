### jedis
#### String
~~~ java
jedis.set(key, value);
jedis.del(key);
~~~

#### Hash
~~~ java
// 添加
jedis.hset(hash, key, value);
jedis.hmset(hash, Map<key, value> map);
// 获取所有值
jedis.hvals(hash)
// 所有键
jedis.hkeys(hash)
// 是否存在健
jedis.hexists("hashs", "key003")
// 获取key001和key003的值
jedis.hmget(hash, "key001", "key003")
// 删除
jedis.hdel(hash, key);
~~~

#### List
~~~ java
// 左侧添加
jedis.lpush(key, "Google");
// 可重复
jedis.lpush(key, "Google");
jedis.lpush(key, "Apple");
// 右侧添加
jedis.rpush(key, "Apple");
// 全部取出，不会影响redis中的数据，使用pop则会影响redis中的数据
List<String> list = jedis.lrange(key, 0, -1 );
// list长度
jedis.llen("key")
// 删除，第二个参数为删除的个数（有重复时），后add进去的值先被删，类似于出栈
jedis.lrem(key, 2, "Google")
// 右侧删除
jedis.rrem(key, 2, "Google")
// 左侧阻塞出栈
jedis.blpop(timeout, key);
// 右侧阻塞出栈
jedis.brpop(timeout, key);
~~~

#### Set
~~~ java
jedis.sadd(key, "member1");
// Set不允许重复
jedis.sadd(key, "member1");
jedis.sadd(key, "member2");
// 获取元素数量
jedis.scard(KEY)
// 查看所有元素
jedis.smembers(key)
// 交集
jedis.sinter("sets1", "sets2")
// 并集
jedis.sunion("sets1", "sets2")
// 差集
jedis.sdiff("sets1", "sets2")
// 删除
jedis.srem(key,"member1");
~~~

#### SortedSet
~~~ java
// 第二项score为排序的依据，允许重复，第三项member重复时，以最后添加score的为准
jedis.zadd(key, 1, "C++");
jedis.zadd(key, 3, "Java");
jedis.zadd(key, 1, "Java");
jedis.zadd(key, 4, "Java");
jedis.zadd(key, 2, "Python");
jedis.zadd(key, 2, "Go");
// 获取所有元素
jedis.zrange(key, 0, -1)
// 元素个数
jedis..zcard(key)
// 权重在1-5之间的数量
shardedJedis.zcount(key, 1.0, 5.0)
// 删除
jedis.zrem(key, "C++");
~~~
### [redission操作](https://aperise.iteye.com/blog/2396196)
~~~ java
RBucket<String> keyObject = redissonClient.getBucket("key");  
//如果key存在，就设置key的值为新值value  
//如果key不存在，就设置key的值为value  
keyObject.set("value");  
~~~
# 常用命令
#### 连接操作命令
|命令|说明|
|-|-|
|quit|关闭连接（connection）|
|auth|简单密码认证|
|help cmd|查看cmd帮助，例如|help quit|

#### 持久化
|命令|说明|
|-|-|
|save|将数据同步保存到磁盘|
|bgsave|将数据异步保存到磁盘|
|lastsave|返回上次成功将数据保存到磁盘的Unix时戳|
|shundown|将数据同步保存到磁盘，然后关闭服务|

#### 远程服务控制
|命令|说明|
|-|-|
|info|提供服务器的信息和统计|
|monitor|实时转储收到的请求|
|slaveof|改变复制策略设置|
|config|在运行时配置Redis服务器|

#### 对value操作的命令
|命令|说明|
|-|-|
|exists(key)|确认一个key是否存在|
|del(key)|删除一个key|
|type(key)|返回值的类型|
|keys(pattern)|返回满足给定pattern的所有key|
|randomkey|随机返回key空间的一个|
|keyrename(oldname, newname)|重命名key|
|dbsize|返回当前数据库中key的数目|
|expire|设定一个key的活动时间（s）|
|ttl|获得一个key的活动时间|
|select(index)|按索引查询|
|move(key, dbindex)|移动当前数据库中的key到dbindex数据库|
|flushdb|删除当前选择数据库中的所有key|
|flushall|删除所有数据库中的所有key|

#### String
|命令|说明|
|-|-|
|set(key, value)|给数据库中名称为key的string赋予值value|
|get(key)|返回数据库中名称为key的string的value|
|getset(key, value)|给名称为key的string赋予上一次的value|
|mget(key1, key2,…, key N)|返回库中多个string的value|
|setnx(key, value)|添加string，名称为key，值为value|
|setex(key, time, value)|向库中添加string，设定过期时间time|
|mset(key N, value N)|批量设置多个string的值|
|msetnx(key N, value N)|如果所有名称为key i的string都不存在|
|incr(key)|名称为key的string增1操作|
|incrby(key, integer)|名称为key的string增加integer|
|decr(key)|名称为key的string减1操作|
|decrby(key, integer)|名称为key的string减少integer|
|append(key, value)|名称为key的string的值附加value|
|substr(key, start, end)|返回名称为key的string的value的子串|

#### Hash
|命令|说明|
|-|-|
|hset(key, field, value)|向名称为key的hash中添加元素field|
|hget(key, field)|返回名称为key的hash中field对应的value|
|hmget(key, (fields))|返回名称为key的hash中field i对应的value|
|hmset(key, (fields))|向名称为key的hash中添加元素field |
|hincrby(key, field, integer)|将名称为key的hash中field的value增加integer|
|hexists(key, field)|名称为key的hash中是否存在键为field的域|
|hdel(key, field)|删除名称为key的hash中键为field的域|
|hlen(key)|返回名称为key的hash中元素个数|
|hkeys(key)|返回名称为key的hash中所有键|
|hvals(key)|返回名称为key的hash中所有键对应的value|
|hgetall(key)|返回名称为key的hash中所有的键（field）及其对应的value|

#### List
|命令|说明|
|-|-|
|rpush(key, value)|在名称为key的list尾添加一个值为value的元素|
|lpush(key, value)|在名称为key的list头添加一个值为value的 元素|
|llen(key)|返回名称为key的list的长度|
|lrange(key, start, end)|返回名称为key的list中start至end之间的元素|
|ltrim(key, start, end)|截取名称为key的list|
|lindex(key, index)|返回名称为key的list中index位置的元素|
|lset(key, index, value)|给名称为key的list中index位置的元素赋值|
|lrem(key, count, value)|删除count个key的list中值为value的元素|
|lpop(key)|返回并删除名称为key的list中的首元素|
|rpop(key)|返回并删除名称为key的list中的尾元素|
|blpop(key1, key2,… key N, timeout)|lpop命令的block版本。|
|brpop(key1, key2,… key N, timeout)|rpop的block版本。|
|rpoplpush(srckey, dstkey)|返回并删除名称为srckey的list的尾元素，并将该元素添加到名称为dstkey的list的头部|

#### Set
|命令|说明|
|-|-|
|sadd(key, member)|向名称为key的set中添加元素member|
|srem(key, member) |删除名称为key的set中的元素member|
|spop(key) |随机返回并删除名称为key的set中一个元素|
|smove(srckey, dstkey, member) |移到集合元素|
|scard(key) |返回名称为key的set的基数|
|sismember(key, member) |member是否是名称为key的set的元素|
|sinter(key1, key2,…key N) |求交集|
|sinterstore(dstkey, (keys)) |求交集并将交集保存到dstkey的集合|
|sunion(key1, (keys)) |求并集|
|sunionstore(dstkey, (keys)) |求并集并将并集保存到dstkey的集合|
|sdiff(key1, (keys)) |求差集|
|sdiffstore(dstkey, (keys)) |求差集并将差集保存到dstkey的集合|
|smembers(key) |返回名称为key的set的所有元素|
|srandmember(key) |随机返回名称为key的set的一个元素|

#### SortedSet
|命令|说明|
|-|-|
|zadd(key, member)|向名称为key的set中添加元素member|
|zrem(key, member) |删除名称为key的set中的元素member|
|zcount||
|zcard(key) |返回名称为key的set的基数|
|zinterstore(dstkey, (keys)) |求交集并将交集保存到dstkey的集合|
|zunionstore(dstkey, (keys)) |求并集并将并集保存到dstkey的集合|
|zmembers(key) |返回名称为key的set的所有元素|
|zrandmember(key) |随机返回名称为key的set的一个元素|