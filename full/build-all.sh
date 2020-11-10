docker build -t schtr4jh/private:sendmail-php -f Dockerfile-sendmail-php .
docker push schtr4jh/private:sendmail-php

docker build -t schtr4jh/private:redis -f Dockerfile-redis .
docker push schtr4jh/private:redis

docker build -t schtr4jh/private:rabbitmq -f Dockerfile-rabbitmq .
docker push schtr4jh/private:rabbitmq

docker build -t schtr4jh/private:php-cron -f Dockerfile-php-cron .
docker push schtr4jh/private:php-cron

docker build -t schtr4jh/private:apache -f Dockerfile-apache .
docker push schtr4jh/private:apache