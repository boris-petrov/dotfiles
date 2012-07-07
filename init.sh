#!/bin/sh

shopt -s dotglob

SCRIPT=$(readlink -f $0)
SCRIPTPATH=$(dirname $SCRIPT)

if [ `uname -s` = "Linux" ]; then
	for file in $SCRIPTPATH/*
	do
		if [ $file != "$SCRIPTPATH/init.sh" -a $file != "$SCRIPTPATH/README" -a $file != "$SCRIPTPATH/.git" -a $file != "$SCRIPTPATH/.minttyrc" -a $file != "$SCRIPTPATH/AutoHotkey.ahk" -a $file != "$SCRIPTPATH/prio.ini" -a $file != "$SCRIPTPATH/_vsvimrc" -a $file != "$SCRIPTPATH/DonationCoder" -a $file != "$SCRIPTPATH/CurrentSettings.vssettings" ]
		then
			ln -sf $file ~/$(basename $file)
		fi
	done

elif [ `uname -o` = "Cygwin" ]; then

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
			cmd /c mklink /d $(cygpath -w ~)\\.vim $(cygpath -w $SCRIPTPATH/.vim)
		elif [ $file == "$SCRIPTPATH/.vimrc" ]; then
			cmd /c del "C:\Program Files (x86)\Vim\_vimrc"
			cmd /c mklink "C:\Program Files (x86)\Vim\_vimrc" $(cygpath -w $SCRIPTPATH/.vimrc)
		elif [ $file == "$SCRIPTPATH/AutoHotkey.ahk" ]; then
			cmd /c del %USERPROFILE%\\Documents\\AutoHotkey.ahk
			cmd /c mklink %USERPROFILE%\\Documents\\AutoHotkey.ahk $(cygpath -w $SCRIPTPATH/AutoHotkey.ahk)
		elif [ $file == "$SCRIPTPATH/prio.ini" ]; then
			cmd /c del %USERPROFILE%\\AppData\\Roaming\\prio.ini
			cmd /c mklink %USERPROFILE%\\AppData\\Roaming\\prio.ini $(cygpath -w $SCRIPTPATH/prio.ini)
		elif [ $file == "$SCRIPTPATH/_vsvimrc" ]; then
			cmd /c del %USERPROFILE%\\_vsvimrc
			cmd /c mklink %USERPROFILE%\\_vsvimrc $(cygpath -w $SCRIPTPATH/_vsvimrc)
		elif [ $file == "$SCRIPTPATH/FindAndRunRobot.ini" ]; then
			cmd /c del %USERPROFILE%\\Documents\\DonationCoder\\FindAndRunRobot\\FindAndRunRobot.ini
			cmd /c mklink %USERPROFILE%\\Documents\\DonationCoder\\FindAndRunRobot\\FindAndRunRobot.ini $(cygpath -w $SCRIPTPATH/FindAndRunRobot.ini)
		elif [ $file == "$SCRIPTPATH/myaliases.alias" ]; then
			cmd /c del %USERPROFILE%\\Documents\\DonationCoder\\FindAndRunRobot\\AliasGroups\\MyCustom\\myaliases.alias
			cmd /c mklink %USERPROFILE%\\Documents\\DonationCoder\\FindAndRunRobot\\AliasGroups\\MyCustom\\myaliases.alias $(cygpath -w $SCRIPTPATH/myaliases.alias)
		elif [ $file == "$SCRIPTPATH/CurrentSettings.vssettings" ]; then
			cmd /c del "%USERPROFILE%\\Documents\\Visual Studio 2010\\Settings\\CurrentSettings.vssettings"
			cmd /c mklink "%USERPROFILE%\\Documents\\Visual Studio 2010\\Settings\\CurrentSettings.vssettings" $(cygpath -w $SCRIPTPATH/CurrentSettings.vssettings)
		elif [ $file != "$SCRIPTPATH/init.sh" -a $file != "$SCRIPTPATH/README" -a $file != "$SCRIPTPATH/.git" ]; then
			ln -sf $file ~/$(basename $file)
		fi
	done

fi

