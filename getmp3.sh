#!/bin/bash
# -i input then -o output
usage()
{
	cat << EOF
	
	usage: $0 options

	This script will extract the mp3 from an flv

	OPTIONS
	-h show this message
	-i input file path
	-o output file path
	made by Ammar Khaku

EOF
}

INPUTFILE=
OUTPUTFILE=
CUT_FROM=

while getopts "h:i:o:c:" OPTION
do
	case $OPTION in
		h)
			usage
			exit 1
			;;
		i)
			INPUTFILE=$OPTARG
			;;
		o)
			OUTPUTFILE=$OPTARG
			;;
        c)
            CUT_FROM=$OPTARG
            ;;
		?)
			usage
			exit
			;;
	esac
done
if [ -z "$INPUTFILE" ] || [ -z "$OUTPUTFILE" ]; then
	usage
	exit 1
else
    if [ -z "$CUT_FROM" ]; then
	    ffmpeg -i "$INPUTFILE" -ab 128000 -ar 44100 -f mp3 "$OUTPUTFILE"
    else
	    ffmpeg -i "$INPUTFILE" -ss "$CUT_FROM" -ab 128000 -ar 44100 -f mp3 "$OUTPUTFILE"
    fi
	echo "Succuessfully created file"
	echo ""
fi
