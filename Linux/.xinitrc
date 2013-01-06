xrdb -merge ~/.Xresources

autokey-gtk &
launchy &
thunderbird &
dropboxd &
turpial &

~/bin/fix_screens

exec dbus-launch awesome
