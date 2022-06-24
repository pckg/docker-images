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

# chown storage when existent
echo "Chowning"
[ -d "/var/www/html/storage" ] && chown -R www-data:www-data /var/www/html/storage

echo "Creating apache run dir"
mkdir -p /var/run/apache2

# enable redis session
echo "Enabling redis session handler"
echo "session.save_handler = redis" >> /etc/php/8.0/fpm/php.ini
echo "session.save_path = \"tcp://${REDIS_HOST##/cache-server-}:6379?auth="${REDIS_PASS}"\"" >> /etc/php/8.0/fpm/php.ini

# choose ssl (http+https) or non-ssl (http) environment
# wait, we mounted some of those files, so we don't really want to override them?
[[ -n $NO_SSL_ENV ]] && echo "Using non-SSL / http-only environment" && mv /etc/apache2/sites-available/000-default-http.conf /etc/apache2/sites-enabled/000-default.conf

echo "Starting php"
service php8.0-fpm start

echo "Starting apache"
/usr/sbin/apache2 -D FOREGROUND
#/bin/bash
