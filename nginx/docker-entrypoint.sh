#!/bin/sh
set -e

cd `dirname $0`

if [ "${1:0:1}" = '-' ]; then
	set -- nginx "$@"
fi

# 对文件夹进行权限修改
if [ "$1" = 'nginx-server' -a "$(id -u)" = '0' ]; then
	exec nginx

	# 这部分由于项目多的时候，执行会非常慢，放在 nginx 启动后执行
	#chown -R work:work /home/work/www
fi

exec "$@"
