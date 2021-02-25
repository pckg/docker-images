#!/bin/bash

[ "$DEBUG" ] && set -x

# set current working directory to the directory of the script
cd "$(dirname "$0")"

matchCommandWithOutput () {
  OUTPUT=$($1)
  echo $OUTPUT

  PHP=$(echo $OUTPUT | grep "$2" -c)
  echo $PHP

  [ "$PHP" != "1" ] && echo "$3" && exit 1
}

matchCommandWithOutput "php -v" "PHP 7.4." "Missing or invalid PHP version"
[ -f /usr/bin/phpize ] || (echo "No phpize or missing php-dev" && exit 1)

matchCommandWithOutput "node --version" "v14.16." "Missing or invalid node version"
matchCommandWithOutput "npm --version", "7.5." "Missing or invalid npm version"
matchCommandWithOutput "yarn --version" "1.22." "Missing or invalid yarn version"
matchCommandWithOutput "composer --version" "Composer version 2." "Missing or invalid composer"

matchCommandWithOutput "webpack --version" "webpack 5." "Missing or invalid webpack"
matchCommandWithOutput "webpack --version" "webpack-cli 4." "Missing or invalid webpack-cli"
matchCommandWithOutput "lessc --version" "lessc 4." "Missing or invalid less"

matchCommandWithOutput "redis-server --version" "Redis server v=5." "Missing or invalid redis server"
matchCommandWithOutput "ls /usr/lib/rabbitmq/lib/" "rabbitmq_server-3.8." "Missing or invalid rabbitmq server"
matchCommandWithOutput "mysql --version" "mysql Ver 8." "Missing or invalid mysql server"
matchCommandWithOutput "apache2 -v" "Apache/2.4." "Missing or invalid apache server"
#matchCommandWithOutput "docker -v" "Docker version 20." "Missing or invalid docker"

#matchCommandWithOutput "nano --version" "version 4.8" "Missing or invalid nano"
matchCommandWithOutput "git --version" "git version 2." "Missing or invalid git"

echo "SUCCESS"
