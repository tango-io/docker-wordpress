FROM framallo/php-fpm
MAINTAINER Federico Ramallo <framallo@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update 
RUN apt-get install -y  curl mysql-client
RUN rm -rf /var/lib/apt/lists/*

ENV WORDPRESS_VERSION 4.1.1
ENV WORDPRESS_UPSTREAM_VERSION 4.1.1
ENV WORDPRESS_SHA1 15d38fe6c73121a20e63ccd8070153b89b2de6a9

RUN rm /var/www/index.php

# upstream tarballs include ./wordpress/ so this gives us /usr/src/wordpress
RUN curl -o wordpress.tar.gz -SL https://wordpress.org/wordpress-${WORDPRESS_UPSTREAM_VERSION}.tar.gz \
	&& echo "$WORDPRESS_SHA1 *wordpress.tar.gz" | sha1sum -c - \
	&& tar -xzf wordpress.tar.gz -C /var/ \
	&& rm wordpress.tar.gz

RUN cp -r /var/wordpress/* /var/www
ADD wp-config.template.php /var/www/wp-config.template.php

RUN chown -R www-data:www-data /var/www
RUN chmod 755 -R /var/www/


VOLUME /var/www

ADD *.sh /
RUN chmod +x /*.sh

CMD for f in /*.sh; do $f ; done

# # Add custom themes, plugins and/or uploads
# ADD themes/ /app/wp-content/themes/
# ADD plugins/ /app/wp-content/plugins/
# ADD uploads/ /app/wp-content/uploads/
# RUN chown www-data:www-data /app/wp-content -R
