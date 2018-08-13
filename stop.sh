#! /bin/sh
cd `dirname $0`

docker-compose stop

cd php7

docker-compose stop

cd ../php53

docker-compose stop