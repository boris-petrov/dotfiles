xrdb -merge ~/.Xresources

autokey-gtk &
launchy &
thunderbird &

~/bin/fix_layout

dropboxd &

turpial &

~/bin/fix_screens

exec dbus-launch awesome
