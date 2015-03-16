FROM ctsi/centos
MAINTAINER Cui Wei <cuiwei@ctsi.com.cn>

#############################################
# Run the system update and install the necessary software, libs.
#############################################
RUN yum -y install http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm &&\
 yum -y install http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm &&\
 yum -y update &&\
 yum -y install openssh-server wget tar bzip2 make &&\
 yum -y install libxml2-devel libicu-devel python-devel libtool-ltdl-devel gcc-c++ bzip2-devel boost-devel openssl-devel &&\
 yum -y install pcre-devel sqlite-devel llvm-devel clang-devel gdal-devel geos-devel proj-devel proj-epsg &&\
 yum -y install libpng-devel pixman-devel cairo-devel libjpeg-turbo-devel libtiff-devel freetype-devel &&\
 yum -y clean all


#############################################
# The supervisord part.
#############################################
# The environment variables.
ENV PY_HOME /home/python

# Copy the files.
COPY setuptools-12.0.5.tar.gz $PY_HOME/setuptools-12.0.5.tar.gz

# Install the supervisord, we use the supervisord to start the postgresql later.
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


#############################################
# The nginx parts.
#############################################
# The environment variables.
ENV NGX_MAJOR_VER 1.6.0
ENV NGX_HOME /home/nginx
ENV NGX_MNT_HOME /mnt/nginx

ENV NGX_VAR_HOME $NGX_MNT_HOME/var
ENV NGX_CONF_HOME $NGX_MNT_HOME/etc
ENV NGX_CACHE_HOME $NGX_MNT_HOME/cache

ENV NGX_USER www-data

RUN mkdir -p $NGX_CONF_HOME/cert &&\
 mkdir -p $NGX_CONF_HOME/site-enabled &&\
 mkdir -p $NGX_VAR_HOME/logs &&\
 mkdir -p $NGX_VAR_HOME/run &&\
 mkdir -p $NGX_CACHE_HOME &&\
 useradd --system --no-create-home --user-group $NGX_USER


COPY nginx-$NGX_MAJOR_VER.tar.gz $NGX_HOME/nginx-$NGX_MAJOR_VER.tar.gz

RUN cd $NGX_HOME &&\
 tar xvzf nginx-$NGX_MAJOR_VER.tar.gz &&\
 cd nginx-$NGX_MAJOR_VER &&\
 ./configure --prefix=$NGX_HOME \
 --conf-path=$NGX_CONF_HOME/nginx.conf \
 --pid-path=$NGX_VAR_HOME/nginx.pid \
 --error-log-path=$NGX_VAR_HOME/logs/nginx-error.log \
 --http-log-path=$NGX_VAR_HOME/logs/nginx-access.log \
 --lock-path=$NGX_VAR_HOME/nginx.lock \
 --http-client-body-temp-path=$NGX_CACHE_HOME/client_body_temp \
 --http-uwsgi-temp-path=$NGX_CACHE_HOME/uwsgi_temp \
 --http-proxy-temp-path=$NGX_CACHE_HOME/proxy_temp \
 --http-fastcgi-temp-path=$NGX_CACHE_HOME/fastcgi_temp \
 --http-scgi-temp-path=$NGX_CACHE_HOME/scgi_temp \
 --user=$NGX_USER --group=$NGX_USER \
 --with-select_module --with-poll_module --with-http_ssl_module --with-http_spdy_module \
 --with-http_gzip_static_module --with-http_stub_status_module --with-http_sub_module &&\
 make &&\
 make install &&\
 cd $NGX_HOME &&\
 rm nginx-$NGX_MAJOR_VER -rf &&\
 rm nginx-$NGX_MAJOR_VER.tar.gz -rf


#############################################
# Expose the Nginx port
#############################################
EXPOSE 80 443


#############################################
# Add VOLUMEs to allow backup of config, logs
#############################################.
VOLUME ["/mnt/nginx"]


#############################################
# Set the default command to run when starting the container
#############################################
COPY supervisord.conf $PY_HOME/supervisord.conf
CMD $PY_HOME/.ve/bin/supervisord -c $PY_HOME/supervisord.conf
