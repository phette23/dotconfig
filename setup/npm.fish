#!/usr/bin/env fish

if command --query mise
    mise install node@latest
    mise use -g node
else
    echo "mise not found, run brew.sh first to install mise, then run this script again."
    exit 1
end

npm i -g npm
set -Ux PNPM_HOME "$HOME/Library/pnpm"
fish_add_path "$PNPM_HOME"
# install pnpm outside of the mise npm environment
curl -fsSL https://get.pnpm.io/install.sh | sh -
pnpm setup
pnpm add -g fx
npm config set --global fund false
pnpm config set --global fund false
pnpm config set --global minimumReleaseAge (math 60 x 24 x 7)
