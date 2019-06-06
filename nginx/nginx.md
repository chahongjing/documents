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