#!/bin/bash

echo 'Creating config file'


sed -e "s/{DB_NAME}/$DB_NAME/g" \
    -e "s/{DB_USER}/$DB_USER/g" \
    -e "s/{DB_PASS}/$DB_PASS/g" \
    -e "s/{AUTH_KEY}/$AUTH_KEY/g" \
    -e "s/{SECURE_AUTH_KEY}/$SECURE_AUTH_KEY/g" \
    -e "s/{LOGGED_IN_KEY}/$LOGGED_IN_KEY/g" \
    -e "s/{NONCE_KEY}/$NONCE_KEY/g" \
    -e "s/{AUTH_SALT}/$AUTH_SALT/g" \
    -e "s/{SECURE_AUTH_SALT}/$SECURE_AUTH_SALT/g" \
    -e "s/{LOGGED_IN_SALT}/$LOGGED_IN_SALT/g" \
    -e "s/{NONCE_SALT}/$NONCE_SALT/g" \
    -e "s/{MYSQL_PORT_3306_TCP_ADDR}/$MYSQL_PORT_3306_TCP_ADDR/g" \
    -e "s/{MYSQL_PORT_3306_TCP_PORT}/$MYSQL_PORT_3306_TCP_PORT/g" \
    /var/www/wp-config.template.php > /var/www/wp-config.php
