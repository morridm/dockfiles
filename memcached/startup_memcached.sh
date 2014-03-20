!#/bin/bash
MAXCONN=${MAXCONN-1024}
CACHESIZE=${CACHESIZE-128}
echo -e [program:memcached]\\ncommand = /usr/bin/memcached -u memcached -p 11211 -c ${MAXCONN} -m ${CACHESIZE}\\n >> /etc/supervisord.conf
exec supervisord -n
