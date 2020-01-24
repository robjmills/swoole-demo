FROM php:7.3-fpm-alpine3.10

RUN rm -rf /var/cache/apk/* \
    && rm -rf /tmp/*

RUN apk update

RUN apk add --no-cache \
    g++ \
    make \
    autoconf \
    git

RUN git -c advice.detachedHead=false clone --branch v4.4.4 --single-branch --depth 1 https://github.com/swoole/swoole-src \
    && cd swoole-src/ \
    && phpize \
    && ./configure \
    && make -j 4 \
    && make install

RUN git clone git://github.com/swoole/async-ext.git \
    && cd async-ext/ \
    && git reset --hard 6df15d51f9edd9950c418f2374d0b97fce08a30b \
    && phpize \
    && ./configure \
    && make -j 4 \
    && make install

RUN docker-php-ext-enable swoole swoole_async

RUN mkdir -p /app/data

WORKDIR /app

COPY ./app /app

EXPOSE 9502
ENTRYPOINT ["/usr/local/bin/php", "/app/index.php"]
