#!/bin/bash

startcrf=$1
codec=$2
declare -a gpofpics=(1 10 24)
framerate=30
crflimit=2
settingspath=Settings/settingsMaxCurvature.ini
currdir=experiments/images
folder=$codec"_crf:"$crf"_gpofpics="$gpofpics

function match() {
	for dir in $currdir/output/*/;
	do
		echo matlab -nosplash -nodisplay -nodesktop -r automateMatcher"(""'"$currdir/original"'","'"$currdir"/"$dir"'","'"$settingspath"'"")"";"exit";"
	done
}

while [ $startcrf -lt $crflimit ]
do
	for i in "${gpofpics[@]}";do
		folder=$codec"_crf:"$startcrf"_gpofpic:"$i
		if [ ! -d "$currdir/output" ]; then
			echo `mkdir "$currdir/output"`
		fi
		if [ ! -d "$currdir/output/$folder" ]; then
			echo `mkdir "$currdir/output/$folder"`
		fi
		echo `ffmpeg -y -r $framerate -f image2 -pattern_type glob -i $currdir'/original/*.png' -vcodec $codec -crf $startcrf  -pix_fmt yuv420p -g $i $currdir/output/$folder/video.mp4`
		echo `ffmpeg -y -r $framerate -i $currdir/output/$folder/video.mp4 $currdir/output/$folder/%04d.png`
		echo `rm $currdir/output/$folder/video.mp4`
	done
	startcrf=$(( $startcrf + 1 ))
done
match