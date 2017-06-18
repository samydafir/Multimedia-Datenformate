#!/bin/bash

compress()
{
  current_rate=$1
  rm -rf output/jp2-$current_rate-$nr_layers
  mkdir output/jp2-$current_rate-$nr_layers

  for file in original/*.png; do
    name=`basename -s .png $file`
    convert $file -define jp2:rate=$current_rate -define jp2:number-resolutions=$nr_layers output/jp2-$current_rate-$nr_layers/${name}.jp2
  done
}

# main

argc=4

if [ $# -ne $argc ]; then
 echo "Usage: bash jp2_compression.sh <min rate> <max rate> <rate step> <layers>"
 exit
fi

rate=$1
max_rate=$2
step=$3
nr_layers=$4

nr_runs=$(( ($max_rate - $rate) / $step + 1))
current_run=1

while [ $rate -le $max_rate ]; do
  echo Processing $current_run"/"$nr_runs
  compress $rate
  current_run=$(( $current_run + 1))
  rate=$(( $rate + $step ))

done
