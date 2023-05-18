#!/bin/bash
set -e

if [ -z "$JOB" ]; then
    echo "JOB env variable is required";
    exit;
fi

if [ -z "$EVERY" ]; then
    echo "EVERY env variable is required";
    exit;
fi

# chown storage when existent
[ -d "/var/www/html/storage" ] && chown -R www-data:www-data /var/www/html/storage

# create crontab definition
echo "Creating crontab"
echo "$EVERY $JOB > /proc/1/fd/1 2>/proc/1/fd/2" > /etc/cron.d/crontab

# Update permissions
echo "Chmodding crontab"
chmod 0644 /etc/cron.d/crontab

# Add to cron
echo "Preparing cron"
/usr/bin/crontab /etc/cron.d/crontab

# run cron
echo "Running cron $EVERY $JOB"
cron -f

echo "Exiting"