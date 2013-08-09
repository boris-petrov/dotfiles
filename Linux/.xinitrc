xrdb -merge ~/.Xresources

autokey-gtk &
launchy &
thunderbird &
dropboxd &
hotot-qt &
liferea &
kbdd
loliclip &
urxvtd --quiet --opendisplay --fork

xset r rate 300 20

~/bin/fix_screens

exec awesome
