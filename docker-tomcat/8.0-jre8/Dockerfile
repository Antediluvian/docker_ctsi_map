FROM ctsi/java:oracle-8-jre
MAINTAINER Cui Wei <cuiwei1@ctsi.com.cn>


# The Tomcat environment variables.
ENV TOMCAT_VER 8.0.20

# Install the JDK and Tomcat.
RUN cd /home\
 && wget http://config.sufor.cc/software/apache-tomcat-$TOMCAT_VER.tar.gz\
 && tar xvzf apache-tomcat-$TOMCAT_VER.tar.gz\
 && mv apache-tomcat-$TOMCAT_VER tomcat\
 && rm *.tar.gz -rf\
 && rm /home/tomcat/bin/*.bat


# Expose the Tomcat port.
EXPOSE 8080


# Add VOLUMEs to webapps folder.
VOLUME ["/home/tomcat/webapps"]


# Set the default command to run when starting the container.
CMD ["/home/tomcat/bin/catalina.sh", "run"]
