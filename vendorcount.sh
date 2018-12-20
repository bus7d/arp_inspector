#!/bin/bash



cat $1.device|cut -d " " -f2 > $1.files

for files in $(cat $1.files );do cat $files|grep -v base >>$1.hosts;done

cat $1.hosts|sort -u >$1.temp
 echo "$1 number "
 wc -l $1.temp
