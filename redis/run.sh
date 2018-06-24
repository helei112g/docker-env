#! bin/sh
cd `dirname $0`

chown -R work:work /home

# 启动 redis
redis-server /home/work/app/redis/conf/redis.conf
