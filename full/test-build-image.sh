#!/bin/bash

[ "$DEBUG" ] && set -x

# set current working directory to the directory of the script
cd "$(dirname "$0")"

dockerImage=$1
testSuite=$2

echo "Testing $dockerImage..."

if ! docker inspect "$dockerImage" &> /dev/null; then
    echo $'\timage does not exist!'
    false
fi

# running tests
OUTPUT=$(docker run -v $PWD/test/$2.sh:/docker-entrypoint$3.sh -v $PWD/test:/var/www/html/www $dockerImage)

echo $OUTPUT

if [[ "$OUTPUT" == *"ERROR"* ]]; then
  echo "ERROR"
  exit 1
fi

if [[ "$OUTPUT" != *"SUCCESS"* ]]; then
  echo "Not explicit SUCCESS"
  exit 1
fi

echo "SUCCESS"
