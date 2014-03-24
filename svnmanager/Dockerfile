FROM elex/supervisor:latest
RUN yum install -y -q gcc.x86_64 bzip2.x86_64 libtool.x86_64 file-5.04-15.el6.x86_64 pcre-devel.x86_64 unzip.x86_64 zlib-devel.x86_64 perl-ExtUtils-Embed expat-devel.x86_64 openldap-devel.x86_64 && yum -q clean all
#apr
RUN cd /tmp && curl -O http://apache.cs.utah.edu/apr/apr-1.5.0.tar.bz2 && tar xf apr-1.5.0.tar.bz2 && cd apr-1.5.0 && ./configure -q && make -s -j && make install && cd .. && rm -fr $OLDPWD*
#apr-util
RUN cd /tmp && curl -O http://apache.cs.utah.edu/apr/apr-util-1.5.3.tar.bz2 && tar xf apr-util-1.5.3.tar.bz2 && cd apr-util-1.5.3 && ./configure -q --with-apr=/usr/local/apr --with-ldap --with-ldap-lib=/usr/lib64 --with-ldap-include=/etc/openldap && make -s -j && make install && cd .. && rm -fr $OLDPWD*
#apache2 httpd
RUN cd /tmp && curl -O http://apache.cs.utah.edu/httpd/httpd-2.4.9.tar.bz2 && tar xf httpd-2.4.9.tar.bz2 && cd httpd-2.4.9 && ./configure -q --enable-dav --enable-so --with-apr=/usr/local/apr/bin/apr-1-config --with-apr-util=/usr/local/apr/bin/apu-1-config && make -s -j && make install && cd .. && rm -fr $OLDPWD*
#svn
RUN cd /tmp && curl -O http://apache.cs.utah.edu/subversion/subversion-1.8.8.tar.bz2 && tar xf subversion-1.8.8.tar.bz2 && cd subversion-1.8.8 && curl -O http://www.sqlite.org/2014/sqlite-amalgamation-3080401.zip && unzip sqlite-amalgamation-3080401.zip && mv sqlite-amalgamation{-3080401,} &&CC="gcc -std=gnu99" ./configure -q --with-apxs=/usr/local/apache2/bin/apxs --with-apr=/usr/local/apr --with-apr-util=/usr/local/apr --with-apache-libexecdir --enable-mod-activation && make -s -j && make install && cd .. && rm -fr $OLDPWD*

#config httpd.conf
##done by --enable-mod-activation
#conf.d
RUN mkdir -p /usr/local/apache2/conf/conf.d/ && echo -e Include conf/conf.d/*.conf >> /usr/local/apache2/conf/httpd.conf
ADD svn.conf /usr/local/apache2/conf/conf.d/