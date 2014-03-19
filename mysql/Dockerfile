FROM elex/supervisor:latest
RUN yum -y -q install mysql-server.x86_64 pwgen.x86_64
RUN yum -q clean all
ADD my.cnf /etc/
ADD startup_mysql.sh /usr/bin/
VOLUME ["/var/lib/mysql"]
EXPOSE 3306
RUN echo -e [program:mysql]\\ncommand=/usr/bin/pidproxy /var/run/mysqld/mysqld.pid /usr/bin/mysqld_safe\\nautostart=true\\nautorestart=true\\nstartsecs=30\\nstartretries=3 >> /etc/supervisord.conf
CMD /bin/bash /usr/bin/startup_mysql.sh
