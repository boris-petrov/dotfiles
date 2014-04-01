#!/bin/bash

wget https://aur.archlinux.org/packages/pa/packer/packer.tar.gz
tar -xzf packer.tar.gz
cd packer
makepkg -s
pacman -U packer-*

packer -S archlinux-keyring
packer -S xf86-video-intel xf86-input-synaptics
packer -S zathura feh libreoffice smplayer kbgoffice deadbeef
packer -S cups gutenprint system-config-printer
packer -S networkmanager network-manager-applet
packer -S anything-sync-daemon profile-sync-daemon chromium-pepper-flash firefox
packer -S pidgin skype skype4pidgin kbdd-latest-git pidgin-otr purple-whatsapp
packer -S dropbox liferea xcmenu-git thunderbird hotot htop autokey-gtk arandr xdg-utils
packer -S xorg-server xorg-xinit awesome dmenu xlockmore
packer -S aspell hunspell
packer -S gvim colordiff colorgcc git ctags the_silver_searcher
packer -S zsh rxvt-unicode-pixbuf urxvt-clipboard tmux
packer -S jre ntp openssh sudo wget ntfs-3g xsel unrar oxygen-icons
packer -S deluge flareget
packer -S freerdp realvnc-viewer
packer -S python2-pip python2-howdoi
packer -S infinality-bundle infinality-bundle-multilib ibfonts-meta-base otf-inconsolatazi4-ibx

sudo pip2 install requests-cache
sudo pip2 install pygments

# https://wiki.archlinux.org/index.php/Infinality-bundle%2Bfonts
