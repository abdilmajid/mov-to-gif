#!/bin/bash

# This script converts mov files to gif format
# Make sure to have ffmpg already nstalled
# https://ffmpeg.org/download.html#repositories

# Check that ffmpg installed
CHECK_FFMPG=$(which ffmpeg)
CHECK_FFMPG=$(echo $?)

if [ $CHECK_FFMPG -eq 0 ]; then
 for i in *.mov; do 
  ffmpeg -i ${i} -filter_complex "[0:v] palettegen" p_${i}.png
  ffmpeg -i ${i} -i p_${i}.png -filter_complex "[0:v][1:v] paletteuse" ${i}.gif
  ffmpeg -i ${i} -i p_${i}.png -filter_complex "[0:v] fps=10,scale=1280:-1 [new];[new][1:v] paletteuse" ${i}.gif -y
  mv ${i}.gif $(ls ${i}.gif | cut -f1,3 -d'.')
  rm p_${i}.png
 done;
else
 echo "Need to install FFMEG package, or Something went wrong"
fi


