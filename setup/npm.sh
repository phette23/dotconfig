#!/usr/bin/env bash -x
# install global NPM packages
npm install -g --quiet \
  @babel/core \
  @babel/cli \
  @babel/preset-env \
  n \
  trash-cli \
  uglify-js

# gd Mac OS & how it doesn't let you chown /usr/local drives me crazy
sudo mkdir /usr/local/n && sudo chown $(whoami):staff /usr/local/n
# install node stable with n
n stable

# remove homebrew node, we will use n for node version management
brew uninstall node

# if any of my personal utilities exist, link them
projects="~/code/dogedc ~/code/equella_cli"
for project in ${projects}; do
    # if dir exists, move into it & link
    [ -d ${project} ] && cd ${project} && npm link
done
