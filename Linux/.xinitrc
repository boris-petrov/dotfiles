source $HOME/.profile

xrdb -merge ~/.Xresources

nm-applet &
autokey-gtk &
thunderbird &
dropboxd &
hotot-qt &
liferea &
xcmenu &
~/code/vrome/system/ruby/bin/vrome &

~/bin/fix_screens

exec awesome
