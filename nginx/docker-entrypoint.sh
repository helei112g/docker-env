#! bin/sh
cd `dirname $0`

set -e

if [ "${1:0:1}" = '-' ]; then
	set -- nginx "$@"
fi

# 对文件夹进行权限修改
if [ "$1" = 'nginx-server' -a "$(id -u)" = '0' ]; then
	chown -R work:work /home
	exec nginx
fi

# 启动 nginx
exec "$@"
