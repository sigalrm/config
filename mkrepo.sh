#!/bin/sh

if [ -z $1 ]; then
	echo "Usage: $0 <reponame>."
	exit
fi

repodir="$1.git"

if [ -d $repodir ]; then
	echo "Directory $repodir already exists."
	exit
fi

mkdir $repodir
GIT_DIR=$repodir git init
touch $repodir/git-daemon-export-ok
read -e -p "Description: " description
echo -E $description > $repodir/description
chmod +x $repodir/hooks/post-update
