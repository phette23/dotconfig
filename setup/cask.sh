#!/usr/bin/env bash
set -x
if [ ! "$(command -v brew)" ]; then
  echo 'You need to install homebrew first, silly!'
  open "http://brew.sh"
  exit 1
fi

brew tap homebrew/cask-versions

bic () { brew install --cask "$1"; }

[ -d /Applications/1Password.app ] || bic 1password
bic 1password/tap/1password-cli
bic docker-desktop
bic discord
bic firefox
[ -d "/Applications/Google Chrome.app" ] || bic google-chrome
bic imageoptim
bic iterm2
bic slack
bic tor-browser
bic visual-studio-code
bic xquartz
