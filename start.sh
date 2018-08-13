#! /bin/sh
cd `dirname $0`

# 检查日志文件是否存在
logpath='./logs'
if [ ! -d $logpath ]; then
  echo 'make log dir'
  mkdir -p $logpath
fi

# 初始化应用对应的目录
appLogDirs=('nginx' 'redis' 'phpfpm')
for i in ${appLogDirs[@]}
do
  appLogPath="${logpath}/${i}"
  if [ ! -d $appLogPath ]; then
    echo 'make app log dir:' $appLogPath
    mkdir -p $appLogPath
  fi
done

# 生成项目文件
wwwpath='./www/test'
if [ ! -d $wwwpath ]; then
  echo 'make www dir'
  mkdir -p $wwwpath
fi

# 生成php info文件
testphp='./www/test/index.php'
if [ ! -f $testphp ]; then
  echo 'touch php file'
  touch $testphp
  echo '<?php\n phpinfo();' > $testphp
fi

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
