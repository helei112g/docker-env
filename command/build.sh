#! /bin/sh
cd `dirname $0`

. ./function.sh
. ./color.sh

#检查是否需要初始化
checkImageExist
if [ $? = 1 ]; then
  $OUTPUT "$SKY_GREEN the image is exist. please use [dayuenv start] $TAILS"
  exit
fi

dir=$(cd ../; pwd)
$OUTPUT "docker compose file dir:$dir"

# 拷贝文件
cp $dir/docker-compose.yml.bak $dir/docker-compose.yml
cp $dir/code.conf.bak $dir/code.conf

$OUTPUT "get current uid and gid ... "
uid=`id|grep -o "uid=[0-9]\+"|grep -o "[0-9]\+"`
gid=`id|grep -o "gid=[0-9]\+"|grep -o "[0-9]\+"`
$OUTPUT "$GREEN uid=$uid  gid=$gid  $TAILS"

sys=`uname -s`
case $sys in
  "Linux")
    sed -i "s/UID/$uid/g" $dir/docker-compose.yml
    sed -i "s/GID/$gid/g" $dir/docker-compose.yml
    ;;
  "Darwin")
    sed -i "" "s/UID/$uid/g" $dir/docker-compose.yml
    sed -i "" "s/GID/$gid/g" $dir/docker-compose.yml
    ;;
  *)
    $OUTPUT "system $sys not supported!"
    exit -1
esac

user=`whoami`
inDocker=`id|grep docker`
if [ "$inDocker" = "" ]; then
  $OUTPUT "add current user $user to docker group ... "
  case $sys in
    "Linux")
      sudo usermod -a -G docker $user
      ;;
    "Darwin")
      sudo dscl . -append /Groups/docker GroupMembership $user
      ;;
    *)
      $OUTPUT "system $sys not supported!"
      exit -1
  esac
fi

# 创建默认网络
createNetwork
docker-compose up -d

# 创建日志目录
createLogDirs

$OUTPUT "$GREEN Congratulations! you can use the container! $TAILS"
