#!/usr/bin/env bash
# Script to grab major software for a fresh Ubuntu install

# First update apt-get
sudo apt-get update

# Install all my packages
# -y = "assume yes to all prompts & run non-interactively"
sudo apt-get -y install \
	adobe-flashplugin \
	apache2 \
	audacity \
	chromium-browser \
	clang \
	cowsay \
	curl \
  	denyhosts \
	epiphany-browser \
	fonts-droid \
	fonts-inconsolata \
	fonts-linuxlibertine \
	freeciv-server \
	freeciv-client-gtk \
	git \
	gimp \
	gnome-do \
	gnome-dictionary \
	inkscape \
	lynx \
	midori \
	mongodb \
	mysql-server \
	ngrep \
  	openssh-server \
	optipng \
	pandoc \
	phantomjs \
	php5-cli \
	php-pear \
	pngcrush \
	python-setuptools \
	rbenv \
	ruby1.9.1 \
	scribus \
	source-highlight \
	synaptic \
	terminator \
	texlive-fonts-recommended \
	tor \
	tree \
	vidalia \
	vim \
	wine \
	xclip \
  	xinetd \
	yaz

# Done! Dropbox is the only major item not in apt-get
echo "Done! Don't forget to manually install Dropbox."
xdg-open https://www.dropbox.com/install?os=lnx
