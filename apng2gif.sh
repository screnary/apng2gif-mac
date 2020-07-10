#!/bin/sh
Source_Folder="/data_apng"
Target_Folder="/data_gif"
Folder_A=$(cd "$(dirname '$0')";pwd)$Source_Folder
Folder_B=$(cd "$(dirname '$0')";pwd)$Target_Folder
if [ ! -d "$Folder_B" ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
  mkdir $Folder_B
fi
suffix=".gif"
for file_a in ${Folder_A}/*
do
    in_fn=$(basename $file_a)
    echo "Processing "$in_fn
    out_fn=$(echo $in_fn | cut -d . -f1)
    out_file=${Folder_B}/$out_fn$suffix
    ffmpeg -loglevel quiet -i $file_a -filter_complex "pad=iw*2:ih:iw:ih:white,crop=iw/2:ih:0:0[back];[back][0]overlay=0:0" $out_file
done
