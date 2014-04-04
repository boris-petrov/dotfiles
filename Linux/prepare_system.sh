#!/bin/bash

cd

# install packer
wget https://aur.archlinux.org/packages/pa/packer/packer.tar.gz
tar -xzf packer.tar.gz
pushd packer
makepkg -s
pacman -U packer-*
popd
rm -rf packer packer.tar.gz

# for infinality packages
sudo pacman-key -r 962DDE58
sudo pacman-key --lsign-key 962DDE58

# refresh repositories
sudo pacman -Syy

# install packages
packer -S archlinux-keyring
packer -S xf86-video-intel xf86-input-synaptics
packer -S zathura feh libreoffice smplayer kbgoffice deadbeef
packer -S cups gutenprint system-config-printer
packer -S networkmanager network-manager-applet
packer -S anything-sync-daemon profile-sync-daemon chromium-pepper-flash firefox
packer -S pidgin skype skype4pidgin-svn-dbus kbdd-latest-git pidgin-otr purple-whatsapp
packer -S dropbox liferea xcmenu-git thunderbird hotot-qt4 htop autokey-gtk xdg-utils lxappearance
packer -S xorg-server xorg-xinit slim awesome dmenu xlockmore arandr
packer -S aspell hunspell
packer -S gvim colordiff colorgcc git ctags the_silver_searcher
packer -S zsh rxvt-unicode-pixbuf urxvt-clipboard tmux
packer -S jre ntp openssh sudo wget ntfs-3g xsel oxygen-icons
packer -S zip unrar unzip
packer -S deluge flareget
packer -S freerdp realvnc-viewer
packer -S python2-pip python2-howdoi
packer -S infinality-bundle infinality-bundle-multilib ibfonts-meta-base otf-inconsolatazi4-ibx
packer -S nodejs

# install howdoi dependencies
sudo pip2 install requests-cache
sudo pip2 install pygments

# install npm
wget https://www.npmjs.org/install.sh
sudo sh install.sh
rm install.sh
sudo npm install -g coffee-script

# clone my dotfiles, install them and install screenful
git clone git@github.com:boris-petrov/dotfiles.git
pushd dotfiles
./init.sh
pushd Linux/.config/awesome
./install-screenful.sh
popd
popd

# enable Vim persistent undo
mkdir .vim/undodir

# install ruby's bundler
sudo gem install bundler

# install vrome
mkdir -p code/vrome
pushd code/vrome
git clone git@github.com:jinzhu/vrome.git
sudo bundle
rake build
popd

# add less keybindings
lesskey

# enable services
sudo systemctl enable slim
sudo systemctl enable sshd
sudo systemctl enable ntpd
sudo systemctl enable NetworkManager

# should install aspell and hunspell dictionaries from Dropbox directory
# should run lxappearance so a ~/.gtkrc-2.0 is created
# should execute 'cp ~/Dropbox/Private/wallpaper.jpg ~/.config/awesome/themes/'
