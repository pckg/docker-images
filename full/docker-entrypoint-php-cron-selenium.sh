#!/bin/bash
set -e

if [ -z "$JOB" ]; then
    echo "JOB env variable is required";
    exit;
fi

#echo "Running Selenium via xvfb"
#chromedriver --whitelisted-ips &
#xvfb-run java -Dwebdriver.chrome.driver=/usr/bin/chromedriver -jar /var/www/selenium.jar
# java -jar /var/www/selenium.jar &

#echo "Waiting 5s"
#sleep 5

# chown storage when existent
[ -d "/var/www/html/storage" ] && chown -R www-data:www-data /var/www/html/storage

echo "Running $JOB"
php /var/www/html/$JOB