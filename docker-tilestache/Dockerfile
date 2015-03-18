FROM ctsi/centos
MAINTAINER Cui Wei <cuiwei@ctsi.com.cn>


# Install the necessary software, libs.
RUN yum -y install http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-1.noarch.rpm &&\
 yum -y install libxml2-devel libicu-devel python-devel libtool-ltdl-devel gcc-c++ bzip2-devel \
 boost-devel openssl-devel pcre-devel sqlite-devel llvm-devel clang-devel gdal-devel geos-devel \
 proj-devel proj-epsg libpng-devel pixman-devel cairo-devel libjpeg-turbo-devel libtiff-devel \
 freetype-devel postgresql94-contrib postgresql94-devel postgis2_94-devel &&\
 yum -y clean all


# The environment variables.
ENV PY_HOME /home/python

COPY PIL-1.1.7.tar.gz $PY_HOME/PIL-1.1.7.tar.gz

# Install the uwsgi, you must put PIL here in case TileStache using Pillow instead.
RUN groupadd -f www-data &&\
 useradd --system --no-create-home --gid www-data uwsgi &&\
 cd $PY_HOME &&\
 source ./.ve/bin/activate &&\
 tar xvzf PIL-1.1.7.tar.gz &&\
 cd PIL-1.1.7 &&\
 python setup.py install &&\
 cd $PY_HOME &&\
 rm PIL-1.1.7 -rf &&\
 pip install -i http://pypi.douban.com/simple --trusted-host pypi.douban.com uWSGI &&\
 pip install -i http://pypi.douban.com/simple --trusted-host pypi.douban.com TileStache &&\
 deactivate


# Add the mapnik lib to ldconfig cache.
RUN echo "$PY_HOME/parts/mapnik/lib" >> /etc/ld.so.conf.d/mapnik-x86_64.conf

ENV PG_MAJOR_VER 9.4


# Copy the files.
COPY py2cairo-1.10.0.tar.bz2 $PY_HOME/py2cairo-1.10.0.tar.bz2
COPY mapnik-2.2.0.tar.gz $PY_HOME/mapnik-2.2.0.tar.gz


# Install the mapnik and tilestache.
RUN mkdir -p $PY_HOME/var/run &&\
 cd $PY_HOME &&\
 source ./.ve/bin/activate &&\
 tar xvjpf py2cairo-1.10.0.tar.bz2 &&\
 cd py2cairo-1.10.0 &&\
 ./waf configure --prefix=$PY_HOME/parts/pycairo &&\
 ./waf install --prefix=$PY_HOME/parts/pycairo &&\
 cd $PY_HOME &&\
 rm py2cairo-1.10.0 -rf &&\
 tar xvzf mapnik-2.2.0.tar.gz &&\
 cd mapnik-2.2.0 &&\
 ./configure PREFIX=$PY_HOME/parts/mapnik JOBS=2 PKG_CONFIG_PATH=$PY_HOME/parts/pycairo/lib/pkgconfig PG_CONFIG=/usr/pgsql-$PG_MAJOR_VER/bin/pg_config &&\
 make &&\
 make install &&\
 cd $PY_HOME &&\
 rm mapnik-2.2.0 -rf &&\
 deactivate &&\
 mkdir -p /home/cache/ctsi/ &&\
 mkdir -p /home/cache/ctsi_mapnik/ &&\
 chown uwsgi:www-data /home/cache -R &&\
 ldconfig



COPY sympy-0.7.6.tar.gz $PY_HOME/sympy-0.7.6.tar.gz
COPY numpy-1.9.2.tar.gz $PY_HOME/numpy-1.9.2.tar.gz

# Install the others.
RUN mkdir -p $PY_HOME/var/run &&\
 cd $PY_HOME &&\
 source ./.ve/bin/activate &&\
 tar xvzf sympy-0.7.6.tar.gz &&\
 cd sympy-0.7.6 &&\
 python setup.py install &&\
 cd $PY_HOME &&\
 rm sympy-0.7.6 -rf &&\
 tar xvzf numpy-1.9.2.tar.gz &&\
 cd numpy-1.9.2 &&\
 python setup.py install &&\
 cd $PY_HOME &&\
 rm numpy-1.9.2 -rf &&\
 pip install -i http://pypi.douban.com/simple --trusted-host pypi.douban.com Blit &&\
 deactivate &&\
 rm *.tar.* -rf



# Expose the uwsgi port
EXPOSE 8001:8001 8002:8002 8003:8003 8004:8004


# Add VOLUMEs to allow backup of caches.
VOLUME  ["/home/cache"]


# Set the default command to run when starting the container
CMD $PY_HOME/.ve/bin/supervisord -c $PY_HOME/supervisord.conf
