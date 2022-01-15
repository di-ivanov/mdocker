FROM diivanov/php:8.0-base

RUN pecl install xdebug && \
    docker-php-ext-install \
        opcache \
        pcntl && \
    docker-php-ext-enable xdebug

# Install mhsendmail
ENV GOPATH "/opt/go"
RUN apk add --upgrade --no-cache --virtual .mailhog-deps go git && \
    mkdir -p ${GOPATH} && \
    go get github.com/mailhog/mhsendmail && \
    mv ${GOPATH}/bin/mhsendmail /usr/local/bin/mhsendmail && \
    rm -rf ${GOPATH} && \
    apk del .mailhog-deps

COPY www.conf /usr/local/etc/php-fpm.d/www.conf
COPY php.ini /usr/local/etc/php/php.ini
COPY start.sh /start.sh
RUN usermod -u 1000 www-data &&\
    groupmod -g 1000 www-data && \
    chgrp -R www-data /usr/local/etc/php-fpm.d/www.conf && \
    chown -R www-data /usr/local/etc/php/conf.d/ && \
    chown www-data /start.sh && \
    echo -e "\nsendmail_path = \"/usr/local/bin/mhsendmail --smtp-addr='mailhog:1025'\"" >> /usr/local/etc/php/php.ini

RUN chmod +x /start.sh

WORKDIR /var/www/html

EXPOSE 9000

USER www-data

CMD ["/start.sh"]