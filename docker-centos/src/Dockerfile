FROM ctsi/centos:7.0.1406
MAINTAINER Cui Wei <cuiwei@ctsi.com.cn>

# Run the system update and install the necessary software, libs.
RUN yum -y install http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm &&\
 yum -y install http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm &&\
 yum -y update &&\
 yum -y install wget bzip2 make tar openssh-server vim &&\
 yum -y clean all


# The python environment variables.
ENV PY_HOME /home/python

# Copy the setuptools file.
COPY setuptools-12.0.5.tar.gz $PY_HOME/setuptools-12.0.5.tar.gz

# Install the supervisord.
RUN mkdir -p $PY_HOME &&\
 cd $PY_HOME &&\
 tar xvzf setuptools-12.0.5.tar.gz &&\
 cd setuptools-12.0.5 &&\
 python setup.py install &&\
 cd $PY_HOME &&\
 rm setuptools-12.0.5 -rf &&\
 rm *.tar.* -rf &&\
 easy_install -i http://pypi.douban.com/simple pip &&\
 pip install -i http://pypi.douban.com/simple --trusted-host pypi.douban.com virtualenv &&\
 virtualenv .ve &&\
 source ./.ve/bin/activate &&\
 pip install -i http://pypi.douban.com/simple --trusted-host pypi.douban.com -U setuptools &&\
 pip install -i http://pypi.douban.com/simple --trusted-host pypi.douban.com supervisor &&\
 deactivate
