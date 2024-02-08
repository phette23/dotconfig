#! /usr/bin/env bash -x

asdf install ruby 3.0.6 || { echo "must install asdf before running ruby.sh" 1>&2 && exit 1; }

gem install \
    bundler
