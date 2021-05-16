#!/bin/sh
XDEBUG_CONFIG_FILE=/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
if [ "${XDEBUG_IDEKEY}" = "PHPSTORM" ]
then
    sed -i '1 a xdebug.remote_mode=req' $XDEBUG_CONFIG_FILE
    sed -i '1 a xdebug.remote_handler=dbgp' $XDEBUG_CONFIG_FILE
    sed -i '1 a xdebug.remote_connect_back=1 ' $XDEBUG_CONFIG_FILE
    sed -i '1 a xdebug.remote_port=${XDEBUG_REMOTE_PORT}' $XDEBUG_CONFIG_FILE
    sed -i '1 a xdebug.remote_enable=1' $XDEBUG_CONFIG_FILE
    sed -i '1 a xdebug.remote_log=/tmp/xdebug.log' $XDEBUG_CONFIG_FILE
    sed -i '1 a xdebug.idekey=${XDEBUG_IDEKEY}' $XDEBUG_CONFIG_FILE
else
    if ! grep -Fq ";zend_extension" $XDEBUG_CONFIG_FILE
    then
        sed -i 's zend_extension ;zend_extension ' $XDEBUG_CONFIG_FILE
    fi
fi
# Start service
exec php-fpm
