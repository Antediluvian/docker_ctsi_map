FROM ctsi/centos:7.0.1406
MAINTAINER Cui Wei <cuiwei@ctsi.com.cn>

# Run the system update and install the necessary software, libs.
RUN yum -y install http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm &&\
 yum -y install http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm &&\
 yum -y update &&\
 yum -y install wget bzip2 make tar vim gcc-c++ cmake openssh-server &&\
 yum -y clean all


# The python environment variables.
ENV PY_HOME /home/python
ENV SETUPTOOLS_VER 14.3

# Copy the setuptools file.
COPY setuptools-$SETUPTOOLS_VER.tar.gz $PY_HOME/setuptools-$SETUPTOOLS_VER.tar.gz

# Install the supervisord.
RUN mkdir -p $PY_HOME &&\
 cd $PY_HOME &&\
 tar xvzf setuptools-$SETUPTOOLS_VER.tar.gz &&\
 cd setuptools-$SETUPTOOLS_VER &&\
 python setup.py install &&\
 cd $PY_HOME &&\
 rm setuptools-$SETUPTOOLS_VER -rf &&\
 rm *.tar.* -rf &&\
 easy_install -i http://pypi.douban.com/simple pip &&\
 pip install -i http://pypi.douban.com/simple --trusted-host pypi.douban.com virtualenv &&\
 virtualenv .ve &&\
 source ./.ve/bin/activate &&\
 pip install -i http://pypi.douban.com/simple --trusted-host pypi.douban.com -U setuptools &&\
 pip install -i http://pypi.douban.com/simple --trusted-host pypi.douban.com supervisor &&\
 deactivate
