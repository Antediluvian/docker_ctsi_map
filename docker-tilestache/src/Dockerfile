FROM ctsi/centos
MAINTAINER Cui Wei <cuiwei@ctsi.com.cn>


# Run the system update and install the necessary software, libs.
RUN yum -y install http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-1.noarch.rpm &&\
 yum -y install http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm &&\
 yum -y install http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm &&\
 yum -y install openssh-server wget tar bzip2 make &&\
 yum -y install libxml2-devel libicu-devel python-devel libtool-ltdl-devel gcc-c++ bzip2-devel boost-devel openssl-devel &&\
 yum -y install pcre-devel sqlite-devel llvm-devel clang-devel gdal-devel geos-devel proj-devel proj-epsg &&\
 yum -y install libpng-devel pixman-devel cairo-devel libjpeg-turbo-devel libtiff-devel freetype-devel &&\
 yum -y install postgresql94-contrib postgresql94-devel postgis2_94-devel &&\
 yum -y clean all


# Create the system group and user.
RUN groupadd -f www-data &&\
 useradd --system --no-create-home --gid www-data uwsgi


# The environment variables.
ENV UWSGI_HOME /home/uwsgi

# Copy the files.
COPY setuptools-12.0.5.tar.gz $UWSGI_HOME/setuptools-12.0.5.tar.gz

# Install the supervisord, we use this to start the uwsgi later.
RUN cd $UWSGI_HOME &&\
 tar xvzf setuptools-12.0.5.tar.gz &&\
 cd setuptools-12.0.5 &&\
 python setup.py install &&\
 cd $UWSGI_HOME &&\
 rm setuptools-12.0.5 -rf &&\
 rm *.tar.* -rf &&\
 easy_install -i http://pypi.douban.com/simple pip &&\
 easy_install -i http://pypi.douban.com/simple virtualenv &&\
 mkdir -p $UWSGI_HOME/etc &&\
 cd $UWSGI_HOME &&\
 virtualenv .ve &&\
 source ./.ve/bin/activate &&\
 pip install -i http://pypi.douban.com/simple --trusted-host pypi.douban.com -U setuptools &&\
 pip install -i http://pypi.douban.com/simple --trusted-host pypi.douban.com supervisor &&\
 pip install -i http://pypi.douban.com/simple --trusted-host pypi.douban.com uWSGI &&\
 pip install -i http://pypi.douban.com/simple --trusted-host pypi.douban.com TileStache &&\
 deactivate


# Copy the files.
COPY py2cairo-1.10.0.tar.bz2 $UWSGI_HOME/py2cairo-1.10.0.tar.bz2
COPY mapnik-2.2.0.tar.gz $UWSGI_HOME/mapnik-2.2.0.tar.gz

# Add the mapnik lib to ldconfig cache.
RUN echo "$UWSGI_HOME/parts/mapnik/lib" >> /etc/ld.so.conf.d/mapnik-x86_64.conf

ENV PG_MAJOR_VER 9.4

# Install the mapnik and tilestache.
RUN mkdir -p $UWSGI_HOME/var/run &&\
 cd $UWSGI_HOME &&\
 source ./.ve/bin/activate &&\
 tar xvjpf py2cairo-1.10.0.tar.bz2 &&\
 cd py2cairo-1.10.0 &&\
 ./waf configure --prefix=$UWSGI_HOME/parts/pycairo &&\
 ./waf install --prefix=$UWSGI_HOME/parts/pycairo &&\
 cd $UWSGI_HOME &&\
 rm py2cairo-1.10.0 -rf &&\
 tar xvzf mapnik-2.2.0.tar.gz &&\
 cd mapnik-2.2.0 &&\
 ./configure PREFIX=$UWSGI_HOME/parts/mapnik JOBS=2 PKG_CONFIG_PATH=$UWSGI_HOME/parts/pycairo/lib/pkgconfig PG_CONFIG=/usr/pgsql-$PG_MAJOR_VER/bin/pg_config &&\
 make &&\
 make install &&\
 cd $UWSGI_HOME &&\
 rm mapnik-2.2.0 -rf &&\
 rm *.tar.* -rf &&\
 deactivate &&\
 ldconfig


# Expose the uwsgi port
EXPOSE 8001:8001 8002:8002 8003:8003 8004:8004


# Add VOLUMEs to allow backup of caches.
VOLUME  ["/home/cache"]


# Set the default command to run when starting the container
COPY supervisord.conf $UWSGI_HOME/supervisord.conf
CMD $UWSGI_HOME/.ve/bin/supervisord -c $UWSGI_HOME/supervisord.conf

