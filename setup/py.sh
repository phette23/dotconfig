#!/usr/bin/env bash -x
# setup Python modules

sudo easy_install pip

sudo -H pip install \
  csvkit \
  flake8 \
  pymarc \
  requests \
  virtualenv
