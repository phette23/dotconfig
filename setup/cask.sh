#!/usr/bin/env bash
if [ ! $(command -v brew) ]; then
  echo 'You need to install homebrew first, silly!'
  open "http://brew.sh"
  exit 1
fi

brew tap phinze/homebrew-cask
brew tap caskroom/homebrew-versions
brew install brew-cask

brew cask install \
  alfred \
  dropbox \
  firefox \
  gimp \
  google-chrome \
  google-drive \
  imageoptim \
  istumbler \
  iterm2 \
  prey \
  spotify \
  torbrowser \
  zotero

# useful Quick Look plugins for developers
# https://github.com/sindresorhus/quick-look-plugins
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package

echo 'Remember to install Prey with an API key, using "API_KEY=blah brew cask install prey"'
