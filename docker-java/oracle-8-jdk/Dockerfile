FROM ctsi/centos-buildpack:curl
MAINTAINER Cui Wei <cuiwei1@ctsi.com.cn>

RUN cd /home\
 && wget http://config.sufor.cc/software/centos/jdk-8u40-linux-x64.rpm\
 && rpm -ivh jdk-8u40-linux-x64.rpm\
 && rm *.rpm -rf
