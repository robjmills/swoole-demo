FROM phpswoole/swoole:4.4.14-php7.3

RUN install-swoole-ext.sh async 4.4.14 \
  && docker-php-ext-enable swoole_async

RUN mkdir -p /app/data

WORKDIR /app

COPY ./app /app

EXPOSE 9502
ENTRYPOINT ["/usr/local/bin/php", "/app/index.php"]
