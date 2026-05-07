#!/usr/bin/env fish

if command --query mise
    mise install node@latest
else
    echo "mise not found, run brew.sh first to install mise, then run this script again."
    exit 1
end

# get pnpm and switch to using it for global deps
if command --query corepack
    corepack enable pnpm
else
    npm i -g pnpm@latest
end
set -Ux PNPM_HOME "$HOME/Library/pnpm"
fish_add_path "$PNPM_HOME"
pnpm setup
pnpm add -g \
    fx
npm config set --global fund false
pnpm config set --global fund false
pnpm config set --global minimumReleaseAge (math 60 x 24 x 7)
