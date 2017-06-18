#!/bin/bash

argc=2

if [ $# -ne $argc ]; then
 echo "Usage: bash calc_folderSize.sh <folder> <file extension>"
 exit
fi

for Directory in `find $1/* -type d`; do

  sum=0
  name=`basename $Directory`

  for File in $Directory/*.$2; do
    size=`du -b $File | tr '\t' ' ' | cut -d" " -f1`
    sum=`echo "$size + $sum" | bc -l`
  done

  mv $Directory $1/$name-$sum

done
