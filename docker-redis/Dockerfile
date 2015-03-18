FROM ctsi/centos
MAINTAINER Cui Wei <cuiwei@ctsi.com.cn>


# Install the necessary software and libs.
RUN yum -y install gcc-c++ make && yum -y clean all


# The Redis environment variables.
ENV REDIS_VER 2.8.19

# Install the Redis.
RUN cd /home &&\
 wget http://config.sufor.cc/software/redis-$REDIS_VER.tar.gz &&\
 tar xvzf redis-$REDIS_VER.tar.gz &&\
 cd redis-$REDIS_VER/deps &&\
 make hiredis jemalloc linenoise lua &&\
 cd .. &&\
 make install &&\
 cd .. &&\
 rm * -rf


# Expose the Redis port
EXPOSE 6379


# Set the default command to run when starting the container
CMD ["supervisord", "-c", "/home/supervisord.conf"]
