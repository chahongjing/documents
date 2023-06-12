```shell
# redis
docker run --name redis -v /d/workspace/code/my/mvc/web/build/compose/redis/conf/redis.conf:/etc/redis/redis.conf -v /d/workspace/code/my/mvc/web/build/compose/redis/data:/data -v /d/workspace/code/my/mvc/web/build/compose/redis/tmp/redis/logs:/logs -p 6379:6379 redis:7.0.11 redis-server /etc/redis/redis.conf

# nginx
docker run --name nginx -v /d/workspace/code/my/mvc/web/build/compose/nginx/conf/nginx.conf:/etc/nginx/nginx.conf -v /d/workspace/code/my/mvc/web/build/compose/nginx/conf/conf.d:/etc/nginx/conf.d -v /d/tmp/logs/nginx:/var/log/nginx -v /d/tmp/logs/nginx/html:/usr/share/nginx/html -p 80:80 -p 443:443 nginx:1.25.0

# mysql8
docker run --name mysql8 -v /d/tmp/logs/mysql8/data:/var/lib/mysql -v /d/tmp/logs/mysql8/conf.d:/etc/mysql/conf.d -p 3306:3306 -p 33060:33060 -e MYSQL_ROOT_PASSWORD=123456 mysql:8.0.33
```