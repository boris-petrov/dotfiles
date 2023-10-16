#!/bin/bash

trap 'exit' ERR

cd

sudo pacman -S wget git

# install yay
wget https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz
tar -xzf yay.tar.gz
pushd yay
yes | makepkg -si
popd
rm -rf yay yay.tar.gz

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
yay -S --needed archlinux-keyring \
  intel-ucode \
  xf86-video-intel mesa-libgl mesa-vdpau libva-intel-driver \
  xf86-input-libinput acpi acpid laptop-mode-tools \
  lsb-release deb2targz \
  pulseaudio pulseaudio-alsa pavucontrol sof-firmware \
  systemd-boot-pacman-hook \
  alsa-utils alsa-plugins libsamplerate \
  smplayer deadbeef \
  udisks2 udiskie dosfstools \
  zathura zathura-djvu zathura-pdf-poppler zathura-ps \
  libreoffice-fresh \
  cups gutenprint system-config-printer \
  networkmanager network-manager-applet networkmanager-pptp networkmanager-openvpn networkmanager-l2tp gnome-keyring \
  anything-sync-daemon profile-sync-daemon profile-cleaner chromium pepper-flash firefox flashplugin \
  pidgin telegram-tdlib-purple-minimal-git purple-skypeweb-git purple-hangouts-git purple-facebook-git slack-libpurple-git purple-discord-git purple-matrix-git kbdd-git pidgin-otr \
  dropbox liferea xcmenu-git thunderbird htop autokey-gtk xdg-utils lxappearance feh gnome-themes-extra \
  xorg-server xorg-xinit slim awesome dmenu xorg-xprop xscreensaver arandr \
  aspell hunspell \
  gvim colordiff uctags-git the_silver_searcher ripgrep fzf grc ngrok ncdu \
  zsh zsh-syntax-highlighting rxvt-unicode-pixbuf urxvt-clipboard urxvt-font-size-git wezterm tmux fzf fd \
  ntp openssh ntfs-3g oxygen-icons \
  zip unrar unzip \
  deluge-gtk flareget \
  freerdp tigervnc \
  fontconfig freetype2 ttf-dejavu otf-inconsolata-lgc-git \
  jdk nodejs npm pnpm ruby python python-pip python-pycodestyle gdb \
  thunar gvfs gvfs-smb sshfs \
  earlyoom git-delta difftastic \
  intltool less htop \
  extundelete haveged rsibreak-git ulauncher fluxgui redshift

sudo bash -c "echo -e \"EARLYOOM_ARGS=\"-m 3 -r 0 --avoid \'^\(firefox\|awesome\|slim\)$\' --prefer \'^\(java\|code\|node\|chromium\)$\'\"\" > /etc/default/earlyoom"

sudo npm install -g gulp grunt coffeescript npm-check-updates bower ember-cli stylelint prettier

# sudo bootctl --path=/boot install

# enable Vim persistent undo
mkdir -p .vim/undodir

# install ruby's bundler
sudo gem install bundler

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

pushd code
git clone https://github.com/EionRobb/pidgin-groupchat-typing-notifications.git
pushd pidgin-groupchat-typing-notifications
make
sudo make install
popd
rm -rf pidgin-groupchat-typing-notifications
popd

pushd code
git clone https://github.com/EionRobb/icyque.git
pushd icyque
make
sudo make install
popd
rm -rf icyque
popd

# Handle out-of-memory situations better:
sudo sh -c 'echo "vm.oom_kill_allocating_task = 1" >> /etc/sysctl.d/local.conf'

# enable services
sudo systemctl enable asd
systemctl --user enable psd
sudo systemctl enable slim
sudo systemctl enable sshd
sudo systemctl enable ntpd
sudo systemctl enable cups-browsed
sudo systemctl enable haveged
sudo systemctl enable pcscd
sudo systemctl enable earlyoom

# TODO: if on laptop:
sudo systemctl enable NetworkManager
sudo systemctl enable acpid
sudo systemctl enable laptop-mode

npm config set ignore-scripts true
pnpm config set ignore-scripts true

# copy `/etc/X11/xorg.conf.d` from the old laptop
# execute "set spell" in Vim in order to download its dictionaries
# install aspell and hunspell dictionaries from Dropbox directory
# install kbgoffice from https://bitbucket.org/axil42/aur-mirror/raw/master/kbgoffice/PKGBUILD or the file in this directory
# execute "cp ~/Dropbox/Private/wallpaper.jpg ~/.config/awesome/themes/"
# cp ~/.purple from the old laptop OR copy Pidgin stuff from Dropbox folder to ~/.purple
# cp ~/.thunderbird from the old laptop
# install Chrome's Stylus styles from ~/dotfiles/common/stylish/*
# use Chrome's Page Monitor sites from ~/dotfiles/common/Chrome/Page Monitor.html
# setup spelling in Chrome - Settings, search for "spell", Language and input settings
# remove the 3 "group i = AltGr" lines in /usr/share/X11/xkb/compat/basic
# set default soundcard in ~/.asoundrc
# set Chrome/Thunderbird fonts, encodings
# add Facebook icons for Pidgin from https://github.com/PowaBanga/pidgin-EAP
# enable wanted Pidgin plugins (like the groupchat-typing-notifications one)
# set the `Adwaita-dark` theme in `lxappearance`
