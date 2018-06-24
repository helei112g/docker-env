#! /bin/sh
cd `dirname $0`

# 检查日志文件是否存在
logpath='./logs'
if [ ! -d $logpath ]; then
  echo 'make log dir'
  mkdir -p $logpath
fi

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

docker-compose up -d
