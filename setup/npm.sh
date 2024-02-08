#!/usr/bin/env bash -x
# get pnpm and switch to using it for global deps
npm i -g pnpm
pnpm setup
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME":$PATH
pnpm install -g \
    fx \
    trash-cli

# install latest node with asdf
asdf global nodejs latest

# remove homebrew node, we will use n for node version management
echo "If that suceeded, you can remove the hombrew node with 'brew uninstall node'"
