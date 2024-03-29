#!/usr/bin/env bash -x
# Software for a fresh Ubuntu Server install

sudo apt-get update

sudo apt-get -y install \
    autossh \
    curl \
    fail2ban \
    git \
    ngrep \
    openssh-server \
    python-pip \
    python-setuptools \
    rbenv \
    source-highlight \
    tree \
    vim \
    xinetd

# Node in Apt is outdated
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get install -y nodejs npm

# Binary is at nodejs initially, fix that
ln -s /usr/bin/nodejs /usr/bin/node
