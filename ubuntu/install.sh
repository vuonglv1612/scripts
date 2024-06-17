#!/usr/bin/sh
BASE_DIR=$PWD

sudo apt update
sudo apt install git curl unzip openvpn tmux  fzf -y

# Install ibus-bamboo
sudo add-apt-repository ppa:bamboo-engine/ibus-bamboo -y
sudo apt-get update
sudo apt-get install ibus-bamboo -y
ibus restart
env DCONF_PROFILE=ibus dconf write /desktop/ibus/general/preload-engines "['BambooUs', 'Bamboo']" && gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('ibus', 'Bamboo')]"

# Install telegram
curl -L https://telegram.org/dl/desktop/linux -o /tmp/tsetup.tar.xz
sudo rm -rf /opt/telegram
sudo mkdir -p /opt/telegram && cd /opt/telegram
sudo tar -xvf /tmp/tsetup.tar.xz
sudo rm -f /tmp/tsetup.tar.xz
sudo rm -rf /usr/bin/telegram
sudo ln -s /opt/telegram/Telegram/Telegram /usr/bin/telegram

# Install flux
sudo add-apt-repository ppa:nathan-renniewaldock/flux -y
sudo sed -i 's/focal/bionic/g' /etc/apt/sources.list.d/nathan-renniewaldock-ubuntu-flux-focal.list
sudo apt-get update
sudo apt-get install fluxgui -y


# Install dash to dock
sudo apt install gnome-tweaks gnome-shell-extensions gettext gnome-tweak-tool -y


sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt update
sudo apt install python3-pip python3.6 python3.8 python3.6-dev python3.8-dev libpq-dev python-dev python3-dev libxml2-dev libxslt1-dev libldap2-dev libsasl2-dev libffi-dev -y

## FONTS
mkdir -p ~/.local/share/fonts
cp $BASE_DIR/fonts/*.ttf ~/.local/share/fonts/.
fc-cache -f -v

## VSCODE
curl -o /tmp/vscode_latest.deb -JL 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
sudo apt install /tmp/vscode_latest.deb -y
rm  -rf /tmp/vscode_latest.deb

## POSTMAN
wget https://dl.pstmn.io/download/latest/linux64 -O /tmp/postman.tar.gz
sudo tar -xzf /tmp/postman.tar.gz -C /opt
rm -rf  /tmp/postman.tar.gz
sudo rm -f /usr/bin/postman
sudo ln -s /opt/Postman/Postman /usr/bin/postman
 
mkdir -p ~/.local/share/applications
cat > ~/.local/share/applications/postman.desktop <<EOL
[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=postman
Icon=/opt/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;
EOL

## COPY DOTFILES
cp -a $BASE_DIR/dotfiles/. ~/.
xrdb -merge ~/.Xresources

echo 'export PATH="~/.local/bin:$PATH"' >> ~/.bashrc
echo "source /usr/share/doc/fzf/examples/key-bindings.bash" >> ~/.bashrc
echo "source /usr/share/doc/fzf/examples/completion.bash" >> ~/.bashrc
. ~/.bashrc


# install spotify from snapstore
sudo snap install spotify authy todoist
