FROM ctsi/debian-buildpack:curl
MAINTAINER Cui Wei <cuiwei1@ctsi.com.cn>

RUN cd /home\
 && apt-get update && apt-get -y -t wheezy-backports install java-package\
 && wget http://config.sufor.cc/software/debian/jre-8u40-linux-x64.tar.gz


RUN fakeroot make-jpkg jre-8u40-linux-x64.tar.gz\
 && dpkg -i oracle-java8-jre_8u40_amd64.deb\
 && rm -rf /var/lib/apt/lists/*
