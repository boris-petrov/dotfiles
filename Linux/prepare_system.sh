#!/bin/bash

cd

sudo pacman -S wget git

# install packer
wget https://aur.archlinux.org/packages/pa/packer/packer.tar.gz
tar -xzf packer.tar.gz
pushd packer
makepkg -s
sudo pacman -U packer-*
popd
rm -rf packer packer.tar.gz

# clone my dotfiles, install them and install screenful
git clone git@github.com:boris-petrov/dotfiles.git
pushd dotfiles
./init.sh
pushd Linux/.config/awesome
./install-screenful.sh
popd
popd

# for infinality packages
sudo pacman-key -r 962DDE58
sudo pacman-key --lsign-key 962DDE58

# refresh repositories
sudo pacman -Syy

# install packages
packer -S archlinux-keyring \
          xf86-video-intel xf86-input-synaptics acpi acpid laptop-mode-tools \
          pulseaudio pulseaudio-alsa lib32-libpulse pavucontrol \
          alsa-utils alsa-plugins lib32-alsa-plugins libsamplerate \
          smplayer deadbeef \
          zathura zathura-djvu zathura-pdf-poppler zathura-ps \
          libreoffice-common libreoffice-en-US libreoffice-impress libreoffice-writer \
          kbgoffice \
          cups gutenprint system-config-printer \
          networkmanager network-manager-applet \
          anything-sync-daemon profile-sync-daemon profile-cleaner chromium-pepper-flash firefox flashplugin \
          pidgin skype-secure skype4pidgin-svn-dbus kbdd-latest-git pidgin-otr purple-whatsapp \
          dropbox liferea xcmenu-git thunderbird hotot-qt4-git htop autokey-gtk xdg-utils lxappearance feh \
          xorg-server xorg-xinit slim awesome dmenu xorg-xprop xlockmore arandr \
          aspell hunspell \
          gvim colordiff ctags the_silver_searcher \
          zsh rxvt-unicode-pixbuf urxvt-clipboard urxvt-font-size-git tmux \
          jdk ntp openssh sudo ntfs-3g xsel oxygen-icons \
          zip unrar unzip \
          deluge flareget \
          freerdp realvnc-viewer \
          infinality-bundle infinality-bundle-multilib ibfonts-meta-base ibfonts-meta-extended otf-inconsolatazi4-ibx otf-inconsolata-lgc \
          nodejs ruby python gdb

# install npm
wget https://www.npmjs.org/install.sh
sudo sh install.sh
rm install.sh
sudo npm install -g coffee-script

# enable Vim persistent undo
mkdir -p .vim/undodir

# install ruby's bundler
sudo gem install bundler

# install vrome
mkdir -p code/vrome
pushd code/vrome
git clone git@github.com:jinzhu/vrome.git
sudo bundle
bundle exec rake build
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

# execute "set spell" in Vim in order to download its dictionaries
# install aspell and hunspell dictionaries from Dropbox directory
# execute "cp ~/Dropbox/Private/wallpaper.jpg ~/.config/awesome/themes/"
# copy Pidgin stuff from Dropbox folder to ~/.purple
# install Thunderbird add-ons from ~/dotfiles/common/ThunderbirdAddons.txt
# install Chrome's Stylish styles from ~/dotfiles/common/stylish/*
# use Chrome's Page Monitor sites from ~/dotfiles/common/Chrome/Page Monitor.html
# remove the 3 "group i = AltGr" lines in /usr/share/X11/xkb/compat/basic
# set default soundcard in ~/.asoundrc
# set Chrome/Thunderbird fonts, encodings
# use "git@github.com:boris-petrov/Hotot.git" as _gitroot when installing hotot-qt4-git
# set Pidgin's Skype plugin to use "sskype" instead of "skype" as an executable

# Do this so Skype audio works:
# As the main user, copy /etc/pulse/default.pa to ~/.config/pulse/default.pa and add:
# load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1
# As the _skype user, create ~/.config/pulse/client.conf and add:
# default-server = 127.0.0.1
