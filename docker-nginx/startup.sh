#! /bin/bash

docker run --privileged=true --name="ngx_01"\
 -d -e "TZ=Asia/Shanghai" -p 80:80 -p 443:443\
 --link tc_8080:tomcat_test\
 -v $(pwd)/etc/sites-enabled:/home/nginx/etc/sites-enabled\
 -v $(pwd)/etc/cert:/home/nginx/etc/cert\
 -v $(pwd)/etc/nginx.conf:/home/nginx/etc/nginx.conf\
 -v $(pwd)/etc/conf.d:/home/nginx/etc/conf.d\
 -v $(pwd)/supervisord.conf:/home/supervisord.conf ctsi/nginx
