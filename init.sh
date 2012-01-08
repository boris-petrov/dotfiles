#!/bin/sh

shopt -s dotglob

SCRIPT=$(readlink -f $0)
SCRIPTPATH=$(dirname $SCRIPT)

for file in $SCRIPTPATH/*
do
	if [ $file != "$SCRIPTPATH/startup.sh" ]
	then
		ln -s $file ~/$(basename $file)
	fi
done

