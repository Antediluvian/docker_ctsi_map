#! /bin/bash

docker run --privileged=true --name="tc_8080"\
 -d -e "TZ=Asia/Shanghai" -p 8080:8080\
 -v $(pwd)/webapps:/home/tomcat/webapps\
 -v $(pwd)/supervisord.conf:/home/supervisord.conf ctsi/tomcat
