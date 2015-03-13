#!/bin/bash

echo 'Creating config file'

# from http://pempek.net/articles/2013/07/08/bash-sh-as-template-engine/
# render a template configuration file
# expand variables + preserve formatting
render_template() {
  eval "echo \"$(cat $1)\""
}

render_template /var/www/wp-config.template.php > /var/www/wp-config.php


# echo 'wp-config'
# cat -n /var/www/wp-config.php 

