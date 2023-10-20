#!/usr/bin/env bash -x
# setup Python modules
# we use pyenv to get a modern, non-homebrew python, then use that as our global python version
# it's a bad idea to use homebrew python for global packages because reguler `brew upgrade` cmds
# will wipe out your existing python & break packages installed under it
# https://justinmayer.com/posts/homebrew-python-is-not-for-you/
pyenv install 3.11
# need python 2 for old EQUELLA scripts
pyenv install 2.7
pyenv global 3.11 2.7
pyenv init - | source
python -m pip install --upgrade pip
python -m pip install csvkit \
    unoconv
