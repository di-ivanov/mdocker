FROM php:8.2.4-fpm-alpine

# Set timezone variable, you can control this from docker-compose
# env DEFAULT_TZ
ARG TZ='Europe/Berlin'
ENV DEFAULT_TZ ${TZ}

# Add dependencies
RUN apk add --no-cache \
    $PHPIZE_DEPS \
    bash \
    freetype \
    freetype-dev \
    g++ \
    icu \
    icu-dev \
    libgcrypt-dev \
    libjpeg-turbo \
    libjpeg-turbo-dev \
    libmcrypt \
    libmcrypt-dev \
    libpng \
    libpng-dev \
    libsodium-dev \
    libxml2-dev \
    libxslt-dev \
    libzip-dev \
    linux-headers \
    make \
    shadow \
    tzdata \
    zlib-dev

# Add timezone so we can remove tzdata
RUN cp /usr/share/zoneinfo/${DEFAULT_TZ} /etc/localtime

# Install modules
RUN docker-php-ext-configure intl && \
    docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg && \
    docker-php-ext-install \
        bcmath \
        gd \
        intl \
        mysqli \
        pcntl \
        pdo \
        pdo_mysql \
        soap \
        sockets \
        sodium \
        xsl \
        zip

# Add pecl
# RUN pecl install mcrypt-1.0.4 && \
#     docker-php-ext-enable mcrypt

# Clean not needed dependencies
RUN apk del --no-cache \
    freetype-dev \
    g++ \
    icu-dev \
    libjpeg-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libsodium-dev \
    tzdata \
    zlib-dev

WORKDIR /var/www/html

EXPOSE 9000

CMD ["php-fpm"]