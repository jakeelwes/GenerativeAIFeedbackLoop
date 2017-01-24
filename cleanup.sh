#/bin/bash
sudo rm currentImage/toCap.jpg
sudo rm -rf web-interface/genImages/*
sudo echo "" > web-interface/results.json
wget http://cf.ltkcdn.net/feng-shui/images/std/202931-576x450-yinyang.jpg -O currentImage/toCap.jpg
