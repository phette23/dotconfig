#!/usr/bin/env bash -x
if [ ! $(command -v brew) ]; then
  echo 'You need to install homebrew first, silly!'
  open "http://brew.sh"
  exit 1
fi

brew tap homebrew/cask-versions

brew install --cask \
    alfred \
    discord \
    firefox \
    google-chrome \
    imageoptim \
    iterm2 \
    psequel \
    sequel-pro \
    slack \
    spotify \
    tor-browser \
    visual-studio-code \
    xquartz

# useful Quick Look plugins for developers
# https://github.com/sindresorhus/quick-look-plugins
brew install --cask qlmarkdown quicklook-json quicklook-csv webpquicklook
