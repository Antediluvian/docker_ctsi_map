FROM ctsi/centos
MAINTAINER Cui Wei <cuiwei@ctsi.com.cn>

# Install the necessary software and libs.
RUN yum -y install gcc-c++ make && yum -y clean all


# The environment variables.
ENV NGX_MAJOR_VER 1.6.2
ENV NGX_HOME /home/nginx

ENV NGX_VAR_HOME NGX_HOME/var
ENV NGX_CONF_HOME NGX_HOME/etc
ENV NGX_CACHE_HOME NGX_HOME/cache

ENV NGX_USER www-data


# Create the user and folders.
RUN mkdir -p $NGX_CONF_HOME/cert &&\
 mkdir -p $NGX_CONF_HOME/site-enabled &&\
 mkdir -p $NGX_VAR_HOME/logs &&\
 mkdir -p $NGX_VAR_HOME/run &&\
 mkdir -p $NGX_CACHE_HOME &&\
 useradd --system --no-create-home --user-group $NGX_USER

# Install the Nginx.
RUN cd /home &&\
 wget http://config.sufor.cc/software/nginx-$NGX_MAJOR_VER.tar.gz &&\
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
 cd .. &&\
 rm nginx-$NGX_MAJOR_VER -rf &&\
 rm nginx-$NGX_MAJOR_VER.tar.gz -rf



# Expose the Nginx port.
EXPOSE 80 443


# Set the default command to run when starting the container
CMD ["supervisord", "-c", "/home/supervisord.conf"]
