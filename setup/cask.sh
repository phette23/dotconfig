#!/usr/bin/env bash
if [ ! $(command -v brew) ]; then
  echo 'You need to install homebrew first, silly!'
  open "http://brew.sh"
  exit 1
fi

brew tap phinze/homebrew-cask
brew cask

brew cask install \
  alfred \
  dropbox \
  google-chrome \
  google-drive \
  imageoptim \
  istumbler \
  iterm2 \
  slack \
  spotify \
  torbrowser \
  xquartz \
  zotero

# now we can `brew install ghostscript` with X11, xquartz was a requirement
brew install ghostscript --with-x11

# useful Quick Look plugins for developers
# https://github.com/sindresorhus/quick-look-plugins
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package

echo 'Remember to install Prey with an API key, using "API_KEY=blah brew cask install prey"'
