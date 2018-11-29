#!/bin/sh
cd `dirname $0`

. ./color.sh

if [ $1 ] && [ $1 = 'p7' ]; then
  $OUTPUT "
  $WHITE into the php 7.1 container $TAILS
  "
  docker exec -it i18n-php71 /bin/bash
else
  $OUTPUT "
  $WHITE into the php 5.3 container $TAILS
  "
  docker exec -it i18n-php53 /bin/bash
fi