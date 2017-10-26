#!/usr/bin/env bash -x
# Software for a fresh Ubuntu Desktop install

sudo apt-get update

sudo apt-get -y install \
	apache2 \
	adobe-flashplugin \
	chromium-browser \
	clang \
	fonts-droid \
	fonts-inconsolata \
	fonts-linuxlibertine \
	freeciv-server \
	freeciv-client-gtk \
	gimp \
	gnome-do \
	gnome-dictionary \
	phantomjs \
	texlive-fonts-recommended \
	tor \
	vidalia \
	xclip

# Done! Dropbox is the only major item not in apt-get
echo "Done! Don't forget to manually install Dropbox."
xdg-open https://www.dropbox.com/install?os=lnx
