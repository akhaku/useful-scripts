#!/bin/bash
IFS='
'
old=`pwd`
cd '/media/New Volume/Music/'
all_music=$(ls -1)
for elem in $all_music; do
    printf "\n$elem\n"
    read option
    if [ $option = 'y' ]; then
        cp "$elem" "/media/New Volume/music_to_copy/$elem"
    elif [ $option = 'q' ]; then
        printf "Stopped on $elem\n"
        exit 0
    fi
done
cd $old
