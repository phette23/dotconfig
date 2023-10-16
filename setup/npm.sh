#!/usr/bin/env bash -x
# gd Mac OS & how it doesn't let you chown /usr/local drives me crazy
sudo mkdir /usr/local/n && sudo chown $(whoami):staff /usr/local/n

# get pnpm and switch to using it for global deps
npm i -g pnpm
pnpm setup
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME":$PATH
pnpm install -g n fx trash-cli
# install node stable with n
command -v n >/dev/null && n stable

# remove homebrew node, we will use n for node version management
echo "If that this suceeded, you can remove the hombrew node with 'brew uninstall node'"
