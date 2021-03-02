# pckg/docker-images

A collection of docker images for rapid web development.

## Base (schtr4jh/pckg:base)

Base up-to-date Ubuntu image with `locales`, `software-properties-common`, `sudo`, `curl`, `apt-transport-https`
, `apt-utils`, `tzdata`, `openssl`, `ca-certificates`, `gnupg-agent`, and generated `en_US.UTF-8` locale.

## Standalone services

All PHP images include `curl`, `intl`, `xml`, `mbstring`, `zip`, `mysql`, `pgsql`, `cli`, `amqplib`, `ssh2`, `zmq`
, `imap`, `redis`, `bcmath`, `gd`, `bz2`, `soap`, and `dev` extensions.

All Apache images include have `expires`, `headers`, `rewrite` and `ssl` modules enabled.

### Beanstalkd (schtr4jh/pckg:beanstalkd)

Beanstalkd server.

## Group services

### Apache (schtr4jh/pckg:apache-alpine)

*(non-alpine Ubuntu image)

Apache 2.4 with PHP 7.4.

### Apache FPM (schtr4jh/pckg:apache-fpm-alpine)

*(non-alpine Ubuntu image)

Apache 2.4 with PHP 7.4 FPM.

### Apache FPM Snappy (schtr4jh/pckg:apache-fpm-alpine-snappy)

*(non-alpine Ubuntu image)

Apache 2.4 with PHP 7.4 FPM and Snappy extension.

### PHP (schtr4jh/pckg:php-cron)

PHP 7.4

### Sendmail (schtr4jh/pckg:sendmail-php)

PHP 7.4 with `sendmail` and `opendkim`.

### GO (schtr4jh/pckg:php-go-alpine)

*(non-alpine Ubuntu image)

PHP 7.4 with `golang`.

### GO supervisor (schtr4jh/pckg:php-go-supervisor-alpine)

*(non-alpine Ubuntu image)

PHP 7.4 with `golang` and `supervisord`.

## Dev

### Latest (schtr4jh/pckg:latest)

Includes `node`, `yarn`, `composer`, `webpack`, `webpack-cli`, `g++`, `zip`, `unzip`, `git`, `wget`, and `python2`.

### Services (schtr4jh/pckg:services)

Includes MySQL, PostgreSQL, Redis and RabbitMQ servers.

# Tests

Tests are available in `./full/test/` folder.

See `./.github/workflows/build.yaml` for more info about the build process.
