FROM diivanov/php:8.3-base 
RUN apk add --no-cache libstdc++ libpq && \
    apk add --no-cache --virtual .build-deps $PHPIZE_DEPS curl-dev linux-headers postgresql-dev openssl-dev pcre-dev pcre2-dev zlib-dev && \
    pecl channel-update pecl.php.net && \
    pecl install --configureoptions 'enable-redis-igbinary="no" enable-redis-lzf="no" enable-redis-zstd="no"' redis-6.0.1 && \
	docker-php-ext-enable redis && \
    docker-php-ext-install sockets && \
    docker-php-source extract && \
    mkdir /usr/src/php/ext/swoole && \
    curl -sfL https://github.com/swoole/swoole-src/archive/v5.1.0.tar.gz -o swoole.tar.gz && \
    tar xfz swoole.tar.gz --strip-components=1 -C /usr/src/php/ext/swoole && \
    docker-php-ext-configure swoole \
        --enable-mysqlnd      \
        --enable-swoole-pgsql \
        --enable-openssl      \
        --enable-sockets --enable-swoole-curl && \
    docker-php-ext-install -j$(nproc) swoole && \
    rm -f swoole.tar.gz $HOME/.composer/*-old.phar && \
    docker-php-source delete && \
    apk del .build-deps