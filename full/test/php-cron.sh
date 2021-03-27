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

matchCommandWithOutput "php -v" "PHP 7.4." "Missing or invalid PHP version"

matchCommandWithOutput "mysql --version" "mysql Ver 8." "Missing or invalid mysql server"
matchCommandWithOutput "apache2 -v" "Apache/2.4." "Missing or invalid apache server"

matchCommandWithOutput "git --version" "git version 2." "Missing or invalid git"

echo "SUCCESS"
