FROM ctsi/centos
MAINTAINER Cui Wei <cuiwei@ctsi.com.cn>


# Install the necessary software, libs.
RUN yum -y install http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-1.noarch.rpm &&\
 yum -y install gcc-c++ bzip2 make libxml2-devel libicu-devel python-devel libtool-ltdl-devel\
 bzip2-devel boost-devel openssl-devel pcre-devel sqlite-devel llvm-devel clang-devel\
 gdal-devel geos-devel proj-devel proj-epsg libpng-devel pixman-devel cairo-devel\
 libjpeg-turbo-devel libtiff-devel freetype-devel\
 postgresql94-contrib postgresql94-devel postgis2_94-devel &&\
 yum -y clean all


# Install the uwsgi, you must put PIL here to prevent TileStache using Pillow.
RUN groupadd -f www-data &&\
 useradd --system --no-create-home --gid www-data uwsgi &&\
 cd /home &&\
 wget http://config.sufor.cc/software/PIL-1.1.7.tar.gz &&\
 tar xvzf PIL-1.1.7.tar.gz &&\
 cd PIL-1.1.7 &&\
 python setup.py install &&\
 cd /home &&\
 rm PIL-1.1.7 -rf &&\
 wget http://config.sufor.cc/software/sympy-0.7.6.tar.gz &&\
 tar xvzf sympy-0.7.6.tar.gz &&\
 cd sympy-0.7.6 &&\
 python setup.py install &&\
 cd /home &&\
 rm sympy-0.7.6 -rf &&\
 wget http://config.sufor.cc/software/numpy-1.9.2.tar.gz &&\
 tar xvzf numpy-1.9.2.tar.gz &&\
 cd numpy-1.9.2 &&\
 python setup.py install &&\
 cd /home &&\
 rm numpy-1.9.2 -rf &&\
 wget http://config.sufor.cc/software/Blit-1.4.0.tar.gz &&\
 tar xvzf Blit-1.4.0.tar.gz &&\
 cd Blit-1.4.0 &&\
 python setup.py install &&\
 cd /home &&\
 rm Blit-1.4.0 -rf &&\
 easy_install -i http://pypi.douban.com/simple uWSGI &&\
 easy_install -i http://pypi.douban.com/simple TileStache &&\
 rm * -rf


ENV PG_MAJOR_VER 9.4


# Install the mapnik and tilestache.
RUN cd /home &&\
 wget http://config.sufor.cc/software/py2cairo-1.10.0.tar.bz2 &&\
 tar xvjpf py2cairo-1.10.0.tar.bz2 &&\
 cd py2cairo-1.10.0 &&\
 ./waf configure &&\
 ./waf install &&\
 cd /home &&\
 rm py2cairo-1.10.0 -rf &&\
 wget http://config.sufor.cc/software/mapnik-2.2.0.tar.gz &&\
 tar xvzf mapnik-2.2.0.tar.gz &&\
 cd mapnik-2.2.0 &&\
 ./configure JOBS=2 PKG_CONFIG_PATH=/usr/local/lib/pkgconfig PG_CONFIG=/usr/pgsql-$PG_MAJOR_VER/bin/pg_config &&\
 make &&\
 make install &&\
 cd /home &&\
 rm * -rf &&\
 mkdir -p /home/cache/ctsi/ &&\
 mkdir -p /home/cache/ctsi_mapnik/ &&\
 chown uwsgi:www-data /home/cache -R



# Expose the uwsgi port
EXPOSE 8001:8001 8002:8002 8003:8003 8004:8004


# Add VOLUMEs to allow backup of caches.
VOLUME  ["/home/cache"]


# Set the default command to run when starting the container
CMD ["supervisord", "-c", "/home/supervisord.conf"]
