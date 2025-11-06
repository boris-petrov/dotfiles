source $HOME/.zprofile

xrdb -merge $HOME/.Xresources

kbdd
xbindkeys
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
ulauncher &
redshift-gtk &
xscreensaver -no-splash &

$HOME/bin/fix_screens

source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

exec awesome
