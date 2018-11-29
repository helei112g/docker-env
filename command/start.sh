#! /bin/sh
cd `dirname $0`

. ./function.sh
. ./color.sh

# 创建保存数据的目录
createDataDirs
# 创建日志目录
createLogDirs

# 检查是否启动
isWorkForContainer
if [ $? = 1 ]; then
  $OUTPUT "
  $WHITE Dayu docker environment is running $TAILS
  "
  docker ps | grep dayu-php
else
  docker-compose up -d
  $OUTPUT "
  $WHITE Dayu docker environment start work, enjoy coding... $TAILS
  "
fi
