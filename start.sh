#! /bin/sh
cd `dirname $0`

# 生成redis与mysql的数据保存文件
basePath='./'
dataDirs=('mysql' 'redis')
for i in ${dataDirs}
do
  dataPath="${basePath}/${i}/data"
  if [ ! -d $dataPath ]; then
    echo "make ${i} data dir"
    mkdir -p $dataPath
  fi
done

# 首先启动 php7 ，再启动其它服务
echo 'start php7-fpm...'
cd php7
docker-compose up -d

# 启动php5.3
echo '\nstart php53-fpm...'
cd ../php53
docker-compose up -d

cd ..
echo '\nstart mysql/redis/nginx ...'
docker-compose up -d
