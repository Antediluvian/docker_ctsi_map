#! /bin/bash

docker run --name="pg_map_2014_q3" -d -e "TZ=Asia/Shanghai" -v /home/postgresql ctsi/postgresql true

docker run --privileged=true --name="pg_map_01" -d -e "TZ=Asia/Shanghai" -p 5432:5432 --volumes-from pg_map_2014_q3 -v $(pwd)/postgresql/postgresql.conf:/home/postgresql/data/postgresql.conf ctsi/postgresql
