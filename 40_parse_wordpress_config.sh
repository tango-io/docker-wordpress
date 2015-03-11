#!/bin/bash

echo 'Creating config file'

if [ ! -f /var/www/salt.php ]; then
  curl https://api.wordpress.org/secret-key/1.1/salt/ > /var/www/salt.php
fi

sed -e "s/{DB_NAME}/$DB_NAME/g" \
    -e "s/{DB_USER}/$DB_USER/g" \
    -e "s/{DB_PASS}/$DB_PASS/g" \
    -e "s/{MYSQL_PORT_3306_TCP_ADDR}/$MYSQL_PORT_3306_TCP_ADDR/g" \
    -e "s/{MYSQL_PORT_3306_TCP_PORT}/$MYSQL_PORT_3306_TCP_PORT/g" \
    /var/www/wp-config.template.php > /var/www/wp-config.php

cat /var/www/salt.php >> /var/www/wp-config.php
