#! /bin/bash

docker run --privileged=true --name="ngx_01"\
 -d -e "TZ=Asia/Shanghai" -p 80:80 -p 443:443\
 -v $(pwd)/site-enabled:/home/site-enabled\
 -v $(pwd)/supervisord.conf:/home/supervisord.conf ctsi/nginx
