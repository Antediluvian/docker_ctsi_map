#! /bin/bash

docker run --name="pg_map_2014_q3" -d -e "TZ=Asia/Shanghai" -v /home/postgresql ctsi/postgresql true

docker run --privileged=true --name="pg_map_01"\
 --volumes-from pg_map_2014_q3 -d -e "TZ=Asia/Shanghai" -p 5432:5432\
 -v $(pwd)/postgresql.conf:/home/postgresql/data/postgresql.conf\
 -v $(pwd)/supervisord.conf:/home/supervisord.conf ctsi/postgresql
