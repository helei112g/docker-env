#! /bin/sh
cd `dirname $0`

. ./function.sh
. ./color.sh

# 创建日志目录
createLogDirs

# 检查是否启动
isWorkForContainer
if [ $? = 1 ]; then
  $OUTPUT "
  $WHITE php5.3 and php 7.1 container is running $TAILS
  "
  docker ps | grep mi-php
else
  docker-compose up -d
  $OUTPUT "
  php5.3 and php 7.1 environment start work, enjoy coding...
  "
fi
