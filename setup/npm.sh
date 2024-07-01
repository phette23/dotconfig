#!/usr/bin/env bash
set -x

# TODO conditional on mise existing
mise install node@latest
# get pnpm and switch to using it for global deps
npm i -g pnpm
pnpm setup
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME":$PATH
pnpm install -g \
    fx \
    trash-cli
