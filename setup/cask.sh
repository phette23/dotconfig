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
  calibre \
  clamxav \
  daisydisk \
  dropbox \
  firefox \
  gimp \
  google-chrome \
  google-chrome-canary \
  google-drive \
  imageoptim \
  inkscape \
  istumbler \
  iterm2 \
  lastfm \
  menumeters \
  openrefine \
  prey \
  quicksilver \
  scribus \
  spotify \
  sublime-text3 \
  torbrowser \
  zotero

echo 'Remember to install Prey with an API key, using "API_KEY=blah brew cask install prey"'
