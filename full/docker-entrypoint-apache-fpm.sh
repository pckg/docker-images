#!/bin/bash
set -e

unset HOME
if [ "${APACHE_CONFDIR##/etc/apache2-}" != "${APACHE_CONFDIR}" ] ; then
    SUFFIX="-${APACHE_CONFDIR##/etc/apache2-}"
else
    SUFFIX=
fi
export APACHE_RUN_USER=www-data
export APACHE_RUN_GROUP=www-data
export APACHE_PID_FILE=/var/run/apache2/apache2$SUFFIX.pid
export APACHE_RUN_DIR=/var/run/apache2$SUFFIX
export APACHE_LOCK_DIR=/var/lock/apache2$SUFFIX
export APACHE_LOG_DIR=/var/log/apache2$SUFFIX
export LANG=C
export LANG

chown -R www-data:www-data /var/www/html/storage

mkdir -p /var/run/apache2

# enable redis session
echo "session.save_handler = redis" >> /etc/php/7.4/fpm/php.ini
echo "session.save_path = \"tcp://cache-server:6379?auth="${REDIS_PASS}"\"" >> /etc/php/7.4/fpm/php.ini

service php7.4-fpm start

/usr/sbin/apache2 -D FOREGROUND
#/bin/bash