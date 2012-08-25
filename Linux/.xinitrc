xrdb -merge ~/.Xresources

autokey-gtk &
launchy &
thunderbird &

setxkbmap -layout us,bg -variant ,phonetic -option grp:ctrl_shift_toggle

xbindkeys

exec dbus-launch awesome
