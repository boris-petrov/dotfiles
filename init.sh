#!/bin/sh

if [ `uname -s` = "Linux" ]; then
	shopt -s dotglob

	SCRIPT=$(readlink -f $0)
	SCRIPTPATH=$(dirname $SCRIPT)

	for file in $SCRIPTPATH/*
	do
		if [ $file != "$SCRIPTPATH/init.sh" ]
		then
			ln -s $file ~/$(basename $file)
		fi
	done

elif [ `uname -o` = "Cygwin" ]; then

	shopt -s dotglob

	SCRIPT=$(readlink -f $0)
	SCRIPTPATH=$(dirname $SCRIPT)

	for file in $SCRIPTPATH/*
	do
		if [ $file == "$SCRIPTPATH/.pentadactylrc" ]; then
			cmd /c del %USERPROFILE%\\_pentadactylrc
			cmd /c mklink %USERPROFILE%\\_pentadactylrc $(cygpath -w $SCRIPTPATH/.pentadactylrc)
		elif [ $file == "$SCRIPTPATH/pentadactyl" ]; then
			cmd /c rmdir %USERPROFILE%\\pentadactyl
			cmd /c mklink /d %USERPROFILE%\\pentadactyl $(cygpath -w $SCRIPTPATH/pentadactyl)
		elif [ $file == "$SCRIPTPATH/.vim" ]; then
			cmd /c rmdir %USERPROFILE%\\.vim
			cmd /c mklink /d %USERPROFILE%\\.vim $(cygpath -w $SCRIPTPATH/.vim)
		elif [ $file == "$SCRIPTPATH/.vimrc" ]; then
			cmd /c del "C:\Program Files (x86)\Vim\_vimrc"
			cmd /c mklink "C:\Program Files (x86)\Vim\_vimrc" $(cygpath -w $SCRIPTPATH/.vimrc)
		elif [ $file != "$SCRIPTPATH/init.sh" -a $file != "$SCRIPTPATH/README" -a $file != "$SCRIPTPATH/.git" ]; then
			ln -sf $file ~/$(basename $file)
		fi
	done

fi

