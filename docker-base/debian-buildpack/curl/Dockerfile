FROM ctsi/debian:wheezy
MAINTAINER Cui Wei <cuiwei1@ctsi.com.cn>

RUN rm /etc/apt/sources.list &&\
 echo deb http://mirrors.163.com/debian wheezy main >> /etc/apt/sources.list &&\
 echo deb http://mirrors.163.com/debian wheezy-updates main >> /etc/apt/sources.list &&\
 echo deb http://mirrors.163.com/debian wheezy-backports main contrib >> /etc/apt/sources.list

RUN apt-get update\
 && apt-get install -y --no-install-recommends ca-certificates curl wget tar\
 && rm -rf /var/lib/apt/lists/*
