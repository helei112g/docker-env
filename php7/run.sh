#! bin/sh
cd `dirname $0`

# 文件授权
chown -R work:work /home

# 启动 php-fpm
php-fpm
