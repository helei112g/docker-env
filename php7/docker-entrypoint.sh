#!/bin/sh
set -e

cd `dirname $0`

# 对文件夹进行权限修改
if [ "$1" = 'php-fpm' -a "$(id -u)" = '0' ]; then
	chown -R work:work /home
	exec php-fpm
fi

exec "$@"
