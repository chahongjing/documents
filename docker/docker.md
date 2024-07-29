```shell
# redis
docker run --name redis -v /d/workspace/code/my/mvc/web/build/compose/redis/conf/redis.conf:/etc/redis/redis.conf -v /d/workspace/code/my/mvc/web/build/compose/redis/data:/data -v /d/workspace/code/my/mvc/web/build/compose/redis/tmp/redis/logs:/logs -p 6379:6379 redis:7.0.11 redis-server /etc/redis/redis.conf

# nginx
docker run --name nginx -v /d/workspace/code/my/mvc/web/build/compose/nginx/conf/nginx.conf:/etc/nginx/nginx.conf -v /d/workspace/code/my/mvc/web/build/compose/nginx/conf/conf.d:/etc/nginx/conf.d -v /d/tmp/logs/nginx:/var/log/nginx -v /d/tmp/logs/nginx/html:/usr/share/nginx/html -p 80:80 -p 443:443 nginx:1.25.0

# mysql8
docker run --name mysql8 -v /d/tmp/logs/mysql8/data:/var/lib/mysql -v /d/tmp/logs/mysql8/conf.d:/etc/mysql/conf.d -p 3306:3306 -p 33060:33060 -e MYSQL_ROOT_PASSWORD=123456 mysql:8.0.33
```

#### 制作镜像
```shell
# 精简linux
FROM alpine:3.20.0

USER root
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
    && apk update --no-cache && apk add --no-cache tzdata shadow net-tools curl wget tcpdump git gawk grep procps htop sysstat bash zsh iftop nload \
    && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
    && mkdir -p /home/work/data/www && mkdir -p /home/work/logs/applogs && mkdir -p /home/work/app/mitelemetry/agent \
    && groupadd -g 10000 work && useradd -m -u 10000 -g work -s /bin/zsh work \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

SHELL ["/bin/zsh", "-c"]

ENV TZ=Asia/Shanghai

WORKDIR /home/work/data
```

```shell
# 基于上面的最精简版linux，制作jdk
FROM hub.pf.xiaomi.com/asp-operation-web/alpine:3.20.1
# https://adoptium.net/zh-CN/temurin/archive/?version=8 自行下载 Alpine Linux x64 版本JDK
COPY ./alpine-jdk8u412 /home/work/app/openjdk

ENV JAVA_HOME=/home/work/app/openjdk
ENV PATH $PATH:$JAVA_HOME/bin
```