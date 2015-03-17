FROM ctsi/centos
MAINTAINER Cui Wei <cuiwei@ctsi.com.cn>


#############################################
# The redis parts.
#############################################
# The environment variables.
ENV RDS_VER 2.8.19

COPY redis-$RDS_VER.tar.gz /home/redis/redis-$RDS_VER.tar.gz

RUN cd /home/redis &&\
 tar xvzf redis-$RDS_VER.tar.gz &&\
 cd redis-$RDS_VER/deps &&\
 make hiredis jemalloc linenoise lua &&\
 cd .. &&\
 make install &&\
 cd /home/redis &&\
 rm * -rf


#############################################
# Expose the Redis port
#############################################
EXPOSE 6379


#############################################
# Add VOLUMEs to allow backup of config, logs
#############################################.
VOLUME ["/mnt/redis"]


#############################################
# Set the default command to run when starting the container
#############################################
COPY supervisord.conf /home/python/supervisord.conf
CMD /home/python/.ve/bin/supervisord -c /home/python/supervisord.conf
