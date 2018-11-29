#!/bin/sh
cd `dirname $0`

. ./color.sh

if [ $1 ] && [ $1 = 'php' ]; then
  $OUTPUT "
  $WHITE into the dayu-php container $TAILS
  "
  docker exec -it php7_dev.php-fpm.srv_1 /bin/bash
elif [ $1 ] && [ $1 = 'nginx' ]; then
  $OUTPUT "
  $WHITE into the dayu-nginx container $TAILS
  "
  docker exec -it dockerenv_dev.nginx.srv_1 /bin/sh
elif [ $1 ] && [ $1 = 'redis' ]; then
  $OUTPUT "
  $WHITE into the dayu-redis container $TAILS
  "
  docker exec -it dockerenv_dev.redis.srv_1 /bin/sh
elif [ $1 ] && [ $1 = 'mysql' ]; then
  $OUTPUT "
  $WHITE into the dayu-mysql container $TAILS
  "
  docker exec -it dockerenv_dev.mysql.srv_1 /bin/bash
else
  $OUTPUT '$WHITE need option: php  nginx  redis  mysql $TAILS'
  $OUTPUT '$WHITE like this: ./dayuenv.sh login php $TAILS'
fi