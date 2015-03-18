#! /bin/bash

docker run --privileged=true --name="rds_01"\
 -d -e "TZ=Asia/Shanghai" -p 6379:6379\
 -v $(pwd)/redis.conf:/home/redis.conf\
 -v $(pwd)/supervisord.conf:/home/supervisord.conf ctsi/redis
