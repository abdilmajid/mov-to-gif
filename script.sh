#!/bin/bash

# This script converts mov files to gif format
# Make sure to have ffmpg already nstalled
# https://ffmpeg.org/download.html#repositories

# Optional: install gifscle to further compress gif size
# https://www.lcdf.org/gifsicle/

# Check that ffmpg installed
CHK_FFMPG=$(which ffmpeg)
CHK_FFMPG=$(echo $?)

# Check if gifsicle installed
CHK_GFS=$(which gifsicle)
CHK_GFS=$(echo $?)

if [ $CHK_FFMPG -eq 0 ] && [ $CHK_GFS -eq 0 ]; then
 for i in *.mov; do 
  ffmpeg -i ${i} -filter_complex "[0:v] palettegen" p_${i}.png
  ffmpeg -i ${i} -i p_${i}.png -filter_complex "[0:v][1:v] paletteuse" ${i}.gif
  ffmpeg -i ${i} -i p_${i}.png -filter_complex "[0:v] fps=10:-1 [new];[new][1:v] paletteuse" ${i}.gif -y
  gifsicle -O3 --lossy=100 ${i}.gif -o gscl_${i}.gif
  mv gscl_${i}.gif $(ls gscl_${i}.gif | cut -f1,3 -d'.')
  rm p_${i}.png ${i}.gif
 done;
elif [ $CHK_FFMPG -eq 0 ]; then
 for i in *.mov; do
  ffmpeg -i ${i} -filter_complex "[0:v] palettegen" p_${i}.png
  ffmpeg -i ${i} -i p_${i}.png -filter_complex "[0:v][1:v] paletteuse" ${i}.gif
  ffmpeg -i ${i} -i p_${i}.png -filter_complex "[0:v] fps=10:-1 [new];[new][1:v] paletteuse" ${i}.gif -y
  mv ${i}.gif $(ls ${i}.gif | cut -f1,3 -d'.')
  rm p_${i}.png
 done;
else
 echo "Need to install FFMEG package, or Something went wrong"
fi


