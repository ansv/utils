#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "$(date) - This script must be run as root"
	exit 1
fi

apt update
apt upgrade

apt install \
	zsh \
	zsh-autosuggestions \
	zsh-syntax-highlighting \
	vim \
	gparted \
	snapd \
	build-essential \
	git \
	cmake \
	python3 \
	gnome-tweaks \
	gnome-shell-extensions \
	gnome-shell-extension-manager \
	gnome-shell-extension-desktop-icons-ng \
	vlc \
	tmux \
	keepass2 \
	wireshark \
	iperf3 \
	wakeonlan \
	htop \
	thunderbird \
	fonts-powerline \
	gimp

# install vscode
snap install --classic code

# install spotify
snap install spotify

# install obsidian
snap install obsidian

# install Signal (https://signal.org/download/linux/)
# NOTE: These instructions only work for 64-bit Debian-based
# Linux distributions such as Ubuntu, Mint etc.

# 1. Install our official public software signing key:
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
# 2. Add our repository to your list of repositories:
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
  sudo tee /etc/apt/sources.list.d/signal-xenial.list
# 3. Update your package database and install Signal:
sudo apt update && sudo apt install signal-desktop

# install shell color theme base16
# https://github.com/chriskempson/base16-shell
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

# install vim-plug
# https://github.com/junegunn/vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# make zsh the default shell
chsh -s /bin/zsh

# install SF-Mono-Powerline font
mkdir -p ~/.fonts
git clone https://github.com/Dambe/SF-Mono-Powerline.git ~/src/fonts/SF-Mono-Powerline

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
rm ~/.zshrc

# create symlinks
ln -s ~/src/utils/oh-my-zsh.rc ~/.zshrc
ln -s ~/src/utils/amuse_own.zsh-theme ~/.oh-my-zsh/themes/amuse_own.zsh-theme
source ~/.zshrc

ln -s ~/src/utils/tmux.conf ~/.tmux.conf
ln -s ~/src/utils/vim.rc ~/.vimrc
ln -s ~/src/utils/git.config ~/.gitconfig

echo "Things to do:"
echo "Download SF Fonts and copy them into ~/.fonts (https://developer.apple.com/fonts/)"
echo "Install Gnome Extensions: https://extensions.gnome.org/"
echo "	ArcMenu"
echo "	Dash to Panel"
echo "	Desktop Icons NG (DING)"
echo "	Lock screen background"
echo "	Removable Drive Menu"
echo "	Tactile"
echo "	Ubuntu AppIndicators"
echo "	WinTile"
echo ""
echo "Connect Google Account(s) (Settings > Online Accounts)"

