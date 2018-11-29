#! /bin/sh
cd `dirname $0`

. ./function.sh
. ./color.sh

dir=$(cd ../;pwd)
conf=$dir/code.conf
if [ ! -f $conf ]; then
  cp $dir/code.conf.bak $dir/code.conf
fi

logfile=$dir/getcode.log
rm -rf $logfile

cd $dir
if [ ! -d $1 ]; then
  $OUTPUT "$RED $1 dir isn't exist, create the dir $TAILS\n"
  mkdir -p $1
fi
codepath=$(cd $1;pwd)
$OUTPUT "CODE PATH: $codepath \n"

# 创建代码相关的目录
logDirs=('golang/bin' 'golang/pkg' 'golang/src' 'php' 'js' 'nginx')
for i in ${logDirs[@]}
do
  codeDir="${codepath}/${i}"
  if [ ! -d $codeDir ]; then
    $OUTPUT "$GREEN create code dir: $codeDir $TAILS"
    mkdir -p $codeDir
  fi
done

if test ! -f $conf; then
  $OUTPUT "file $conf not exists"
  exit 1
fi

while read micodepath
do
  micodepath=`echo $micodepath | grep -v "#"`
  if [ "$micodepath" = "" ];then
    continue
  fi
  #$OUTPUT "$BLUE git pull $micodepath $TAILS"
  getcode $micodepath
done < $conf
$OUTPUT "\n $YELLOW pull code complete!!!! $TAILS"