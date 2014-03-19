FROM elex/supervisor:latest
RUN yum -y -q install php-fpm.x86_64
RUN sed -i 's/127\.0\.0\.1:9000/0\.0\.0\.0:9000/g; s/listen\.allowed_clients/;listen\.allowed_clients/g;' /etc/php-fpm.d/www.conf
RUN echo -e [program:php-fpm]\\ncommand = /usr/sbin/php-fpm -c /etc -y /etc/php-fpm.conf -F\\nautostart=true\\nautorestart=true\\nstartsecs=10\\nstartretries=3\\nuser=apache>> /etc/supervisord.conf
RUN chown apache:apache -R /var/run/php-fpm
EXPOSE 9000
