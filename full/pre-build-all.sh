echo "\n\nBase"
php build.php base

echo "\n\nApache FPM"
php build.php apache-fpm

echo "\n\nApache"
php build.php apache

echo "\n\nPHP cron"
php build.php php-cron

echo "\n\nPHP go"
php build.php php-go

echo "\n\nPHP go (supervisord)"
php build.php php-go-supervisord

echo "\n\nBeanstalkd"
php build.php beanstalkd

echo "\n\nRabbitMQ"
php build.php rabbitmq

echo "\n\nRedis"
php build.php redis

echo "\n\nSendmail (PHP)"
php build.php sendmail-php

echo "\n\nDocker"
php build.php docker

echo "\n\nDev"
php build.php ""