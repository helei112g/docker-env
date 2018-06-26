#!/bin/sh
set -e

cd `dirname $0`

# 对文件夹进行权限修改
if [ "$1" = 'php-fpm' -a "$(id -u)" = '0' ]; then
	chown -R work:work /home/work/app
	exec php-fpm

	# 这部分由于项目多的时候，执行会非常慢，放在 php fmp启动后执行
	#chown -R work:work /home/work/www
fi

exec "$@"
