#!/usr/bin/env bash -x
# setup Python modules
# we use pyenv to get a modern, non-homebrew python, then use that as our global python version
# it's a bad idea to use homebrew python for global packages because reguler `brew upgrade` cmds
# will wipe out your existing python & break packages installed under it
# https://justinmayer.com/posts/homebrew-python-is-not-for-you/
asdf install python latest:3.11
asdf install python latest:2.7
# cannot set global python 2 & 3 versions like with pyenv
asdf global python latest:3.11 latest:2.7
asdf reshim python

pip install --upgrade pip
pip install \
    csvkit \
    unoconv
