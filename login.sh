#! /bin/sh
cd `dirname $0`

if [ $1 ] && [ $1 = 'php' ]; then
    echo 'enter php fpm server.'
    docker exec -it php7_dev.php-fpm.srv_1 /bin/bash
elif [ $1 ] && [ $1 = 'nginx' ]; then
    echo 'enter nginx server.'
    docker exec -it dockerenv_dev.nginx.srv_1 /bin/sh
elif [ $1 ] && [ $1 = 'redis' ]; then
    echo 'enter redis server.'
    docker exec -it dockerenv_dev.redis.srv_1 /bin/sh
elif [ $1 ] && [ $1 = 'mysql' ]; then
    echo 'enter mysql server.'
    docker exec -it dockerenv_dev.mysql.srv_1 /bin/bash
else
    echo 'need args: php  nginx  redis  mysql\n'
    echo 'like this: ./login.sh php'
fi