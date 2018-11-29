#! /bin/sh
cd `dirname $0`

. ./function.sh
. ./color.sh

# 检查是否启动
isWorkForContainer
if [ $? = 1 ]; then
  $OUTPUT "
  $WHITE docker container will stop running $TAILS
  "
  docker-compose stop
else
  $OUTPUT "
  $WHITE docker container was stop $TAILS
  "
fi
