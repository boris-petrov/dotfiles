source $HOME/.zprofile

xrdb -merge $HOME/.Xresources

kbdd
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
