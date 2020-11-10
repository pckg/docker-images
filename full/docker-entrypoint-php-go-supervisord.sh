#!/bin/bash
set -e

chown -R www-data:www-data /var/www/html/

echo "Running supervisord"
/usr/bin/supervisord
