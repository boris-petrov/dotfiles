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
packer -S archlinux-keyring \
          xf86-video-intel xf86-input-synaptics acpi acpid laptop-mode-tools \
          alsa-utils alsa-plugins libsamplerate smplayer deadbeef \
          zathura feh libreoffice kbgoffice \
          cups gutenprint system-config-printer \
          networkmanager network-manager-applet \
          anything-sync-daemon profile-sync-daemon chromium-pepper-flash firefox \
          pidgin skype skype4pidgin-svn-dbus kbdd-latest-git pidgin-otr purple-whatsapp \
          dropbox liferea xcmenu-git thunderbird hotot-qt4 htop autokey-gtk xdg-utils lxappearance \
          xorg-server xorg-xinit slim awesome dmenu xlockmore arandr \
          aspell hunspell \
          gvim colordiff colorgcc git ctags the_silver_searcher \
          zsh rxvt-unicode-pixbuf urxvt-clipboard tmux \
          jre ntp openssh sudo wget ntfs-3g xsel oxygen-icons \
          zip unrar unzip \
          deluge flareget \
          freerdp realvnc-viewer \
          python2-pip python2-howdoi \
          infinality-bundle infinality-bundle-multilib ibfonts-meta-base otf-inconsolatazi4-ibx \
          nodejs

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
sudo systemctl enable cups

# TODO: if on laptop:
sudo systemctl enable NetworkManager
sudo systemctl enable acpid
sudo systemctl enable laptop-mode

# should install aspell and hunspell dictionaries from Dropbox directory
# should run lxappearance so a ~/.gtkrc-2.0 is created
# should execute 'cp ~/Dropbox/Private/wallpaper.jpg ~/.config/awesome/themes/'
# should copy Pidgin stuff from Dropbox folder to ~/.purple
# should install Thunderbird add-ons from ~/dotfiles/common/ThunderbirdAddons.txt
# should install Chrome's Stylish styles from ~/dotfiles/common/stylish/*
# should use Chrome's Page Monitor sites from ~/dotfiles/common/Chrome/Page Monitor.html
# should remove the 3 "group i = AltGr" lines in /usr/share/X11/xkb/compat/basic
