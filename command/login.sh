#!/bin/sh
cd `dirname $0`

. ./color.sh

if [ $1 ] && [ $1 = 'php' ]; then
  $OUTPUT "
  $WHITE into the dayu-php container $TAILS
  "
  docker exec -it dev-php7 /bin/bash
elif [ $1 ] && [ $1 = 'nginx' ]; then
  $OUTPUT "
  $WHITE into the dayu-nginx container $TAILS
  "
  docker exec -it dev-nginx /bin/sh
elif [ $1 ] && [ $1 = 'redis' ]; then
  $OUTPUT "
  $WHITE into the dayu-redis container $TAILS
  "
  docker exec -it dev-redis /bin/sh
elif [ $1 ] && [ $1 = 'mysql' ]; then
  $OUTPUT "
  $WHITE into the dayu-mysql container $TAILS
  "
  docker exec -it dev-mysql /bin/bash
elif [ $1 ] && [ $1 = 'golang' ]; then
  $OUTPUT "
  $WHITE into the dayu-golang container $TAILS
  "
  docker exec -it dev-golang /bin/sh
else
  $OUTPUT "
  $WHITE example: ./dayuenv.sh login php $TAILS
   option: [php] [nginx] [redis] [mysql]
  "
fi