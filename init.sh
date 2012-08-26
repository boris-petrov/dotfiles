#!/bin/sh

shopt -s dotglob

SCRIPT=$(readlink -f $0)
SCRIPTPATH=$(dirname $SCRIPT)

if [ `uname -s` = 'Linux' ]; then
	for file in `find $SCRIPTPATH/common/* -maxdepth 0` `find $SCRIPTPATH/Linux/* -maxdepth 0`
	do
		BASENAME=$(basename $file)
		ln -sfn $file ~/$BASENAME
	done

elif [ `uname -o` = 'Cygwin' ]; then

	for file in $SCRIPTPATH/common/* $SCRIPTPATH/Windows/*
	do
		if [ $file == "$SCRIPTPATH/common/.pentadactylrc" ]; then
			cmd /c del %USERPROFILE%\\_pentadactylrc
			cmd /c mklink %USERPROFILE%\\_pentadactylrc $(cygpath -w $SCRIPTPATH/common/.pentadactylrc)
		elif [ $file == "$SCRIPTPATH/common/.pentadactyl" ]; then
			cmd /c rmdir %USERPROFILE%\\pentadactyl
			cmd /c mklink /d %USERPROFILE%\\pentadactyl $(cygpath -w $SCRIPTPATH/common/.pentadactyl)
		elif [ $file == "$SCRIPTPATH/common/.vim" ]; then
			cmd /c rmdir %USERPROFILE%\\.vim
			cmd /c mklink /d %USERPROFILE%\\.vim $(cygpath -w $SCRIPTPATH/common/.vim)
			cmd /c mklink /d $(cygpath -w ~)\\.vim $(cygpath -w $SCRIPTPATH/common/.vim)
		elif [ $file == "$SCRIPTPATH/common/.vimrc" ]; then
			cmd /c del "C:\Program Files (x86)\Vim\_vimrc"
			cmd /c mklink "C:\Program Files (x86)\Vim\_vimrc" $(cygpath -w $SCRIPTPATH/common/.vimrc)
		elif [ $file == "$SCRIPTPATH/Windows/AutoHotkey.ahk" ]; then
			cmd /c del %USERPROFILE%\\Documents\\AutoHotkey.ahk
			cmd /c mklink %USERPROFILE%\\Documents\\AutoHotkey.ahk $(cygpath -w $SCRIPTPATH/Windows/AutoHotkey.ahk)
		elif [ $file == "$SCRIPTPATH/Windows/prio.ini" ]; then
			cmd /c del %USERPROFILE%\\AppData\\Roaming\\prio.ini
			cmd /c mklink %USERPROFILE%\\AppData\\Roaming\\prio.ini $(cygpath -w $SCRIPTPATH/Windows/prio.ini)
		elif [ $file == "$SCRIPTPATH/Windows/_vsvimrc" ]; then
			cmd /c del %USERPROFILE%\\_vsvimrc
			cmd /c mklink %USERPROFILE%\\_vsvimrc $(cygpath -w $SCRIPTPATH/Windows/_vsvimrc)
		elif [ $file == "$SCRIPTPATH/Windows/FindAndRunRobot.ini" ]; then
			cmd /c del %USERPROFILE%\\Documents\\DonationCoder\\FindAndRunRobot\\FindAndRunRobot.ini
			cmd /c mklink %USERPROFILE%\\Documents\\DonationCoder\\FindAndRunRobot\\FindAndRunRobot.ini $(cygpath -w $SCRIPTPATH/Windows/FindAndRunRobot.ini)
		elif [ $file == "$SCRIPTPATH/Windows/myaliases.alias" ]; then
			cmd /c del %USERPROFILE%\\Documents\\DonationCoder\\FindAndRunRobot\\AliasGroups\\MyCustom\\myaliases.alias
			cmd /c mklink %USERPROFILE%\\Documents\\DonationCoder\\FindAndRunRobot\\AliasGroups\\MyCustom\\myaliases.alias $(cygpath -w $SCRIPTPATH/Windows/myaliases.alias)
		elif [ $file == "$SCRIPTPATH/Windows/CurrentSettings.vssettings" ]; then
			cmd /c del "%USERPROFILE%\\Documents\\Visual Studio 2010\\Settings\\CurrentSettings.vssettings"
			cmd /c mklink "%USERPROFILE%\\Documents\\Visual Studio 2010\\Settings\\CurrentSettings.vssettings" $(cygpath -w $SCRIPTPATH/Windows/CurrentSettings.vssettings)
		elif [ $file != "$SCRIPTPATH/init.sh" -a $file != "$SCRIPTPATH/README" -a $file != "$SCRIPTPATH/.git" ]; then
			ln -sf $file ~/$(basename $file)
		fi
	done

fi

