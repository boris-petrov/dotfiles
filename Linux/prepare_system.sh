#!/bin/bash

trap 'exit' ERR

cd

sudo pacman -S wget git

# install apacman
wget https://aur.archlinux.org/packages/ap/apacman/apacman.tar.gz
tar -xzf apacman.tar.gz
pushd apacman
makepkg -s
sudo pacman -U apacman-*
popd
rm -rf apacman apacman.tar.gz

# clone my dotfiles, install them and install screenful
git clone git@github.com:boris-petrov/dotfiles.git
pushd dotfiles
./init.sh
pushd Linux/.config/awesome
./install-screenful.sh
popd
popd

# refresh repositories
sudo pacman -Syy

# install packages
apacman -S archlinux-keyring \
  intel-ucode \
  # ONE of the next two lines should be chosen
  xf86-video-intel mesa-libgl lib32-mesa-libgl mesa-vdpau lib32-mesa-vdpau libva-intel-driver \
  nvidia lib32-nvidia-libgl libva-vdpau-driver \
  # the next line is for laptops only
  xf86-input-synaptics acpi acpid laptop-mode-tools \
  # instead of "libacr38ucontrol", install the drivers
  # for the correct model of the USB stick
  libacr38ucontrol lsb-release deb2targz scinterface-bin \
  pulseaudio pulseaudio-alsa lib32-libpulse pavucontrol \
  alsa-utils alsa-plugins lib32-alsa-plugins libsamplerate \
  smplayer deadbeef \
  udisks2 udiskie dosfstools \
  zathura zathura-djvu zathura-pdf-poppler zathura-ps \
  libreoffice-fresh kbgoffice \
  cups gutenprint system-config-printer \
  networkmanager network-manager-applet \
  anything-sync-daemon profile-sync-daemon profile-cleaner chromium pepper-flash firefox flashplugin \
  pidgin skype-secure purple-skypeweb-git kbdd-git pidgin-otr purple-whatsapp-git \
  dropbox liferea xcmenu-git thunderbird htop autokey-py3 xdg-utils lxappearance feh gnome-themes-standard \
  xorg-server xorg-xinit slim awesome dmenu xorg-xprop xlockmore arandr \
  aspell hunspell \
  gvim colordiff universal-ctags-git the_silver_searcher ripgrep grc \
  zsh zsh-syntax-highlighting rxvt-unicode-pixbuf urxvt-clipboard urxvt-font-size-git tmux \
  ntp openssh ntfs-3g oxygen-icons \
  zip unrar unzip \
  deluge flareget \
  freerdp realvnc-viewer-bin \
  fontconfig lib32-fontconfig freetype2 lib32-freetype2 ttf-dejavu otf-inconsolata-lgc \
  jdk nodejs npm ruby python python-pip python-pycodestyle gdb \
  thunar gvfs gvfs-smb sshfs \
  extundelete haveged rsibreak-git

sudo npm install -g gulp coffee-script iced-coffee-script npm-check-updates bower diff-so-fancy

# enable Vim persistent undo
mkdir -p .vim/undodir

# install ruby's bundler
sudo gem install bundler

# install pep8 for Python checking
sudo pip3 install pep8

# install vrome
mkdir -p code/vrome
pushd code/vrome
git clone git@github.com:jinzhu/vrome.git .
bundle
bundle exec rake build
popd

# install Hotot
mkdir -p code/Hotot
pushd code/Hotot
git clone git@github.com:boris-petrov/Hotot.git .
mkdir build
cd build
cmake .. -DWITH_GTK2=off -DWITH_GTK3=off -DWITH_GTK=off -DWITH_GIR=off -DWITH_QT=On -DWITH_KDE=off -DWITH_KDE_QT=off -DWITH_CHROME=off -DPYTHON_EXECUTABLE=/usr/bin/python2
make
sudo make install
popd

# add less keybindings
lesskey

# enable services
sudo systemctl enable asd
systemctl --user enable psd
sudo systemctl enable slim
sudo systemctl enable sshd
sudo systemctl enable ntpd
sudo systemctl enable cups-browsed
sudo systemctl enable haveged
sudo systemctl enable pcscd

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

# Do this so Skype audio works:
# As the main user, copy /etc/pulse/default.pa to ~/.config/pulse/default.pa and add:
# load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1
# As the _skype user, create ~/.config/pulse/client.conf and add:
# default-server = 127.0.0.1
