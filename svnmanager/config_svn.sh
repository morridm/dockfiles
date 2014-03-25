#!/bin/bash

if [ "$(ls -A /data/svn)" ]; then 
	echo "svn dir not empty. skip setup"
else
	echo "svn dir empty, setting new svn repo"
	touch /data/svn/passwdfile
	touch /data/svn/accessfile
	/usr/local/bin/svnadmin create /data/svn/test
	chown -R www-data:subversion /data/svn

	#if [ -n "$MYSQL_URI" ]; then 
	MYSQL_URI=${MYSQL_URI-''}
	AUTHURLSTRING=${AUTHURLSTRING-''}
	BINDPW=${BINDPW-''}
	BINDDN=${BINDDN-''}
	sed -i 's#mysql_uri#$MYSQL_URI#' /var/www/html/svnmanager/config.php
	#fi
	#set authurlstring, bindpw, binddn
	sed -i 's#authurlstring#{$AUTHURLSTRING}#; s#bindpw#${BINDPW}# s#binddn#${BINDDN}#' /usr/local/apache2/conf/conf.d/svn.conf
	
	exec supervisord -n
fi