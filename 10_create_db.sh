#!/bin/bash

echo /dev/tcp/${MYSQL_PORT_3306_TCP_ADDR}/${MYSQL_PORT_3306_TCP_PORT}
while ! exec 6<>/dev/tcp/${MYSQL_PORT_3306_TCP_ADDR}/${MYSQL_PORT_3306_TCP_PORT}; do
  echo "Trying to connect to mysql"
  sleep 1
done
  

echo "creating database $DB_NAME"
if [[ $DB_PASS != "" ]]; then
  echo "Creating database"
  mysql -u $DB_USER -p$DB_PASS -h $MYSQL_PORT_3306_TCP_ADDR -e "create database IF NOT EXISTS $DB_NAME;"
fi

exit 0
