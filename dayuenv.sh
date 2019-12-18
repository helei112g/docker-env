#! /bin/sh
cd `dirname $0`

. ./command/color.sh

# 获取输入命令
cmd=$1

case $cmd in
  "build" )
    $OUTPUT "$RED  Build the docker image and init container $TAILS\n"
    ./command/build.sh
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
  "ls" )
    $OUTPUT "$RED  Show all the container $TAILS\n"
    docker ps -a | grep dev-*
    exit
  ;;
  "getcode" )
    $OUTPUT "$RED  Update project code $TAILS\n"
    codepath='../code'
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
    $WHITE dayuenv $TAILS build/start/ls/restart/stop/getcode/login/destroy

  $YELLOW Command: $TAILS
    $WHITE dayuenv build $TAILS      build image and init docker container
    $WHITE dayuenv start $TAILS      build or start container
    $WHITE dayuenv ls $TAILS         show container list
    $WHITE dayuenv restart $TAILS    restart container
    $WHITE dayuenv stop $TAILS       stop container
    $WHITE dayuenv getcode $TAILS    clone or pull project code from github, default code path: ../code
    $WHITE dayuenv login $TAILS      into the container, option: [php] [nginx] [redis] [redis-slave] [mysql] [golang]
    $WHITE dayuenv destroy $TAILS    destroy container and delete the logs dir
    $WHITE dayuenv help $TAILS       commands list

  $GREEN GitHub: $BTLINE https://github.com/helei112g$TAILS
  "
    exit
  ;;
esac
