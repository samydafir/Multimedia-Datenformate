compress() {

 opj_compress -r $1 -ImgDir $inputDir -OutFor jp2

 mkdir $outputParDir/jp2
 mv $inputDir/*.jp2 $outputParDir/jp2/
 size=`du -b $outputParDir/jp2 | tr '\t' ' ' | cut -d " " -f1`
 mv $outputParDir/jp2 $outputParDir/jp2-$size
}

# main
# TODO: Kompression fuer sinnvolle, unterschiedliche compression ratios, nicht nur 1

# input directory
inputDir='original'
# output parent directory
outputParDir='output'

ratio=4

compress $ratio
