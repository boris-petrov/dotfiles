source $HOME/.zprofile

xrdb -merge $HOME/.Xresources

kbdd
start-pulseaudio-x11
syndaemon -t -k -i 1 -d
udiskie --smart-tray &
nm-applet &
autokey-gtk &
thunderbird &
dropbox &
hotot-qt &
liferea &
xcmenu &
rsibreak &
cerebro &
$HOME/code/vrome/system/ruby/bin/vrome &

$HOME/bin/fix_screens

exec awesome
