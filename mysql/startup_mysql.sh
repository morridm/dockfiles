#/bin/bash
if [ ! -d /var/run/mysqld ]; then
  install -m 755 -o mysql -g root -d /var/run/mysqld
fi
if [ ! -f /var/lib/mysql/ibdata1 ]; then
  mysql_install_db
  chown -R mysql:mysql /var/lib/mysql
  /usr/bin/mysqld_safe > /dev/null 2>&1 &
  PASS=${MYSQL_PASS:-$(pwgen -s 12 1)}
  _word=$( [ ${MYSQL_PASS} ] && echo "preset" || echo "random" )
  echo "=> Creating MySQL admin user with ${_word} password"
  RET=1
  while [[ RET -ne 0 ]]; do
    sleep 5
    mysql -uroot -e "CREATE USER 'admin'@'%' IDENTIFIED BY '$PASS'"
	  RET=$?
  done

  mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION"

  mysqladmin -uroot shutdown
  echo "=> Done!"
  echo "========================================================================"
  echo "You can now connect to this MySQL Server using:"
  echo ""
  echo "    mysql -uadmin -p$PASS -h<host> -P<port>"
  echo ""
  echo "Please remember to change the above password as soon as possible!"
  echo "MySQL user 'root' has no password but only allows local connections"
  echo "========================================================================"
fi
 
exec supervisord -n
