echo "\n\nBase"
php build.php base
php build.php base alpine

echo "\n\nApache FPM"
php build.php apache-fpm
php build.php apache-fpm alpine

echo "\n\nApache FPM snappy"
php build.php apache-fpm-snappy
php build.php apache-fpm-snappy alpine

echo "\n\nApache"
php build.php apache
php build.php apache alpine

echo "\n\nPHP cron"
php build.php php-cron
php build.php php-cron alpine

echo "\n\nPHP go"
php build.php php-go
php build.php php-go alpine

echo "\n\nPHP go (supervisord)"
php build.php php-go-supervisord
php build.php php-go-supervisord alpine

echo "\n\nBeanstalkd"
php build.php beanstalkd
php build.php beanstalkd alpine

echo "\n\nRabbitMQ"
php build.php rabbitmq
php build.php rabbitmq alpine

echo "\n\nRedis"
php build.php redis
php build.php redis alpine

echo "\n\nSendmail (PHP)"
php build.php sendmail-php
php build.php sendmail-php alpine

echo "\n\nDocker"
php build.php docker
php build.php docker alpine

echo "\n\nServices"
php build.php ""
php build.php "" alpine

echo "\n\nDev"
php build.php services
php build.php services alpine
