#! /bin/sh

# 检查image是否安装
function checkImageExist()
{
  phpVersion=`docker image ls | grep dayu-php | awk '{print $2}'`
  if [ -z "$phpVersion" ] ; then
    return 0
  fi

  php71='7.2.6'
  php53='5.3.29'
  for version in ${phpVersion[@]}
  do
    if [ $version != $php71 ] && [ $version != $php53 ]; then
      return 0
    fi
  done

  return 1
}

# 创建网络
function createNetwork()
{
  net=`docker network ls | grep 'dayuenv' | awk '{print $2}'`
  defaultNet="dayuenv_default"
  if [ ! -z "$net" ] && [ $defaultNet = $net ]; then
    return 1
  fi

  docker network create dayuenv_default
  return 0
}

# 创建日志目录
function createLogDirs()
{
  logpath='../logs'
  if [ ! -d $logpath ]; then
    $OUTPUT "$WHITE make log dir $TAILS"
    mkdir -p $logpath
  fi

  appLogDirs=('nginx' 'redis' 'phpfpm')
  for i in ${appLogDirs[@]}
  do
    appLogPath="${logpath}/${i}"
    if [ ! -d $appLogPath ]; then
      $OUTPUT "$WHITE make app log dir: $appLogPath $TAILS"
      mkdir -p $appLogPath
    fi
  done
}

# 检查容器是否已经开始工作
function isWorkForContainer()
{
  phpVersion=`docker ps | grep dayu-php | awk '{print $2}'`
  if [ -z "$phpVersion" ] ; then
    return 0
  fi
  php71='dayu-php:7.2.6'
  php53='dayu-php:5.3.29'

  for version in ${phpVersion[@]}
  do
    if [ $version != $php71 ] && [ $version != $php53 ]; then
      return 0
    fi
  done

  return 1
}

# pull code
function getcode()
{
  target=$codepath/$3
  if test -d $target; then
    cd $target
    $OUTPUT "$BLUE git pull $target $TAILS"
    git pull >> $logfile
    cd - >> /dev/null
  else
    $OUTPUT "$GREEN git clone -b $2 $1 $target $TAILS"
    git clone -b $2 $1 $target >> $logfile
  fi
}