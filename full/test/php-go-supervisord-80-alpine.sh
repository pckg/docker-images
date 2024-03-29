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

matchCommandWithOutput "php -v" "PHP 8.0." "Missing or invalid PHP version"

echo "SUCCESS"
