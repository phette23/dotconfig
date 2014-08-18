#!/usr/bin/env bash
# Software for a fresh Ubuntu Desktop install

sudo apt-get update

sudo apt-get -y install \
	apache2 \
	adobe-flashplugin \
	audacity \
	chromium-browser \
	clang \
	epiphany-browser \
	fonts-droid \
	fonts-inconsolata \
	fonts-linuxlibertine \
	freeciv-server \
	freeciv-client-gtk \
	gimp \
	gnome-do \
	gnome-dictionary \
	inkscape \
	midori \
	phantomjs \
	scribus \
	synaptic \
	terminator \
	texlive-fonts-recommended \
	tor \
	vidalia \
	wine \
	xclip

# Done! Dropbox is the only major item not in apt-get
echo "Done! Don't forget to manually install Dropbox."
xdg-open https://www.dropbox.com/install?os=lnx
