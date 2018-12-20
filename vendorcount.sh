#!/bin/bash

echo "ENTER VENDOR NAME"
read VENDOR

cat $VENDOR.device|cut -d " " -f2 > $VENDOR.files 
 
for files in $(cat $VENDOR.files );do cat $files|grep -v base >>$VENDOR.hosts;done
 
cat $VENDOR.hosts|sort -u >$VENDOR.temp
 echo "$VENDOR number "
 wc -l $VENDOR.temp
 
 
 
