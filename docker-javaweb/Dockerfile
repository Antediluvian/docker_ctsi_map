FROM ctsi/centos
MAINTAINER Cui Wei <cuiwei@ctsi.com.cn>


#############################################
# The tomcat parts.
#############################################
# The environment variables.
ENV TOMCAT_VER 8.0.20

RUN cd /home &&\
 wget http://config.sufor.cc/jdk-8u40-linux-x64.rpm &&\
 rpm -ivh jdk-8u40-linux-x64.rpm &&\
 wget http://config.sufor.cc/apache-tomcat-$TOMCAT_VER.tar.gz &&\
 tar xvzf apache-tomcat-$TOMCAT_VER.tar.gz &&\
 mv apache-tomcat-$TOMCAT_VER tomcat &&\
 rm *.rpm -rf &&\
 rm *.gz -rf


#############################################
# Expose the Tomcat port
#############################################
EXPOSE 8080


#############################################
# Add VOLUMEs to allow backup of config, logs
#############################################.
VOLUME ["/home/tomcat/webapps"]


#############################################
# Set the default command to run when starting the container
#############################################
CMD /home/python/.ve/bin/supervisord -c /home/python/supervisord.conf
