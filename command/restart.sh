#! /bin/sh
cd `dirname $0`

. ./color.sh

# 如果未启动，会直接启动
$OUTPUT "
$WHITE docker container will restart $TAILS
"
docker-compose restart
