#! bin/sh
cd `dirname $0`

# 对文件夹进行权限修改
chown -R work:work /home

# 启动 nginx
nginx
