#! /bin/bash

docker run --privileged=true --name="ngx_01"\
 -d -e "TZ=Asia/Shanghai" -p 80:80 -p 443:443\
 -v $(pwd)/etc/site-enabled:/home/nginx/etc/site-enabled\
 -v $(pwd)/etc/nginx.conf:/home/nginx/etc/nginx.conf\
 -v $(pwd)/etc/conf.d:/home/nginx/etc/conf.d\
 -v $(pwd)/supervisord.conf:/home/supervisord.conf ctsi/nginx
