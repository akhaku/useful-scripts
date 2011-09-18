#!/bin/bash
base_path="/home/ammar/.cache/google-chrome/Default/Cache"
music_path="/media/New Volume/Music"
printf "Welcome to the flv extractor, written by Ammar Khaku <ammar.khaku@gmail.com>\n\n"

show_options(){
    indexes=${!files[*]}
    head=0
    for elem in $indexes; do
        echo "[ $elem ] ${files[$elem]}"
    done
    printf "What would you like to do?\n"
    read choice
    execute $choice
}

initialize(){
    old=`pwd`
    cd $base_path
    temp_files=$(file * | grep Flash\ Video | cut -d':' -f1)
    head=0
    for elem in $temp_files; do
        files[$head]="$elem"
        head=$((head+1))
    done
    show_options
}

execute(){
    input="$1"
    if [ $input = 'q' ]; then
        printf "Goodbye.\n"
        exit 0
    fi
    action=${input:0:1}
    which=${input:1}
    if [ $action = 'p' ]; then
        mplayer "$base_path/${files[$which]}"
    elif [ $action = 'c' ]; then
        printf "Please enter the filename:\n"
        read filename
        printf "Cut how many seconds from the top?\n"
        read seconds
        if [ -e "$music_path/$filename.mp3" ]; then
            printf "File already exists\n"
        else
            getmp3.sh -i "$base_path/${files[$which]}" -o "$music_path/$filename.mp3" -c "$seconds"
            if [ -e "$music_path/$filename.mp3" ]; then
                printf "File successfully created\n"
                unset files[$which]
            fi
        fi
    elif [ $action = 'r' ]; then
        rm "$base_path/${files[$which]}"
        unset files[$which]
    else
        usage
    fi
    show_options
}

usage(){
printf """\nUsage: When prompted, enter the code of the file you would like to try. p to play, c to
convert, r to remove and q to quit.
Eg: p2, q, r1, c3
"""
}
usage
initialize
