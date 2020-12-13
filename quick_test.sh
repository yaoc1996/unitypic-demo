#!/bin/bash

DATA_FILE=./raw/NEON-DS-Sample-LiDAR-Point-Cloud.las
POTREE_CONVERTER_ZIP=PotreeConverter_1.7_windows_x64.zip
CONVERTED_DATA=./converted
UNITYPIC_ZIP=UnityPIC.zip

if [ ! -f "$DATA_FILE" ]; then
    printf "\n\033[32mDownloading data...\033[39m\n\n"
    mkdir raw
    curl -L https://ndownloader.figshare.com/files/7024955 -o $DATA_FILE
fi

if [ ! -f "$POTREE_CONVERTER_ZIP" ]; then
    printf "\n\033[32mDownloading PotreeConverter...\033[39m\n\n"
    curl -L https://github.com/potree/PotreeConverter/releases/download/1.7/PotreeConverter_1.7_windows_x64.zip -o $POTREE_CONVERTER_ZIP
fi

unzip -q -o $POTREE_CONVERTER_ZIP

if [ -d $CONVERTED_DATA ]; then
    rm -r $CONVERTED_DATA
fi

printf "\n\033[32mConverting to Potree file format...\033[39m\n\n"
./PotreeConverter_1.7_windows_x64/PotreeConverter.exe $DATA_FILE -a INTENSITY -o $CONVERTED_DATA

mkdir UnityPIC
unzip -q -o $UNITYPIC_ZIP

rm $POTREE_CONVERTER_ZIP
