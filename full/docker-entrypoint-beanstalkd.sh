#!/bin/bash
set -e

beanstalkd -l 0.0.0.0 -p 11300

/bin/bash