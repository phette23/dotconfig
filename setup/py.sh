#!/usr/bin/env bash -x
# setup Python modules
sudo easy_install pip

sudo -H pip install \
  virtualenv \
  virtualfish

sudo -H pip install csvkit --ignore-installed six
