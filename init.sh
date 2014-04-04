#!/bin/bash

SCRIPT=$(readlink -f $0)
SCRIPTPATH=$(dirname $SCRIPT)

if [[ `uname -s` == 'Linux' || `uname -s` == 'Darwin' ]]; then
	for file in `find $SCRIPTPATH/common/ -maxdepth 1` `find $SCRIPTPATH/Linux/ -maxdepth 1`
	do
		if [[ "$file" != "$SCRIPTPATH/common/Chrome" &&
					"$file" != "$SCRIPTPATH/common/" &&
					"$file" != "$SCRIPTPATH/Linux/" &&
					"$file" != "$SCRIPTPATH/Linux/icons" &&
					"$file" != "$SCRIPTPATH/common/stylish" &&
					"$file" != "$SCRIPTPATH/common/zsh-syntax-highlighting" &&
					"$file" != "$SCRIPTPATH/common/ThunderbirdAddons.txt" &&
					"$file" != "$SCRIPTPATH/Linux/prepare_system.sh"
			]]; then
			if [[ "$file" == "$SCRIPTPATH/Linux/etc" ||
						"$file" == "$SCRIPTPATH/Linux/usr" ]]; then
				sudo cp -r "$file" /
			else
				BASENAME=$(basename "$file")
				if [[ -d "$file" && -d ~/$BASENAME ]]; then
					cp -rf ~/$BASENAME/* "$file"
					rm -rf ~/$BASENAME
				fi
				ln -sfn "$file" ~/$BASENAME
			fi
		fi
	done

elif [[ `uname -o` == 'Cygwin' ]]; then

	for file in $SCRIPTPATH/common/* $SCRIPTPATH/Windows/*
	do
		if [[ "$file" == "$SCRIPTPATH/common/.pentadactylrc" ]]; then
			cmd /c del %USERPROFILE%\\_pentadactylrc
			cmd /c mklink %USERPROFILE%\\_pentadactylrc $(cygpath -w $SCRIPTPATH/common/.pentadactylrc)
		elif [[ "$file" == "$SCRIPTPATH/common/.pentadactyl" ]]; then
			cmd /c rmdir %USERPROFILE%\\pentadactyl
			cmd /c mklink /d %USERPROFILE%\\pentadactyl $(cygpath -w $SCRIPTPATH/common/.pentadactyl)
		elif [[ "$file" == "$SCRIPTPATH/common/.vim" ]]; then
			cmd /c rmdir %USERPROFILE%\\.vim
			cmd /c mklink /d %USERPROFILE%\\.vim $(cygpath -w $SCRIPTPATH/common/.vim)
			cmd /c mklink /d $(cygpath -w ~)\\.vim $(cygpath -w $SCRIPTPATH/common/.vim)
		elif [[ "$file" == "$SCRIPTPATH/common/.vimrc" ]]; then
			cmd /c del "C:\Program Files (x86)\Vim\_vimrc"
			cmd /c mklink "C:\Program Files (x86)\Vim\_vimrc" $(cygpath -w $SCRIPTPATH/common/.vimrc)
		elif [[ "$file" == "$SCRIPTPATH/Windows/AutoHotkey.ahk" ]]; then
			cmd /c del %USERPROFILE%\\Documents\\AutoHotkey.ahk
			cmd /c mklink %USERPROFILE%\\Documents\\AutoHotkey.ahk $(cygpath -w $SCRIPTPATH/Windows/AutoHotkey.ahk)
		elif [[ "$file" == "$SCRIPTPATH/Windows/prio.ini" ]]; then
			cmd /c del %USERPROFILE%\\AppData\\Roaming\\prio.ini
			cmd /c mklink %USERPROFILE%\\AppData\\Roaming\\prio.ini $(cygpath -w $SCRIPTPATH/Windows/prio.ini)
		elif [[ "$file" == "$SCRIPTPATH/Windows/_vsvimrc" ]]; then
			cmd /c del %USERPROFILE%\\_vsvimrc
			cmd /c mklink %USERPROFILE%\\_vsvimrc $(cygpath -w $SCRIPTPATH/Windows/_vsvimrc)
		elif [[ "$file" == "$SCRIPTPATH/Windows/FindAndRunRobot.ini" ]]; then
			cmd /c del %USERPROFILE%\\Documents\\DonationCoder\\FindAndRunRobot\\FindAndRunRobot.ini
			cmd /c mklink %USERPROFILE%\\Documents\\DonationCoder\\FindAndRunRobot\\FindAndRunRobot.ini $(cygpath -w $SCRIPTPATH/Windows/FindAndRunRobot.ini)
		elif [[ "$file" == "$SCRIPTPATH/Windows/myaliases.alias" ]]; then
			cmd /c del %USERPROFILE%\\Documents\\DonationCoder\\FindAndRunRobot\\AliasGroups\\MyCustom\\myaliases.alias
			cmd /c mklink %USERPROFILE%\\Documents\\DonationCoder\\FindAndRunRobot\\AliasGroups\\MyCustom\\myaliases.alias $(cygpath -w $SCRIPTPATH/Windows/myaliases.alias)
		elif [[ "$file" == "$SCRIPTPATH/Windows/CurrentSettings.vssettings" ]]; then
			cmd /c del "%USERPROFILE%\\Documents\\Visual Studio 2010\\Settings\\CurrentSettings.vssettings"
			cmd /c mklink "%USERPROFILE%\\Documents\\Visual Studio 2010\\Settings\\CurrentSettings.vssettings" $(cygpath -w $SCRIPTPATH/Windows/CurrentSettings.vssettings)
		elif [[ "$file" != "$SCRIPTPATH/init.sh" && "$file" != "$SCRIPTPATH/README" && "$file" != "$SCRIPTPATH/.git" ]]; then
			ln -sf "$file" ~/$(basename "$file")
		fi
	done

fi

git submodule update --init --recursive
