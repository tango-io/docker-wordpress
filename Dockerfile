FROM framallo/php-fpm
MAINTAINER Federico Ramallo <framallo@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update 
RUN apt-get install -y  curl mysql-client
RUN rm -rf /var/lib/apt/lists/*

ENV WORDPRESS_VERSION 4.1.1
ENV WORDPRESS_UPSTREAM_VERSION 4.1.1
ENV WORDPRESS_SHA1 15d38fe6c73121a20e63ccd8070153b89b2de6a9
ENV DB_NAME wordpress_development
ENV DB_USER root
ENV DB_PASS root
ENV AUTH_KEY            --w,=nO-t>g:EOH>e-ZXs!7x(: W4:}1A2$E?Sn9P>TW-[=:u[nc-eQ<vIi<6|wh
ENV SECURE_AUTH_KEY     PlM~WQ/9-~V:-3&be`nxuaghz@JyN!]SzVr_]lAM2b?QH(d(|`.z_;1jIE4kY&f+
ENV LOGGED_IN_KEY       K]6*uCb-m~>zj5C1krtu:>2VT(WlI/Jl5T~Pov2-`r+Zb5s3i6&aIN$*/+k/~sLN
ENV NONCE_KEY           ~; xvP`h^{Pl9zaD#/!f@M21BAk0#sKg>*P+=1LV+FY+;HNE)%Y`4(Xq|&})fCj^
ENV AUTH_SALT           A2|G[jvSLB+z dy S/ S>(lLyzxDvJ8(ps1(F%~x]eRD`UHv(h*IDjye+SYV-a;O
ENV SECURE_AUTH_SALT    9cv/Hy~a;qr]4)i*udy-/$non@_:CU0SIdm-L[WH^k_}s:Jq[)HV,Wu8na<_;ef3
ENV LOGGED_IN_SALT      {d*4OCrk9x`|cb-4EBK7=ewJ3D]y%z,7mSEd:8?=eP![zD.O`<Uubt-u%@TA+x T
ENV NONCE_SALT          z6G5thFC]JIW]|ZQIBgZ?zBb^!N#3-Un=)`!Xb/,Yd8[2&}.W{ITu?=PE0oZ,<8^
ENV WP_RELOCATE true

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
