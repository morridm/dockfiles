FROM supervisor:latest
RUN yum -y -q install file ntp vim-enhanced pcre pcre-devel gcc gcc-c++ gcc-g77 flex bison autoconf automake  ncurses-devel   libjpeg-devel libpng-devel libtiff-devel fontconfig-devel freetype-devel libXpm-devel gettext-devel  pam-devel e2fsprogs-devel krb5-devel libidn libidn-devel mysql-devel libtool  vixie-cron crontabs libxml2 libxml2-devel bzip2 bzip2-devel curl curl-devel openssl openssl-devel zlib zlib-devel  libevent-devel libmcrypt libmcrypt-devel  libc-client-devel libxslt-devel libtermcap libtermcap-devel libtool git
WORKDIR /tmp
RUN wget http://curl.haxx.se/download/curl-7.35.0.tar.bz2
RUN tar xf curl-7.35.0.tar.bz2
RUN cd curl-7.35.0 && ./configure --prefix=/usr/local/curl --with-ssl --without-nss && make && make install && cd .. 
RUN wget http://downloads.php.net/stas/php-5.4.17.tar.bz2
RUN tar xf php-5.4.17.tar.bz2
RUN cd php-5.4.17 && ./configure --prefix=/opt/php --enable-fpm --with-mysql --with-mcrypt --with-zlib --enable-mbstring --with-curl=/usr/local/curl --with-mhash --enable-sockets --with-openssl --with-gd --with-freetype-dir --with-png-dir --with-jpeg-dir --with-pdo-mysql --with-pear && make -j`grep processor /proc/cpuinfo |wc -l` && make install && cd ..
# set /opt/php/lib/php.ini
RUN a=`/opt/php/bin/php -i "phpinfo();" 2>/dev/null|grep php.ini |head -n 1 |cut -f 2 -d ">"`/php.ini; b=`/opt/php/bin/php-config --extension-dir`; cp -v /tmp/php-5.4.17/php.ini-production $a
RUN bash -c 'a=`/opt/php/bin/php -i "phpinfo();" 2>/dev/null|grep php.ini |head -n 1 |cut -f 2 -d ">"`/php.ini; b=`/opt/php/bin/php-config --extension-dir`;echo extension_dir = $b >> $a'
#RUN mkdir `/opt/php/bin/php -i "phpinfo();" 2>/dev/null|grep php.ini |head -n 1 |cut -f 2 -d ">"`
#todo  cd /tmp/php-5.4.17/ext/bcmath &&  /opt/php/bin/phpize && ./configure --with-php-config=/opt/php/bin/php-config && make && make install && cd ..
#redis-2.2.4.tgz php-handlersocket-0.3.1.tar.gz memcache-3.0.8.tgz APC-3.1.13.tgz
RUN wget http://pecl.php.net/get/redis-2.2.4.tgz
RUN tar xf redis-2.2.4.tgz && cd redis-2.2.4  &&  /opt/php/bin/phpize && ./configure --with-php-config=/opt/php/bin/php-config && make && make install && cd ..
RUN git clone https://github.com/kjdev/php-ext-handlersocketi.git
RUN cd php-ext-handlersocketi &&  /opt/php/bin/phpize && ./configure --with-php-config=/opt/php/bin/php-config && make && make install && cd ..
RUN wget  http://pecl.php.net/get/memcache-3.0.8.tgz
RUN tar xf memcache-3.0.8.tgz && cd memcache-3.0.8  &&  /opt/php/bin/phpize && ./configure --with-php-config=/opt/php/bin/php-config && make && make install && cd ..
RUN wget http://pecl.php.net/get/APC-3.1.13.tgz
RUN tar xf APC-3.1.13.tgz && cd APC-3.1.13  &&  /opt/php/bin/phpize && ./configure --with-php-config=/opt/php/bin/php-config && make && make install && cd ..
#RUN a=`/opt/php/bin/php-config --extension-dir`; for i in `ls $a`; do  echo extension=$i >> `/opt/php/bin/php -i "phpinfo();" 2>/dev/null|grep php.ini |head -n 1 |cut -f 2 -d ">"`/php.ini; done
RUN bash -c 'a=`/opt/php/bin/php-config --extension-dir`;b=`/opt/php/bin/php -i "phpinfo();" 2>/dev/null|grep php.ini |head -n 1 |cut -f 2 -d ">"`/php.ini; for i in `ls $a`; do  echo extension=$i >> $b; done'
WORKDIR /root
RUN rm -fr /tmp/*
RUN cp -v /opt/php/etc/php-fpm.conf{.default,}
EXPOSE 9000
RUN bash -c 'echo -e [program:php-fpm]\\ncommand = /opt/php/sbin/php-fpm >> /etc/supervisord.conf'

