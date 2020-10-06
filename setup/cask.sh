#!/usr/bin/env bash -x
if [ ! $(command -v brew) ]; then
  echo 'You need to install homebrew first, silly!'
  open "http://brew.sh"
  exit 1
fi

brew tap homebrew/cask-versions

brew cask install \
    alfred \
    atom \
    firefox \
    google-chrome \
    google-chrome-canary \
    imageoptim \
    iterm2 \
    slack \
    spotify \
    tor-browser \
    xquartz

# useful Quick Look plugins for developers
# https://github.com/sindresorhus/quick-look-plugins
brew cask install qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzip webpquicklook
