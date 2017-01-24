#!/bin/bash
#
# Jake Elwes <me@jakeelwes.com>
# 2017

if [ "$#" -ne "1" ]; then
  echo "Provide a number of images & captions to generate"
  exit 1
fi

    number=0
    until [ $number -ge ${1} ]; do
      echo "Number = $number - `expr ${1} - $number` still to go"

     rm -f densecap/vis/data/*
     #rm -f densecap/vis/data/*

     cd densecap
      th densecap/run_model.lua -input_image ../currentImage/toCap.jpg -gpu -1 #(cant get gpu working yet, requires torch with cudnn4?)
      cd ..
      rm -f currentImage/toCap.jpg

      python extract-first-densecap.py
      value=`cat currentImage/caption.txt`
      echo "$value"

      sh generate-from-captions.sh $value

      number=$((number + 1))

    done
