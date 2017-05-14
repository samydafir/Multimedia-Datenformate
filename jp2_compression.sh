#!/bin/bash

compress() {

 opj_compress -r $1 -ImgDir $input_dir -OutFor jp2

 mkdir $output_par_dir/jp2
 mv $input_dir/*.jp2 $output_par_dir/jp2/
 size=`du -b $output_par_dir/jp2 | tr '\t' ' ' | cut -d " " -f1`
 ratio_string=`echo $ratio | tr '.' 'p'`
 mv $output_par_dir/jp2 $output_par_dir/jp2-$ratio_string-$size
}

# main
# TODO: Kompression fuer sinnvolle, unterschiedliche compression ratios, nicht nur 1

# input directory
input_dir='original'
# output parent directory
output_par_dir='output'
# min ratio
ratio_min=2
# max ratio
ratio_max=4
# ratio intervall
ratio_intervall='0.5'

ratio=$ratio_min

is_ratio_lt_ratioMax=1

while [ $is_ratio_lt_ratioMax -eq 1 ]; do
  compress $ratio
  ratio=`echo "$ratio + $ratio_intervall" | bc`
  is_ratio_lt_ratioMax=`echo "$ratio <= $ratio_max" | bc`
done
