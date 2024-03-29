echo "\n\nBase"
php build.php base
php build.php base alpine

echo "\n\nApache FPM (7.4)"
php build.php apache-fpm
php build.php apache-fpm alpine

echo "\n\nApache FPM 8.0"
php build.php apache-fpm-80
php build.php apache-fpm-80 alpine

echo "\n\nApache FPM 8.1"
php build.php apache-fpm-81
php build.php apache-fpm-81 alpine

echo "\n\nApache FPM 8.2"
php build.php apache-fpm-82
php build.php apache-fpm-82 alpine

echo "\n\nApache FPM 8.3"
php build.php apache-fpm-83
php build.php apache-fpm-83 alpine

echo "\n\nApache FPM snappy 8.0"
php build.php apache-fpm-snappy
php build.php apache-fpm-snappy alpine

echo "\n\nApache FPM snappy7"
php build.php apache-fpm-snappy7
php build.php apache-fpm-snappy7 alpine

echo "\n\nApache"
php build.php apache
php build.php apache alpine

echo "\n\nPHP cron"
php build.php php-cron
php build.php php-cron alpine

echo "\n\nPHP cron 8.0"
php build.php php-cron-80
php build.php php-cron-80 alpine

echo "\n\nPHP go"
php build.php php-go
php build.php php-go alpine

echo "\n\nPHP go 8.0"
php build.php php-go-80
php build.php php-go-80 alpine

echo "\n\nPHP go (supervisord)"
php build.php php-go-supervisord
php build.php php-go-supervisord alpine

echo "\n\nPHP go (supervisord) 8.0"
php build.php php-go-supervisord-80
php build.php php-go-supervisord-80 alpine

echo "\n\nPHP go (puppeteer)"
php build.php php-go-puppeteer
php build.php php-go-puppeteer alpine

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
