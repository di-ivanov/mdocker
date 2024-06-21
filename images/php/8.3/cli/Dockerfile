FROM diivanov/php:8.3-base

# Add utilities
RUN apk add --no-cache zip gzip git mysql-client procps bash-completion openssh coreutils findutils

# Install mhsendmail
ENV GOPATH "/opt/go"
RUN apk add --upgrade --no-cache --virtual .mailhog-deps go git && \
    mkdir -p ${GOPATH} && \
    go install github.com/mailhog/mhsendmail@latest && \
    mv ${GOPATH}/bin/mhsendmail /usr/local/bin/mhsendmail && \
    rm -rf ${GOPATH} && \
    apk del .mailhog-deps

# Add composer v1 and v2 switchable by env variable $OMPOSER_VERSION
ENV COMPOSER_VERSION 2
RUN  curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer1 --version=1.10.17 && \
     curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer2 && \
     echo "#!/bin/bash" >> /usr/local/bin/composer && \
     echo 'CV=$([ "${COMPOSER_VERSION:-1}" == 2 ] && echo 2 || echo 1)' >> /usr/local/bin/composer && \
     echo '/usr/local/bin/composer"$CV" $@' >> /usr/local/bin/composer && \
     chmod +x /usr/local/bin/composer

# Add n98-magerun
RUN curl -sS -O https://files.magerun.net/n98-magerun2-latest.phar && \
    chmod +x ./n98-magerun2-latest.phar && \
    mv n98-magerun2-latest.phar /usr/local/bin/n98-magerun2.phar

COPY php.ini /usr/local/etc/php/php.ini

RUN usermod -u 1000 www-data && \
    groupmod -g 1000 www-data && \
    chgrp -R www-data /usr/local/etc/php-fpm.d/www.conf && \
    chown -R www-data /usr/local/etc/php/conf.d/ && \
    mkdir /home/www-data/.composer && \
    chown -R www-data:www-data /home/www-data/.composer && \
    chown www-data:www-data /var/www/html && \
    echo -e "\nsendmail_path = \"/usr/local/bin/mhsendmail --smtp-addr='mailhog:1025'\"" >> /usr/local/etc/php/php.ini

# Add bin/magento autocompletion
RUN curl -o /etc/bash_completion.d/magento2-bash-completion-enterprise https://raw.githubusercontent.com/yvoronoy/magento2-bash-completion/master/magento2-bash-completion-enterprise

WORKDIR /var/www/html

EXPOSE 9000

USER www-data

# Add magento-cloud tools
RUN echo "source /etc/profile" >> /home/www-data/.bashrc  && \
    echo "alias n98=/usr/local/bin/n98-magerun2.phar" >> /home/www-data/.bashrc && \
    curl -sS https://accounts.magento.cloud/cli/installer | php; exit 0

ENV PATH "$PATH:/home/www-data/.magento-cloud/bin"

CMD ["bash"]
