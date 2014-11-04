source $HOME/.zprofile

xrdb -merge $HOME/.Xresources

kbdd
start-pulseaudio-x11
syndaemon -t -k -i 1 -d
nm-applet &
autokey-gtk &
thunderbird &
dropboxd &
hotot-qt &
liferea &
xcmenu &
$HOME/code/vrome/system/ruby/bin/vrome &

$HOME/bin/fix_screens

exec awesome
