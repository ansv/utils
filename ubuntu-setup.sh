#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "$(date) - This script must be run as root"
	exit 1
fi

apt update
apt upgrade

apt install \
	zsh \
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
	wireshark \
	iperf3 \
	wakeonlan \
	htop \
	thunderbird \
	fonts-powerline \
	gimp

# install vscode
snap install --classic code

# make zsh the default shell
chsh -s /bin/zsh

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

