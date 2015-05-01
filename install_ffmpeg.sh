#!/bin/bash
sudo apt-get update
sudo apt-get install yasm
git clone git://source.ffmpeg.org/ffmpeg.git ~/.ffmpeg
cd ~/.ffmpeg
sudo chmod +x ./configure
./configure
make 
sudo make install
