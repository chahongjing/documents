# nginx
~~~ cmd
rem 启动nginx，注意启动后不能直接关闭cmd，这样nginx进程不会结束，会导致个性配置文件后不生效。要用下面的命令关闭nginx
start nginx
rem 
nginx -c /path/to/nginx.conf
rem 修改配置后重新加载生效
nginx -s reload
rem 重新打开日志文件
nginx -s reopen
rem 测试nginx配置文件是否正确
nginx -t -c /path/to/nginx.conf

rem 快速停止nginx
nginx -s stop
rem 完整有序的停止nginx
nginx -s quit
rem 其他的停止nginx 方式：
ps -ef | grep nginx
rem 从容停止Nginx
kill -QUIT 主进程号
rem 快速停止Nginx
kill -TERM 主进程号
rem 强制停止Nginx
pkill -9 nginx

rem 平滑重启nginx
kill -HUP 主进程号
~~~~
### 节点配置
1. 在http节点下配置服务结点，mynodes为自定义名称，在第二步中要与这个名字保持一致
~~~ json
upstream mynodes {
    server 127.0.0.1:20000;
    server 127.0.0.1:20001;
}
~~~
2. 在http --> server --> location节点下添加`proxy_pass http://mynodes;`。其中mynodes要和上面配置的节点名称一致
~~~
location / {
    root   html;
    index  index.html index.htm;
    proxy_pass http://mynodes; 
}
proxy_pass http://mynodes; 
~~~
3. 以上配置完成后nginx会监听http --> server中listen端口的请求自动转到mynodes下面的节点中的一个进行负载均衡。
### 多域名映射多节点配置
1. 在http节点下添加设置`server_names_hash_bucket_size 64;`注意末尾的分号。，否则无法启动，报错误：could not build server_names_hash, you should increase server_names_hash_bucket_size: 32
2. 在配置文件nginx.conf所在目录添加domain文件夹，在nginx.conf文件中http节点下添加`include domains/*.conf;`注意末尾的分号。
![1](../imgs/nginx/1.png)
3. 进入domain文件夹下，添加对应配置文件。内容如下
![2](../imgs/nginx/22222.png)
~~~ ini
upstream dev.your.domain.com {
    server 127.0.0.1:21002;
}

server {
    listen       80;
    server_name  dev.your.domain.com;

    location / {
        root   html;
        index  index.html index.htm;
        proxy_pass http://dev.your.domain.com; 
    }
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   html;
    }
}
~~~
### 请求信息大小限制（如上传）
- 在http节点中添加`client_max_body_size 20M;`注意末尾的分号。
