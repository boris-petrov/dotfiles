xrdb -merge ~/.Xresources

autokey-gtk &
launchy &
thunderbird &

setxkbmap -layout us,bg -variant ,phonetic -option grp:ctrl_shift_toggle

xbindkeys

dropboxd &

qwit &

~/bin/fix_screens

exec dbus-launch awesome
