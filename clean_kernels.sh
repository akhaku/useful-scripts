#!/bin/bash
execute(){
    input="$1"
    headim=${input:0:1}
    which=${input:1}
    if [ $headim = 'K' ]; then
        apt-get purge ${headers[$which]}
    fi
    # todo put in check for current kernel
    show_options
}

show_options(){
    headers=()
    temp_headers=$(dpkg --list | grep linux-image | cut -d' ' -f3)
    current=`uname -r`
    head=0
    for elem in $temp_headers; do
        echo "[ K$head ] $elem"
        headers[$head]="$elem"
        head=$((head+1))
    done
    printf "\nYour current kernel version is $current\nWhat would you like to remove? q to quit.\n"
    read remove
    if [ $remove = "q" ]; then
        printf "Goodbye.\n"
        exit 1
    fi
    execute $remove
}

printf """Welcome to the Ubuntu kernel removal program.
Written by Ammar Khaku <ammar.khaku@gmail.com> when he got tired of removing old kernels by hand.
Use at your own risk

Usage: When prompted, enter the code of the kernel you would like to remove
"""
head=0
show_options
