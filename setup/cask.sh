#!/usr/bin/env bash -x
if [ ! $(command -v brew) ]; then
  echo 'You need to install homebrew first, silly!'
  open "http://brew.sh"
  exit 1
fi

brew tap homebrew/cask-versions

bic () { brew install --cask $1 }

bic 1password/tap/1password-cli
bic alfred
bic docker
bic discord
bic firefox
bic google-chrome
bic imageoptim
bic iterm2
bic slack
bic spotify
bic tor-browser
bic visual-studio-code
bic xquartz

# useful Quick Look plugins for developers
# https://github.com/sindresorhus/quick-look-plugins
bic qlmarkdown
bic quicklook-json
bic quicklook-csv
bic webpquicklook
