#!/bin/bash
set -e

if [ -z "$JOB" ]; then
    echo "JOB env variable is required";
    exit;
fi

# chown storage when existent
[ -d "/var/www/html/storage" ] && chown -R www-data:www-data /var/www/html/storage

echo "Running $JOB"
php /var/www/html/$JOB