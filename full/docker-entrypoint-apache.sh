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
[ -d "/var/www/html/storage" ] && chown -R www-data:www-data /var/www/html/storage

/usr/sbin/apache2 -D FOREGROUND
#/bin/bash