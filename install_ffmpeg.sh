#!/bin/bash
sudo apt-get update
sudo apt-get install yasm
if [ -d ~/.ffmpeg ]
then
  cd ~/.ffmpeg
  git pull
else
  git clone git://source.ffmpeg.org/ffmpeg.git ~/.ffmpeg
  cd ~/.ffmpeg
fi
sudo chmod +x ./configure
./configure
make 
sudo make install
