FROM ctsi/centos
MAINTAINER Cui Wei <cuiwei@ctsi.com.cn>


# Install the necessary software and libs.
RUN yum -y install gcc-c++ make && yum -y clean all

RUN useradd --system --no-create-home --user-group www-data

# The Redis environment variables.
ENV PHP_VER 5.6.6

# Install the Redis.
RUN cd /home &&\
 wget http://config.sufor.cc/software/php-$REDIS_VER.tar.gz &&\
 tar xvzf php-$REDIS_VER.tar.gz &&\
 cd php-$REDIS_VER/deps &&\

 make install &&\
 cd .. &&\
 rm * -rf


# Expose the Redis port
EXPOSE 6379


# Set the default command to run when starting the container
CMD ["supervisord", "-c", "/home/supervisord.conf"]
