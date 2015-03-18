FROM ctsi/centos
MAINTAINER Cui Wei <cuiwei@ctsi.com.cn>


# The Tomcat environment variables.
ENV TOMCAT_VER 8.0.20

# Install the JDK and Tomcat.
RUN cd /home &&\
 wget http://config.sufor.cc/software/jdk-8u40-linux-x64.rpm &&\
 rpm -ivh jdk-8u40-linux-x64.rpm &&\
 wget http://config.sufor.cc/software/apache-tomcat-$TOMCAT_VER.tar.gz &&\
 tar xvzf apache-tomcat-$TOMCAT_VER.tar.gz &&\
 mv apache-tomcat-$TOMCAT_VER tomcat &&\
 rm *.rpm -rf &&\
 rm *.tar.gz -rf


# Expose the Tomcat port.
EXPOSE 8080


# Add VOLUMEs to webapps folder.
VOLUME ["/home/tomcat/webapps"]


# Set the default command to run when starting the container.
CMD ["supervisord", "-c", "/home/supervisord.conf"]
