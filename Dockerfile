FROM php:7.3-fpm-alpine3.10

RUN rm -rf /var/cache/apk/* \
    && rm -rf /tmp/*

RUN apk update

RUN apk add --no-cache \
    g++ \
    make \
    autoconf

RUN pecl install \
    swoole-4.4.15 \
    && docker-php-ext-enable swoole

RUN mkdir -p /app/data

WORKDIR /app

COPY ./app /app

EXPOSE 9502
CMD ["/usr/local/bin/php", "/app/index.php"]