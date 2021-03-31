#!/usr/bin/env bash -x
# Software for a fresh Ubuntu Desktop install

sudo apt-get update

sudo apt-get -y install \
	apache2 \
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
	texlive-fonts-recommended \
	tor \
	vidalia \
	xclip

