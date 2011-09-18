#!/bin/bash
usage(){
	cat << EOF
	Usage:
	$0 (eecs || reseauxs || nevershopalone)
EOF
}

if [ "$1" == "eecs" ]; then
	ssh -X -i $HOME/.ssh/eecs akhaku01@linux.eecs.tufts.edu
elif [ "$1" == "reseauxs" ]; then
	ssh -i $HOME/.ssh/reseauxs reseauxs@reseauxs.net
elif [ "$1" == "nevershopalone" ]; then
    ssh -i $HOME/.ssh/wubkey.pem ec2-user@www.nevershopalone.com
else
	usage
	exit
fi
