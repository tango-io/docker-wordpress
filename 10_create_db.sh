#!/bin/bash

echo "creating database $DB_NAME"

if [[ $DB_PASS != "" ]]; then
  echo "Creating database"
  mysql -u $DB_USER -p$DB_PASS -h $MYSQL_PORT_3306_TCP_ADDR -e "create database $DB_NAME;"
fi

exit 0
