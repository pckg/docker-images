#!/bin/bash

[ "$DEBUG" ] && set -x

# set current working directory to the directory of the script
cd "$(dirname "$0")"

matchCommandWithOutput () {
  OUTPUT=$($1)
  echo $OUTPUT

  PHP=$(echo $OUTPUT | grep "$2" -c)
  echo $PHP

  [ "$PHP" != "1" ] && echo "$3" && echo "Expected $2" && exit 1
}

matchCommandWithOutput "php -v" "PHP 8.2." "Missing or invalid PHP version"
[ -f /usr/bin/phpize ] || (echo "No phpize or missing php-dev" && exit 1)

matchCommandWithOutput "node --version" "v16." "Missing or invalid node version"
matchCommandWithOutput "npm --version", "6." "Missing or invalid npm version"
matchCommandWithOutput "yarn --version" "1." "Missing or invalid yarn version"
matchCommandWithOutput "composer --version" "Composer version 2." "Missing or invalid composer"

matchCommandWithOutput "webpack --version" "webpack: 5." "Missing or invalid webpack"
matchCommandWithOutput "webpack --version" "webpack-cli: 4." "Missing or invalid webpack-cli"
matchCommandWithOutput "lessc --version" "lessc 4." "Missing or invalid less"

matchCommandWithOutput "mysql --version" "mysql Ver 8." "Missing or invalid mysql server"
matchCommandWithOutput "apache2 -v" "Apache/2.4." "Missing or invalid apache server"

matchCommandWithOutput "git --version" "git version 2." "Missing or invalid git"

echo "SUCCESS"
