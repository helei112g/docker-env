#!/bin/sh
cd `dirname $0`

. ./color.sh
. ./function.sh

# 检查是否启动
isWorkForContainer
if [ $? = 1 ]; then
  docker-compose stop
fi

# 删除
$OUTPUT "
$RED delete the i18n container and logs dir $TAILS
"

logDir=../logs
rm -rf $logDir

docker-compose rm
