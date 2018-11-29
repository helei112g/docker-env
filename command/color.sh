#! /bin/sh

#字颜色变量
BLACK="\033[30m"          #黑色
RED="\033[31m"            #红色
GREEN="\033[32m"          #绿色
YELLOW="\033[33m"         #黄色
BLUE="\033[34m"           #蓝色
PURPLE="\033[35m"         #紫色
SKY_GREEN="\033[36m "     #天绿色
WHITE="\033[37m"          #白色
 
#字背景颜色变量
BLACK_WHITE="\033[40;37m"      #黑底白字
RED_WHITE="\033[41;37m"        #红底白字
GREEN_WHITE="\033[42;37m"      #绿底白字
YELLOW_WHITE="\033[43;37m"     #黄底白字
BLUE_WHITE="\033[44;37m"       #蓝底白字
PURPLE_WHITE="\033[45;37m"     #紫底白字
SKY_BLUE_WHITE="\033[46;37m"   #天蓝底白字
WHITE_BLACK="\033[47;30m"      #白底黑字
 
#闪炼变量
FLICKER="\033[05m"
BTLINE="\033[4m"
 
#头部
sys=`uname -s`
case $sys in
	"Darwin")
    OUTPUT="echo"
		;;
	*)
		OUTPUT="echo -e"
esac
 
#尾部
TAILS="\033[0m"