FROM ctsi/centos:7.0.1406
MAINTAINER Cui Wei <cuiwei@ctsi.com.cn>

# Install the necessary software and libs.
RUN yum -y install http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm &&\
 yum -y install http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm &&\
 yum -y install wget tar && yum -y clean all


# The setuptools environment variables.
ENV SETUPTOOLS_VER 14.3


# Install the supervisord.
RUN cd /home &&\
 wget http://config.sufor.cc/python/setuptools-$SETUPTOOLS_VER.tar.gz &&\
 tar xvzf setuptools-$SETUPTOOLS_VER.tar.gz &&\
 cd setuptools-$SETUPTOOLS_VER &&\
 python setup.py install &&\
 cd /home &&\
 easy_install -i http://pypi.douban.com/simple supervisor &&\
 rm * -rf
