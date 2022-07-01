#!/usr/bin/env bash -x
# gd Mac OS & how it doesn't let you chown /usr/local drives me crazy
sudo mkdir /usr/local/n && sudo chown $(whoami):staff /usr/local/n

# get pnpm and switch to using it for global deps
corepack enable pnpm
pnpm setup
# install node stable with n
pnpm install -g n
n stable
pnpm install -g fx trash-cli

# remove homebrew node, we will use n for node version management
brew uninstall node
