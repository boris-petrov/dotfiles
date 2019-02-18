source $HOME/.zprofile

xrdb -merge $HOME/.Xresources

kbdd
start-pulseaudio-x11
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
fluxgui &
xscreensaver -no-splash &

$HOME/bin/fix_screens

exec awesome
