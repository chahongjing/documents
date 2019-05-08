# [spring + redis分布式session方案](https://www.cnblogs.com/williamjie/p/9155748.html)
### Maven依赖
~~~ xml
<!-- Jedis -->
<dependency>
    <groupId>redis.clients</groupId>
    <artifactId>jedis</artifactId>
    <version>3.0.1</version>
</dependency>
<!-- Spring Data Redis -->
<dependency>
    <groupId>org.springframework.data</groupId>
    <artifactId>spring-data-redis</artifactId>
    <version>2.1.6.RELEASE</version>
</dependency>
<!-- Spring Session -->
<dependency>
    <groupId>org.springframework.session</groupId>
    <artifactId>spring-session</artifactId>
    <version>1.3.5.RELEASE</version>
</dependency>
<!-- Apache Commons Pool -->
<dependency>
    <groupId>org.apache.commons</groupId>
    <artifactId>commons-pool2</artifactId>
    <version>2.6.2</version>
</dependency>
~~~
### 配置Filter
~~~ xml
<filter>
    <filter-name>springSessionRepositoryFilter</filter-name>
    <filter-class>org.springframework.web.filter.DelegatingFilterProxy</filter-class>
</filter>
<filter-mapping>
    <filter-name>springSessionRepositoryFilter</filter-name>
    <url-pattern>/*</url-pattern>
    <dispatcher>REQUEST</dispatcher>
    <dispatcher>ERROR</dispatcher>
</filter-mapping>
~~~
### Spring配置文件
~~~ xml
<bean class="org.springframework.session.data.redis.config.annotation.web.http.RedisHttpSessionConfiguration"/>

<bean class="org.springframework.data.redis.connection.jedis.JedisConnectionFactory">
    <property name="hostName" value="localhost" />
    <property name="password" value="your-password" />
    <property name="port" value="6379" />
    <property name="database" value="10" />
</bean>
~~~
### 解决Redis云服务Unable to configure Redis to keyspace notifications异常
- Context initialization failed org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'enableRedisKeyspaceNotificationsInitializer' defined in class path resource [org/springframework/session/data/redis/config/annotation/web/http/RedisHttpSessionConfiguration.class]:
Invocation of init method failed; nested exception is java.lang.IllegalStateException: Unable to configure Redis to keyspace notifications.
See http://docs.spring.io/spring-session/docs/current/reference/html5/#api-redisoperationssessionrepository-sessiondestroyedevent
Caused by: redis.clients.jedis.exceptions.JedisDataException: ERR unknown command config
- 实际上这种异常发生的原因是，很多Redis云服务提供商考虑到安全因素，会禁用掉Redis的config命令：Redis需要以下的配置：redis-cli config set notify-keyspace-events Egx。http://docs.spring.io/spring-session/docs/current/reference/html5/#api-redisoperationssessionrepository-sessiondestroyedevent
- 首先要想办法给云服务Redis加上这个配置。部分Redis云服务提供商可以在对应的管理后台配置：
- 然后还需要在Spring配置文件中加上一个配置，让Spring Session不再执行config命令：
~~~ xml
<!-- 让Spring Session不再执行config命令 -->
<util:constant static-field="org.springframework.session.data.redis.config.ConfigureRedisAction.NO_OP"/>
~~~