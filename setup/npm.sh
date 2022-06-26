#!/usr/bin/env bash -x
# gd Mac OS & how it doesn't let you chown /usr/local drives me crazy
sudo mkdir /usr/local/n && sudo chown $(whoami):staff /usr/local/n

# get pnpm and switch to using it for global deps
corepack enable
# install node stable with n
pnpm install -g n
n stable
pnpm install -g fx trash-cli

# remove homebrew node, we will use n for node version management
brew uninstall node

# if any of my personal utilities exist, link them
projects="~/code/dogedc ~/code/equella_cli"
for project in ${projects}; do
    # if dir exists, move into it & link
    [ -d ${project} ] && cd ${project} && pnpm link
done
