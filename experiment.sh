#!/bin/bash

startcrf=$1
codec=$2
declare -a gpofpics=(1)
declare -a fileNames=()
framerate=30
crflimit=2
settingspath=Settings/settingsMaxCurvature.ini
currdir=experiments/images
folder=$codec"-"$crf"-"$gpofpics
tempLine=""
count=0
currSize=0

#ignore
#function match() {
#	for dir in $currdir/output/*/;
#	do
#		echo `matlab -nosplash -nodisplay -nodesktop -r automateMatcher"(""'"$currdir/original"'","'"$currdir"/"$dir"'","'"$settingspath"'"")"";"exit";"`
#	done
#}

function renameFiles() {
	count=0
	for file in $currdir/output/$1/*.png; do
		templine=$(echo $file| cut -d'/' -f 4)
		echo `mv $file $(dirname "${file}")/${fileNames[$count]}`
		count=$(( $count + 1 ))
	done

}

function getFileNames() {
	for file in $currdir/original/*.png; do
		tempLine=$(echo $file| cut -d'/' -f 4)
		fileNames+=($tempLine)
	done
}

getFileNames
while [ $startcrf -lt $crflimit ]
do
	for i in "${gpofpics[@]}";do
		folder=$codec"-"$startcrf"-"$i
		if [ ! -d "$currdir/output" ]; then
			echo `mkdir "$currdir/output"`
		fi
		if [ -d "$currdir/output/$folder" ]; then
			echo `rm -R "$currdir/output/$folder"`
		fi
		echo `mkdir "$currdir/output/$folder"`
		echo `ffmpeg -y -r $framerate -f image2 -pattern_type glob -i $currdir'/original/*.png' -vcodec $codec -crf $startcrf  -pix_fmt yuv420p -g $i $currdir/output/$folder/video.mp4`
		echo `ffmpeg -y -r $framerate -i $currdir/output/$folder/video.mp4 $currdir/output/$folder/%04d.png`
		currSize=`du -k "$currdir/output/$folder/video.mp4" | cut -f1`
		echo `rm $currdir/output/$folder/video.mp4`
		renameFiles $folder
		echo `mv $currdir/output/$folder $currdir/output/$folder"-"$currSize`
	done
	startcrf=$(( $startcrf + 1 ))
done
