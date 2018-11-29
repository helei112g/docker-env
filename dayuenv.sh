#! /bin/sh
cd `dirname $0`

. ./command/color.sh

# 获取输入命令
cmd=$1

case $cmd in
  "build" )
    $OUTPUT "$RED  Build the docker image and init container $TAILS\n"
    ./command/start.sh
    exit
  ;;
  "start" )
    $OUTPUT "$RED  Start the docker container $TAILS\n"
    ./command/start.sh
    exit
  ;;
  "restart" )
    $OUTPUT "$RED  Restart the docker container $TAILS\n"
    ./command/restart.sh
    exit
  ;;
  "login" )
    $OUTPUT "$RED  Into the docker container $TAILS\n"
    ./command/login.sh $2
    exit
  ;;
  "stop" )
    $OUTPUT "$RED  Stop the docker container $TAILS\n"
    ./command/stop.sh
    exit
  ;;
  "list" )
    $OUTPUT "$RED  Show all the container $TAILS\n"
    docker ps -a | grep mi-php
    exit
  ;;
  "getcode" )
    $OUTPUT "$RED  Update project code $TAILS\n"
    codepath=$2
    if [ -z "$2" ];then
      codepath='../code'
    fi
    ./command/code.sh $codepath
    exit
  ;;
  "destroy" )
    $OUTPUT "$RED  Delete the docker container $TAILS\n"
    ./command/destroy.sh
    exit
  ;;
  * )
$OUTPUT "
  $BLUE$FLICKER Building a development environment for yourself by docker $TAILS

  $YELLOW Usage: $TAILS
    $WHITE dayuenv $TAILS start/list/restart/stop/getcode/login/destroy

  $YELLOW Command: $TAILS
    $WHITE dayuenv build $TAILS      build image and init docker container
    $WHITE dayuenv start $TAILS      build or start container
    $WHITE dayuenv list $TAILS       show container list
    $WHITE dayuenv restart $TAILS    restart container
    $WHITE dayuenv stop $TAILS       stop container
    $WHITE dayuenv getcode $TAILS    clone or pull project code from micode, option: [code path], default: ../code
    $WHITE dayuenv login $TAILS      into the container, option: [php] [nginx] [redis] [mysql]
    $WHITE dayuenv destroy $TAILS    destroy container and delete the logs dir
    $WHITE dayuenv help $TAILS       commands list

  $GREEN Blog: $BTLINE https://dayutalk.cn$TAILS
  $GREEN GitHub: $BTLINE https://github.com/helei112g$TAILS
  "
    exit
  ;;
esac
