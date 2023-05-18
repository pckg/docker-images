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

Env variables:

- `REDIS_HOST` & `REDIS_PORT` - hostname and port to which PHP will store sessions
- `REDIS_PASS` - password used to authenticate with Redis

### Apache FPM Snappy 7 (schtr4jh/pckg:apache-fpm-alpine-snappy7)

*(non-alpine Ubuntu image)

Apache 2.4 with PHP 7.4 FPM and Snappy extension.

### Apache FPM Snappy (schtr4jh/pckg:apache-fpm-alpine-snappy)

*(non-alpine Ubuntu image)

Apache 2.4 with PHP 8 FPM and Snappy extension.

### Apache FPM Snappy 8.1 (schtr4jh/pckg:apache-fpm-81-alpine)

*(non-alpine Ubuntu image)

Apache 2.4 with PHP 8.1 FPM.

### Apache FPM 8.2 (schtr4jh/pckg:apache-fpm-82-alpine)

*(non-alpine Ubuntu image)

Apache 2.4 with PHP 8.2 FPM.

### PHP (schtr4jh/pckg:php-cron)

PHP 7.4

Env variables:

- `JOB` (required) - PHP script available in `/var/www/html/`

### PHP 8.0 (schtr4jh/pckg:php-cron-80)

PHP 8.0

Env variables:

- `EVERY` (required) - `* * * * *`
- `JOB` (required) - PHP script available in `/var/www/html/`

### PHP Sendmail (schtr4jh/pckg:sendmail-php)

PHP 7.4 with `sendmail` and `opendkim`.

Env variables:

- `DOMAIN` - hostname domain for DKIM and SPF

### GO (schtr4jh/pckg:php-go-alpine)

*(non-alpine Ubuntu image)

PHP 7.4 with `golang`.

Env variables:

- `JOB` (required) - GO script available in `/var/www/html/`

### GO 8.0 (schtr4jh/pckg:php-go--80-alpine)

*(non-alpine Ubuntu image)

PHP 8.0 with `golang`.

Env variables:

- `JOB` (required) - GO script available in `/var/www/html/`

### GO supervisor (schtr4jh/pckg:php-go-supervisor-alpine)

*(non-alpine Ubuntu image)

PHP 7.4 with `golang` and `supervisord`.

### GO supervisor 8.0 (schtr4jh/pckg:php-go-supervisor-80-alpine)

*(non-alpine Ubuntu image)

PHP 8.0 with `golang` and `supervisord`.

## Dev

### Latest (schtr4jh/pckg:latest)

Includes `node`, `yarn`, `composer`, `webpack`, `webpack-cli`, `g++`, `zip`, `unzip`, `git`, `wget`, and `python2`.

Mount points:

- `/home/developer/developer.ovpn` - mount `.ovpn` file and connect to OpenVPN server
- `/root/.ssh/id_rsa` & `/root/.ssh/id_rsa.pub` - mount to allow SSH for GIT
- `/root/.composer/auth.json` - mount to share credentials for Composer

Env variables:

- `PCKG_EMAIL` & `PCKG_NAME` - set GIT email and name

### Services (schtr4jh/pckg:services)

Includes `MySQL`, `PostgreSQL`, `Redis` and `RabbitMQ` servers.

# Tests

Tests are available in `./full/test/` folder.

See `./.github/workflows/build.yaml` for more info about the build process.

# Availability table

| Name               | Image                            | PHP     | Apache     | Cron  | PM    |
|--------------------|----------------------------------|---------| ---        | ---   | ---   |  
| Base*              | pckg:base                        |         |            |       |       |
| Beanstalkd         | pckg:beanstalkd                  |         |            |       |       |
| Apache             | pckg:apache-alpine               | X       |     X      |       |   X   |
| Apache FPM         | pckg:apache-fpm-alpine           | X       |     X      |       |   X   |
| Apache FPM Snappy7 | pckg:apache-fpm-alpine-snappy    | X (7.4) |     X      |       |   X   |
| Apache FPM Snappy  | pckg:apache-fpm-80-alpine-snappy | X (8.0) |     X      |       |   X   |
| Apache FPM8.1      | pckg:apache-fpm-81-alpine-snappy | X (8.1) |     X      |       |   X   |
| Apache FPM8.2      | pckg:apache-fpm-82-alpine-snappy | X (8.2) |     X      |       |   X   |
| PHP Cron*          | pckg:php-cron                    | X       |            |   X   |       |
| PHP Cron* 8.0      | pckg:php-cron-80                 | X (8.0) |            |   X   |       |
| Sendmail           | pckg:sendmail-php                | X       |            |   X   |       |
| Go*                | pckg:php-go-alpine               | X       |            |       |       |
| Go 8.0             | pckg:php-go-80-alpine            | X (8.0) |            |       |       |
| Go Supervisor      | pckg:php-go-supervisor-alpine    | X       |            |       |       |
| Go Supervisor 8.0  | pckg:php-go-supervisor-80-alpine | X (8.0) |            |       |       |
| Go Puppeteer       |                                  | X       |            |       |       |
| Dev (latest)       | pckg:latest                      | X       |            |       |   X   |
| Services           | pckg:services                    | X       |            |       |   X   |

