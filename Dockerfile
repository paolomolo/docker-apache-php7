FROM alpine:3.6

RUN apk add --no-cache \
  apache2 \
  php7-apache2 \
  php7-gd \
  php7-simplexml \
  php7-redis \
  php7-mysqli \
  php7-zlib \
  php7-mbstring \
  php7-json

COPY localhost.conf /etc/apache2/conf.d/localhost.conf

COPY index.php /var/www/localhost/htdocs/index.php

RUN mkdir -p /run/apache2/

RUN ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log

CMD ["/usr/sbin/httpd", "-DFOREGROUND"]
