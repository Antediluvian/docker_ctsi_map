#! /bin/bash

docker run --name "ts_cache_01" -d -v /home/cache ctsi/tilestache true
docker run --name "ts_01" --privileged=true -d -p 8001:8001 -p 8002:8002 -p 8003:8003 -p 8004:8004 \
 -v $(pwd)/tilestache:/mnt/tilestache --volumes-from ts_cache_01 --link pg_map_01:db_01 ctsi/tilestache
