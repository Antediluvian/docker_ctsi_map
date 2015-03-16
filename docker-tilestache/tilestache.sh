#! /bin/bash

docker run --name "ts_cache_01" -d -v /home/cache ctsi/uwsgi true
docker run --name "ts_01" --privileged=true -d -p 8001:8001 -p 8002:8002 -p 8003:8003 -p 8004:8004 \
 -v $(pwd)/uwsgi:/mnt/uwsgi --volumes-from ts_cache_01 --link pg_01:db ctsi/uwsgi

