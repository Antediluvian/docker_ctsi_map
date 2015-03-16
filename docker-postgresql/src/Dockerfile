FROM ctsi/centos
MAINTAINER Cui Wei <cuiwei@ctsi.com.cn>


# Run the system update and install the necessary software, libs.
RUN yum -y install http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-1.noarch.rpm &&\
 yum -y install postgis2_94 postgresql94-server &&\
 yum -y clean all



# The environment variables.
ENV PG_MAJOR_VER 9.4
ENV PG_HOME /home/postgresql
ENV PG_DATA_HOME $PG_HOME/data
ENV PG_LOGS_HOME $PG_HOME/logs

RUN mkdir -p $PG_LOGS_HOME &&\
 mkdir -p $PG_DATA_HOME &&\
 chown postgres:postgres $PG_HOME -R

# Run the rest of the commands as the ``postgres`` user
USER postgres

# Create a PostgreSQL role named ``ctsi`` with ``ctsi_pass`` as the password and
# then create a database `ctsi_map_2014_q3` owned by the ``ctsi`` role.
RUN /usr/pgsql-$PG_MAJOR_VER/bin/initdb -D $PG_DATA_HOME --auth-local=trust -E 'UTF-8' --lc-collate='en_US.UTF-8' --lc-ctype='en_US.UTF-8' &&\
 /usr/pgsql-$PG_MAJOR_VER/bin/pg_ctl start -w -D $PG_DATA_HOME -l $PG_LOGS_HOME/postgresql.log &&\
 psql -c "CREATE USER ctsi WITH SUPERUSER PASSWORD 'ctsi_pass';" &&\
 createdb -O ctsi ctsi_map_2014_q3 &&\
 psql -c "CREATE EXTENSION postgis;" -d ctsi_map_2014_q3 &&\
 /usr/pgsql-$PG_MAJOR_VER/bin/pg_ctl stop -w -D $PG_DATA_HOME

# Adjust PostgreSQL configuration so that remote connections to the database are possible.
RUN echo "host    all    all    0.0.0.0/0    md5" >> $PG_DATA_HOME/pg_hba.conf

# And add ``listen_addresses`` to ``$PG_DATA_HOME/postgresql.conf``.
# RUN echo "listen_addresses='*'" >> $PG_DATA_HOME/postgresql.conf
COPY postgresql.conf $PG_DATA_HOME/postgresql.conf


# Run the rest of the commands as the ``root`` user
USER root


# Expose the PostgreSQL port
EXPOSE 5432


# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/home/postgresql"]


# Set the default command to run when starting the container
COPY supervisord.conf /home/python/supervisord.conf
CMD /home/python/.ve/bin/supervisord -c /home/python/supervisord.conf
