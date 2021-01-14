#!/bin/bash
set -e

# chown storage when existent
[ -d "/var/www/html/storage" ] && chown -R www-data:www-data /var/www/html/storage

echo "Running supervisord"
/usr/bin/supervisord
