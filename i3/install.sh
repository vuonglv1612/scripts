#!/bin/bash

#Ubuntu 16.10+
# INSTALL I3 GAPS
APP_DIR=$PWD
# install dependencies
sudo apt install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
                 libxcb-util0-dev libxcb-icccm4-dev libyajl-dev \
                 libstartup-notification0-dev libxcb-randr0-dev \
                 libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
                 libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev \
                 autoconf libxcb-xrm0 libxcb-xrm-dev automake libxcb-shape0-dev

mkdir -p /tmp/install
cd /tmp/install

# clone the repository
git clone https://github.com/vuonglv1612/i3 i3-gaps
cd i3-gaps

# compile & install
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/

# Disabling sanitizers is important for release versions!
# The prefix and sysconfdir are, obviously, dependent on the distribution.
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install


# install i3status, rofi, pasystray, nitrogen, fontawesome, flameshot
sudo apt install i3status \
                 rofi \
                 pasystray \
                 nitrogen \
                 fonts-font-awesome \
                 flameshot \
                 imagemagick \
                 util-linux -y

# dependencies for i3lock-color
cd /tmp/install
sudo apt install pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev
git clone https://github.com/Raymo111/i3lock-color.git
cd i3lock-color
chmod +x build.sh
./build.sh
chmod +x install-i3lock-color.sh
./install-i3lock-color.sh

cd /tmp/install
git clone https://github.com/meskarune/i3lock-fancy.git
cd i3lock-fancy
sudo make install

# copy config file to home dir
mkdir -p ~/scripts
mkdir -p ~/.config/i3status
cp $APP_DIR/i3exit.sh ~/scripts/i3exit.sh
sudo rm -rf /usr/bin/i3exit
sudo ln -s ~/scripts/i3exit.sh /usr/bin/i3exit
cp $APP_DIR/config ~/.config/i3/config
cp $APP_DIR/status_config ~/.config/i3status/config
i3-msg restart
