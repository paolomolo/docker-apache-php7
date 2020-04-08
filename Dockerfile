FROM alpine:3.8

ADD https://dl.bintray.com/php-alpine/key/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub

RUN apk --update add ca-certificates

RUN echo "https://dl.bintray.com/php-alpine/v3.8/php-7.2" >> /etc/apk/repositories

RUN apk add --update \
  php \
  apache2 \
  php-apache2 \
  php-gd \
  php-ctype \
  php-gd \
  php-redis \
  php-zlib \
  php-mbstring \
  php-json \
  php-curl \
  php-openssl \
  php-dom

COPY localhost.conf /etc/apache2/conf.d/localhost.conf

COPY index.php /var/www/localhost/htdocs/index.php

RUN mkdir -p /run/apache2/

RUN ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log

CMD ["/usr/sbin/httpd", "-DFOREGROUND"]
