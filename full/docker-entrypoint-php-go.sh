#!/bin/bash
set -e

if [ -z "$JOB" ]; then
    echo "JOB env variable is required";
    exit;
fi

chown -R www-data:www-data /var/www/html/

echo "Running $JOB"
/var/www/html/$JOB