FROM elex/supervisor:latest
RUN yum install memcached -y -q
ADD startup_memcached.sh /usr/bin/
EXPOSE 11211
CMD /usr/bin/startup_memcached.sh

