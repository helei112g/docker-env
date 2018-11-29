#! /bin/sh
cd `dirname $0`

. ./function.sh
. ./color.sh

dir=$(cd ../;pwd)
conf=$dir/code.conf
if [ ! -f $conf ]; then
  cp $dir/code.conf.bak $dir/code.conf
fi

if test ! -f $conf; then
  $OUTPUT "file $conf not exists"
  exit 1
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

while read line
do
  line=`echo $line | grep -v "#"`
  if [ "$line" = "" ];then
    continue
  fi
  getcode $line
done < $conf
$OUTPUT "\n $YELLOW pull code complete!!!! $TAILS"