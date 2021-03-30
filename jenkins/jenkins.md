``` shell
#!/bin/bash
#域名：获取的jenkins 项目名称，建项目的时候确保jenkins名称正确
domain="${JOB_NAME}"
#tomcat实例个数，一般默认1
domain_num=1
package="${package}"
deployid=${package}_${BUILD_ID}

#make up directory
mkdir -p /web/logs/${domain}
# stop the application
ps -ef |grep ${package}.jar|grep -v grep  |awk '{print $2}'|xargs kill -9 

#add nginx configration file
domain_conf="/web/servers/serverconf/${domain}.conf"
if [ ! -f "${domain_conf}" ]; then		
	cp /home/dmadmin/deploy/domain.conf ${domain_conf}
	sed -i "s/{domain}/${domain}/g" ${domain_conf}
else
	sed -i "/weight=10 max_fails=2 fail_timeout=30s;/d" ${domain_conf}
fi
#判断jar是否存在，不存在直接退出
package_path="/web/app/deploy/${package}.jar "
if [ ! -e /web/app/deploy/${package}.jar ];then
    echo "$package_path不存在文件，请重新检查Source files包名字或路劲"
    exit 1
fi
# insert upstream into nginx domain

spring_domain="/web/app/${domain}"
if [ ! -d "${spring_domain}" ]; then
	#不存在域名路径，则向Python接口传要创建的域名和tomcat实例个数
       mkdir -p  /web/jenkins/
        cd /web/jenkins/
        rm -rf python-port*
        scp dmadmin@10.248.8.20:/home/dmadmin/luhuan/jenkins_auto_port/python-port.tar .
        tar -xzvf python-port.tar
	python3 /web/jenkins/jenkins_spring_port.py $domain $domain_num
        
fi
#start the application
dir=`ls $spring_domain`
for i in $dir
do
	 #echo $i
         server_dir="^server8[0-9]{3}$"
         if [[  "$i" =~ $server_dir ]];then
         port=${i#*server}
         echo $i $port
         sed -i "1 a    server ${serverip}:${port}  weight=10 max_fails=2 fail_timeout=30s;" ${domain_conf}
         rsync -avzu ${domain_conf} dmadmin@10.248.8.13:/web/servers/tengine/conf/domains_lightning_inner
                   rm -rf /web/app/${domain}/$i/*
                   #move application to app
                  echo "/web/app/${domain}/$i/${package}.jar"
                   mv  /web/app/deploy/${package}.jar  /web/app/${domain}/$i/
	          nohup /usr/java/jdk1.8.0_60/bin/java -jar /web/app/${domain}/$i/${package}.jar  --server.port=${port}  > /web/logs/${domain}/nohuplog.log 2>&1 &
fi
done
echo "`date ` deploy  ${deployid}" >> /web/app/deploy/deploy.log
```

## jenkins安装
[jenkins](https://blog.csdn.net/liuxiangke0210/article/details/106761904)