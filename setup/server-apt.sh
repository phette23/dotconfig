#!/usr/bin/env bash
# Software for a fresh Ubuntu Server install

sudo apt-get update

sudo apt-get -y install \
    cowsay \
    curl \
    denyhosts \
    git \
    lynx \
    mongodb \
    ngrep \
    openssh-server \
    optipng \
    pandoc \
    php5-cli \
    php-pear \
    pngcrush \
    python-setuptools \
    rbenv \
    ruby1.9.1 \
    source-highlight \
    tree \
    vim \
    xinetd \
    yaz

# Node in Apt is outdated
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get install -y nodejs \
    npm

# Binary is at nodejs initially, fix that
ln -s /usr/bin/nodejs /usr/bin/node
